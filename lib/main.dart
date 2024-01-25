import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/login/cubit/login_cubit.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

late Size mq;

const appId = "62b3eb641dbd4ca7a203c41ce90dbca2";
const token = "007eJxTYGDl0Sp3jbE33hR+YO2ElWvTrd9fq/YsaPX0m7zTKf3RO24FBjOjJOPUJDMTw5SkFJPkRPNEIwPjZBPD5FRLg5Sk5EQj4TUbUhsCGRlOXUxiYIRCEJ+FoSS1uISBAQAICh+J";
const channel = "test";

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

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  try {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  } on PlatformException catch (e) {
    print("Error requesting FCM permissions: $e");
  }

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print('Message from: ${message.from}');
    print('Message senderId: ${message.senderId}');
    print('Message category: ${message.category}');
    print('Received notification: ${message.notification?.body}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (message.notification != null) {

      print('Message also contained a notification: ${message.notification}');
      // AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      //     "channelId", "Channel Name",
      //     importance: Importance.max);
      // FlutterLocalNotificationsPlugin().show(
      //   notification.hashCode,
      //   notification?.title,
      //   notification?.body,
      //   NotificationDetails(
      //     android: androidDetails
      //   ),
      // );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);




  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Extract call details from message data
  String? type = message.data["type"];
  String? callerUid = message.data["caller_uid"];
  if (type == "call_notification") {
    print("Type-- $type");
    try {
      await showIncomingCallNotification(callerUid!);
    } on Exception catch (e) {
      print("Error handling incoming call notification: $e");
    }
  }
  else{
    print("Type-- else $type");
  }
}


Future<void> showIncomingCallNotification(String callerUid) async {
  // Get caller information using callerUid
  try {
    FirebaseUtils.getUserInfo(callerUid).listen((snapshot) {
      UserModel caller = UserModel.fromJson(snapshot.data() ?? {});
      // Build notification content
      String notificationTitle = "${caller.name} is calling";
      String notificationBody = "Tap to answer the call";
      // Set notification payload
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
          "channelId", "Channel Name",
          importance: Importance.max);
      NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);
      // Show notification
      FlutterLocalNotificationsPlugin().show(
          0, notificationTitle, notificationBody, platformDetails,
          payload: callerUid); // payload: {'callerUid': callerUid}
    });
  } catch (e) {
    print("showIncomingCallNotification $e");
  }
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
      ],
      child: MaterialApp(
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
