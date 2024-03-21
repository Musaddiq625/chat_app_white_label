import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconComponent extends StatelessWidget {
  final IconData iconData;
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
    required this.iconData,
    this.iconSize = 24.0, // Default icon size
    this.iconColor = Colors.black, // Default icon color
    this.borderSize = 2.0, // Default border size
    this.borderColor = Colors.black, // Default border color
    this.circleSize = 50,
    this.circleHeight,
    this.backgroundColor = Colors.grey,
    this.onTap, // Default circle size
    this.customText,
    this.customIconText,
    this.customTextColor = Colors.black,
    this.customTextSize = 12,
    this.customFontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(

            width: customIconText == null? circleSize: null,
            // width:  MediaQuery.of(context).size.width/4, // Set the width to the circle size
            height:
                circleHeight ?? circleSize, // Set the height to the circle size
            decoration: customIconText == null
                ? BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: borderSize,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor,
                    // shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: borderSize,
                    ),
                  ),
            child: customIconText != null
                ? Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(
                        iconData,
                        size: iconSize,
                        color: iconColor,
                      ),
                      SizedBox(width: 5,),
                      Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: Text(
                          customIconText!,
                          style: TextStyle(color: customTextColor),
                        ),
                      ),
                    ],
                  )
                : Icon(
                    iconData,
                    size: iconSize,
                    color: iconColor,
                  ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
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
