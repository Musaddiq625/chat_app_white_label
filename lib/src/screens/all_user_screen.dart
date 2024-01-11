import 'package:chat_app_white_label/src/components/user_tile_component.dart';
import 'package:chat_app_white_label/src/models/user.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../constants/color_constants.dart';
import '../utils/service/firbase_auth_service.dart';
import 'app_cubit/app_cubit.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  late AppCubit appCubit = BlocProvider.of<AppCubit>(context);
  FirebaseService firebaseService = getIt<FirebaseService>();

  @override
  Widget build(BuildContext context) {
    Stream<List<Map<String, dynamic>>> getUserData() async* {
      await firebaseService.requestPermission();
      Iterable<Contact> localContacts = await firebaseService.getContacts();
      CollectionReference usersRef =
          firebaseService.firestore.collection('users');

      await for (var snapshot in usersRef.snapshots()) {
        List<Map<String, dynamic>> userDataList = [];
        for (var doc in snapshot.docs) {
          if (doc.exists) {
            userDataList.add(doc.data() as Map<String, dynamic>);
          } else {
            throw Exception('User does not exist in the database');
          }
        }
        yield userDataList;
      }
    }

    Map<String, dynamic> contactToMap(Contact contact,String firebaseUserName) {
      return {
        'name': contact.displayName,
        'phoneNumber':  (contact.phones ?? []).map((item) => item.value).toList().first?.replaceAll(" ", ""),
        'subName': firebaseUserName
        // Add other contact fields you want to include
      };
    }

    Stream<List<Map<String, dynamic>>> getMatchingContacts() async* {
      try {
        await firebaseService.requestPermission();
        Iterable<Contact> localContacts = await firebaseService.getContacts();
        await for (List<Map<String, dynamic>> firebaseUsers in getUserData()) {
          List<Map<String, dynamic>> matchedContacts = [];

          for (var user in firebaseUsers) {
            String? firebasePhoneNumber = user['phoneNumber'];
            String? firbaseUserName = user['name'];
            print("firebasePhoneNumber $firebasePhoneNumber");
            for (var contact in localContacts) {
              var contactPhones = (contact.phones ?? []).map((item) => item.value).toList().first?.replaceAll(" ", "");
              print("contactPhones $contactPhones");
              try {
                if (contactPhones != null && contactPhones.contains(firebasePhoneNumber!)) {
                  final contactMap = contactToMap(contact,firbaseUserName!);
                  print("Adding contact to matchedContacts: $contactMap");
                  matchedContacts.add(contactMap);
                  // Removed break for demonstration; re-add if needed
                }
              }
              catch(e){
                print("An error occurred addding number : $e");
              }
            }
          }
          print("Yielding matchedContacts: $matchedContacts");
          yield matchedContacts;
        }
      } catch (e) {
        print("An error occurred: $e");
        // Handle the error or rethrow
      }
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: getMatchingContacts(),
        builder: (context, snapshot) {
          // if (snapshot.hasError) {
          //   return const Center(child: Text('Error fetching chats '));
          // }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }


          final users =
              snapshot.data?.map((doc) => UserMoodel.fromMap(doc)).toList();
          print("Matched Contacts ${users}");
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
                  onPressed: () {NavigationUtil.pop(context);},
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    size: 28,
                  ),
                  color: ColorConstants.white,
                ),
              ],
              // bottom: AppBar(
              //   automaticallyImplyLeading: false,
              //   backgroundColor: ColorConstants.greenMain,
              //   leading: Icon(
              //     Icons.camera_alt_rounded,
              //     color: Colors.white.withOpacity(0.5),
              //     size: 28,
              //   ),
              //   actions: [
              //     Container(
              //       width: 80,
              //       decoration: const BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(color: Colors.white, width: 5),
              //         ),
              //       ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: GestureDetector(
              //               onTap: () {},
              //               child: const Text(
              //                 'CHATS',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     Container(
              //       width: 115,
              //       decoration: const BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(color: Colors.transparent, width: 5),
              //         ),
              //       ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: GestureDetector(
              //               onTap: () {
              //                 NavigationUtil.push(
              //                     context, RouteConstants.statusScreen);
              //               },
              //               child: Text(
              //                 'STATUS',
              //                 style: TextStyle(
              //                   color: Colors.white.withOpacity(0.5),
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     Container(
              //       width: 115,
              //       decoration: const BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(color: Colors.transparent, width: 5),
              //         ),
              //       ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: GestureDetector(
              //               onTap: () {
              //                 NavigationUtil.push(
              //                     context, RouteConstants.callScreen);
              //               },
              //               child: Text(
              //                 'CALLS',
              //                 style: TextStyle(
              //                   color: Colors.white.withOpacity(0.5),
              //                   fontSize: 18,
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
            // floatingActionButton: SizedBox(
            //   width: 70,
            //   height: 70,
            //   child: FittedBox(
            //     child: FloatingActionButton(
            //       onPressed: () {NavigationUtil.push(context, RouteConstants.allUserScreen);},
            //       backgroundColor: ColorConstants.green,
            //       child: const Icon(
            //         Icons.message,
            //       ),
            //     ),
            //   ),
            // ),
            body: users == null || users.isEmpty
                ? const Center(child: Text('No Contacts available'))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 7),
                    itemBuilder: (context, index) {
                      final UserMoodel user = users[index];
                      print("user subname ${user.subName}");
                      return UserTileComponent(
                        name: user.name ?? "",
                        image: user.image ?? "",
                        message: user.about ?? "",
                        subName: user.subName ?? "",
                      );
                    },
                    itemCount: users.length //data.chat.length
                    ),
          );
        });
  }
}
