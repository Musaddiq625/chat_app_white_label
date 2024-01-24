import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ContactTileComponent extends StatelessWidget {
  final String localName;
  final UserModel? chatUser;
  final bool? isSelected;
  final Function()? onContactTap;

  const ContactTileComponent(
      {super.key,
      required this.localName,
      required this.chatUser,
      this.isSelected,
      this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onContactTap == null
            ? NavigationUtil.push(context, RouteConstants.chatRoomScreen,
                args: [chatUser, '0'])
            : onContactTap!(),
        leading: (chatUser?.image ?? '').isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      CachedNetworkImageProvider(chatUser?.image ?? ''),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.account_circle,
                  size: 65,
                  color: Colors.grey.shade500,
                ),
              ),
        minVerticalPadding: 0,
        horizontalTitleGap: 5,
        title: Text(
          localName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            chatUser?.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ),
        trailing: isSelected != null
            ? Checkbox(
                checkColor: Colors.white,
                activeColor: ColorConstants.greenMain,
                focusColor: ColorConstants.greenMain,
                hoverColor: ColorConstants.greenMain,
                value: isSelected,
                onChanged: (bool? value) {},
              )
            : null);
  }
}
