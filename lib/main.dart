import 'dart:convert';
import 'dart:io';

import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/call_data_model.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/cubit/group_chat_room_cubit.dart';
import 'package:chat_app_white_label/src/screens/login/cubit/login_cubit.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
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

const appId = "dd77f448b0004006b22181d772231fd0";
const token =
    "007eJxTYJCtf1Gx6c4Ns12hcg7XC/fmRfonu7351n8l89Hd/z0zVt1SYEhJMTdPMzGxSDIwMDAxMDBLMjIytDAEChoZGRumpRjs8L6e2hDIyCAUs4KBEQpBfBaGktTiEgYGABtnIcs=";
const channel = "test";
String callType = '';
String callId = "";
String callerNumber = "";

String? callerName;
String? callerPhoneNumber;
String? selectedNotificationPayload;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  //
  await Firebase.initializeApp();
  final getIt = GetIt.I;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Check if FirebaseService is already registered
  if (!getIt.isRegistered<FirebaseService>()) {
    // If not registered, register it as a singleton
    getIt.registerSingleton(FirebaseService());
  }
  final messegingService = getIt<FirebaseService>();

  try {
    try {
      FirebaseNotificationUtils.callData = CallDataModel.fromJson(message.data);
      print(
          'Initialized callData: ${FirebaseNotificationUtils.callData.toJson()}');
    } catch (e) {
      print('Error initializing CallDataModel: $e');
    }
    FirebaseNotificationUtils.initializeLocalNotifications();
    messegingService.handleIncomingCall(messegingService.callData);
    print("_callType 0 ${FirebaseNotificationUtils.callData.messageType}");

    final data = {
      "callType": "background",
      "messageType": message.data["messageType"],
      "callId": FirebaseNotificationUtils.callData.callId,
      "callerName": FirebaseNotificationUtils.callData.callerName,
      "callerNumber": FirebaseNotificationUtils.callData.callerNumber,
    };
    final payloadString = jsonEncode(data);

    final String? action = message.data["action"];

    if (action == "accept_action") {
      // User tapped on "Accept" action, open the app or perform desired action
      // based on your app logic
    } else if (action == "reject_action") {
      // User tapped on "Reject" action, do not open the app
      return;
    }

    if (message.data["messageType"] == "call") {
      String? phoneNumber = message.data["callerNumber"];
      // callData.callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
        // await initializeLocalNotifications();
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          sound:
              UriAndroidNotificationSound('content://settings/system/ringtone'),
          enableVibration: true,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept_action', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction(
              'reject_action',
              'Reject',
              showsUserInterface: true,
            ),
          ],
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Incoming Call',
          'You have a new call from ${callerName}',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }
    else if (message.data["messageType"] == "video_call") {
      String? phoneNumber = message.data["callerNumber"];
      callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
        // await initializeLocalNotifications();
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Video Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          enableVibration: true,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept_action', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction(
              'reject_action',
              'Reject',
              showsUserInterface: true,
            ),
          ],
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Incoming Video Call',
          'You have a new call from ${callerName}',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }
    else if (message.data["messageType"] == "group_call") {
      String? phoneNumber = message.data["callerNumber"];
      callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];

      if (phoneNumber != null) {
        // await initializeLocalNotifications();
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Group Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          enableVibration: true,
          // playSound: true,
          ongoing: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept_action', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction(
              'reject_action',
              'Reject',
              cancelNotification: true,
              showsUserInterface: true,
            ),
          ],
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          1,
          'Incoming Group Call',
          'You have a new group call from ${callerName}',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }
    else if (message.data["messageType"] == "group_video_call") {
      String? phoneNumber = message.data["callerNumber"];
      callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
        // await initializeLocalNotifications();
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Group Video Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          enableVibration: true,
          // playSound: true,
          ongoing: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept_action', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction(
              'reject_action',
              'Reject',
              cancelNotification: true,
              // showsUserInterface: true,
            ),
          ],
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Incoming Group Video Call',
          'You have a new group video call from ${callerName}',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }

    // Your background message handling logic here
    // Same as the logic in getNotificationsBackground method
  } catch (e) {
    print("Error handling background message: $e");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // print(
  //     "flutterLocalNotificationsPlugin-splash $flutterLocalNotificationsPlugin");
  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   NotificationResponse? notificationResponse =
  //       notificationAppLaunchDetails!.notificationResponse;
  //   print("notificationResponse?.actionId ${notificationResponse?.actionId}");
  //   if (notificationResponse?.actionId == "reject_action") {
  //     exit(0);
  //   }
  //   selectedNotificationPayload = notificationAppLaunchDetails.notificationResponse?.payload;
  //   print("selectedNotificationPayload-splash ${selectedNotificationPayload}");
  // }

  await Firebase.initializeApp();
  FirebaseNotificationUtils.getNotificationSettings();
  FirebaseNotificationUtils.initializeLocalNotifications();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print("USER ${FirebaseAuth.instance.currentUser?.uid}");
  await _initRepos();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.greenMain,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  runApp(const MyApp());
}

Future<void> _initRepos() async {
  getIt.registerSingleton(FirebaseService());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
