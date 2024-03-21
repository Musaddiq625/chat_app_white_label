import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/search_textfield_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  int _selectedIndex = 0;
  List selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        bgColor: ColorConstants.backgroundColor,
        widget: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextComponent(
                    StringConstants.chat,
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
              Expanded(
                child: ListView.builder(
                    itemCount: 16,
                    itemBuilder: (context, index) => const ChatTileComponent()),
                //  Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const TextComponent(
                //       '🙁',
                //       style: TextStyle(fontSize: 30),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     const TextComponent(
                //       StringConstants.itsReallyQuiet,
                //       style: TextStyle(
                //           fontFamily: FontConstants.fontProtestStrike,
                //           fontSize: 30),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 30),
                //       child: TextComponent(
                //         StringConstants.startChatwithYourFriends,
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     ButtonComponent(
                //         buttonText: StringConstants.startChat,
                //         onPressedFunction: () {})
                //   ],
                // ),
              )
            ],
          ),
        ));
  }

  showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextComponent(
                            StringConstants.createChat,
                            style: TextStyle(
                                color: ColorConstants.purple,
                                fontSize: 20,
                                fontFamily: FontConstants.fontProtestStrike),
                          ),
                          InkWell(
                              onTap: () => NavigationUtil.pop(context),
                              child: const Icon(Icons.close))
                        ],
                      ),
                      const TextComponent(
                        StringConstants.startDirectChat,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: FontConstants.fontNunitoSans),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dummyContactList.length,
                      itemBuilder: (context, index) {
                        return ContactTileComponent(
                          title: dummyContactList[index].name,
                          subtitle: dummyContactList[index].designation,
                          isSelected: selectedContacts.contains(index),
                          onTap: () {
                            if (selectedContacts.contains(index)) {
                              selectedContacts.remove(index);
                            } else {
                              selectedContacts.add(index);
                            }
                            setState(() {});
                            LoggerUtil.logs(selectedContacts);
                          },
                        );
                      }),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            Column(
              children: [
                Expanded(child: Container()),
                SizedBox(
                  width: 300,
                  child: ButtonComponent(
                      buttonText: StringConstants.startChatting,
                      bgcolor: ColorConstants.yellow,
                      onPressedFunction: () {}),
                ),
              ],
            )
          ],
        ),
      );
    }));
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileImageComponent(
                  url: null,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextComponent(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextComponent(
                      subtitle,
                      style: const TextStyle(color: ColorConstants.lightGrey),
                    )
                  ],
                ),
                const Spacer(),
                Checkbox(
                  shape: const CircleBorder(),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.green;
                    }
                    return null;
                  }),
                  value: isSelected,
                  onChanged: (bool? newValue) {
                    // setState(() {
                    //   checkBoxValue = newValue!;
                    // });
                  },
                )
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
        )
      ],
    );
  }
}

class DummyContacts {
  String name;
  String designation;
  DummyContacts({required this.name, required this.designation});
}

List<DummyContacts> dummyContactList = [
  DummyContacts(name: 'Jesse Ebert', designation: 'Graphic Designer'),
  DummyContacts(
      name: 'Ann Chovey', designation: 'Infrastructure Project Manager'),
  DummyContacts(name: 'Luz Stamm', designation: 'Accountant'),
  DummyContacts(name: 'Accountant', designation: 'Digital Marketing'),
  DummyContacts(name: 'Digital Marketing', designation: 'Graphic Designer'),
  DummyContacts(name: 'Graphic Designer', designation: 'Graphic Designer'),
  DummyContacts(name: 'Jesse Ebert', designation: 'Graphic Designer'),
  DummyContacts(
      name: 'Ann Chovey', designation: 'Infrastructure Project Manager'),
  DummyContacts(name: 'Luz Stamm', designation: 'Accountant'),
  DummyContacts(name: 'Accountant', designation: 'Digital Marketing'),
  DummyContacts(name: 'Digital Marketing', designation: 'Graphic Designer'),
  DummyContacts(name: 'Graphic Designer', designation: 'Graphic Designer')
];
