import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonComponent extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final Color bgcolor;
  final Color emptybgcolor;
  final Color textColor;
  final Color? overrideTextColor;
  final Color? overrideBorderColor;
  final bool invertBtnColor;
  final bool minimizeHorizontalPadding;
  final bool minimizeVerticalPadding;
  final String? leadingImgPath;
  final BorderRadius? overrideBorderRadius;
  final TextStyle? overrideFontStyle;
  final bool isSmallBtn;
  final double? btnHeight;
  final double? btnWidth;
  final bool giveDefaultPadding;
  final bool isBold;

  const ButtonComponent({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.bgcolor = ColorConstants.primaryColor,
    this.emptybgcolor = ColorConstants.blackLight,
    this.overrideTextColor,
    this.overrideBorderColor,
    this.invertBtnColor = false,
    this.minimizeHorizontalPadding = false,
    this.leadingImgPath,
    this.overrideBorderRadius,
    this.overrideFontStyle,
    this.minimizeVerticalPadding = false,
    this.isSmallBtn = false,
    this.textColor = ColorConstants.grey1,
    this.btnHeight,
    this.btnWidth,
    this.giveDefaultPadding = true,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

    BorderRadius borderRadius() => BorderRadius.circular(25);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: borderRadius(),
          child: Container(
            padding: giveDefaultPadding
                ? EdgeInsets.symmetric(
                    vertical: 10, horizontal: isSmallBtn ? 30 : 0)
                : EdgeInsets.zero,
            height: btnHeight,
            width: btnWidth ??
                (isSmallBtn ? null : MediaQuery.of(context).size.width),
            decoration: BoxDecoration(
                borderRadius: overrideBorderRadius ?? borderRadius(),
                // border: overrideBorderColor != null
                //     ? Border.all(color: overrideBorderColor!)
                //     : Border.all(color: bgcolor),
                color: onPressed == null
                    ? emptybgcolor //ColorConstants.disableColor
                    : bgcolor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingImgPath != null) ...[
                  if (leadingImgPath!.split('.').last == 'svg')
                    SvgPicture.asset(
                      leadingImgPath!,
                      height: 16,
                      width: 16,
                    )
                  else
                    Image.asset(
                      leadingImgPath!,
                      height: 16,
                      width: 16,
                    ),
                  SizedBoxConstants.sizedBoxSixteenW(),
                ],
                TextComponent(
                  buttonText,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: overrideFontStyle ??
                      FontStylesConstants.style14(
                        fontWeight:
                            isBold ? FontWeight.bold : FontWeight.normal,
                        color: textColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // return ElevatedButton(
    //     onPressed: onPressed,
    //     style: ElevatedButton.styleFrom(
    //         foregroundColor: textColor,
    //         backgroundColor: bgcolor,
    //         disabledBackgroundColor: ColorConstants.lightGray.withOpacity(0.2),
    //         disabledForegroundColor: ColorConstants.lightGray,
    //         shadowColor: Colors.transparent,
    //         padding: EdgeInsets.symmetric(
    //             horizontal: horizontalLength, vertical: 12),
    //         textStyle:
    //             TextStyle(fontSize: textSize, fontWeight: FontWeight.bold)),
    //     child: Text(buttonText));
  }
}

// class ButtonComponent2 extends StatelessWidget {
//   final String buttonText;
//   final Function()? onPressed;
//   final Color bgcolor;
//   final Color? overrideTextColor;
//   final Color? overrideBorderColor;
//   final bool invertBtnColor;
//   final bool minimizeHorizontalPadding;
//   final bool minimizeVerticalPadding;
//   final String? leadingImgPath;
//   final BorderRadius? overrideBorderRadius;
//   final bool? overrideFontStyle;
//   final bool isSmallBtn;

//   const ButtonComponent2({
//     Key? key,
//     required this.buttonText,
//     this.onPressed,
//     this.bgcolor = ColorConstants.bgcolorbutton,
//     this.overrideTextColor,
//     this.overrideBorderColor,
//     this.invertBtnColor = false,
//     this.minimizeHorizontalPadding = false,
//     this.leadingImgPath,
//     this.overrideBorderRadius,
//     this.overrideFontStyle = false,
//     this.minimizeVerticalPadding = false,
//     this.isSmallBtn = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     BorderRadius _borderRadius() => BorderRadius.circular(25);
//     return Stack(
//       alignment: Alignment.centerLeft,
//       children: [
//         InkWell(
//           onTap: onPressed,
//           borderRadius: _borderRadius(),
//           child: Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 12,
//             ),
//             width: isSmallBtn
//                 ? AppConstants.responsiveWidth(context, percentage: 20)
//                 : MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 borderRadius: overrideBorderRadius ?? _borderRadius(),
//                 border: overrideBorderColor != null
//                     ? Border.all(color: overrideBorderColor!)
//                     : Border.all(color: bgcolor),
//                 color: onPressed == null
//                     ? null //ColorConstants.disableColor
//                     : bgcolor),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (leadingImgPath != null) ...[
//                   if (leadingImgPath!.split('.').last == 'svg')
//                     SvgPicture.asset(
//                       leadingImgPath!,
//                       height: 16,
//                       width: 16,
//                     )
//                   else
//                     Image.asset(
//                       leadingImgPath!,
//                       height: 16,
//                       width: 16,
//                     ),
//                   SizedBoxConstants.sizedBoxSixteenW(),
//                 ],
//                 TextComponent(
//                   buttonText,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                   style: FontStylesConstants.style14(
//                     fontWeight: FontWeight.bold,
//                     // color: overrideTextColor ?? ColorConstants.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
