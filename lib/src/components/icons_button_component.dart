import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonWithIconComponent extends StatelessWidget {
  final String? btnText;
  final IconData? icon;
  final String? svgData;
  final Function() onPressed;
  final TextStyle btnTextStyle;
  final Color? btnTextColor;
  final Color? bgcolor;
  final double iconSize;
  final Color iconColor;
  final double? widthSpace;
  final bool svgDataCheck;

  const ButtonWithIconComponent({
    super.key,
    this.btnText,
    this.icon,
    this.svgData,
    this.svgDataCheck=false,
    this.widthSpace = 10,
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
            if(btnText!=null)
            Text(
              btnText!,
              style: TextStyle(color: btnTextColor,fontWeight: FontWeight.bold),
            ),
            SizedBox(width: widthSpace),
            svgData!=null ?
            SvgPicture.asset(
              height: iconSize,
                svgData!,
              colorFilter:
              ColorFilter.mode(iconColor, BlendMode.srcIn),
            ):Icon(
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
