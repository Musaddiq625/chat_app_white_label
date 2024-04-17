import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/size_box_constants.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.earnings,
          centerTitle: false,
          isBackBtnCircular: false,
          action: TextComponent(
            StringConstants.withDraw,
            style: FontStylesConstants.style16(color: ColorConstants.white),
          ),
        ),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          Container(
            width: AppConstants.responsiveWidth(context, percentage: 100),
            decoration: const BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // color: themeCubit.darkBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.totalMoneyEarnedForFar,
                          style: FontStylesConstants.style16(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.black),
                        ),
                        TextComponent(
                          "SAR 1400",
                          style: FontStylesConstants.style38(
                              color: ColorConstants.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: 120,
                    // color: ColorConstants.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageComponent(
                          imgUrl: AssetConstants.earnedCoins,
                          height: 100,
                          width: 100,
                          imgProviderCallback: (imgProvider) {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
