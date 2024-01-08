import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/dummy%20data/whatsapp_data.dart';
import 'package:chat_app_white_label/src/screens/app_cubit/app_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../models/chat.dart';

Data data = Data();

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  late AppCubit appCubit = BlocProvider.of<AppCubit>(context);
  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('jm')
        .format(date); // 'jm' formats it in 'hh:mm AM/PM' format
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Map<String, dynamic>>> getChatData(String? userId) async* {
      DocumentReference userRef =
          firebaseService.firestore.collection('users').doc(userId);

      await for (var snapshot in userRef.snapshots()) {
        if (snapshot.exists) {
          List<String> chatIds = List<String>.from(
              (snapshot.data() as Map<String, dynamic>)['chats_ids']);
          List<Map<String, dynamic>> chatData = [];
          for (var chatId in chatIds) {
            var chatSnapshot = await firebaseService.firestore
                .collection('chats')
                .doc(chatId)
                .get();
            if (chatSnapshot.exists) {
              chatData.add(chatSnapshot.data() as Map<String, dynamic>);
            } else {
              throw Exception('Chat does not exist in the database');
            }
          }
          yield chatData;
        } else {
          throw Exception('User does not exist in the database');
        }
      }
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: getChatData(appCubit.phoneNumber),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching chats'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final chats = snapshot.data!.map((doc) => Chat.fromMap(doc)).toList();
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
                  onPressed: () {},
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
                              NavigationUtil.push(
                                  context, RouteConstants.callScreen);
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
                  onPressed: () {},
                  backgroundColor: ColorConstants.green,
                  child: const Icon(
                    Icons.message,
                  ),
                ),
              ),
            ),
            body: chats.isEmpty
                ? const Center(child: Text('No chat available'))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 7),
                    itemBuilder: (context, index) {
                      final Chat chat = chats[index];
                      return ChatTileComponent(
                        name: chat.last_message?.name ?? "",
                        image: "",
                        message: chat.last_message?.message ?? "",
                        time: formatTimestamp(
                            chat.last_message?.time ?? Timestamp.now()),
                      );
                    },
                    itemCount: chats.length //data.chat.length
                    ),
          );
        });
  }
}
