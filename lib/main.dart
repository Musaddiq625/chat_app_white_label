import 'dart:convert';

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
    "007eJxTYNC2vlHDFNvGcuVWxfYfzG7S9kLGj1hUrcL899drNlS6SyowpKSYm6eZmFgkGRgYmBgYmCUZGRlaGAIFjYyMDdNSDJii7qQ2BDIySGlasTAyQCCIz8JQklpcwsAAAOhxGcE=";
const channel = "test";
String callId = "";
String? callerName;
String? callerPhoneNumber;
String? selectedNotificationPayload;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final getIt = GetIt.I;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (!getIt.isRegistered<FirebaseService>()) {
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
    callId = message.data["callId"];
    FirebaseNotificationUtils.listenForCallStatusChanges(
        callId, int.parse(message.data["callerNumber"]));
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

    if (message.data["messageType"] == "call") {
      String? phoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
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
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Video Call',
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
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Group Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          sound:
              UriAndroidNotificationSound('content://settings/system/ringtone'),
          enableVibration: true,
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
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Incoming Group Video Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          sound:
              UriAndroidNotificationSound('content://settings/system/ringtone'),
          enableVibration: true,
          ongoing: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept_action', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction(
              'reject_action',
              'Reject',
              cancelNotification: true,
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
    else if (message.data["messageType"] == "missed-call") {
      String? phoneNumber = message.data["callerNumber"];
      callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Missed Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          enableVibration: true,
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Missed Call',
          'You have missed a call from $callerName',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }
    else if (message.data["messageType"] == "missed-video-call") {
      String? phoneNumber = message.data["callerNumber"];
      callerPhoneNumber = message.data["callerNumber"];
      callerName = message.data["callerName"];
      if (phoneNumber != null) {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'test',
          'Missed Call',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          enableLights: true,
          enableVibration: true,
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Missed Video Call',
          'You have missed a Video call from $callerName',
          platformChannelSpecifics,
          payload: payloadString,
        );
      }
    }
  } catch (e) {
    print("Error handling background message: $e");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

// void main() => runApp(const BottomNavigationBarExampleApp());
//
// class BottomNavigationBarExampleApp extends StatelessWidget {
//   const BottomNavigationBarExampleApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: BottomNavBar(),
//     );
//   }
// }

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
        initialRoute: RouteConstants.splashScreen,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
