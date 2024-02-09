
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/cubit/group_chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/login/cubit/login_cubit.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

late Size mq;

const appId = "62b3eb641dbd4ca7a203c41ce90dbca2";
const token = "007eJxTYFh2JWvK3q4DdTf1mXd/Xm3zIu7YUV17QYUVxSdt70/d2yGqwGBmlGScmmRmYpiSlGKSnGieaGRgnGximJxqaZCSlJxo5HPkaGpDICPDpLZtDIxQCOKzMJSkFpcwMAAA9/ciEg==";
const channel = "test";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print("USER ${FirebaseAuth.instance.currentUser?.uid}");

  await _initRepos();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.greenMain,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final messegingService = getIt<FirebaseService>();
  await messegingService.initializeLocalNotifications();

  runApp(const MyApp());
}

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        // initialRoute: RouteConstants.myApp,
        initialRoute: RouteConstants.splashScreen,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
