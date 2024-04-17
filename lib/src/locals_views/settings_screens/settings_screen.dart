import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: appBar(),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: IconComponent(
              svgData: AssetConstants.backArrow,
              svgDataCheck: false,
              iconColor: ColorConstants.lightGray,
              iconSize: 40,
              circleHeight: 40,
            ),
          ),
          TextComponent(
            StringConstants.settings,
            style: FontStylesConstants.style28(color: themeCubit.primaryColor),
          ),
          SizedBoxConstants.sizedBoxTenW(),
        ],
      ),
    );
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.notifications,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.notifications,
              isLeadingImageSVG: true,
              onTap: () {}),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.contactUs,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.contactUs,
              isLeadingImageSVG: true,
              onTap: () {}),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.termsOfService,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.note,
              isLeadingImageSVG: true,
              onTap: () {}),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.privacyPolicy,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.security,
              isLeadingImageSVG: true,
              onTap: () {}),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.logOut,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.logout,
              isLeadingImageSVG: true,
              onTap: () {}),
          Spacer(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              iconText: StringConstants.deleteYourAccount,
              subIcon: null,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.delete,
              isLeadingImageSVG: true,
              onTap: () {}),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }
}
