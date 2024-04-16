import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';
import 'icon_component.dart';

class ListTileComponent extends StatelessWidget {
  final String? leadingIcon;
  final String iconText;
  final String subText;
  final double? subTextSize;
  final double? trailingIconSize;
  final double leadingIconWidth;
  final double leadingIconHeight;
  final IconData subIcon;
  final Color iconColor, subIconColor, subTextColor;
  final Function()? onTap;
  final bool isLeadingImageCircular;
  final bool isLeadingImageSVG;
  final bool isSocialConnected;

  final double? overrideLeadingIconSize;

  const ListTileComponent({
    super.key,
    this.leadingIcon,
    required this.iconText,
    required this.subText,
    required this.onTap,
    this.subIcon = Icons.arrow_forward_ios,
    this.iconColor = ColorConstants.black,
    this.subIconColor = ColorConstants.lightGray,
    this.subTextColor = ColorConstants.white,
    this.subTextSize,
    this.trailingIconSize,
    this.isLeadingImageCircular = false,
    this.isLeadingImageSVG = false,
    this.overrideLeadingIconSize,
    this.leadingIconWidth = 15,
    this.leadingIconHeight = 15,
    this.isSocialConnected = false,
  });

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.responsiveWidth(context),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: themeCubit.darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  if (leadingIcon != null)
                    const SizedBox(
                      width: 10,
                    ),
                  TextComponent(
                    iconText,
                    style: TextStyle(fontSize: 15, color: themeCubit.textColor),
                  ),
                  const Spacer(),
                  TextComponent(
                    subText,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: subTextColor),
                  ),
                  SizedBox(
                    width: isSocialConnected ? 15 : 5,
                  ),
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
