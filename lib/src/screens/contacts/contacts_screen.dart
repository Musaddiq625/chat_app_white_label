import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../agora_video_calling.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      localContacts = await ContactsService.getContacts(withThumbnails: false);
    });
  }

  getContactsToDisplay(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    contactToDisplay.clear();
    for (var i = 0; i < localContacts.length; i++) {
      String? localNumber = (localContacts[i].phones ?? [])
          .map((item) => item.value)
          .toList()
          .firstWhere((phone) => phone != null && phone.trim().isNotEmpty,
              orElse: () => null)
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


  Future<void> sendFCM(String fcmToken, String title, String body, Map<String, dynamic> data) async {
    Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'content-type': 'application/json',
      'Authorization':'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'

    };

    final payload = {
      "to": fcmToken,
      "notification": {
        "title": title,
        "body": body,
      },
      "data": data
    };

    final response = await http.post(postUrl,
        body: json.encode(payload),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.greenMain,
        leading: IconButton(
          onPressed: () => NavigationUtil.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
          color: ColorConstants.white,
        ),
        title: const Text(
          'Select Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: const [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.search,
          //     size: 28,
          //   ),
          //   color: ColorConstants.white,
          // ),
          // IconButton(
          //   onPressed: () {
          //     NavigationUtil.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.more_vert_rounded,
          //     size: 28,
          //   ),
          //   color: ColorConstants.white,
          // ),
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
              return Column(
                children: [
                  ListTile(
                    onTap: () => NavigationUtil.push(
                        context, RouteConstants.selectContactsScreen,
                        args: contactToDisplay),
                    leading: const Text(
                      'Create Group',
                      style: TextStyle(
                          color: ColorConstants.greenMain, fontSize: 20),
                    ),
                    trailing: const Icon(
                      Icons.add_circle_outline,
                      color: ColorConstants.greenMain,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: contactToDisplay.length,
                      padding: const EdgeInsets.only(top: 7),
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                            future: FirebaseUtils.getChatUser(
                                contactToDisplay[index].phoneNumber ?? ''),
                            builder: (context, asyncSnapshot) {
                              UserModel firebaseContactUser = UserModel.fromJson(
                                  asyncSnapshot.data?.data() ?? {});
                              contactToDisplay[index].firebaseData =
                                  firebaseContactUser;
                              return ContactTileComponent(
                                localName: contactToDisplay[index].localName ?? '',
                                chatUser: firebaseContactUser,
                                onCallTapped: () async {
                                  int recipientUid = int.parse(firebaseContactUser.phoneNumber ?? "");
                                  String? senderName = FirebaseUtils.user?.name;
                                  String? senderContactNumber = FirebaseUtils.user?.phoneNumber;

                                  print("firebaseContactUser.fcmToken ${firebaseContactUser.fcmToken}");
                                  print("recipientUid $recipientUid");
                                  print("contactToDisplay[index].phoneNumber ${contactToDisplay[index].phoneNumber}");
                                  //
                                  //
                                  // Uri postUrl = Uri.parse(
                                  //     'https://fcm.googleapis.com/fcm/send');
                                  // final data = {
                                  //   "to": firebaseContactUser.fcmToken,
                                  //   "notification": {
                                  //     "title": 'New Call Request',
                                  //     "body": 'You have a new call request',
                                  //   },
                                  //   "data": {
                                  //     "messageType" : "call",
                                  //     "callerName": senderName,
                                  //     "callerNumber": senderContactNumber,
                                  //   }
                                  // };
                                  //
                                  // final headers = {
                                  //   'content-type': 'application/json',
                                  //   'Authorization':
                                  //       'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'
                                  // };
                                  //
                                  // final response = await http.post(postUrl,
                                  //     body: json.encode(data),
                                  //     encoding: Encoding.getByName('utf-8'),
                                  //     headers: headers);
                                  //
                                  // if (response.statusCode == 200) {
                                  //   print("response ${response.body}");
                                  //   print('Notification sent successfully');
                                  // } else {
                                  //   print(
                                  //       'Failed to send notification ${response.statusCode}');
                                  // }

                                  Map<String, dynamic> data = {
                                    "messageType" : "call",
                                    "callerName": senderName,
                                    "callerNumber": senderContactNumber,
                                  };

                                  await sendFCM(firebaseContactUser.fcmToken!, 'New Call Request', 'You have a new call request', data);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgoraCalling(recipientUid: int.parse(FirebaseUtils.user!.phoneNumber!),)),
                                  );
                                },
                                onVideoCallTapped: () async{
                                  int recipientUid = int.parse(firebaseContactUser.phoneNumber ?? "");
                                  String? senderName = FirebaseUtils.user?.name;
                                  String? senderContactNumber = FirebaseUtils.user?.phoneNumber;

                                  Map<String, dynamic> data = {
                                    "messageType" : "video_call",
                                    "callerName": senderName,
                                    "callerNumber": senderContactNumber,
                                  };

                                  await sendFCM(firebaseContactUser.fcmToken!, 'Video Call Request', 'You have a new Video call request', data);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgoraVideoCalling(recipientUid: int.parse(FirebaseUtils.user!.phoneNumber!),)),
                                  );
                                },
                              );
                            });
                      },
                    ),
                  ),
                ],
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
