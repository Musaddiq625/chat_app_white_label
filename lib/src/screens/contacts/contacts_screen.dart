import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../main.dart';
import '../../constants/color_constants.dart';
import 'package:http/http.dart' as http;
import '../agora_calling.dart';

class ContactsScreen extends StatefulWidget  {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();
  List<Contact> localContacts = [];
  List<ContactModel> contactToDisplay = [];
  late RtcEngine _engine;
  final _eventHandler = const RtcEngineEventHandler();

  final String agoraAppId = '62b3eb641dbd4ca7a203c41ce90dbca2';

  @override
  void initState() {
    super.initState();
    // _initAgora();
    initAgora();
    // _fetchLocalContacts();
    // _initFirebaseMessaging();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      localContacts = await ContactsService.getContacts(withThumbnails: false);
    });
  }

  @override
  void didJoinedOfUid(int uid, int elapsed) {
    print('User joined: $uid');
    // Show a notification or dialog to inform the user about the incoming call
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle incoming call notification here
    print("Received background message: ${message.data}");
  }



  Future<void> initAgora() async{
  await [Permission.microphone, Permission.camera].request();

  //create the engine

  _engine = createAgoraRtcEngine();
  await _engine.initialize(const RtcEngineContext(
  appId: appId,
  channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  ));
  _engine.registerEventHandler(_eventHandler);
  // await _engine.setEventHandler(this);
}

  getContactsToDisplay(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    contactToDisplay.clear();
    for (var i = 0; i < localContacts.length; i++) {
      String? localNumber = (localContacts[i].phones ?? [])
          .map((item) => item.value)
          .toList()
          .firstWhere((phone) => phone != null && phone.trim().isNotEmpty, orElse: () => null)
          ?.replaceAll(' ', '')
          .replaceAll('+', '');
      if ((localNumber ?? '').startsWith('0')) {
        localNumber = localNumber?.replaceFirst('0', '92');
      }
      bool contactExist = (snapshot.data?.docs ?? [])
          .any((firebaseUser) => firebaseUser.id == localNumber);
      // .any for filtering in Firebase users
      if (contactExist) {
        contactToDisplay.add(ContactModel(
            localName: localContacts[i].displayName,
            phoneNumber: localNumber ?? ''));
      }
    }
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'call_notification') {
      print("FCM Message succsess ${(message.data['type'])}");
      // Navigator.pushNamed(context, '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
    else{
      print("FCM Message fail ${(message.data['type'])}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.greenMain,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
              ),
              color: ColorConstants.white,
            ),
            const Text(
              'Select Contacts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
            color: ColorConstants.white,
          ),
          IconButton(
            onPressed: () {
              NavigationUtil.pop(context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 28,
            ),
            color: ColorConstants.white,
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseUtils.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching contacts'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if ((snapshot.data?.docs ?? []).isEmpty) {
              return const Center(
                child: Text("No Contacts Available !"),
              );
            }
            getContactsToDisplay(snapshot);
            if (contactToDisplay.isNotEmpty) {
              return ListView.builder(
                itemCount: contactToDisplay.length,
                padding: const EdgeInsets.only(top: 7),
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: FirebaseUtils.getChatUser(
                          contactToDisplay[index].phoneNumber ?? ''),
                      builder: (context, asyncSnapshot) {
                        UserModel firebaseUser = UserModel.fromJson(
                            asyncSnapshot.data?.data() ?? {});
                        return ContactTileComponent(
                          localName: contactToDisplay[index].localName ?? '',
                          chatUser: firebaseUser,
                          onCallTapped: () async {
                            // DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get();
                            int recipientUid = int.parse(firebaseUser.phoneNumber ?? "");
                            print("recipientUid $recipientUid");
                            print("contactToDisplay[index].phoneNumber ${contactToDisplay[index].phoneNumber}");
                            // await _engine.joinChannel(
                            // token: token,
                            // channelId: channel,
                            // uid: recipientUid,
                            // options: const ChannelMediaOptions(),
                            // );

                            Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
                            final data = {
                              "to" : firebaseUser.fcmToken,
                              "notification" : {
                                "title": 'New Call Request',
                                "body" : 'You have a new call request',
                              }
                            };

                            final headers = {
                              'content-type': 'application/json',
                              'Authorization': 'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'
                            };

                            final response = await http.post(postUrl ,
                                body: json.encode(data),
                                encoding: Encoding.getByName('utf-8'),
                                headers: headers);

                            if (response.statusCode == 200) {
                              print('Notification sent successfully');
                            } else {

                              print('Failed to send notification ${response.statusCode}');
                            }
                            // await FirebaseMessaging.instance.sendMessage(
                            //   to: firebaseUser.fcmToken!,
                            //   data: {
                            //     "type": "call_notification",
                            //     "caller_uid": firebaseUser.phoneNumber ?? "",
                            //   }..removeWhere((key, value) => value == null),
                            // );

                            // try {
                            //   if (firebaseUser.fcmToken != null) {
                            //     await FirebaseMessaging.instance.sendMessage(
                            //       to: firebaseUser.fcmToken!,
                            //       data: {
                            //         "type": "call_notification",
                            //         "caller_uid": recipientUid.toString() , // Include relevant call details
                            //       },
                            //     );
                            //   } else {
                            //     print("Firebase token is null.");
                            //   }
                            // } catch (e) {
                            //   print("Failed to send message: $e");
                            // }

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AgoraCalling()),
                            );
                          },
                        );
                      });
                },
              );
            } else {
              return const Center(
                child: Text("No Contacts Available !"),
              );
            }
          }),
    );
  }
}






