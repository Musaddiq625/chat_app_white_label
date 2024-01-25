import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ContactTileComponent extends StatelessWidget {
  final String localName;
  final UserModel chatUser;
  final VoidCallback onCallTapped;

  const ContactTileComponent({
    super.key,
    required this.localName,
    required this.chatUser,
    required this.onCallTapped,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: () => NavigationUtil.push(context, RouteConstants.chatRoomScreen,
          args: [chatUser, '0']),
      leading: (chatUser.image ?? '').isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    CachedNetworkImageProvider(chatUser.image ?? ''),
              ),
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
        localName,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 19,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Text(
          chatUser.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ),
      trailing: CircleAvatar(
        backgroundColor: Colors.lightGreenAccent,
        child: IconButton(
          onPressed: () => onCallTapped(),
         icon: const Icon(
            Icons.call,
            size: 25,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
