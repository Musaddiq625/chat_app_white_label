import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icons_button_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/dark_theme_color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';
import 'icon_component.dart';

class ListTileComponent extends StatelessWidget {
  final String? leadingIcon;
  final String? leadingText;
  final String? leadingsubText;
  final String? trailingText;
  final String? title;
  final double? trailingTextSize;
  final double? titleSize;
  final IconData? iconData;
  final double? trailingIconSize;
  final double leadingIconWidth;
  final double leadingIconHeight;

  final Widget? trailingWidget;
  final bool showShareBtn;
  final EdgeInsetsGeometry? customPadding;

  final Color? trailingBtnBgColor;
  final Color? trailingBtnTextColor;

  final bool overrideTrailingWithBtn;
  final bool removeBorderFromTile;

  final IconData? trailingIcon;
  final Color iconColor, subIconColor, subTextColor;
  Color? backgroundColor;
  Color? titleColor;
  final Function()? onTap;
  final Function()? profileImageTap;
  final bool isLeadingImageProfileImage;
  final bool isLeadingImageSVG;
  final bool isSocialConnected;
  final bool isIconValue;
  final bool isLeadingIconAsset;

  final double? overrideLeadingIconSize;
  final String? trailingBtnTitle;
  final Function()? trailingBtnTap;
  final Function()? moreBtnTap;
  final Function()? shareBtnTap;
  final bool reducePadding;

  ListTileComponent({
    super.key,
    this.leadingIcon,
    this.iconData,
    this.leadingText,
    this.trailingText,
    this.onTap,
    this.profileImageTap,
    this.trailingIcon,
    this.iconColor = ColorConstants.black,
    this.subIconColor = ColorConstants.lightGray,
    this.subTextColor = ColorConstants.white,
    this.backgroundColor,
    this.trailingTextSize,
    this.trailingIconSize,
    this.isLeadingImageProfileImage = false,
    this.isLeadingImageSVG = false,
    this.overrideLeadingIconSize,
    this.leadingIconWidth = 15,
    this.leadingIconHeight = 15,
    this.isSocialConnected = false,
    this.isIconValue = false,
    this.isLeadingIconAsset = false,
    this.title,
    this.titleColor,
    this.titleSize,
    this.leadingsubText,
    this.overrideTrailingWithBtn = false,
    this.trailingBtnTitle,
    this.trailingBtnTap,
    this.trailingBtnBgColor,
    this.trailingBtnTextColor,
    this.reducePadding = false,
    this.removeBorderFromTile = false,
    this.trailingWidget,
    this.showShareBtn = false,
    this.moreBtnTap,
    this.shareBtnTap,
    this.customPadding,
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
        decoration: removeBorderFromTile
            ? null
            : BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                color: backgroundColor),
        child: Padding(
          padding: customPadding != null
              ? customPadding!
              : reducePadding
                  ? const EdgeInsets.fromLTRB(16, 4, 16, 8)
                  : const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: (title ?? '').length > 25
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  // if (title != null)
                  if (leadingIcon != null)
                      GestureDetector(
                        onTap: profileImageTap,
                        child:  isLeadingImageProfileImage
                            ? ProfileImageComponent(
                          url: leadingIcon,
                          size: 40,
                        )
                            : Container(
                          // color: ColorConstants.blue,
                          child: ImageComponent(
                            imgUrl: leadingIcon!,
                            imgProviderCallback: (imgProvider) {},
                            width: isSocialConnected ? 30 : leadingIconWidth,
                            height: isSocialConnected ? 30 : leadingIconHeight,
                            isAsset: isLeadingIconAsset,
                          ),
                        ),
                      ),


                  if (title != null)
                    Center(
                      child: TextComponent(
                        title!,
                        style: FontStylesConstants.style18(
                          fontSize: titleSize ?? 18,
                          fontFamily: FontConstants.inter,
                          color: titleColor ?? themeCubit.textColor,
                        ),
                      ),
                    ),
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
                      width: 14,
                    ),
                  if (leadingText != null)
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Container(
                              // color: ColorConstants.red,
                              child: TextComponent(
                                leadingText!,
                                maxLines: 4,
                                style: TextStyle(
                                    fontSize: 15, color: themeCubit.textColor),
                              ),
                            ),
                          ),
                          if (leadingsubText != null)
                            TextComponent(
                              leadingsubText!,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: themeCubit.textSecondaryColor,)
                              ,
                            ),
                        ],
                      ),
                    ),
                  if (leadingText != null) const Spacer(),

                  if (trailingText != null && overrideTrailingWithBtn == false)
                    TextComponent(
                      trailingText!,
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: subTextColor),
                    ),
                  if (trailingText != null && overrideTrailingWithBtn == false)
                    SizedBox(
                      width: isSocialConnected ? 15 : 5,
                    ),
                  if (trailingIcon != null && overrideTrailingWithBtn == false)
                    IconComponent(
                      iconData: trailingIcon,
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.transparent,
                      circleSize: trailingIconSize ?? 22,
                      iconSize: trailingIconSize ?? 22,
                      iconColor: subIconColor,
                    ),
                  if (trailingWidget != null) trailingWidget!,
                  // IconComponent(
                  //   svgData: AssetConstants.more,
                  //   onTap: moreBtnTap,
                  //   borderColor: Colors.transparent,
                  //   backgroundColor: themeCubit.darkBackgroundColor100,
                  //   iconColor: Colors.white,
                  //   circleSize: 35,
                  //   iconSize: 5,
                  // ),
                  if (overrideTrailingWithBtn)
                    ButtonComponent(
                        buttonText: trailingBtnTitle ?? '',
                        textColor: trailingBtnTextColor ?? themeCubit.textColor,
                        bgcolor: trailingBtnBgColor ??
                            themeCubit.darkBackgroundColor200,
                        // isSmallBtn: true,
                        isBold: false,
                        giveDefaultPadding: false,
                        btnHeight: 30,
                        btnWidth: 90,
                        onPressed: trailingBtnTap)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
