import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  // late AppSettingCubit appSettingCubit =
  //     BlocProvider.of<AppSettingCubit>(context);
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: context.watch<AppSettingCubit>().isContactactsPermissionGranted
          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ChatUtils.getAllChats(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching chats'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorConstants.greenMain,
                  ));
                }
                if ((snapshot.data?.docs ?? []).isEmpty) {
                  return const Center(
                    child: Text("No Chats Available !"),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final ChatModel chat =
                          ChatModel.fromJson(snapshot.data!.docs[index].data());
                      String? chatUserId;
                      if (chat.isGroup == false) {
                        // get the id of other person of chat
                        chatUserId = snapshot.data?.docs[index]
                            .data()['users']
                            .firstWhere((id) => id != FirebaseUtils.user?.id);
                        // Single user unread count
                        chat.unreadCount = snapshot.data?.docs[index]
                            .data()['${FirebaseUtils.user?.id}_unread_count'];
                      } else {
                        // condition to check if the 'read_count_group' is
                        // not null if it is null it means group is new
                        if (snapshot.data!.docs[index]
                            .data()
                            .containsKey('read_count_group')) {
                          // check if it contain a key with userid
                          // if it does not contain it means that user has not opened
                          if (snapshot.data?.docs[index]
                              .data()['read_count_group']
                              .containsKey('${FirebaseUtils.user?.id}')) {
                            chat.readCountGroup = snapshot.data?.docs[index]
                                    .data()['read_count_group']
                                ['${FirebaseUtils.user?.id}'];
                            chat.unreadCount = ((chat.messageCount ?? 0) -
                                    (chat.readCountGroup ?? 0))
                                .toString();
                          } else {
                            chat.unreadCount = chat.messageCount.toString();
                          }
                        } else {
                          // group currently have no message
                          chat.unreadCount = '0';
                        }
                      }

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
                              chatUser.firstName =
                                  FirebaseUtils.getNameFromLocalContact(
                                      chatUser.id ?? '', context);
                              return Container();
                              //  ChatTileComponent(
                              //   chat: chat,
                              //   chatUser: chatUser,
                              // );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return Container();
                            //  ChatTileComponent(
                            //   chat: chat,
                            //   chatUser: null,
                            // );
                          }
                        },
                      );
                    });
              })
          : const Center(
              child: CircularProgressIndicator(
              color: ColorConstants.greenMain,
            )),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              NavigationUtil.push(context, RouteConstants.contactsScreen);
            },
            backgroundColor: ColorConstants.greenMain,
            child: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
