import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppSettingCubit appSettingCubit =
      BlocProvider.of<AppSettingCubit>(context);

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await flutterLocalNotificationsPlugin.cancelAll();
      final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
      print("flutterLocalNotificationsPlugin-splash $flutterLocalNotificationsPlugin");
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        NotificationResponse? notificationResponse = notificationAppLaunchDetails!.notificationResponse;
        var payloadMap = jsonDecode(notificationResponse!.payload!) as Map<String, dynamic>;
        var callType = payloadMap["callType"];

        if(callType=="background"){
          FirebaseNotificationUtils.backgroundincomingCall(notificationResponse!);
          selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
          print("selectedNotificationPayload-splash ${selectedNotificationPayload}");
        }
        else{
          _navigateToNext();
        }

      }
      else{
        _navigateToNext();
      }
      await FirebaseNotificationUtils.getNotificationsForground();
      await getFlavorName();
      appSettingCubit.initCamera();

    });
    super.initState();
  }

  Future<void> getFlavorName() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      LoggerUtil.logs('pname ${packageInfo.packageName}');
      appSettingCubit.setFlavor(packageInfo.packageName);
    });
  }

  Future<void> _navigateToNext() async {
    final userData = await FirebaseUtils.getCurrentUser();


    Future.delayed(const Duration(milliseconds: 100), () async {
      if (userData != null) {
        if (userData.isProfileComplete == true) {
          NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
        } else {
          NavigationUtil.popAllAndPush(context, RouteConstants.profileScreen,
              args: userData.id);
        }
      } else {
        NavigationUtil.popAllAndPush(
          context,
          RouteConstants.loginScreen,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
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
