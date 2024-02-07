import 'dart:async';

import 'package:chat_app_white_label/agora_video_calling.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
import '../../constants/firebase_constants.dart';
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
  String _callId = "";
  String _callerNumber = "";
  var uuid = const Uuid();
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;

  String? callerName;
  String? callerPhoneNumber;
  String? selectedNotificationPayload;

  // String phoneRingtoneUri = 'content://settings/system/ringtone';
  //final phoneRingtoneSound = UriAndroidNotificationSound(phoneRingtoneUri);

  late final phoneRingtoneSound;

  void initializeNotification() {}

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
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
          }
          catch(e){
            print("error $e");
          }
    });
  }


  Future<List<Contact>> getLocalContacts() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
  }

  Future<void> requestCameraAndMicPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    final microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
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
    // FirebaseMessaging.onBackgroundMessage(getflutterCallKitIncoming);
  }

  final FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
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
    print(
        "Action Id ${payload.actionId}  paylod ${payload.payload} type ${payload.notificationResponseType}");
    if (payload.actionId == "accept_action") {
      print('Call accepted. Payload: $payload');
      if (_callType == "call") {
        FirebaseUtils.updateCallsOnReceiveOrReject(true ,_callId);
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => AgoraCalling(
                recipientUid: int.parse(callerPhoneNumber!),
                callerName: callerName,
                callerNumber: callerPhoneNumber,
                callId : _callId)));
      } else if (_callType == "video_call") {
        FirebaseUtils.updateCallsOnReceiveOrReject(true ,_callId);
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => AgoraVideoCalling(
                recipientUid: int.parse(callerPhoneNumber!),
                callerName: callerName,
                callerNumber: callerPhoneNumber,
              callId : _callId
            )));
      }
    } else if (payload.actionId == "reject_action") {
      FirebaseUtils.updateCallsOnReceiveOrReject(false ,_callId);
      print('Call rejected. Payload: $payload');
    }
  }

  Future<void> getNotificationsForground() async {
    // final alarmManager = AndroidAlarmManager.instance;
    // final ringtoneUri = await alarmManager.getAlarmUri(AlarmType.ringtone);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');
      // print('Message from: ${message.from}');
      // print('Message senderId: ${message.senderId}');
      // print('Message category: ${message.category}');
      // print('Received notification title : ${message.notification?.title}');
      // print('Received notification body : ${message.notification?.body}');
      // print('Received notification type : ${message.data["messageType"]}');
      _callType = message.data["messageType"];
      _callId = message.data["callId"];
      _callerNumber = message.data["callerNumber"];
      _listenForCallStatusChanges(_callId,int.parse(_callerNumber));
      if (message.notification != null) {
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
              payload: 'incoming_call',
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
              payload: 'incoming_call',
            );
          }
        }
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');
    // print('Message from: ${message.from}');
    // print('Message senderId: ${message.senderId}');
    // print('Message category: ${message.category}');
    // print('Received notification title : ${message.notification?.title}');
    // print('Received notification body : ${message.notification?.body}');
    // print('Received notification type : ${message.data["messageType"]}');      // print('Got a message whilst in the foreground!');
    //       print('Message data: ${message.data}');
    //       print('Message from: ${message.from}');
    //       print('Message senderId: ${message.senderId}');
    //       print('Message category: ${message.category}');
    //       print('Received notification title : ${message.notification?.title}');
    //       print('Received notification body : ${message.notification?.body}');
    //       print('Received notification type : ${message.data["messageType"]}');
    String? type = message.data["type"];
    String? callerUid = message.data["caller_uid"];
    _callType = message.data["messageType"];
    if (message.notification != null) {
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
            payload: 'incoming_call',
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
            payload: 'incoming_call',
          );
        }
      }
    } else {
      print("Type-- else $type");
    }
  }

  Future<void> showIncomingCallNotification(String callerUid) async {
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
}
