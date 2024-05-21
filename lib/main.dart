import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/edit_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/cubit/signup_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/otp_screen/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_event_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'globals.dart';

final getIt = GetIt.I;

late Size mq;
 String? token ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

// void main() => runApp(const MyApp());

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(DioClientNetwork());
  getIt.registerSingleton(SharedPreferencesUtil());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Locals App',
            theme: ThemeData(
              fontFamily: FontConstants.fontNunitoSans,
              useMaterial3: true,
            ),
          initialRoute:(token != null && token!.isNotEmpty) ? RouteConstants.mainScreen:RouteConstants.splashScreenLocal,
            onGenerateRoute: generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
