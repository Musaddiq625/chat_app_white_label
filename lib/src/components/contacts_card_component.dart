import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';
import '../constants/font_styles.dart';
import '../constants/size_box_constants.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final Function()? onShareTap;
  final Function()? onProfileTap;
  final bool showShareIcon;
  final bool iconGradient;
  final Color iconColor;
  final Color iconBgColor;
  final String icon;
  final double iconSize;

  const ContactCard(
      {Key? key,
      required this.contact,
      this.iconGradient = true,
      this.icon = AssetConstants.share,
      this.iconColor = ColorConstants.black,
      this.iconBgColor = ColorConstants.darkBackgrounddColor,
      this.iconSize = 18,
      this.onShareTap,
      this.showShareIcon = true,
      this.onProfileTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 0, right: 20),
          child: InkWell(
            onTap: onProfileTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileImageComponent(url: contact.url),
                SizedBoxConstants.sizedBoxTenW(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(contact.name,
                          style: FontStylesConstants.style16(
                              color: ColorConstants.white)),
                      TextComponent(contact.title,
                          style: FontStylesConstants.style14(
                              color: ColorConstants.lightGray)),
                    ],
                  ),
                ),
                const Spacer(),
                if (showShareIcon)
                  Container(
                    decoration: BoxDecoration(
                      gradient: iconGradient
                          ? LinearGradient(
                              colors: [
                                ColorConstants.btnGradientColor,
                                Color.fromARGB(255, 220, 210, 210)
                              ],
                            )
                          : null,
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconComponent(
                      svgData: icon,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.transparent,
                      circleSize: 40,
                      iconSize: iconSize,
                      iconColor: iconColor,
                      onTap: onShareTap,
                    ),
                  )
              ],
            ),
          ),
        ),
        const Divider(thickness: 0.1),
      ],
    );
  }
}
