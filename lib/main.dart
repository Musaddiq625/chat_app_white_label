import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'globals.dart';

final getIt = GetIt.I;

late Size mq;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
//   FirebaseNotificationUtils.getNotificationSettings();
//   FirebaseNotificationUtils.initializeLocalNotifications();
//
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   print("USER ${FirebaseAuth.instance.currentUser?.uid}");
//   await _initRepos();
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: ColorConstants.greenMain,
//       statusBarIconBrightness: Brightness.light,
//     ),
//   );
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//
//   runApp(const MyApp());
// }

void main() => runApp(const MyApp());

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
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
        )
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
            initialRoute: RouteConstants.createEventScreen,
            onGenerateRoute: generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
