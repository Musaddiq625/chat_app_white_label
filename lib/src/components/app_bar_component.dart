import 'dart:io';

import 'package:chat_app_white_label/src/components/back_button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarComponent extends StatelessWidget {
  final Function()? overrideBackPressed;
  final String? titleText;
  final String? titleText2;
  final String? subtitleText;
  Color? iconBgColor;
  final bool enableDark;
  final bool enablePadding;
  final bool showBackbutton;
  final bool isBackBtnCircular;
  final bool centerTitle;
  final Widget? action;

  AppBarComponent(
    this.titleText, {
    Key? key,
    this.overrideBackPressed,
    this.enableDark = false,
    this.subtitleText,
    this.iconBgColor,
    this.enablePadding = false,
    this.showBackbutton = true,
    this.action,
    this.centerTitle = true,
    this.isBackBtnCircular = true,
    this.titleText2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    iconBgColor ??= themeCubit.darkBackgroundColor;

    return Container(
      height: kToolbarHeight +
          (Platform.isIOS ? MediaQuery.of(context).viewPadding.top : 10),
      margin: titleText != null
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
          if (showBackbutton)
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: BackButtonComponent(
                  bgColor: iconBgColor ?? ColorConstants.blackLight,
                  image: AssetConstants.backArrow,
                  //! pass your asset here
                  enableDark: enableDark,
                  isImage: true,
                  isCircular: isBackBtnCircular,
                  onTap: () {
                    if (showBackbutton) {
                      overrideBackPressed == null
                          ? NavigationUtil.pop(context)
                          : overrideBackPressed!();
                    }
                  }),
            ),
          // else
          //   const SizedBox(),
          if (titleText != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: showBackbutton ? 5 : 16),
                      child: TextComponent(
                        '',
                        listOfText: [titleText!, titleText2 ?? ''],
                        listOfTextStyle: [
                          FontStylesConstants.style24(
                              color: themeCubit.primaryColor),
                          FontStylesConstants.style24(
                              color: themeCubit.textSecondaryColor),
                        ],
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: FontStylesConstants.style22(
                            color: themeCubit.primaryColor),
                      ),
                    ),
                  ),
                ),
                if (subtitleText != null)
                  Expanded(
                    child: TextComponent(
                      subtitleText!,
                      // style: FontStyles.font15(),
                    ),
                  ),
              ],
            ),

          //!trailing work will be done here in future
          // Opacity(
          //   opacity: 1.0,
          //   child: BackButtonComponent(
          //       image: AssetConstants.add,
          //       enableDark: enableDark,
          //       onTap: () {
          //         overrideBackPressed == null
          //             ? NavigationUtil.pop(context)
          //             : overrideBackPressed!();
          //       }),
          // ),
          if (centerTitle == false) const Spacer(),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: action!,
            )
        ],
      ),
    );
  }
}
