import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/textfield_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  int _selectedIndex = 0;
  List selectedContacts = [];
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        bgColor: themeCubit.backgroundColor,
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                color: themeCubit.backgroundColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          StringConstants.chat,
                          style: TextStyle(
                              color: themeCubit.primaryColor,
                              fontSize: 30,
                              fontFamily: FontConstants.fontProtestStrike),
                        ),
                        InkWell(
                          onTap: () {
                            _showCreateChatBottomSheet();
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorConstants.btnGradientColor,
                                    ColorConstants.white
                                  ],
                                )),
                            child: Icon(
                              Icons.add,
                              color: themeCubit.backgroundColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    TextFieldComponent(
                      TextEditingController(),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Search for People',
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
                  ],
                ),
              ),
              Expanded(
                child: dummyContactList.isNotEmpty
                    ? ListView.builder(
                        itemCount: 16,
                        itemBuilder: (context, index) =>
                            const ChatTileComponent())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetConstants.sad,
                            height: 65,
                            width: 65,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextComponent(
                            StringConstants.itsReallyQuiet,
                            style: TextStyle(
                                fontFamily: FontConstants.fontProtestStrike,
                                color: themeCubit.textColor,
                                fontSize: 30),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: TextComponent(
                              StringConstants.startChatwithYourFriends,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonComponent(
                              buttonText: StringConstants.startChat,
                              bgcolor: themeCubit.primaryColor,
                              textColor: themeCubit.backgroundColor,
                              onPressedFunction: () {})
                        ],
                      ),
              )
            ],
          ),
        ));
  }

  _showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
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
                          TextComponent(
                            StringConstants.createChat,
                            style: TextStyle(
                                color: themeCubit.primaryColor,
                                fontSize: 20,
                                fontFamily: FontConstants.fontProtestStrike),
                          ),
                          InkWell(
                              onTap: () => NavigationUtil.pop(context),
                              child: const Icon(Icons.close))
                        ],
                      ),
                      TextComponent(
                        StringConstants.startDirectChat,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: FontConstants.fontNunitoSans,
                            color: themeCubit.textColor),
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
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  width: double.infinity,
                  height: 45,
                  child: ButtonComponent(
                      buttonText: StringConstants.startChatting,
                      bgcolor: themeCubit.primaryColor,
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

class ContactTileComponent extends StatefulWidget {
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
  State<ContactTileComponent> createState() => _ContactTileComponentState();
}

class _ContactTileComponentState extends State<ContactTileComponent> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: themeCubit.textColor),
                ),
                TextComponent(
                  widget.subtitle,
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
              value: widget.isSelected,
              onChanged: (bool? newValue) {
                // setState(() {
                //   checkBoxValue = newValue!;
                // });
              },
            )
          ],
        ),
      ),
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
