import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/search_textfield_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
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
    return UIScaffold(
        bgColor: ColorConstants.backgroundColor,
        widget: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chats',
                    style: TextStyle(
                        color: ColorConstants.purple,
                        fontSize: 30,
                        fontFamily: FontConstants.fontProtestStrike),
                  ),
                  InkWell(
                    onTap: () {
                      showCreateChatBottomSheet();
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorConstants.yellow,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SearchTextFieldComponent(
                controller: TextEditingController(),
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
              const SizedBox(
                height: 20,
              ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 4,
              //     itemBuilder: (context, index) => const ChatTileComponent())
              //   ,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    '🙁',
                    style: TextStyle(fontSize: 30),
                  ),
                  const Text(
                    'It’s really quiet!',
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 30),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Start a chat with your friends or join any event or group to be a part of group chat!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ButtonComponent(
                      buttonText: 'Start a Chat', onPressedFunction: () {})
                ],
              )
            ],
          ),
        ));
  }

  showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create Chat',
                        style: TextStyle(
                            color: ColorConstants.purple,
                            fontSize: 20,
                            fontFamily: FontConstants.fontProtestStrike),
                      ),
                      Icon(Icons.close)
                    ],
                  ),
                  Text(
                    'Start a direct chat or make a group.',
                    style: TextStyle(
                        fontSize: 15, fontFamily: FontConstants.fontNunitoSans),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ContactTileComponent(
                    title: 'Jesse Ebert',
                    subtitle: 'Graphic Designer',
                    isSelected: true,
                    onTap: () {},
                  );
                })
          ],
        ));
  }
}

class ContactTileComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function() onTap;
  const ContactTileComponent(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const ProfileImageComponent(
        url: null,
        size: 35,
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: ColorConstants.lightGrey),
      ),
      trailing: Checkbox(
        shape: const CircleBorder(),
        splashRadius: 20,
        value: isSelected,
        onChanged: (bool? newValue) {
          // setState(() {
          //   checkBoxValue = newValue!;
          // });
        },
      ),
    );
  }
}
