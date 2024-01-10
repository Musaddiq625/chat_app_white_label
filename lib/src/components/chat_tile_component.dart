import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
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
      onTap: () => NavigationUtil.push(context, RouteConstants.chatRoomScreen,
          args: chatUser),
      leading: (chatUser.image ?? '').isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      CachedNetworkImageProvider(chatUser.image ?? '')),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.account_circle,
                size: 55,
                color: Colors.grey.shade500,
              ),
            ),
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      title: Text(
        chatUser.name ?? '',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Text(
          chat.lastMessage?.msg ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          DateUtil.getFormattedTime(context, chat.lastMessage?.sentAt ?? ''),
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
