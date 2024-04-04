import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String buttonText;
  final Function()? onPressedFunction;
  final Color bgcolor;
  final double textSize;
  final Color? textColor;
  final double horizontalLength;

  ButtonComponent(
      {super.key,
      required this.buttonText,
      this.onPressedFunction,
      this.bgcolor = ColorConstants.bgcolorbutton,
      this.textSize = 15,
      this.textColor = ColorConstants.black,
      this.horizontalLength = 25});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressedFunction,
        style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: bgcolor,
            disabledBackgroundColor: ColorConstants.lightGray.withOpacity(0.2),
            disabledForegroundColor: ColorConstants.lightGray,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalLength, vertical: 12),
            textStyle:
                TextStyle(fontSize: textSize, fontWeight: FontWeight.bold)),
        child: Text(buttonText));
  }
}
