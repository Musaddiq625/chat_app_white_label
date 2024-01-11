import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/service/firbase_auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late AppCubit appCubit = BlocProvider.of<AppCubit>(context);
  FirebaseService firebaseService = getIt<FirebaseService>();
  late AppSettingCubit appSettingCubit =
      BlocProvider.of<AppSettingCubit>(context);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getFlavorName();
      await firebaseService.requestPermission();
      _navigateToNext();

    });
    super.initState();
  }

  Future<void> getFlavorName() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      LoggerUtil.logs('pname ${packageInfo.packageName}');
      appSettingCubit.setFlavor(packageInfo.packageName);
    });
  }
  // void _insertOverlay(BuildContext context) {
  //   return Overlay.of(context).insert(
  //     OverlayEntry(
  //       builder: (context) {
  //         final size = MediaQuery.of(context).size;
  //         return Positioned(
  //           top: size.height - (size.height * 0.95),
  //           left: size.width - 150,
  //           child: Material(
  //             color: Colors.grey.withOpacity(.6),
  //             child: Container(
  //               padding: const EdgeInsets.all(5),
  //               alignment: Alignment.center,
  //               child: const Text(
  //                 'v 0.1.0',
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Future<void> _navigateToNext() async {
    // final token = await getIt<SharedPreferencesUtil>().getString(
    //   SharedPreferenceConstants.token,
    // );

    Future.delayed(const Duration(milliseconds: 1500), () async {
      //   if (token != null) {
      //     appCubit.setToken(token);
      //     await _initializedApiClientBloc(token: token);
      //     NavigationUtil.pushReplace(context, RouteConstants.webView,
      //         args: WebViewArgs(
      //             url: appCubit.isBusiness == true
      //                 ? HttpConstants.bWebUrl
      //                 : HttpConstants.aWebUrl,
      //             token: token),
      //         previousScreen: RouteConstants.splashScreenRoute);
      //   } else {
      //     await _initializedApiClientBloc();
      firebaseService.auth.authStateChanges().listen((User? user) {
        if (user == null) {
          NavigationUtil.pushReplace(
            context,
            RouteConstants.loginScreen,
          );
        }
        else {
          NavigationUtil.pushReplace(
            context,
            RouteConstants.chatScreen,
          );
        }
        // }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppSettingCubit, AppSettingState>(
      listener: (context, state) {
        if (state is SetFlavorState) {
          // setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(appSettingCubit.appLogo),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        appSettingCubit.appName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
