import 'dart:async';
import 'dart:convert';

import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/earnings_screen/cubit/earning_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/edit_event_screen/cubit/edit_event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/edit_group_screen/cubit/edit_group_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/cubit/group_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/cubit/signup_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/cubit/notification_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/otp_screen/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/profile_screen/cubit/view_user_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_event_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_group_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/cubit/create_group_chat_cubit.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/cubit/group_chat_room_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_links/uni_links.dart';

import 'globals.dart';
import 'src/locals_views/event_screen/event_screen.dart';
import 'src/models/user_model.dart';

final getIt = GetIt.I;

late Size mq;
 String? token ;
// bool _initialUriIsHandled = false;
 // UserModel? userModel ;
String? initialRoutes;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait orientation
    DeviceOrientation.portraitDown, // Also lock to upside-down portrait
  ]);

  await Firebase.initializeApp();
  FirebaseNotificationUtils.getNotificationSettings();
  FirebaseNotificationUtils.initializeLocalNotifications();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  print("USER ${FirebaseAuth.instance.currentUser?.uid}");
  await _initRepos();
  token = await getIt<SharedPreferencesUtil>()
      .getString(SharedPreferenceConstants.apiAuthToken);
  print("Token Value $token");
  DioClientNetwork.initializeDio(removeToken: false);

  // initialRoutes= RouteConstants.mainSplashScreenLocal;

  //
  // if (token!= null && (token??"").isNotEmpty) {
  //   if ((userModel?.userPhotos?? []).isNotEmpty) {
  //     initialRoutes = RouteConstants.dobScreen;
  //   } else if ((userModel?.gender?? "").isNotEmpty && userModel?.gender!= null) {
  //     initialRoutes = RouteConstants.aboutYouScreen;
  //   } else if (userModel?.isProfileCompleted == true) {
  //     initialRoutes = RouteConstants.mainScreen;
  //   } else {
  //     initialRoutes = RouteConstants.nameScreen;
  //   }
  // } else {
  //   initialRoutes = RouteConstants.splashScreenLocal;
  // }


  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: ColorConstants.greenMain,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // );
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  runApp( MyApp());
}

// void main() => runApp(const MyApp());

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(DioClientNetwork());
  getIt.registerSingleton(SharedPreferencesUtil());
}

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    // _handleIncomingLinks();
    // _handleInitialUri();
  }

  @override
  void dispose() {
    // _sub?.cancel();
    super.dispose();
  }

  // void _handleIncomingLinks() {
  //   if (!kIsWeb) {
  //     _sub = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) return;
  //       print('got uri: $uri');
  //       if(uri.toString().isNotEmpty){
  //         if (uri!.path.contains('/event')) {
  //           print("This is an Event");
  //           List<String> pathSegments = uri.path.split('/');
  //           String id = pathSegments.last;
  //           NavigationUtil.push(context, RouteConstants.eventScreen ,args: EventScreenArg(id ?? "", ""));
  //
  //         } else if (uri                                                                                                                                                                                   .path.contains('/group')) {
  //           print("This is a Group");
  //         } else {
  //           print("Unknown type");
  //         }
  //       }
  //
  //       //Get.to(()=> RegisterScreen());
  //       setState(() {
  //         _latestUri = uri;
  //         _err = null;
  //       });
  //     }, onError: (Object err) {
  //       if (!mounted) return;
  //       print('got err: $err');
  //       setState(() {
  //         _latestUri = null;
  //         if (err is FormatException) {
  //           _err = err;
  //         } else {
  //           _err = null;
  //         }
  //       });
  //     });
  //   }
  // }
  // Future<void> _handleInitialUri() async {
  //   if (!_initialUriIsHandled) {
  //     _initialUriIsHandled = true;
  //     try {
  //       final uri = await getInitialUri();
  //       if (uri == null) {
  //         print('no initial uri');
  //       } else {
  //         print('got initial uri: $uri');
  //         //Get.to(()=> RegisterScreen());
  //       }
  //       if (!mounted) return;
  //       setState(() => _initialUri = uri);
  //     } on PlatformException {
  //       print('falied to get initial uri');
  //     } on FormatException catch (err) {
  //       if (!mounted) return;
  //       print('malformed initial uri');
  //       setState(() => _err = err);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppSettingCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => OTPCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => MainScreenCubit(),
        ),
        BlocProvider(
          create: (context) => EventCubit(),
        ),
        BlocProvider(
          create: (context) => EditEventCubit(),
        ),
        BlocProvider(
          create: (context) => ViewYourEventScreenCubit(),
        ),
        BlocProvider(
          create: (context) => UserScreenCubit(),
        ),
        BlocProvider(
          create: (context) => GroupCubit(),
        ),
        BlocProvider(
          create: (context) => CreateGroupChatCubit(),
        ),
        BlocProvider(
          create: (context) => GroupChatRoomCubit(),
        ),
        BlocProvider(
          create: (context) => ViewYourGroupScreenCubit(),
        ),
        BlocProvider(
          create: (context) => EditGroupCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationScreenCubit(),
        ),
        BlocProvider(
          create: (context) => ChatRoomCubit(),
        ),
        BlocProvider(
          create: (context) => ViewUserScreenCubit(),
        ),
        BlocProvider(
          create: (context) => EarningScreenCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Locals App',
            theme: ThemeData(
              fontFamily: FontConstants.inter,
              useMaterial3: true,
            ),
          initialRoute: RouteConstants.mainSplashScreenLocal,
            onGenerateRoute: generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
