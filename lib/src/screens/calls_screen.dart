import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/calls_tile_component.dart';
import '../dummy data/whatsapp_data.dart';
import '../models/call_model.dart';
import '../models/usert_model.dart';

Data callList = Data();

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorConstants.green,
              child: const Icon(
                Icons.add_call,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // return ListView.builder(
                //   itemCount: snapshot.data!.docs.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     var chat = snapshot.data!.docs[index];
                //     return ListTile(
                //       title: Text("xyx"),
                //       subtitle: Text("Hello"),
                //       // title: Text(chat['chatName']),
                //       // subtitle: Text(chat['lastMessage']),
                //       onTap: () {
                //
                //       },
                //     );
                //   },
                // );

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseUtils.getAllCalls(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching chats'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if ((snapshot.data?.docs ?? []).isEmpty) {
                        return const Center(
                          child: Text("No Calls Available !"),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          String? chatUserId;
                          chatUserId = snapshot.data?.docs[index]
                              .data()['users']
                              .firstWhere((id) => id != FirebaseUtils.user?.id);
                          final CallModel call = CallModel.fromJson(
                              snapshot.data!.docs[index].data());
                          final chatUserIdData =
                              FirebaseUtils.getChatUser(chatUserId!);
                          print("chatUserIdData ${chatUserIdData}");
                          return FutureBuilder(
                            future: chatUserId != null
                                ? FirebaseUtils.getChatUser(chatUserId)
                                : null,
                            builder: (context, asyncSnapshot) {
                              // if user id is null so this is a group
                              //  no need to read future snapshot user
                              if (chatUserId != null) {
                                if (asyncSnapshot.hasData) {
                                  UserModel chatUser = UserModel.fromJson(
                                      asyncSnapshot.data?.data() ?? {});
                                  chatUser.name =
                                      FirebaseUtils.getNameFromLocalContact(
                                          chatUser.id ?? '', context);
                                  return CallTileComponent(
                                    name: chatUser.name ?? "",
                                    // Assuming 'name' is a field in the document
                                    image: chatUser.image ?? "",
                                    videocall: call.type!,
                                    time: call.time!,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                          // return FutureBuilder(
                          //   future: chatUserId != null
                          //       ? FirebaseUtils.getChatUser(chatUserId)
                          //       : null,
                          //   builder: (context, asyncSnapshot){
                          //     if (snapshot.connectionState == ConnectionState.waiting) {
                          //       return CircularProgressIndicator(); // Show loading indicator while waiting for data
                          //     }
                          //     else if (snapshot.hasError) {
                          //       return Text('Error: ${snapshot.error}'); // Handle error state
                          //     }
                          //     else {
                          //       // final chatUserIdData = snapshot.data?.data();
                          //       // print("chatUserIdData ${chatUserIdData}");
                          //       if (chatUserId != null && asyncSnapshot.hasData) {
                          //         if (asyncSnapshot.hasData) {
                          //           UserModel chatUser = UserModel.fromJson(
                          //               asyncSnapshot.data?.data() ?? {});
                          //           chatUser.name = FirebaseUtils.getNameFromLocalContact(
                          //               chatUser.id ?? '', context);
                          //           return CallTileComponent(
                          //                 name: chatUser.name ?? "", // Assuming 'name' is a field in the document
                          //                 image: chatUser.image ?? "",
                          //                 videocall: call.type!,
                          //                 time: call.time!,
                          //               );
                          //         } else {
                          //           return const SizedBox();
                          //         }
                          //       }
                          //     }
                          //   },
                          // );
                          // return CallTileComponent(
                          //   name: chatUserIdData,
                          //   image: callList.calls.values.elementAt(index).elementAt(1)
                          //   as String,
                          //   videocall:call.type! ,
                          //   time: call.time!,
                          // );
                        },
                      );
                    });

                // return ListView.separated(
                //   itemBuilder: (context, index) => CallTileComponent(
                //     name: callList.calls.values.elementAt(index).elementAt(0)
                //         as String,
                //     image: callList.calls.values.elementAt(index).elementAt(1)
                //         as String,
                //     videocall: callList.calls.values
                //         .elementAt(index)
                //         .elementAt(2) as int,
                //     isMissed: callList.calls.values
                //         .elementAt(index)
                //         .elementAt(3) as bool,
                //     inComing: callList.calls.values
                //         .elementAt(index)
                //         .elementAt(4) as bool,
                //     time: callList.calls.values.elementAt(index).elementAt(5)
                //         as String,
                //   ),
                //   separatorBuilder: (context, index) => callList.calls.values
                //           .elementAt(index)
                //           .elementAt(6) as bool
                //       ? const SizedBox(
                //           height: 10,
                //         )
                //       : const Seperator(),
                //   itemCount: callList.calls.length,
                // );
              }
            }));
  }
}
