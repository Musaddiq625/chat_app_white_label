import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ChatTileComponent extends StatelessWidget {
  final ChatModel chat;
  final UserModel chatUser;

  const ChatTileComponent({
    super.key,
    required this.chat,
    required this.chatUser,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        chat.isGroup == false
            ? NavigationUtil.push(context, RouteConstants.chatRoomScreen,
                args: [chatUser, chat.unreadCount])
            : NavigationUtil.push(context, RouteConstants.groupChatRoomScreen,
                args: chat);
      },
      leading: ProfileImageComponent(
          url: chat.isGroup == false
              ? chatUser.image
              : chat.groupData?.groupImage,
          isGroup: chat.isGroup ?? false),
      minVerticalPadding: 0,
      horizontalTitleGap: 10,
      title: Text(
        chat.isGroup == false
            ? chatUser.name ?? ''
            : chat.groupData?.grougName ?? '',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (FirebaseUtils.user?.id == chat.lastMessage?.fromId)
              Icon(Icons.done_all_rounded,
                  color: chat.isGroup == false
                      ? chat.lastMessage?.readAt != null
                          ? Colors.blue
                          : Colors.grey
                      : chat.lastMessageReadBy?.length ==
                              ((chat.users ?? []).length - 1)
                          ? Colors.blue
                          : Colors.grey,
                  size: 18),
            const SizedBox(width: 2),
            if (chat.lastMessage?.type == MessageType.image)
              Icon(
                Icons.image,
                color: Colors.grey.shade500,
                size: 22,
              )
            else if (chat.lastMessage?.type == MessageType.audio)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.keyboard_voice_sharp,
                    color: ColorConstants.blue,
                    size: 20,
                  ),
                  Text(
                    chat.lastMessage?.length != null
                        ? DateUtil.formatSecondsAsTime(
                            chat.lastMessage?.length ?? 0)
                        : '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  )
                ],
              )
            else if (chat.lastMessage?.type == MessageType.video)
              Icon(
                Icons.videocam_rounded,
                color: Colors.grey.shade500,
                size: 22,
              )
            else if (chat.lastMessage?.type == MessageType.document)
              Icon(
                Icons.description_rounded,
                color: Colors.grey.shade500,
                size: 22,
              )
            else
              Expanded(
                child: Text(
                  chat.lastMessage?.msg ?? '',
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
            Text(
              DateUtil.getFormattedTime(
                  context, chat.lastMessage?.sentAt ?? ''),
              style: TextStyle(
                  color: (chat.unreadCount != null && chat.unreadCount != '0')
                      ? ColorConstants.green
                      : Colors.grey.shade500),
            ),
            if (chat.unreadCount != null && chat.unreadCount != '0')
              CircleAvatar(
                radius: 8,
                backgroundColor: ColorConstants.green,
                child: Text(
                  chat.unreadCount ?? '',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
