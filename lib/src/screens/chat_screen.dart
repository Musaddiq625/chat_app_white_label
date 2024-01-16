import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/dummy%20data/whatsapp_data.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../models/chat_model.dart';

Data data = Data();

class ChatScreen extends StatefulWidget with WidgetsBindingObserver {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('jm')
        .format(date); // 'jm' formats it in 'hh:mm AM/PM' format
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((message) {
      LoggerUtil.logs('message ${message}');
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
//   final a = AppLifecycleListener()

// @override
// Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//   switch (state) {
//     case AppLifecycleState.inactive:
//     case AppLifecycleState.paused:
//     case AppLifecycleState.detached:
//     case AppLifecycleState.resumed:
//     case AppLifecycleState.hidden:
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.greenMain,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseUtils.logOut(context);
            },
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 28,
            ),
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
          stream: FirebaseUtils.getAllChats(),
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
                  final chatUserId = snapshot.data!.docs[index]
                      .data()['users']
                      .firstWhere((id) => id != FirebaseUtils.user?.id);
                  chat.unreadCount = snapshot.data!.docs[index]
                      .data()['${FirebaseUtils.user?.id}_unread_count'];
                  return FutureBuilder(
                    future: FirebaseUtils.getChatUser(chatUserId),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        UserModel chatUser = UserModel.fromJson(
                            asyncSnapshot.data?.data() ?? {});
                        return ChatTileComponent(
                          chat: chat,
                          chatUser: chatUser,
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  );
                });
          }),
    );
  }
}
