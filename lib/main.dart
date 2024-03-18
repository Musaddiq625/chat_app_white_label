import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/cubit/group_chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/login/cubit/login_cubit.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:chat_app_white_label/src/locals_views/chat_listing/chat_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'globals.dart';

final getIt = GetIt.I;

late Size mq;
//
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

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito Sans 10pt"),
      debugShowCheckedModeBanner: false,
      home: const ChatListingScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppSettingCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<OTPCubit>(
          create: (BuildContext context) => OTPCubit(),
        ),
        BlocProvider<ChatRoomCubit>(
          create: (BuildContext context) => ChatRoomCubit(),
        ),
        BlocProvider<GroupChatRoomCubit>(
          create: (BuildContext context) => GroupChatRoomCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'WeUno Chat',
        theme: ThemeData(
          fontFamily: 'Helvetica',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteConstants.splashScreen,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
