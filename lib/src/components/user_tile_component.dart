import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class UserTileComponent extends StatelessWidget {
  final String localName;
  final UserModel? chatUser;
  final Function()? onTap;
  final bool? showAdminIcon;
  final Function()? onRemoveTap;

  const UserTileComponent(
      {super.key,
      required this.localName,
      required this.chatUser,
      this.onTap,
      this.showAdminIcon,
      this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onTap == null
            ? NavigationUtil.push(context, RouteConstants.chatRoomScreen,
                args: [chatUser, '0'])
            : onTap!(),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ProfileImageComponent(url: chatUser?.image),
        ),
        minVerticalPadding: 0,
        horizontalTitleGap: 5,
        title: Text(
          chatUser?.firstName ?? '',
          // localName,

          overflow: TextOverflow.ellipsis,
          style:  TextStyle(
            fontSize: 16,
            color: Colors.grey.shade200,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            // chatUser?.firstName ?? '',
            localName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
          ),
        ),
        trailing: showAdminIcon != null && (showAdminIcon ?? false)
            ? const Icon(Icons.admin_panel_settings,
                size: 30, color: ColorConstants.primaryColor)
            : onRemoveTap != null
                ? InkWell(
                    onTap: onRemoveTap,
                    child: const Icon(Icons.delete,
                        color: ColorConstants.primaryColor, size: 28),
                  )
                :
        null);
  }
}
