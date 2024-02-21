import 'dart:async';
import 'dart:convert';

import 'package:chat_app_white_label/agora_video_calling.dart';
import 'package:chat_app_white_label/src/screens/agora_group_calling.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
import '../../constants/firebase_constants.dart';
import '../../models/call_data_model.dart';
import '../../models/usert_model.dart';
import '../../screens/agora_calling.dart';
import '../../screens/agora_group_video_calling.dart';
import '../firebase_utils.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  String _currentUuid = '';
  String _callType = '';
  String _callId = "";
  String _callerNumber = "";
  var uuid = const Uuid();
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;
  CallDataModel callData = CallDataModel();

  String? callerName;
  String? callerPhoneNumber;
  String? selectedNotificationPayload;

  late final phoneRingtoneSound;


  void initializeNotification() {}

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
  }

  void handleIncomingCall(CallDataModel callDatas) {
    print("callData ${callData.toJson()}");
    print("_callType  1 ${callData.messageType}");
    // ... rest of your logic ...
  }

  void _listenForCallStatusChanges(String callId, int callnumber) {
    _callStatusSubscription = FirebaseUtils.firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(callId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      try {
        if (snapshot.exists && snapshot['is_call_active'] == false) {
          _callStatusSubscription
              ?.cancel(); // Check if the widget is still mounted
          FirebaseUtils.firebaseService.flutterLocalNotificationsPlugin
              .cancel(0); // Leave the channel if is_call_active is false
          // Leave the channel if is_call_active is false
        }
      } catch (e) {
        print("error _listenForCallStatusChanges $e");
      }
    });
  }

  Future<List<Contact>> getLocalContacts() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
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

  void backgroundincomingCall(NotificationResponse payload) {
    var payloadMap = jsonDecode(payload.payload!) as Map<String, dynamic>;
    var messageType = payloadMap["messageType"];
    var callId = payloadMap["callId"];
    var callerName = payloadMap["callerName"];
    var callerNumber = payloadMap["callerNumber"];
    print(
        "Action Id ${payload.actionId} hello paylod ${payload.payload} type ${payload.notificationResponseType}");
    if (payload.actionId == "accept_action") {
      print('Call accepted. Payload: ${payload.payload}');
      print("_callType 1 ${messageType}");

      if (messageType == "call") {
        try {
          FirebaseUtils.updateCallsOnReceiveOfUser(
              [FirebaseUtils.phoneNumber!], callId);
          FirebaseUtils.updateCallsOnReceiveOrReject(true, callId);
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => AgoraCalling(
                    recipientUid: int.parse(callerNumber),
                    callerName: callerName,
                    callerNumber: callerNumber,
                    callId: callId,
                  )));
        } catch (e) {
          print("Error Call $e");
        }
      } else if (messageType == "video_call") {
        try {
          FirebaseUtils.updateCallsOnReceiveOfUser(
              [FirebaseUtils.phoneNumber!], callId);
          FirebaseUtils.updateCallsOnReceiveOrReject(true, callId);
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => AgoraVideoCalling(
                    recipientUid: int.parse(callerNumber!),
                    callerName: callerName,
                    callerNumber: callerNumber,
                    callId: callId,
                  )));
        } catch (e) {
          print("Error videocall $e");
        }
      } else if (messageType == "group_call") {
        try {
          print(
              "Hello calltype ${messageType} callerNumber ${callerNumber} callerName ${callerName} callId${callId} FirebaseUtils.phoneNumber${FirebaseUtils.phoneNumber} ");
          try {
            FirebaseUtils.updateCallsOnReceiveOfUser(
                [FirebaseUtils.phoneNumber!], callId);
          } catch (e) {
            print("error 0 $e");
          }
          try {
            FirebaseUtils.updateCallsOnReceiveOrReject(true, callId);
          } catch (e) {
            print("error 1 $e");
          }
          try {
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => AgoraGroupCalling(
                      recipientUid: int.parse(callerNumber!),
                      callerName: callerName,
                      callerNumber: callerNumber,
                      callId: callId,
                      ownNumber: int.parse(FirebaseUtils.phoneNumber!),
                    )));
          } catch (e) {
            print("error 2 $e");
          }
        } catch (e) {
          print("GroupCall Error $e");
        }
      } else if (messageType == "group_video_call") {
        try {
          FirebaseUtils.updateCallsOnReceiveOfUser(
              [FirebaseUtils.phoneNumber!], callId);
          FirebaseUtils.updateCallsOnReceiveOrReject(true, callId);
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => AgoraGroupVideoCalling(
                    recipientUid: int.parse(callerNumber!),
                    callerName: callerName,
                    callerNumber: callerNumber,
                    ownNumber: int.parse(FirebaseUtils.phoneNumber!),
                    callId: callId,
                  )));
        } catch (e) {
          print("Error video group call $e");
        }
      }
    } else if (payload.actionId == "reject_action") {
      FirebaseUtils.updateCallsOnReceiveOrReject(false, callId);
      print('Call rejected. Payload: $payload');
      flutterLocalNotificationsPlugin.cancel(1);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // SystemNavigator.pop();
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotifications() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb
        ? null
        : await flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    print("notificationAppLaunchDetails ${notificationAppLaunchDetails}");
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      print("selectedNotificationPayload ${selectedNotificationPayload}");
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: incomingCall,
      // onDidReceiveBackgroundNotificationResponse: incomingCall
    );
  }

  void incomingCall(NotificationResponse payload) {



    try {
      print("payload $payload");
      print("Payload-payload ${payload.payload}");
      print(
          "Action Id ${payload.actionId} hello paylod ${payload.payload} type ${payload.notificationResponseType}");
      var payloadMap = jsonDecode(payload.payload!) as Map<String, dynamic>;
      var callType = payloadMap["callType"];
      var messageType = payloadMap["messageType"];
      print("Typepayload $messageType");

      if (callType == "background") {
        print("call data type ${messageType}");
        backgroundincomingCall(payload);
      } else {
        print(
            "Action Id ${payload.actionId} hello paylod ${payload.payload} type ${payload.notificationResponseType}");
        print("_callType ${_callType}");

        if (payload.actionId == "accept_action") {
          print('Call accepted. Payload: ${payload.payload}');
          if (_callType == "call") {
            FirebaseUtils.updateCallsOnReceiveOfUser(
                [FirebaseUtils.phoneNumber!], _callId);
            FirebaseUtils.updateCallsOnReceiveOrReject(true, _callId);
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => AgoraCalling(
                    recipientUid: int.parse(callerPhoneNumber!),
                    callerName: callerName,
                    callerNumber: callerPhoneNumber,
                    callId: _callId)));
          } else if (_callType == "video_call") {
            FirebaseUtils.updateCallsOnReceiveOfUser(
                [FirebaseUtils.phoneNumber!], _callId);
            FirebaseUtils.updateCallsOnReceiveOrReject(true, _callId);
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => AgoraVideoCalling(
                    recipientUid: int.parse(callerPhoneNumber!),
                    callerName: callerName,
                    callerNumber: callerPhoneNumber,
                    callId: _callId)));
          } else if (_callType == "group_call") {
            FirebaseUtils.updateCallsOnReceiveOfUser(
                [FirebaseUtils.phoneNumber!], _callId);
            FirebaseUtils.updateCallsOnReceiveOrReject(true, _callId);
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => AgoraGroupCalling(
                      recipientUid: int.parse(callerPhoneNumber!),
                      callerName: callerName,
                      callerNumber: callerPhoneNumber,
                      callId: _callId,
                      ownNumber: int.parse(FirebaseUtils.phoneNumber!),
                    )));
          } else if (_callType == "group_video_call") {
            FirebaseUtils.updateCallsOnReceiveOfUser(
                [FirebaseUtils.phoneNumber!], _callId);
            FirebaseUtils.updateCallsOnReceiveOrReject(true, _callId);
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => AgoraGroupVideoCalling(
                    recipientUid: int.parse(callerPhoneNumber ?? "0"),
                    callerName: callerName,
                    callerNumber: callerPhoneNumber,
                    ownNumber: int.parse(FirebaseUtils.phoneNumber!),
                    callId: _callId)));
          }
        } else if (payload.actionId == "reject_action") {
          FirebaseUtils.updateCallsOnReceiveOrReject(false, _callId);
          print('Call rejected. Payload: $payload');
        }
      }
    } catch (e) {
      print("incomingcall error $e");
    }
  }



  Future<void> getNotificationsForground() async {

    //
    // final ringtoneManager = RingtoneManager(
    //   android: AndroidRingtoneManager.defaultRingtoneUri,
    // );
    // final ringtoneUri = await ringtoneManager.getDefaultRingtoneUri();
    // const ringtoneUri = await FlutterRingtonePlayer.playRingtone();
    // const defaultRingtone = AndroidNotificationSound('default_ringtone.mp3');
    // AndroidNotificationSound defaultRingtone = FlutterRingtonePlayer.playRingtone();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final data = {
        "callType": "forground",
        "messageType": message.data["messageType"],
        "callId": callData.callId,
        "callerName": callData.callerName,
        "callerNumber": callData.callerNumber,
      };
      final payloadString = jsonEncode(data);
      _callType = message.data["messageType"];
      _callId = message.data["callId"];
      _callerNumber = message.data["callerNumber"];
      _listenForCallStatusChanges(_callId, int.parse(_callerNumber));
      if (message.data["messageType"] == "call") {
        String? phoneNumber = message.data["callerNumber"];
        callerPhoneNumber = message.data["callerNumber"];
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
            enableVibration: true,
            playSound: true,

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
            'You have a new call from $callerName',
            platformChannelSpecifics,
            payload: payloadString,
          );
        }
      } else if (message.data["messageType"] == "video_call") {
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
            // playSound: true,
            ongoing: true,
            audioAttributesUsage: AudioAttributesUsage.alarm,
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
            'You have a new call from $callerName',
            platformChannelSpecifics,
            payload: payloadString,
          );
        }
      } else if (message.data["messageType"] == "group_call") {
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
                showsUserInterface: true,
              ),
            ],
          );
          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            0,
            'Incoming Group Call',
            'You have a new group call from $callerName',
            platformChannelSpecifics,
            payload: payloadString,
          );
        }
      } else if (message.data["messageType"] == "group_video_call") {
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
                showsUserInterface: true,
              ),
            ],
          );
          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
            0,
            'Incoming Group Video Call',
            'You have a new group video call from $callerName',
            platformChannelSpecifics,
            payload: payloadString,
          );
        }
      }
      print('Message also contained a notification: ${message.notification}');
    });
  }
}
