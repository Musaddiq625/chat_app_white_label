import 'package:chat_app_white_label/agora_video_calling.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../../../main.dart';
import '../../models/usert_model.dart';
import '../../screens/agora_calling.dart';
import '../firebase_utils.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  String _currentUuid = '';
  String _callType = '';
  var uuid = const Uuid();

  String? callerName;
  String? callerPhoneNumber;

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
  }

  Future<List<Contact>> getLocalContacts() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
  }

  Future<void> requestCameraAndMicPermission() async {
    await [Permission.camera, Permission.microphone].request();
  }

  Future<void> getNotificationSettings() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );
      LoggerUtil.logs(
          'User granted permission: ${settings.authorizationStatus}');
    } catch (e) {
      LoggerUtil.logs(e.toString());
    }
  }

  Future<void> getNotificationsBackground() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> getNotificationsForground() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');
      // print('Message from: ${message.from}');
      // print('Message senderId: ${message.senderId}');
      // print('Message category: ${message.category}');
      // print('Received notification title : ${message.notification?.title}');
      // print('Received notification body : ${message.notification?.body}');
      // print('Received notification type : ${message.data["messageType"]}');

      _callType = message.data["messageType"];

      if (message.notification != null) {
        if (message.data["messageType"] == "call") {
          String? phoneNumber = message.data["callerNumber"];
          callerPhoneNumber = message.data["callerNumber"];
          callerName = message.data["callerName"];
          if (phoneNumber != null) {
            // Generate a unique UUID for the call
            _currentUuid = uuid.v4();

            CallKitParams params = CallKitParams(
              id: _currentUuid,
              nameCaller: callerName,
              handle: phoneNumber,
              type: 1,
              extra: <String, dynamic>{'userId': '1a2b3c4d'},
            );

            FlutterCallkitIncoming.showCallkitIncoming(params);
            FlutterCallkitIncoming.showMissCallNotification(params);
          }
        } else if (message.data["messageType"] == "video_call") {
          String? phoneNumber = message.data["callerNumber"];
          callerPhoneNumber = message.data["callerNumber"];
          callerName = message.data["callerName"];
          if (phoneNumber != null) {
            // Generate a unique UUID for the call
            _currentUuid = uuid.v4();
            CallKitParams params = CallKitParams(
              id: _currentUuid,
              nameCaller: callerName,
              handle: phoneNumber,
              type: 1,
              extra: <String, dynamic>{'userId': '1a2b3c4d'},
            );

            FlutterCallkitIncoming.showCallkitIncoming(params);
            FlutterCallkitIncoming.showMissCallNotification(params);
          }
        }
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
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
    } else {
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
        AndroidNotificationDetails androidDetails =
            const AndroidNotificationDetails("channelId", "Channel Name",
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

  Future<void> getflutterCallKitIncoming() async {
    String? phoneNumber = FirebaseUtils.phoneNumber;
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      print("Event $event");
      if (event == null) return;
      switch (event.event) {
        case Event.actionCallAccept:
          // Navigate to call screen
          if (phoneNumber != null) {
            print("callType $_callType");
            if (_callType == "call") {
              navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) =>
                      AgoraCalling(recipientUid: int.parse(phoneNumber))));
            } else if (_callType == "video_call") {
              navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) =>
                      AgoraVideoCalling(recipientUid: int.parse(phoneNumber))));
            }
          } else {
            print("No Number $phoneNumber");
          }
          break;
        case Event.actionCallDecline:
          await FlutterCallkitIncoming.endCall(_currentUuid);
          break;
        case Event.actionCallStart:
          break;
        default:
          // Handle other events as needed
          break;
      }
    });
  }
}
