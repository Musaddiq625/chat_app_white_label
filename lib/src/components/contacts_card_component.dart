import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final Function()? onShareTap;
  final bool showShareIcon;

  const ContactCard(
      {Key? key,
      required this.contact,
      this.onShareTap,
      this.showShareIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileImageComponent(url: contact.url),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themeCubit.textColor),
                    ),
                    Text(
                      contact.title,
                      style: const TextStyle(
                          fontSize: 14, color: ColorConstants.lightGray),
                    ),
                  ],
                ),
                const Spacer(),
                if (showShareIcon)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstants.btnGradientColor,
                          Color.fromARGB(255, 220, 210, 210)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconComponent(
                      svgData: AssetConstants.share,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.transparent,
                      circleSize: 40,
                      iconSize: 18,
                      onTap: onShareTap,
                    ),
                  )
              ],
            ),
            const Divider(thickness: 0.2),
          ],
        ),
      ),
    );
  }
}
