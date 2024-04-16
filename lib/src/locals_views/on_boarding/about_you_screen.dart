import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/connect_social_sheet_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          "",
          action: TextComponent(StringConstants.skip,
              style: TextStyle(
                fontSize: 14,
                color: themeCubit.textColor,
              )),
        ),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }

  Widget onBoarding() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: enterName(),
      ),
    );
  }

  enterName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap:()=> NavigationUtil.pop(context),
            //       child: IconComponent(
            //         iconData: Icons.arrow_back_ios_new_outlined,
            //         borderColor: ColorConstants.transparent,
            //         backgroundColor: ColorConstants.iconBg,
            //         iconColor: ColorConstants.white,
            //         circleSize: 30,
            //         iconSize: 20,
            //       ),
            //     ),
            //     TextComponent(StringConstants.skip,
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: themeCubit.textColor,
            //         ))
            //   ],
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    StringConstants.tellUsABitAboutYourSelf,
                    style: TextStyle(
                        fontSize: 22,
                        color: themeCubit.textColor,
                        fontFamily: FontConstants.fontProtestStrike),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextComponent(
                    StringConstants.alsoDoThisLaterInProfile,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.lightGray,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  TextComponent(
                    StringConstants.bio,
                    style: TextStyle(
                      fontSize: 12,
                      color: themeCubit.textColor,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxSixH(),
                  TextFieldComponent(
                    _bioController,
                    filled: true,
                    hintText: StringConstants.bioHint,
                    maxLines: 15,
                    minLines: 4,
                    textColor: themeCubit.textColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            const Divider(
              thickness: 0.1,
            ),
            socials(),
            SizedBoxConstants.sizedBoxTenH(),
            const Divider(
              thickness: 0.1,
            ),
            moreAboutYou(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ButtonComponent(
              bgcolor: themeCubit.primaryColor,
              textColor: themeCubit.backgroundColor,
              buttonText: StringConstants.continues,
              onPressed: () {
                NavigationUtil.push(context, RouteConstants.interestScreen);
              }),
        )
      ],
    );
  }

  Widget socials() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: TextComponent(StringConstants.socials,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.lightGray,
                )),
          ),
          // SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.linkedIn,
              subIcon: Icons.add_circle,
              trailingIconSize: 30,
              leadingIcon: AssetConstants.linkedin,
              isLeadingImageCircular: true,
              isLeadingImageSVG: true,
              isSocialConnected: true,
              subIconColor: themeCubit.textColor,
              subText: "",
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: const SocialSheetComponent(
                    heading: StringConstants.whatsYourLinkedin,
                    isSvg: true,
                    textfieldHint: StringConstants.linkedinHintText,
                    image: AssetConstants.linkedin,
                  ),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingIcon: AssetConstants.instagram,
              isSocialConnected: true,
              iconText: StringConstants.instagram,
              subIconColor: themeCubit.primaryColor,
              trailingIconSize: 30,
              subIcon: Icons.check_circle,
              subText: StringConstants.connected,
              subTextColor: themeCubit.primaryColor,
              isLeadingImageCircular: true,
              isLeadingImageSVG: true,
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: const SocialSheetComponent(
                    heading: StringConstants.whatsYourInstagram,
                    isSvg: true,
                    textfieldHint: StringConstants.instagramHintText,
                    image: AssetConstants.instagram,
                  ),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingIcon: AssetConstants.facebook,
              isSocialConnected: true,
              iconText: StringConstants.facebook,
              subIconColor: themeCubit.primaryColor,
              trailingIconSize: 30,
              subIcon: Icons.check_circle,
              subText: StringConstants.connected,
              subTextColor: themeCubit.primaryColor,
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: const SocialSheetComponent(
                    heading: StringConstants.whatsYourFacebook,
                    textfieldHint: StringConstants.facebookHintText,
                    image: AssetConstants.facebook,
                  ),
                );
              }),
        ],
      ),
    );
  }

  moreAboutYou() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: TextComponent(StringConstants.moreAboutYou,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.lightGray,
                )),
          ),
          // SizedBoxConstants.sizedBoxEightH(),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.diet,
              subIconColor: ColorConstants.iconBg,
              leadingIcon: AssetConstants.diet,
              overrideLeadingIconSize: 15,
              isLeadingImageSVG: true,
              subText: "Love Meat",
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.workout,
              leadingIcon: AssetConstants.workout,
              isLeadingImageSVG: true,
              overrideLeadingIconSize: 15,
              subIconColor: ColorConstants.iconBg,
              subText: "Very Active",
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.height,
              leadingIcon: AssetConstants.height,
              isLeadingImageSVG: true,
              overrideLeadingIconSize: 15,
              subIconColor: ColorConstants.iconBg,
              subText: "5'8",
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.smoking,
              leadingIcon: AssetConstants.smoking,
              subIconColor: ColorConstants.iconBg,
              subText: "No",
              subTextColor: themeCubit.textColor,
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.drinking,
              leadingIcon: AssetConstants.drinking,
              subIconColor: ColorConstants.iconBg,
              subText: "No",
              subTextColor: themeCubit.textColor,
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.pets,
              leadingIcon: AssetConstants.pets,
              subIconColor: ColorConstants.iconBg,
              subText: "No",
              subTextColor: themeCubit.textColor,
              onTap: () {}),
        ],
      ),
    );
  }

  moreAboutYouSelection(String image, String title) {
    return BottomSheetComponent.showBottomSheet(context,
        body: Column(
          children: [
            ImageComponent(
              imgUrl: image,
              imgProviderCallback: (imgProvider) {},
            )
          ],
        ));
  }
}
