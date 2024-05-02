import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/components/user_list_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contact.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
  TextEditingController controller = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List selectedContacts = [];
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "","00112233455"),
    ContactModel('Albert Ebert', 'Manager', "","45612378123"),
    ContactModel('Json Ebert', 'Tester', "","03323333333"),
    ContactModel('Mack', 'Intern', "","03312233445"),
    ContactModel('Julia', 'Developer', "","88552233644"),
    ContactModel('Rose', 'Human Resource', "","55366114532"),
    ContactModel('Frank', 'xyz', "","25651412344"),
    ContactModel('Taylor', 'Test', "","5511772266"),
  ];
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
          ),
          _chatInput()
        ],
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
            PopupMenuButton<String>(
              color: themeCubit.darkBackgroundColor,
              icon: IconComponent(
                svgData: AssetConstants.more,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: Colors.white,
                circleSize: 30,
                iconSize: 4,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onSelected: (String value) => _selectedOption(value),
              itemBuilder: (BuildContext context) => _buildPopupItems(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Container(
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
                cursorColor: themeCubit.primaryColor,
                style: TextStyle(color: themeCubit.textColor),
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
                    fillColor: themeCubit.darkBackgroundColor.withOpacity(0.9),
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
    );
  }

  List<PopupMenuEntry<String>> _buildPopupItems() {
    return [
      PopupMenuItem<String>(
        height: 0,
        value: 'Add People',
        child: Row(
          children: [
            IconComponent(
              // iconData: Icons.groups_outlined,
              svgData: AssetConstants.people,
              svgDataCheck: false,
              iconColor: ColorConstants.grey1,
            ),
            TextComponent(
              'Add People to Group',
              style: TextStyle(color: themeCubit.textColor),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        padding: EdgeInsets.all(0),
        height: 0,
        child: DividerCosntants.divider1,
        value: '',
      ),
      PopupMenuItem<String>(
          height: 0,
          value: 'Rename Group',
          child: Row(
            children: [
              IconComponent(
                iconData: Icons.edit_outlined,
                iconColor: ColorConstants.grey1,
              ),
              TextComponent(
                'Rename Group',
                style: TextStyle(color: themeCubit.textColor),
              ),
            ],
          )),
      PopupMenuItem(
        padding: EdgeInsets.all(0),
        height: 0,
        child: DividerCosntants.divider1,
        value: '',
      ),
      PopupMenuItem<String>(
        height: 0,
        value: 'Media',
        child: Row(
          children: [
            IconComponent(
              svgData: AssetConstants.gallery,
              svgDataCheck: false,
              iconColor: ColorConstants.grey1,
            ),
            TextComponent(
              'Media',
              style: TextStyle(color: themeCubit.textColor),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        padding: EdgeInsets.all(0),
        height: 0,
        child: DividerCosntants.divider1,
        value: '',
      ),
      PopupMenuItem<String>(
          height: 0,
          value: 'Leave Conversation',
          child: Row(
            children: [
              IconComponent(
                svgData: AssetConstants.exit,
                svgDataCheck: false,
                // iconData: Icons.exit_to_app,
                iconColor: ColorConstants.red,
              ),
              TextComponent(
                'Leave Conversation',
                style: TextStyle(color: ColorConstants.red),
              ),
            ],
          )),
      PopupMenuItem(
        padding: EdgeInsets.all(0),
        height: 0,
        child: DividerCosntants.divider1,
        value: '',
      ),
      PopupMenuItem<String>(
        height: 0,
        value: 'Delete Group',
        child: Row(
          children: [
            IconComponent(
              svgData: AssetConstants.delete1,
              svgDataCheck: false,
              // iconData: Icons.delete_outline_sharp,
              iconColor: ColorConstants.red,
            ),
            TextComponent(
              'Delete Group',
              style: TextStyle(color: ColorConstants.red),
            ),
          ],
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
      return UserListComponent(
          headingName: StringConstants.addPeople,
          dummyContactList: contacts,
          subtitle: false,
          btnName: StringConstants.addPeopleToGroup,
          onBtnTap: () {});
      //   Container(
      //   color: ColorConstants.darkBackgrounddColor,
      //   height: AppConstants.responsiveHeight(context, percentage: 90),
      //   child: Stack(
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     TextComponent(
      //                       StringConstants.createChat,
      //                       style: TextStyle(
      //                           color: themeCubit.primaryColor,
      //                           fontSize: 20,
      //                           fontFamily: FontConstants.fontProtestStrike),
      //                     ),
      //                     InkWell(
      //                         onTap: () => NavigationUtil.pop(context),
      //                         child: const Icon(
      //                           Icons.close,
      //                           color: ColorConstants.white,
      //                         ))
      //                   ],
      //                 ),
      //                 SizedBoxConstants.sizedBoxTenH(),
      //                 TextComponent(
      //                   StringConstants.startDirectChat,
      //                   style: TextStyle(
      //                       fontSize: 15,
      //                       fontFamily: FontConstants.fontNunitoSans,
      //                       color: themeCubit.textColor),
      //                 ),
      //                 SizedBoxConstants.sizedBoxTenH(),
      //                 SearchTextField(
      //                   iconColor: ColorConstants.lightGrey.withOpacity(0.6),
      //                   title: "Search",
      //                   hintText: "Search for people",
      //                   onSearch: (text) {
      //                     // widget.viewModel.onSearchStories(text);
      //                   },
      //                   textEditingController: searchController,
      //                   filledColor: ColorConstants.blackLight.withOpacity(0.6),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Expanded(
      //             child: ListView.builder(
      //                 physics: const BouncingScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemCount: dummyContactList.length,
      //                 itemBuilder: (context, index) {
      //                   bool isLast = index == dummyContactList!.length - 1;
      //                   return ContactTileComponent(
      //                     showDivider: (!isLast),
      //                     title: dummyContactList[index].name,
      //                     subtitle: dummyContactList[index].designation,
      //                     isSelected: selectedContacts.contains(index),
      //                     onTap: () {
      //                       if (selectedContacts.contains(index)) {
      //                         selectedContacts.remove(index);
      //                       } else {
      //                         selectedContacts.add(index);
      //                       }
      //                       setState(() {});
      //                       LoggerUtil.logs(selectedContacts);
      //                     },
      //                   );
      //                 }),
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           Container(
      //             margin:
      //                 const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //             width: double.infinity,
      //             height: 45,
      //             child: ButtonComponent(
      //                 textColor: themeCubit.darkBackgroundColor,
      //                 buttonText: StringConstants.startChatting,
      //                 bgcolor: themeCubit.primaryColor,
      //                 onPressed: () {}),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           Expanded(child: Container()),
      //         ],
      //       )
      //     ],
      //   ),
      // );
    }));
  }

  _showLeaveBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: CommonBottomSheetComponent(
          title: StringConstants.areYouSureYouWanttoLeave,
          description: StringConstants.youWillNotBeAbleToAccessAnyMessage,
          image: AssetConstants.warning,
          isImageAsset: true,
          btnColor: ColorConstants.red,
          btnTextColor: ColorConstants.white,
          btnText: StringConstants.yesPleaseLeave,
          size14Disc: true,
          onBtnTap: () {},
        )
        // Column(
        //   children: [
        //     const SizedBox(height: 25),
        //     Image.asset(
        //       AssetConstants.warning,
        //       height: 60,
        //       width: 60,
        //     ),
        //     const SizedBox(height: 20),
        //     Column(
        //       children: [
        //         TextComponent(
        //
        //           StringConstants.areYouSureYouWanttoLeave,
        //           style: TextStyle(
        //               fontFamily: FontConstants.fontProtestStrike,
        //               color: themeCubit.textColor,
        //               fontSize: 20),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 50),
        //           child: TextComponent(
        //             StringConstants.youWillNotBeAbleToAccessAnyMessage,
        //             textAlign: TextAlign.center,
        //             maxLines: 2,
        //             style: TextStyle(color: themeCubit.textColor),
        //           ),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 20),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         InkWell(
        //             onTap: () => Navigator.pop(context),
        //             child: TextComponent(
        //               StringConstants.goBack,
        //               style: TextStyle(
        //                 color: themeCubit.textColor,
        //               ),
        //             )),
        //         const SizedBox(width: 30),
        //         ButtonComponent(
        //           buttonText: StringConstants.yesPleaseLeave,
        //           isSmallBtn: true,
        //           textColor: themeCubit.textColor,
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           bgcolor: ColorConstants.red,
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 20),
        //   ],
        // )
        );
  }

  _showDeleteBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: CommonBottomSheetComponent(
          title: StringConstants.areYouSureYouWantToDelete,
          description: "",
          image: AssetConstants.warning,
          isImageAsset: true,
          btnColor: ColorConstants.red,
          btnTextColor: ColorConstants.white,
          btnText: StringConstants.yesDeleteIt,
          size14Disc: true,
          onBtnTap: () {},
        )
        // Column(
        //   children: [
        //     const SizedBox(height: 25),
        //     Image.asset(
        //       AssetConstants.warning,
        //       height: 60,
        //       width: 60,
        //     ),
        //     const SizedBox(height: 20),
        //     Column(
        //       children: [
        //         TextComponent(
        //           StringConstants.areYouSureYouWanttoLeave,
        //           style: TextStyle(
        //             fontFamily: FontConstants.fontProtestStrike,
        //             fontSize: 20,
        //             color: themeCubit.textColor,
        //           ),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 20),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         InkWell(
        //             onTap: () => Navigator.pop(context),
        //             child: TextComponent(
        //               StringConstants.goBack,
        //               style: TextStyle(
        //                 color: themeCubit.textColor,
        //               ),
        //             )),
        //         const SizedBox(width: 30),
        //         ButtonComponent(
        //           buttonText: StringConstants.yesDeleteIt,
        //           textColor: themeCubit.textColor,
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           bgcolor: ColorConstants.red,
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 20),
        //   ],
        // )
        );
  }

  _renameGroup() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          color: themeCubit.darkBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              TextComponent(
                StringConstants.renameGroup,
                style: FontStylesConstants.style20(
                    color: ColorConstants.primaryColor),
              ),
              const SizedBox(height: 20),
              TextFieldComponent(
                controller,
                filled: true,
                fieldColor: ColorConstants.blackLight,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ButtonComponent(
                  buttonText: StringConstants.save,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
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
      fromId: '921122334455',
      toId: '923083306918',
      msg:
          'Contrary to popular  making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia 😓',
      readAt: '1707482146484',
      type: MessageType.text,
      sentAt: '1707459588852'),
  // MessageModel(
  //     fromId: '923083306918',
  //     toId: '921122334455',
  //     msg:
  //         'https://firebasestorage.googleapis.com/v0/b/weuno-chat-app.appspot.com/o/chats%2F923083306918_921122334455%2Fchat_document%2F1707462477514_we_uno_chat_file-sample_100kB.doc?alt=media&token=daf27335-950e-4b3f-9190-3144a30d7ad6',
  //     readAt: '1707482146484',
  //     type: MessageType.document,
  //     sentAt: '1707459588852'),
  // MessageModel(
  //     fromId: '923083306918',
  //     toId: '921122334455',
  //     msg:
  //         'https://firebasestorage.googleapis.com/v0/b/weuno-chat-app.appspot.com/o/chats%2F923083306918_921122334455%2Fchat_document%2F1707462477514_we_uno_chat_file-sample_100kB.doc?alt=media&token=daf27335-950e-4b3f-9190-3144a30d7ad6',
  //     readAt: '1707482146484',
  //     type: MessageType.image,
  //     sentAt: '1707459588852'),
];
