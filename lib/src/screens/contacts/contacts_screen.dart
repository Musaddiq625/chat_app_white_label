import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../constants/color_constants.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
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
          .first
          ?.replaceAll(' ', '')
          .replaceAll('+', '');
      if ((localNumber ?? '').startsWith('0')) {
        localNumber = localNumber?.replaceFirst('0', '92');
      }
      LoggerUtil.logs(localNumber);
      bool contactExist = (snapshot.data?.docs ?? [])
          .any((firebaseUser) => firebaseUser.id == localNumber);
      // .any for filtering in Firebase users
      if (contactExist) {
        LoggerUtil.logs('sdasdas');
        contactToDisplay.add(ContactModel(
            localName: localContacts[i].displayName,
            phoneNumber: localNumber ?? ''));
      }
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
