import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:flutter/material.dart';

import 'profile_image_component.dart';
import 'text_component.dart';

class EarningDetailComponent extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String detail;
  final String earningsAmount;

  EarningDetailComponent({
    required this.profileImageUrl,
    required this.userName,
    required this.detail,
    required this.earningsAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppConstants.responsiveWidth(context, percentage: 100),
          decoration: const BoxDecoration(
            color: ColorConstants.darkBackgrounddColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 15, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImageComponent(
                  url: profileImageUrl,
                  size: 35,
                ),
                SizedBoxConstants.sizedBoxTenW(),
                Container(
                    width: AppConstants.responsiveWidth(context, percentage: 50),
                    child: TextComponent("",
                        listOfText: [
                          "${userName} joined",
                          "${detail}"
                        ],
                        listOfTextStyle: [
                          FontStylesConstants.style14(
                              color: ColorConstants.white),
                          FontStylesConstants.style14(
                              color: ColorConstants.primaryColor)
                        ],
                        maxLines: 2)),
                Spacer(),
                TextComponent("+ ${AppConstants.currency} $earningsAmount",
                  style: FontStylesConstants.style14(color: ColorConstants.white),)
              ],
            ),
          ),
        ),
        SizedBoxConstants.sizedBoxTenH(),
      ],
    );
  }
}