import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
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
        // floatingActionButton: SizedBox(
        //   width: 70,
        //   height: 70,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //       onPressed: () {},
        //       backgroundColor: ColorConstants.green,
        //       child: const Icon(
        //         Icons.add_call,
        //         color: Colors.white,
        //         size: 20,
        //       ),
        //     ),
        //   ),
        // ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {

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
                          String? groupId;
                          if(call.type == "group_call"){
                            groupId =  call.groupId;
                          }
                          final chatUserIdData = FirebaseUtils.getChatUser(chatUserId!);
                          print("chatUserIdData-1 ${chatUserIdData}");
                          return FutureBuilder(
                            future: call.type != "group_call"
                                ? FirebaseUtils.getChatUser(chatUserId)
                                : ChatUtils.getGroupChat(groupId!),
                            builder: (context, asyncSnapshot) {
                              // if user id is null so this is a group
                              //  no need to read future snapshot user
                              if(call.type == "group_call"){
                                  if (asyncSnapshot.hasData) {
                                     ChatModel chatUser = ChatModel.fromJson(asyncSnapshot.data?.data() ?? {});
                                    return CallTileComponent(
                                      name: chatUser.groupData?.grougName ?? "",
                                      image: chatUser.groupData?.groupImage ?? "",
                                      videocall: call.type!,
                                      time: call.time!,
                                    );
                                  } else {
                                    return const SizedBox();
                                  }

                              }
                              else{
                                if (chatUserId != null) {
                                  if (asyncSnapshot.hasData) {
                                    UserModel chatUser = UserModel.fromJson(
                                        asyncSnapshot.data?.data() ?? {});
                                    chatUser.name = FirebaseUtils.getNameFromLocalContact(chatUser.id ?? '', context);

                                    return CallTileComponent(
                                      name: chatUser.name ?? "",
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
                              }

                            },
                          );
                        },
                      );
                    });
              }
            }));
  }
}
