import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final double borderSize;
  final Color borderColor;
  final double circleSize; // New parameter to control the circle size

  // Constructor to initialize the icon data, size, color, border size, border color, and circle size
  CustomIconWidget({
    required this.iconData,
    this.iconSize =   24.0, // Default icon size
    this.iconColor = Colors.black, // Default icon color
    this.borderSize =   2.0, // Default border size
    this.borderColor = Colors.black, // Default border color
    this.circleSize =   50.0,
    this.backgroundColor= Colors.grey // Default circle size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize, // Set the width to the circle size
      height: circleSize, // Set the height to the circle size
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderSize,
        ),
      ),
      child: Icon(
        iconData,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}