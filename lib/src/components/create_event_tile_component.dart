import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';
import 'icon_component.dart';

class CreateEventTileComponent extends StatelessWidget {
  final String? svg;
  final String iconText;
  final String subText;
  final IconData subIcon;
  final Color iconColor, subIconColor, subTextColor;
  final Function()? onTap;

  const CreateEventTileComponent({
    super.key,
    this.svg,
    required this.iconText,
    required this.subText,
    required this.onTap,
    this.subIcon = Icons.arrow_forward_ios,
    this.iconColor = ColorConstants.black,
    this.subIconColor = ColorConstants.lightGray,
    this.subTextColor = ColorConstants.white,
  });

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.responsiveWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: themeCubit.darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (svg != null)
                    SvgPicture.asset(
                      height: 20,
                      svg!,
                    ),
                  if (svg != null)
                    SizedBox(
                      width: 10,
                    ),
                  TextComponent(
                    iconText,
                    style: TextStyle(fontSize: 15, color: themeCubit.textColor),
                  ),
                  Spacer(),
                  TextComponent(
                    subText,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: subTextColor),
                  ),
                  IconComponent(
                    iconData: subIcon,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    circleSize: 20,
                    iconSize: 20,
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
