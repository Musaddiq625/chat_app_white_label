import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ButtonWithIconComponent extends StatelessWidget {
  final String btnText;
  final IconData? icon;
  final Function() onPressed;
  final TextStyle btnTextStyle;
  final Color? btnTextColor;
  final Color? bgcolor;
  final double iconSize;
  final Color iconColor;

  const ButtonWithIconComponent({
    super.key,
    required this.btnText,
    this.icon,
    required this.onPressed,
    this.btnTextStyle = const TextStyle(color: ColorConstants.white),
    this.bgcolor ,
    this.btnTextColor = Colors.black,
    this.iconSize = 24,
    this.iconColor = Colors.black,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9.5),
        decoration: BoxDecoration(
          gradient:bgcolor == null? LinearGradient(
            colors: [ColorConstants.btnGradientColor, Color.fromARGB(255, 220, 210, 210)],
          ):null,
            borderRadius: BorderRadius.circular(25),
        color: bgcolor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              btnText,
              style: TextStyle(color: btnTextColor,fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}
