import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';
import 'icon_component.dart';

class ListTileComponent extends StatelessWidget {
  final String? leadingIcon;
  final String? iconText;
  final String? subText;
  final String? title;
  final double? subTextSize;
  final IconData? iconData;
  final double? trailingIconSize;
  final double leadingIconWidth;
  final double leadingIconHeight;

  final IconData? subIcon;
  final Color iconColor, subIconColor, subTextColor;
  Color? backgroundColor;
  Color? titleColor;
  final Function()? onTap;
  final bool isLeadingImageCircular;
  final bool isLeadingImageSVG;
  final bool isSocialConnected;
  final bool isIconValue;

  final double? overrideLeadingIconSize;

  ListTileComponent({
    super.key,
    this.leadingIcon,
    this.iconData,
    this.iconText,
    this.subText,
    this.onTap,
    this.subIcon = Icons.arrow_forward_ios,
    this.iconColor = ColorConstants.black,
    this.subIconColor = ColorConstants.lightGray,
    this.subTextColor = ColorConstants.white,
    this.backgroundColor,
    this.subTextSize,
    this.trailingIconSize,
    this.isLeadingImageCircular = false,
    this.isLeadingImageSVG = false,
    this.overrideLeadingIconSize,
    this.leadingIconWidth = 15,
    this.leadingIconHeight = 15,
    this.isSocialConnected = false,
    this.isIconValue = false,
    this.title,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    backgroundColor ??= themeCubit.darkBackgroundColor;
    titleColor ??= themeCubit.textColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.responsiveWidth(context),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (title != null)
                    Center(
                      child: TextComponent(
                        title!,
                        style: FontStylesConstants.style18(
                          fontFamily: FontConstants.inter,
                          color: titleColor ?? themeCubit.textColor,
                        ),
                      ),
                    ),
                  if (leadingIcon != null)
                    ClipRRect(
                        borderRadius: isLeadingImageCircular
                            ? BorderRadius.circular(32)
                            : BorderRadius.zero,
                        child: ImageComponent(
                          imgUrl: leadingIcon!,
                          imgProviderCallback: (imgProvider) {},
                          width: isSocialConnected ? 30 : leadingIconWidth,
                          height: isSocialConnected ? 30 : leadingIconHeight,
                        )),
                  if (isIconValue == true && iconData != null)
                    IconComponent(
                      iconData: iconData!,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.transparent,
                      iconColor: Colors.white,
                      circleSize: 40,
                    ),
                  if (leadingIcon != null)
                    const SizedBox(
                      width: 10,
                    ),
                  if (iconText != null)
                    TextComponent(
                      iconText!,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor),
                    ),
                  if (iconText != null) const Spacer(),
                  if (subText != null)
                    TextComponent(
                      subText!,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: subTextColor),
                    ),
                  if (subText != null)
                    SizedBox(
                      width: isSocialConnected ? 15 : 5,
                    ),
                  if (subIcon != null)
                    IconComponent(
                      iconData: subIcon,
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.transparent,
                      circleSize: trailingIconSize ?? 22,
                      iconSize: trailingIconSize ?? 22,
                      iconColor: subIconColor,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
