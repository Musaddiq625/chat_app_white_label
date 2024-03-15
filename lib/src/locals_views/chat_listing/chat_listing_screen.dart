import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/main_scaffold.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:flutter/material.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chats',
                style: TextStyle(
                    color: ColorConstants.blue,
                    fontSize: 30,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: ColorConstants.yellow,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: 'Search for people, conversations..',
                hintStyle: const TextStyle(
                  color: ColorConstants.grey,
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: const Icon(
                  Icons.search,
                  color: ColorConstants.grey,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FilterComponent(
            options: [
              FilterComponentArg(title: 'All'),
              FilterComponentArg(title: "Unread"),
              FilterComponentArg(title: "DMS", count: 111),
              FilterComponentArg(title: "DMS", count: 23),
              FilterComponentArg(title: "Event", count: 104)
            ],
            groupValue:
                _selectedIndex, // Your state variable for selected index
            onValueChanged: (int value) =>
                setState(() => _selectedIndex = value),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => const ChatTileComponent())
        ],
      ),
    ));
  }
}

class ChatTileComponent extends StatefulWidget {
  const ChatTileComponent({super.key});

  @override
  State<ChatTileComponent> createState() => _ChatTileComponentState();
}

class _ChatTileComponentState extends State<ChatTileComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {},
        leading: const ProfileImageComponent(
          url: null,
        ),
        minVerticalPadding: 0,
        horizontalTitleGap: 10,
        title: const Text(
          'Live Music and Karaoke at The..',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  'Davia: Looking forward to it!!!',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 8,
                backgroundColor: ColorConstants.red,
                child: Text(
                  '6',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
              Text(
                DateUtil.formatedMessageTime('1708524795128'),
                style: const TextStyle(color: ColorConstants.lightGrey),
              ),
              // if (chat.unreadCount != null && chat.unreadCount != '0')
            ],
          ),
        ),
      ),
    );
  }
}
