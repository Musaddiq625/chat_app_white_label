import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/app_setting_cubit/app_setting_cubit.dart';
import '../../utils/dialogs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final appCubit = BlocProvider.of<AppSettingCubit>(context);
  Uri gmailUrl =
      Uri.parse('mailto:test@example.org?subject=Greetings&body=Hello%20World');
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.settings,
          centerTitle: false,
          isBackBtnCircular: false,
        ),
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
              leadingText: StringConstants.notifications,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              leadingIconWidth: 20,
              isLeadingIconAsset: true,
              leadingIcon: AssetConstants.notifications,
              isLeadingImageSVG: true,
              onTap: () {
                NavigationUtil.push(
                    context, RouteConstants.allowNotificationScreen);
              }),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              leadingText: StringConstants.contactUs,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.contactUs,
              isLeadingIconAsset: true,
              isLeadingImageSVG: true,
              onTap: () {
                _launch(gmailUrl);
              }),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              leadingText: StringConstants.termsOfService,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              leadingIconWidth: 20,
              isLeadingIconAsset: true,
              leadingIcon: AssetConstants.note,
              isLeadingImageSVG: true,
              onTap: () {
                NavigationUtil.push(context, RouteConstants.termsOfUseScreen);
              }),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              leadingText: StringConstants.privacyPolicy,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              leadingIconWidth: 20,
              isLeadingIconAsset: true,
              leadingIcon: AssetConstants.security,
              isLeadingImageSVG: true,
              onTap: () {
                NavigationUtil.push(
                    context, RouteConstants.privacyPolicyScreen);
              }),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              leadingText: StringConstants.logOut,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              leadingIconWidth: 20,
              isLeadingIconAsset: true,
              leadingIcon: AssetConstants.logout,
              isLeadingImageSVG: true,
              onTap: () {
                _askToLogoutBottomSheet();
              }),
          Spacer(),
          ListTileComponent(
              // iconColor: ColorConstants.white,
              leadingText: StringConstants.deleteYourAccount,
              trailingIcon: null,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 25,
              isLeadingIconAsset: true,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.delete,
              isLeadingImageSVG: true,
              onTap: () {
                _askToDeleteBottomSheet();
              }),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  _askToLogoutBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AssetConstants.warning,
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 20),
            const TextComponent(StringConstants.areYouSureYouWantToLogout,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontFamily: FontConstants.fontProtestStrike)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(color: themeCubit.textColor),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  isSmallBtn: true,
                  bgcolor: ColorConstants.red,
                  textColor: themeCubit.textColor,
                  buttonText: StringConstants.yesPlease,
                  onPressed: () {
                    appCubit.setToken("");
                    setState(() {
                      token = "";
                    });

                    // NavigationUtil.pop(context);
                    // _connectionRemovedBottomSheet();
                    NavigationUtil.popAllAndPush(
                        context, RouteConstants.splashScreenLocal);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _askToDeleteBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AssetConstants.warning,
              width: 60,
              height: 60,
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            const TextComponent(StringConstants.areYouSureYouWantToDelete,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontFamily: FontConstants.fontProtestStrike)),
            SizedBoxConstants.sizedBoxTenH(),
            TextComponent(StringConstants.allYourDataWillBeLost,
                textAlign: TextAlign.center,
                style: FontStylesConstants.style16()),
            SizedBoxConstants.sizedBoxTwentyH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(color: themeCubit.textColor),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  isSmallBtn: true,
                  bgcolor: ColorConstants.red,
                  textColor: themeCubit.textColor,
                  buttonText: StringConstants.yesPlease,
                  onPressed: () {
                    NavigationUtil.popAllAndPush(
                        context, RouteConstants.splashScreenLocal);
                    // NavigationUtil.pop(context);
                    // _connectionRemovedBottomSheet();
                    // NavigationUtil.popAllAndPush(
                    //     context, RouteConstants.homeScreenLocal);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  Future<void> _launch(Uri url) async {
    try {
      final canLaunchUrlResult = await canLaunchUrl(url);
      if (canLaunchUrlResult) {
        await launchUrl(url);
      } else {
        Dialogs.showSnackbar(context, 'Could not launch this app');
      }
    } catch (e) {
      print('Error launching URL: $e');
      Dialogs.showSnackbar(
          context, 'An error occurred while launching the URL');
    }
  }
}
