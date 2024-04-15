import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CircleButtonComponent extends StatelessWidget {
  const CircleButtonComponent({
    Key? key,
    this.onPressed,
    required this.backgroundColor,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          color: ColorConstants.white,
          size: 15,
        ),
      ),
    );
  }
}
