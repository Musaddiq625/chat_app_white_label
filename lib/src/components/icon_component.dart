import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/color_constants.dart';

class IconComponent extends StatelessWidget {
  final IconData? iconData;
  final String? svgData;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final double borderSize;
  final Color borderColor;
  final double? circleHeight;
  final double circleSize;
  final Function()? onTap; // New parameter to control the circle size
  final String? customText;
  final String? customIconText;
  final Color customTextColor;
  final double customTextSize;
  final FontWeight customFontWeight;

  // Constructor to initialize the icon data, size, color, border size, border color, and circle size
  IconComponent({
    this.iconData,
    this.iconSize = 20, // Default icon size
    this.iconColor = Colors.white, // Default icon color
    this.borderSize = 2.0, // Default border size
    this.borderColor = Colors.transparent, // Default border color
    this.circleSize = 30,
    this.circleHeight,
    this.backgroundColor = Colors.grey,
    this.onTap, // Default circle size
    this.customText,
    this.customIconText,
    this.customTextColor = Colors.black,
    this.customTextSize = 12,
    this.customFontWeight = FontWeight.bold,
    this.svgData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: customIconText == null ? circleSize : null,
            // width:  MediaQuery.of(context).size.width/4, // Set the width to the circle size
            height: circleHeight ?? circleSize,
            // Set the height to the circle size
            decoration: customIconText != null
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor,
                    // shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.btnGradientColor,
                        Color.fromARGB(255, 220, 210, 210)
                      ],
                    ),
                    border: Border.all(
                      color: borderColor,
                      width: borderSize,
                    ),
                  )
                : BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: borderSize,
                    ),
                  ),
            child: customIconText != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      iconData != null
                          ? Icon(
                              iconData,
                              size: iconSize,
                              color: iconColor,
                            )
                          : SvgPicture.asset(
                              height: iconSize,
                              svgData!,
                              colorFilter:
                                  ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          customIconText!,
                          style: TextStyle(color: customTextColor),
                        ),
                      ),
                    ],
                  )
                : iconData != null
                    ? Icon(
                        iconData,
                        size: iconSize,
                        color: iconColor,
                      )
                    : SvgPicture.asset(
                        height: iconSize,
                        svgData!,
                        colorFilter:
                            ColorFilter.mode(iconColor, BlendMode.srcIn),
                      ),
          ),
          if (customText != null)
            const SizedBox(
              height: 10,
            ),
          if (customText != null)
            Text(
              customText!,
              style: TextStyle(
                  fontSize: customTextSize,
                  color: customTextColor,
                  fontWeight: customFontWeight),
            ),
        ],
      ),
    );
  }
}
