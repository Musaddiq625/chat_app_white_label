import 'dart:io';

import 'package:chat_app_white_label/src/components/back_button_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final Function()? overrideBackPressed;
  final String? text;
  final String? subtitleText;
  final bool enableDark;
  final bool enablePadding;
  final bool showBackbutton;

  const AppBarComponent(
    this.text, {
    Key? key,
    this.overrideBackPressed,
    this.enableDark = false,
    this.subtitleText,
    this.enablePadding = false,
    this.showBackbutton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight +
          (Platform.isIOS ? MediaQuery.of(context).viewPadding.top : 10),
      margin: text != null
          ? EdgeInsets.only(top: Platform.isIOS ? 2 : 5, left: 8)
          : null,
      // padding: text != null
      //     ? EdgeInsets.only(
      //         top: Platform.isIOS ? MediaQuery.of(context).viewPadding.top : 16,
      //         bottom: 18,
      //         // left: !enablePadding ? AppConstants.defaultPadding : 0,
      //         // right: !enablePadding ? AppConstants.defaultPadding : 0,
      //       )
      //     : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //if (showBackbutton)
          BackButtonComponent(
              image: AssetConstants.backArrow, //! pass your asset here
              enableDark: enableDark,
              isImage: true,
              isCircular: true,
              onTap: () {
                if (showBackbutton) {
                  overrideBackPressed == null
                      ? NavigationUtil.pop(context)
                      : overrideBackPressed!();
                }
              }),
          // else
          //   const SizedBox(),
          if (text != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      text!,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      //! style: FontStyles.font19(
                      //!     fontWeight: FontWeight.w200, bold: false),
                    ),
                  ),
                ),
                if (subtitleText != null)
                  Expanded(
                    child: Text(
                      subtitleText!,
                      // style: FontStyles.font15(),
                    ),
                  ),
              ],
            ),

          //!trailing work will be done here in future
          Opacity(
            opacity: 0.0,
            child: BackButtonComponent(
                image: AssetConstants.add,
                enableDark: enableDark,
                onTap: () {
                  overrideBackPressed == null
                      ? NavigationUtil.pop(context)
                      : overrideBackPressed!();
                }),
          ),
        ],
      ),
    );
  }
}
