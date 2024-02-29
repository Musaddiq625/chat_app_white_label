import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconComponent extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final double borderSize;
  final Color borderColor;
  final double circleSize;
  final Function ()? onTap;// New parameter to control the circle size
  final String? customText;
  final String? customIconText;
  final Color customTextColor;
  final double customTextSize;
  final FontWeight customFontWeight;

  // Constructor to initialize the icon data, size, color, border size, border color, and circle size
  IconComponent({
    required this.iconData,
    this.iconSize =   24.0, // Default icon size
    this.iconColor = Colors.black, // Default icon color
    this.borderSize =   2.0, // Default border size
    this.borderColor = Colors.black, // Default border color
    this.circleSize =   50.0,
    this.backgroundColor= Colors.grey,
    this.onTap,// Default circle size
    this.customText,
    this.customIconText,
    this.customTextColor= Colors.black,
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
            width: circleSize, // Set the width to the circle size
            height: circleSize, // Set the height to the circle size
            decoration: customIconText == null
        ?
            BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: borderSize,
              ),
            ) :
            BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
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
                Icon(
                  iconData,
                  size: iconSize,
                  color: iconColor,
                ),
                Text(customIconText!,style: TextStyle(color: Colors.white),),
              ],
            )
                : Icon(
              iconData,
              size: iconSize,
              color: iconColor,
            ),
          ),
          SizedBox(height: 10,),
          if (customText != null) // Only show the text if customText is not null
            Text(
              customText!,
              style: TextStyle(
                fontSize: customTextSize, // Adjust the font size as needed
                color: customTextColor,
                fontWeight: customFontWeight// Adjust the text color as needed
              ),
            ),
        ],
      ),
    );
  }
}