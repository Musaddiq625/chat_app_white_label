import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      bgColor: ColorConstants.backgroundColor,
      appBar: _appBar(),
      widget: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messageList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return MessageCard(message: messageList[index], isRead: true);
                }),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconComponent(
                circleSize: 30,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.yellow,
                iconData: Icons.add,
                iconColor: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconComponent(
                          circleSize: 30,
                          borderColor: Colors.transparent,
                          backgroundColor: Colors.indigo,
                          iconData: Icons.send,
                          iconColor: Colors.white,
                        ),
                      ),
                      fillColor: ColorConstants.backgroundColor,
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
        color: ColorConstants.white,
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
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //user name
                Text('Live Music and Karaok...',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: FontConstants.fontProtestStrike,
                        fontWeight: FontWeight.w600)),

                SizedBox(height: 2),
                // last seen time of user
                Text('134 Members',
                    style: TextStyle(
                      fontSize: 12,
                    )),
              ],
            ),
            const SizedBox(width: 10),
            IconComponent(
              iconData: Icons.more_horiz,
              iconSize: 12,
              borderColor: ColorConstants.transparent,
              backgroundColor: Colors.grey.withOpacity(0.2),
              circleSize: 28,
            )
          ],
        ),
      ),
    );
  }
}

List messageList = [
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
