import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/textfield_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/chat_listing/chat_listing_screen.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
  TextEditingController controller = TextEditingController();
  List selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      bgColor: themeCubit.backgroundColor,
      appBar: _appBar(),
      widget: Column(
        children: [
          Expanded(
            child: dummyMessageList.isNotEmpty
                ? ListView.builder(
                    itemCount: dummyMessageList.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                          message: dummyMessageList[index], isRead: true);
                    })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetConstants.chat,
                        height: 75,
                        width: 75,
                      ),
                      TextComponent(
                        StringConstants.noMessagesYet,
                        style: TextStyle(
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 30,
                            color: themeCubit.textColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextComponent(
                          StringConstants.startConversationWithHello,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(color: themeCubit.textColor),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            color: themeCubit.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconComponent(
                          circleSize: 30,
                          backgroundColor: themeCubit.primaryColor,
                          iconData: Icons.send,
                          iconColor: themeCubit.backgroundColor,
                          iconSize: 18,
                        ),
                      ),
                      fillColor:
                          themeCubit.darkBackgroundColor.withOpacity(0.9),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(28)),
                      hintText: "Your message..",
                      hintStyle: const TextStyle(
                          fontSize: 12, color: ColorConstants.lightGrey)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () => NavigationUtil.pop(
        context,
      ),
      child: Container(
        color: themeCubit.darkBackgroundColor,
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                )),
            const ProfileImageComponent(
              url: null,
              size: 40,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //user name
                TextComponent('Faizan, Jesse & more',
                    style: TextStyle(
                        fontSize: 20,
                        color: themeCubit.textColor,
                        fontFamily: FontConstants.fontProtestStrike,
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 2),
                // last seen time of user
                TextComponent('134 Members',
                    style: TextStyle(
                      fontSize: 12,
                      color: themeCubit.textColor,
                    )),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: PopupMenuButton<String>(
                color: themeCubit.darkBackgroundColor,
                icon: Icon(
                  Icons.more_horiz,
                  size: 15,
                  color: themeCubit.textColor,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onSelected: (String value) => _selectedOption(value),
                itemBuilder: (BuildContext context) => _buildPopupItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildPopupItems() {
    return [
      PopupMenuItem<String>(
        value: 'Add People',
        child: ListTile(
          leading: const Icon(Icons.groups_outlined),
          title: TextComponent(
            'Add People to Group',
            style: TextStyle(color: themeCubit.textColor),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Rename Group',
        child: ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: TextComponent(
            'Rename Group',
            style: TextStyle(color: themeCubit.textColor),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Media',
        child: ListTile(
          leading: const Icon(Icons.photo_outlined),
          title: TextComponent(
            'Media',
            style: TextStyle(color: themeCubit.textColor),
          ),
        ),
      ),
      const PopupMenuItem<String>(
        value: 'Leave Conversation',
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: ColorConstants.red,
          ),
          title: TextComponent(
            'Leave Conversation',
            style: TextStyle(color: ColorConstants.red),
          ),
        ),
      ),
      const PopupMenuItem<String>(
        value: 'Delete Group',
        child: ListTile(
          leading: Icon(
            Icons.delete_outline_sharp,
            color: ColorConstants.red,
          ),
          title: TextComponent(
            'Delete Group',
            style: TextStyle(color: ColorConstants.red),
          ),
        ),
      ),
    ];
  }

  _selectedOption(String value) {
    switch (value) {
      case 'Add People':
        _showCreateChatBottomSheet();
        break;
      case 'Rename Group':
        _renameGroup();
        break;
      case 'Media':
        // Show media options
        break;
      case 'Leave Conversation':
        _showLeaveBottomSheet();
        break;
      case 'Delete Group':
        _showDeleteBottomSheet();
        break;
    }
  }

  _showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        height: AppConstants.responsiveHeight(context, percentage: 90),
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
                          Text(
                            StringConstants.addPeople,
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
                          },
                        );
                      }),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  height: 65,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: ButtonComponent(
                      buttonText: StringConstants.addPeopleToGroup,
                      bgcolor: themeCubit.primaryColor,
                      textColor: themeCubit.backgroundColor,
                      onPressedFunction: () {}),
                ),
              ],
            )
          ],
        ),
      );
    }));
  }

  _showLeaveBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AssetConstants.warning,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                TextComponent(
                  StringConstants.areYouSureYouWanttoLeave,
                  style: TextStyle(
                      fontFamily: FontConstants.fontProtestStrike,
                      color: themeCubit.textColor,
                      fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextComponent(
                    StringConstants.youWillNotBeAbleToAccessAnyMessage,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(
                        color: themeCubit.textColor,
                      ),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  buttonText: StringConstants.yesPleaseLeave,
                  textColor: themeCubit.textColor,
                  onPressedFunction: () {
                    Navigator.pop(context);
                  },
                  bgcolor: ColorConstants.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _showDeleteBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AssetConstants.warning,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                TextComponent(
                  StringConstants.areYouSureYouWanttoLeave,
                  style: TextStyle(
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 20,
                    color: themeCubit.textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(
                        color: themeCubit.textColor,
                      ),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  buttonText: StringConstants.yesDeleteIt,
                  textColor: themeCubit.textColor,
                  onPressedFunction: () {
                    Navigator.pop(context);
                  },
                  bgcolor: ColorConstants.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _renameGroup() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              TextComponent(
                StringConstants.renameGroup,
                style: TextStyle(fontSize: 20, color: themeCubit.primaryColor),
              ),
              const SizedBox(height: 20),
              TextFieldComponent(
                controller,
                fieldColor: ColorConstants.lightGrey.withOpacity(0.2),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ButtonComponent(
                  buttonText: StringConstants.save,
                  textColor: themeCubit.backgroundColor,
                  onPressedFunction: () {
                    Navigator.pop(context);
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}

List dummyMessageList = [
  MessageModel(
      fromId: '921122334455',
      toId: '923083306918',
      msg:
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia 😓',
      readAt: '1707482146484',
      type: MessageType.text,
      sentAt: '1707459588852'),
  MessageModel(
      fromId: '921122334455',
      toId: '923083306918',
      msg: 'Contrary to popular belief,',
      readAt: '1707482146484',
      type: MessageType.text,
      sentAt: '1707459588852'),
  MessageModel(
      fromId: '923083306918',
      toId: '921122334455',
      msg:
          'Contrary to popular  making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia 😓',
      readAt: '1707482146484',
      type: MessageType.text,
      sentAt: '1707459588852'),
  MessageModel(
      fromId: '921122334455',
      toId: '923083306918',
      msg:
          'Contrary to popular  making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia 😓',
      readAt: '1707482146484',
      type: MessageType.text,
      sentAt: '1707459588852'),
  MessageModel(
      fromId: '923083306918',
      toId: '921122334455',
      msg:
          'https://firebasestorage.googleapis.com/v0/b/weuno-chat-app.appspot.com/o/chats%2F923083306918_921122334455%2Fchat_document%2F1707462477514_we_uno_chat_file-sample_100kB.doc?alt=media&token=daf27335-950e-4b3f-9190-3144a30d7ad6',
      readAt: '1707482146484',
      type: MessageType.document,
      sentAt: '1707459588852'),
  // MessageModel(
  //     fromId: '923083306918',
  //     toId: '921122334455',
  //     msg:
  //         'https://firebasestorage.googleapis.com/v0/b/weuno-chat-app.appspot.com/o/chats%2F923083306918_921122334455%2Fchat_document%2F1707462477514_we_uno_chat_file-sample_100kB.doc?alt=media&token=daf27335-950e-4b3f-9190-3144a30d7ad6',
  //     readAt: '1707482146484',
  //     type: MessageType.image,
  //     sentAt: '1707459588852'),
];
