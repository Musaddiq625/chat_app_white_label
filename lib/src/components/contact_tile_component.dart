import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ContactTileComponent extends StatelessWidget {
  final String localName;
  final UserModel? chatUser;
  final bool? isSelected;
  final VoidCallback? onCallTapped;
  final VoidCallback? onVideoCallTapped;
  final Function()? onContactTap;

  const ContactTileComponent({
    super.key,
    required this.localName,
    required this.chatUser,
    this.onCallTapped,
    this.onVideoCallTapped,
    this.isSelected,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onContactTap == null
            ? NavigationUtil.push(context, RouteConstants.chatRoomScreen,
                args: [chatUser, '0'])
            : onContactTap!(),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ProfileImageComponent(url: chatUser?.image),
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
        trailing: onContactTap != null
            ? Checkbox(
                checkColor: Colors.white,
                activeColor: ColorConstants.greenMain,
                focusColor: ColorConstants.greenMain,
                hoverColor: ColorConstants.greenMain,
                value: isSelected,
                onChanged: (bool? value) {
                  onContactTap!();
                },
              )
            : onCallTapped != null || onVideoCallTapped != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorConstants.greenMain,
                        child: IconButton(
                          onPressed: () => onCallTapped!(),
                          icon: const Icon(
                            Icons.call,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      CircleAvatar(
                        backgroundColor:  ColorConstants.greenMain,
                        child: IconButton(
                          onPressed: () => onVideoCallTapped!(),
                          icon: const Icon(
                            Icons.video_call,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : null);
  }
}
