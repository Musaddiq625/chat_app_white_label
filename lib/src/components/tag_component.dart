import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/theme_cubit/theme_cubit.dart';

class TagComponent extends StatelessWidget {
  final String? iconData;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final double borderSize;
  final Color borderColor;
  final double? circleHeight;
  final double? width;
  final Function()? onTap; // New parameter to control the circle size
  final String? customText;
  final String? customIconText;
  final Color customTextColor;
  final double customTextSize;
  final FontWeight customFontWeight;
  final AlignmentGeometry? tagAlignment;

  // Constructor to initialize the icon data, size, color, border size, border color, and circle size
  TagComponent({
    this.iconData,
    this.iconSize = 24.0, // Default icon size
    this.iconColor = Colors.black, // Default icon color
    this.borderSize = 2.0, // Default border size
    this.borderColor = Colors.transparent, // Default border color
    this.circleHeight,
    this.width,
    this.backgroundColor = ColorConstants.lightGray,
    this.onTap, // Default circle size
    this.customText,
    this.customIconText,
    this.customTextColor = Colors.black,
    this.customTextSize = 12,
    this.customFontWeight = FontWeight.bold,
    this.tagAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              alignment: tagAlignment,
              width: width,
              height: circleHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                // shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: borderSize,
                ),
              ),
              child: iconData == null
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextComponent(
                        customIconText ?? '',
                        style: TextStyle(
                            color: customTextColor,
                            fontWeight: customFontWeight),
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),

                        ImageComponent(imgUrl: iconData ?? AssetConstants.sad,width: iconSize,height: iconSize, isAsset: true,imgProviderCallback: (imgProviderCallback){}),
                        // Icon(
                        //   iconData,
                        //   size: iconSize,
                        //   color: iconColor,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextComponent(
                            customIconText ?? '',
                            style: TextStyle(color: customTextColor),
                          ),
                        ),
                      ],
                    )),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
