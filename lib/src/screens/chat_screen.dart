import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/dummy%20data/whatsapp_data.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Data data = Data();

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    String formatTimestamp(Timestamp timestamp) {
      DateTime date = timestamp.toDate();
      return DateFormat('jm').format(date); // 'jm' formats it in 'hh:mm AM/PM' format
    }
    // Stream<QuerySnapshot> chatsStream = FirebaseFirestore.instance
    //     .collection('chats')
    //     .where('user ids', arrayContains: 'currentUserID')
    //     .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching chats'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final chats =
              snapshot.data!.docs.map((doc) => Chat.fromDocument(doc)).toList();

          print("Chats asMap ${chats.asMap()}");
          print("Chats ${chats}");
          // return ListView.builder(
          //   itemCount: chats.length,
          //   itemBuilder: (context, index) {
          //     final Chat chat = chats[index];
              // return Card(
              //   child: ListTile(
              //     leading: CircleAvatar(
              //       // backgroundImage: NetworkImage(chat.imageUrl),
              //     ),
              //     title: Text(chat.last_message?.name ?? ""),
              //     subtitle: Text(chat.last_message?.message ?? ""),
              //     trailing: Text(chat.unreadCount.toString()),
              //   ),
              // );
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorConstants.primary,
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
                    backgroundColor: ColorConstants.primary,
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
                            bottom: BorderSide(
                                color: Colors.transparent, width: 5),
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
                            bottom: BorderSide(
                                color: Colors.transparent, width: 5),
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
                body: ListView.builder(
                    padding: const EdgeInsets.only(top: 7),
                    itemBuilder: (context, index) {
                      final Chat chat = chats[index];
                      print("Chat fetch ${chat.last_message?.name}");
                      print("Chat fetch ${chat.last_message?.message}");
                      print("Chat fetch ${chat.last_message?.time}");
                      return ChatTileComponent(
                        name: '${chat.last_message?.name ?? ""}',
                        // data.chat.values.elementAt(index).elementAt(0) as String,
                        image: "",
                        //data.chat.values.elementAt(index).elementAt(1),
                        message: '${chat.last_message?.message ?? ""}',
                        //data.chat.values.elementAt(index).elementAt(2) as String,
                        time: formatTimestamp(chat.last_message?.time ?? Timestamp.now()), //data.chat.values.elementAt(index).elementAt(3) as String,
// time: data.chat.values.elementAt(index).elementAt(3)?? '',     (this way also you can do it sinan)
                      );
                    },
                    //separatorBuilder: (context, index) => const Seperator(),
                    itemCount: chats.length //data.chat.length
                    ),
              );
            // },
    // )
        }
        );
  }
}

class Chat {
  final String id;

  // final String name;
  // final String imageUrl;
  final Message? last_message;
  final int unreadCount;

  const Chat({
    required this.id,
    // required this.name,
    // required this.imageUrl,
    required this.last_message,
    required this.unreadCount,
  });

  factory Chat.fromDocument(DocumentSnapshot doc) {
    return Chat(
      id: doc.id,
      // name: doc['name'],
      // imageUrl: doc['imageUrl'],
      last_message: Message.fromJson(doc['last_message']),
      unreadCount: doc['unread_count'],
    );
  }
}

class Message {
  final String? message;
  final String? msgType;
  final String? name;
  final bool? received;
  final bool? seen;
  final Timestamp? time;

  const Message({
    required this.message,
    required this.msgType,
    required this.name,
    required this.received,
    required this.seen,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      msgType: json['msgType'],
      name: json['name'],
      received: json['received'],
      seen: json['seen'],
      time: json['time'] as Timestamp,
    );
  }
}

class ChatItem extends StatelessWidget {
  final String chatId;
  final bool isGroup;
  final Map<String, dynamic> lastMessage; // Assuming this structure
  final int unreadCount;

  // ...other fields as needed

  const ChatItem({
    Key? key,
    required this.chatId,
    required this.isGroup,
    required this.lastMessage,
    required this.unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isGroup ? Colors.blue : Colors.grey,
        // Adjust colors as needed
        child: isGroup
            ? Text(
                "${lastMessage['user ids'].length}") // Show number of participants
            : Text(lastMessage['name']
                .substring(0, 1)), // Show first letter of sender's name
      ),
      title: Text(
        isGroup
            ? "Group Chat" // Display "Group Chat" for groups
            : lastMessage['name'], // Display sender's name for individual chats
      ),
      subtitle: Text(lastMessage['message']),
      trailing: unreadCount > 0
          ? Chip(
              backgroundColor: Colors.blue,
              label: Text(unreadCount.toString()),
            )
          : null,
      onTap: () {
        // Navigate to chat conversation using chatId
        Navigator.pushNamed(context, '/chat', arguments: chatId);
      },
    );
  }
}
