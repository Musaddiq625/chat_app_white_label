import 'dart:convert';

import 'package:chat_app_white_label/src/models/call_data_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

const appId = "dd77f448b0004006b22181d772231fd0";
const token =
    "007eJxTYNC2vlHDFNvGcuVWxfYfzG7S9kLGj1hUrcL899drNlS6SyowpKSYm6eZmFgkGRgYmBgYmCUZGRlaGAIFjYyMDdNSDJii7qQ2BDIySGlasTAyQCCIz8JQklpcwsAAAOhxGcE=";
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
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LoggerUtil.logs("Handling a background message: ${message.messageId}");

  await Firebase.initializeApp();
  final getIt = GetIt.I;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Check if FirebaseService is already registered
  if (!getIt.isRegistered<FirebaseService>()) {
    // If not registered, register it as a singleton
    getIt.registerSingleton(FirebaseService());
  }
  if (message.data["messageType"] == 'message') {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'message_id',
      'Chat Message',
      importance: Importance.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      '${message.data["senderName"]}',
      message.data["chatType"] == 'text'
          ? '${message.data["chatMessage"]}'
          : '${message.data["chatType"]}',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }
  else {
    try {
      try {
        FirebaseNotificationUtils.callData =
            CallDataModel.fromJson(message.data);
        print(
            'Initialized callData: ${FirebaseNotificationUtils.callData.toJson()}');
      } catch (e) {
        print('Error initializing CallDataModel: $e');
      }
      callId = message.data["callId"];
      callerNumber = message.data["callerNumber"];
      FirebaseNotificationUtils.listenForCallStatusChanges(
          callId, int.parse(callerNumber));
      FirebaseNotificationUtils.initializeLocalNotifications();
      print("_callType 0 ${FirebaseNotificationUtils.callData.messageType}");
      LoggerUtil.logs('sdsds.data ${message.data}');

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
      // Your background message handling logic here
      // Same as the logic in getNotificationsBackground method
    } catch (e) {
      print("Error handling background message: $e");
    }
  }
}
