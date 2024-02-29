import 'package:flutter/material.dart';

class ButtonWithIconComponent extends StatelessWidget {
  final String btnText;
  final IconData? icon;
  final Function() onPressed;
  final TextStyle btnTextStyle;
  final Color bgcolor;
  final double iconSize;
  final Color iconColor;
  final double width;

  const ButtonWithIconComponent({
    super.key,
    required this.btnText,
    this.icon,
    required this.onPressed,
    this.btnTextStyle = const TextStyle(color: Colors.white),
    this.bgcolor = Colors.indigo,
    this.iconSize = 24,
    this.iconColor = Colors.white,
    this.width = 110,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9.5),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              btnText,
              style: btnTextStyle,
            ),
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
