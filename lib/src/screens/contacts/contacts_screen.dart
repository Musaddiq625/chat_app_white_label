import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
// import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/select_contacts_screen.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
// import '../../../agora_video_calling.dart';
import '../../../main.dart';
import '../../constants/color_constants.dart';
import '../agora_calling.dart';
import '../agora_video_calling.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();
  List<Contact> localContacts = [];
  List<ContactModel> contactToDisplay = [];
  List<String> firebaseContactUsers = [];

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
      bool contactExist = (snapshot.data?.docs ?? []).any((firebaseUser) =>
          firebaseUser.id == localNumber &&
          firebaseUser.id != FirebaseUtils.phoneNumber);
      if (contactExist) {
        contactToDisplay.add(ContactModel(
          localName: localContacts[i].displayName,
          phoneNumber: localNumber ?? '',
        ));
      }
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
                        args: SelectContactsScreenArg(
                            contactsList: contactToDisplay)),
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
                              UserModel firebaseContactUser =
                                  UserModel.fromJson(
                                      asyncSnapshot.data?.data() ?? {});
                              contactToDisplay[index].firebaseData =
                                  firebaseContactUser;
                              return ContactTileComponent(
                                // localName:
                                //     contactToDisplay[index].localName ?? '',
                                // chatUser: firebaseContactUser,
                                // onCallTapped: () async {
                                //   int recipientUid = int.parse(
                                //       firebaseContactUser.phoneNumber ?? "");
                                //   String? senderName = FirebaseUtils.user?.name;
                                //   String? senderContactNumber =
                                //       FirebaseUtils.user?.phoneNumber;
                                //   print("recipientUid $recipientUid");
                                //
                                //   final callId =
                                //       "${senderContactNumber!.replaceAll('+', "")}_${FirebaseUtils.getDateTimeNowAsId()}";
                                //   Map<String, dynamic> data = {
                                //     "messageType": "call",
                                //     "callId": callId,
                                //     "callerName": senderName,
                                //     "callerNumber": senderContactNumber,
                                //   };
                                //   firebaseContactUsers
                                //       .add(firebaseContactUser.id!);
                                //   firebaseContactUsers
                                //       .add(FirebaseUtils.user!.id!);
                                //   if (firebaseContactUser.fcmToken != null) {
                                //     await FirebaseNotificationUtils
                                //         .sendNotification(
                                //             firebaseContactUser.fcmToken ?? "",
                                //             data);
                                //   }
                                //   await FirebaseUtils.createCalls(
                                //       callId,
                                //       senderContactNumber,
                                //       firebaseContactUsers,
                                //       "call");
                                //   await FirebaseUtils.updateUserCallList(
                                //       FirebaseUtils.user!.id!, callId);
                                //   await FirebaseUtils.updateUserCallList(
                                //       firebaseContactUser.phoneNumber!, callId);
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AgoraCalling(
                                //               recipientUid: int.parse(
                                //                   firebaseContactUser
                                //                       .phoneNumber!),
                                //               callerName:
                                //                   firebaseContactUser.firstName,
                                //                   // firebaseContactUser.name,
                                //               callerNumber: firebaseContactUser
                                //                   .phoneNumber,
                                //               callId: callId,
                                //               callerImage:
                                //                   firebaseContactUser.image,
                                //               contactUserFcm:
                                //                   firebaseContactUser.fcmToken,
                                //             )),
                                //   );
                                // },
                                // onVideoCallTapped: () async {
                                //   int recipientUid = int.parse(
                                //       firebaseContactUser.phoneNumber ?? "");
                                //   String? senderName = FirebaseUtils.user?.firstName;
                                //   // String? senderName = FirebaseUtils.user?.name;
                                //   String? senderContactNumber =
                                //       FirebaseUtils.user?.phoneNumber;
                                //   final callId =
                                //       "${senderContactNumber!.replaceAll('+', "")}_${FirebaseUtils.getDateTimeNowAsId()}";
                                //   Map<String, dynamic> data = {
                                //     "messageType": "video_call",
                                //     "callId": callId,
                                //     "callerName": senderName,
                                //     "callerNumber": senderContactNumber,
                                //   };
                                //
                                //   firebaseContactUsers
                                //       .add(firebaseContactUser.id!);
                                //   firebaseContactUsers
                                //       .add(FirebaseUtils.user!.id!);
                                //   if (firebaseContactUser.fcmToken != null) {
                                //     await FirebaseNotificationUtils
                                //         .sendNotification(
                                //             firebaseContactUser.fcmToken ?? "",
                                //             data);
                                //   }
                                //
                                //   await FirebaseUtils.createCalls(
                                //       callId,
                                //       senderContactNumber,
                                //       firebaseContactUsers,
                                //       "video_call");
                                //   await FirebaseUtils.updateUserCallList(
                                //       FirebaseUtils.user!.id!, callId);
                                //   await FirebaseUtils.updateUserCallList(
                                //       firebaseContactUser.phoneNumber!, callId);
                                //   await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AgoraVideoCalling(
                                //               recipientUid: int.parse(
                                //                   firebaseContactUser
                                //                       .phoneNumber!),
                                //               callerName:
                                //                   // firebaseContactUser.name,
                                //                   firebaseContactUser.firstName,
                                //               callerNumber: firebaseContactUser
                                //                   .phoneNumber,
                                //               callId: callId,
                                //               contactUserFcm:
                                //                   firebaseContactUser.fcmToken,
                                //             )),
                                //   );
                                // },
                                title: '', subtitle: '', isSelected: false, onTap: () {  },
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
