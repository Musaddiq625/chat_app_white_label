import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../models/chat_model.dart';

class ChatScreen extends StatefulWidget with WidgetsBindingObserver {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((message) {
      LoggerUtil.logs('message $message');
      if (FirebaseUtils.user != null) {
        if (message.toString().contains('resume')) {
          FirebaseUtils.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseUtils.updateActiveStatus(false);
        }
        if (message.toString().contains('detached')) {
          FirebaseUtils.updateActiveStatus(false);
        }
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.greenMain,
        title: Text(
          FirebaseUtils.user?.name ?? "",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseUtils.logOut(context);
            },
            icon: const Icon(
              Icons.logout,
              size: 28,
            ),
            color: ColorConstants.white,
          ),
          IconButton(
            onPressed: () {
              NavigationUtil.push(context, RouteConstants.editProfileScreen,
                  args: true);
            },
            icon: const Icon(
              Icons.edit,
              size: 28,
            ),
            color: ColorConstants.white,
          ),
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.greenMain,
          leading: Icon(
            Icons.camera_alt_rounded,
            color: Colors.white.withOpacity(0.5),
            size: 28,
          ),
          actions: [
            Container(
              width: 80,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'CHATS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 115,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtil.push(
                            context, RouteConstants.statusScreen);
                      },
                      child: Text(
                        'STATUS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 115,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtil.push(context, RouteConstants.callScreen);
                      },
                      child: Text(
                        'CALLS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              NavigationUtil.push(context, RouteConstants.contactsScreen);
            },
            backgroundColor: ColorConstants.green,
            child: const Icon(
              Icons.message,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ChatUtils.getAllChats(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching chats'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
                          chatUser.name = FirebaseUtils.getNameFromLocalContact(
                              chatUser.id ?? '', context);
                          return ChatTileComponent(
                            chat: chat,
                            chatUser: chatUser,
                          );
                        } else {
                          return const SizedBox();
                        }
                      } else {
                        return ChatTileComponent(
                          chat: chat,
                          chatUser: null,
                        );
                      }
                    },
                  );
                });
          }),
    );
  }
}
