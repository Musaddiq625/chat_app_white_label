import 'dart:async';
import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_screen/chat_screen.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_links/uni_links.dart';

import '../../../globals.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  bool _initialUriIsHandled = false;
  late AppSettingCubit appSettingCubit = BlocProvider.of<AppSettingCubit>(context);
  late OnboardingCubit onBoardingCubit =
  BlocProvider.of<OnboardingCubit>(context);
  String? token ;
  UserModel? userModel ;
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

  String? idValue;
  late String eventId;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _handleIncomingLinks();
      _handleInitialUri();
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("Fcm token ${fcmToken}");

      token = await getIt<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.apiAuthToken);
      print("Token Value $token");
      final serializedUserModel = await getIt<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.userModel);
      if((serializedUserModel??"").isNotEmpty){
        userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));
        onBoardingCubit.userModel = userModel ?? UserModel();
      }

      await flutterLocalNotificationsPlugin.cancelAll();
      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        NotificationResponse? notificationResponse =
            notificationAppLaunchDetails!.notificationResponse;
        var payloadMap =
            jsonDecode(notificationResponse!.payload!) as Map<String, dynamic>;
        var callType = payloadMap["callType"];
        var messageType = payloadMap["messageType"];
        if (callType == "background") {
          if (messageType != "missed-call") {
            FirebaseNotificationUtils.backgroundincomingCall(
                notificationResponse!);
            selectedNotificationPayload =
                notificationAppLaunchDetails!.notificationResponse?.payload;
            print(
                "selectedNotificationPayload-splash ${selectedNotificationPayload}");
          } else {
            _navigateToNext();
          }
        } else {
          _navigateToNext();
        }
      } else {
        _navigateToNext();
      }
      await FirebaseNotificationUtils.getNotificationsForground();
      await getFlavorName();
      appSettingCubit.initCamera();

    });
    super.initState();
  }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }


  void _handleIncomingLinks() {
    if (!kIsWeb){
      _sub = uriLinkStream.listen((Uri? uri) async{
        if (!mounted) return;
        print('got uri: $uri');
        userId = await getIt<SharedPreferencesUtil>()
            .getString(SharedPreferenceConstants.userIdValue);
        print("userId-- ${userId}");
        if(uri.toString().isNotEmpty){

          if (uri!.path.contains('/event')) {
            List<String> pathSegments = uri.path.split('/');
            eventId = pathSegments.last;
            Map<String, String> queryParams = uri.queryParameters;
            print("eventId ${eventId}");
            if (queryParams.containsKey('id')) {
              idValue = queryParams['id'];
              print("id value ${idValue}");// Output: 66332e92b9bc57c02be94bfc
              if(userId == idValue){
                // print("my event");
                NavigationUtil.push(context, RouteConstants.viewYourEventScreen ,args: eventId);
              }
              else{
                print("my event not");
                NavigationUtil.push(context, RouteConstants.eventScreen ,args: EventScreenArg(eventId, ""));
              }
            } else {
              print("ID parameter not found.");
            }
            print("This is an Event");

            // NavigationUtil.push(context, RouteConstants.eventScreen ,args: EventScreenArg(id, ""));

          }
          else if (uri.path.contains('/group')) {
            List<String> pathSegments = uri.path.split('/');
            eventId = pathSegments.last;
            Map<String, String> queryParams = uri.queryParameters;
            print("eventId ${eventId}");
            if (queryParams.containsKey('id')) {
              idValue = queryParams['id'];
              print("id value ${idValue}");// Output: 66332e92b9bc57c02be94bfc
              if(userId == idValue){
                // print("my event");
                NavigationUtil.push(context, RouteConstants.viewYourGroupScreen ,args: eventId);
              }
              else{
                print("my event not");
                NavigationUtil.push(context, RouteConstants.viewGroupScreen,
                    args:ViewGroupArg(eventId ?? "", false, false));
                    }
            } else {
              print("ID parameter not found.");
            }
            print("This is a Group");
          } else {
            print("Unknown type");
          }
        }

        //Get.to(()=> RegisterScreen());
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }
  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
          //Get.to(()=> RegisterScreen());
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  Future<void> getFlavorName() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      LoggerUtil.logs('pname ${packageInfo.packageName}');
      appSettingCubit.setFlavor(packageInfo.packageName);
    });
  }

  Future<void> _navigateToNext() async {
    final userData = await FirebaseUtils.getCurrentUser();

    Future.delayed(const Duration(milliseconds: 2000), () async {
      // if (userData != null) {
      //   if (userData.isProfileCompleted == true) {
      //     NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
      //   } else {
      //     NavigationUtil.popAllAndPush(context, RouteConstants.profileScreen,
      //         args: userData.id);
      //   }
      // } else {
      //   NavigationUtil.popAllAndPush(
      //     context,
      //     RouteConstants.loginScreen,
      //   );
      // }
print("userModel?.userPhotos ${userModel?.userPhotos}");
print("userModel?.userPhotos ${userModel?.toJson()}");

      if (token!= null && (token??"").isNotEmpty) {
        if (userModel?.isProfileCompleted == true) {
          final replacedPhoneNumber =onBoardingCubit.userModel.phoneNumber?.replaceAll('+', '');
          FirebaseUtils.user = await FirebaseUtils.getCurrentFirebaseUser(
              replacedPhoneNumber!);
          print("Firebase User Data -- ${FirebaseUtils.user?.toJson()}");
          NavigationUtil.push(context,  RouteConstants.mainScreen);
        }
        else if ((userModel?.gender?? "").isNotEmpty && userModel?.gender!= null) {
          NavigationUtil.push(context,  RouteConstants.aboutYouScreen,args: true);
        }
        else if ((userModel?.userPhotos?? []).isNotEmpty) {
          NavigationUtil.push(context,  RouteConstants.dobScreen,args: true);
        }  else if ((userModel?.phoneNumber?? "").isNotEmpty && userModel?.phoneNumber != null && userModel?.phoneNumber != "null"  ){
          NavigationUtil.push(context,  RouteConstants.nameScreen);
        }
        else {
          NavigationUtil.push(context,  RouteConstants.signUpNumber);
        }
      } else {
        NavigationUtil.push(context,  RouteConstants.splashScreenLocal);
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
