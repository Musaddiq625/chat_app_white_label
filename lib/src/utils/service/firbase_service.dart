import 'package:chat_app_white_label/agora_video_calling.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
import '../../models/usert_model.dart';
import '../../screens/agora_calling.dart';
import '../../screens/incoming_call_screen.dart';
import '../firebase_utils.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  String _currentUuid = '';
  String _callType = '';
  var uuid = Uuid();

  String? callerName;
  String? callerPhoneNumber;

  Future<void> requestPermission() async {
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

  Future<void> getmessagingPermission() async {
    try {
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } on PlatformException catch (e) {
      LoggerUtil.logs("Error requesting FCM permissions: $e");
    }
  }

  Future<void> getNotificationSettings() async {
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
  }


  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> getNotificationsBackground() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> getNotificationsForground() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message from: ${message.from}');
      print('Message senderId: ${message.senderId}');
      print('Message category: ${message.category}');
      print('Received notification title : ${message.notification?.title}');
      print('Received notification body : ${message.notification?.body}');
      print('Received notification type : ${message.data["messageType"]}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // if (message.notification != null) {
      //   if (message.data != null && message.data["messageType"] == "call") {
      //     String? phoneNumber = FirebaseUtils.user?.phoneNumber;
      //     if (phoneNumber != null) {
      //       navigatorKey.currentState!.push(MaterialPageRoute(
      //           builder: (context) =>
      //               AgoraCalling(recipientUid: int.parse(phoneNumber))));
      //     }
      //   }
      //   print('Message also contained a notification: ${message.notification}');
      // }

      _callType= message.data["messageType"];

      if (message.notification != null) {
        if (message.data["messageType"] == "call") {
          String? phoneNumber = message.data["callerNumber"];
          callerPhoneNumber = message.data["callerNumber"];
          callerName = message.data["callerName"];
          if (phoneNumber != null) {
            // Generate a unique UUID for the call
            this._currentUuid = uuid.v4();

            // showCallkitIncoming(_currentUuid);
            CallKitParams params = CallKitParams(
              id: this._currentUuid,
              nameCaller: callerName,
              handle: phoneNumber,
              type: 1,
              extra: <String, dynamic>{'userId': '1a2b3c4d'},
            );

            FlutterCallkitIncoming.showCallkitIncoming(params);
            FlutterCallkitIncoming.showMissCallNotification(params);
            // getflutterCallKitIncoming().catchError((error) {
            //   print("An error occurred: $error");
            // });
          }
        }
        else if ( message.data["messageType"] == "video_call") {
          String? phoneNumber = message.data["callerNumber"];
          callerPhoneNumber = message.data["callerNumber"];
          callerName = message.data["callerName"];
          if (phoneNumber != null) {
            // Generate a unique UUID for the call
            this._currentUuid = uuid.v4();

            // showCallkitIncoming(_currentUuid);
            CallKitParams params = CallKitParams(
              id: this._currentUuid,
              nameCaller: callerName,
              handle: phoneNumber,
              type: 1,
              extra: <String, dynamic>{'userId': '1a2b3c4d'},
            );

            FlutterCallkitIncoming.showCallkitIncoming(params);
            FlutterCallkitIncoming.showMissCallNotification(params);
            // getflutterCallKitIncoming().catchError((error) {
            //   print("An error occurred: $error");
            // });
          }
        }
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // });
  }

  // Future<void> showCallkitIncoming(String uuid) async {
  //   // final params = CallKitParams(
  //   //   id: uuid,
  //   //   nameCaller: 'Hien Nguyen',
  //   //   appName: 'Callkit',
  //   //   avatar: 'https://i.pravatar.cc/100',
  //   //   handle: '0123456789',
  //   //   type: 0,
  //   //   duration: 30000,
  //   //   textAccept: 'Accept',
  //   //   textDecline: 'Decline',
  //   //   missedCallNotification: const NotificationParams(
  //   //     showNotification: true,
  //   //     isShowCallback: true,
  //   //     subtitle: 'Missed call',
  //   //     callbackText: 'Call back',
  //   //   ),
  //   //   extra: <String, dynamic>{'userId': '1a2b3c4d'},
  //   //   headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
  //   //   android: const AndroidParams(
  //   //     isCustomNotification: true,
  //   //     isShowLogo: false,
  //   //     ringtonePath: 'system_ringtone_default',
  //   //     backgroundColor: '#0955fa',
  //   //     backgroundUrl: 'assets/test.png',
  //   //     actionColor: '#4CAF50',
  //   //     textColor: '#ffffff',
  //   //   ),
  //   //   ios: const IOSParams(
  //   //     iconName: 'CallKitLogo',
  //   //     handleType: '',
  //   //     supportsVideo: true,
  //   //     maximumCallGroups: 2,
  //   //     maximumCallsPerCallGroup: 1,
  //   //     audioSessionMode: 'default',
  //   //     audioSessionActive: true,
  //   //     audioSessionPreferredSampleRate: 44100.0,
  //   //     audioSessionPreferredIOBufferDuration: 0.005,
  //   //     supportsDTMF: true,
  //   //     supportsHolding: true,
  //   //     supportsGrouping: false,
  //   //     supportsUngrouping: false,
  //   //     ringtonePath: 'system_ringtone_default',
  //   //   ),
  //   // );
  //   await
  // }

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

  Future<void> getflutterCallKitIncoming() async {
    String? phoneNumber = FirebaseUtils.phoneNumber;
    String? phoneNumberId = FirebaseUtils.user?.id;


    print("Before Event");
    print("firebasephoneNumber $phoneNumber  userId : $phoneNumberId");



    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      print("Event $event");

      if (event == null) return;

      switch (event.event) {

        // case Event.actionCallIncoming:
        //   // Show incoming call UI here
        //   String phoneNumber = callerPhoneNumber ?? "xxxxxxxxxxx";
        //   String callersName = callerName ?? "Unknown";
        //   navigatorKey.currentState!.push(MaterialPageRoute(
        //       builder: (context) => IncomingCallScreen(
        //           callerName: callersName,
        //           callerNumber: phoneNumber,
        //           currentUid: _currentUuid)));
        //   break;
        case Event.actionCallAccept:
          // Navigate to call screen

        if(phoneNumber != null) {
          print("callType $_callType");
          if(_callType == "call"){
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) =>
                    AgoraCalling(recipientUid: int.parse(phoneNumber))));
          }
          else if(_callType == "video_call"){
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) =>
                    AgoraVideoCalling(recipientUid: int.parse(phoneNumber))));
          }
        }
        else{
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
