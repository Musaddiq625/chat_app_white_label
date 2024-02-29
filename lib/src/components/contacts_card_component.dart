import 'package:flutter/material.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import '../constants/color_constants.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final Function() onShareTap;

  const ContactCard({Key? key, required this.contact, required this.onShareTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileImageComponent(url: contact.url),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    contact.title,
                    style: const TextStyle(
                        fontSize: 14, color: ColorConstants.lightGray),
                  ),
                ],
              ),
              const Spacer(),
              IconComponent(
                iconData: Icons.share,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.yellow,
                iconColor: Colors.white70,
                circleSize: 40,
                iconSize: 25,
                onTap: onShareTap,
              )
            ],
          ),
          const Divider(thickness: 0.2),
        ],
      ),
    );
  }
}
