import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/card_component.dart';
import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int connectionRequestCount = 14;

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
    return UIScaffold(
      bgColor: themeCubit.backgroundColor,
      removeSafeAreaPadding: true,
      appBar: const AppBarComponent(
        StringConstants.notifications,
        showBackbutton: false,
      ),
      widget: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: AppConstants.bottomPadding(context)),
          child: Column(
            children: [
              CardComponent(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                              "${StringConstants.connectionRequests} ($connectionRequestCount)",
                              style: FontStylesConstants.style14(
                                  color: themeCubit.textColor)),
                          Row(
                            children: [
                              TextComponent(
                                StringConstants.seeAll,
                                style: FontStylesConstants.style14(
                                    color: themeCubit.textSecondaryColor),
                              ),
                              IconComponent(
                                showCustomTextonLeft: true,
                                iconColor: themeCubit.textSecondaryColor,
                                iconData: Icons.chevron_right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ContactCard(
                    //     name: 'Jessi Ebert',
                    //     url:
                    //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                    //     title: 'title'),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText: StringConstants.linkedIn,
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        trailingBtnTitle: StringConstants.connect,
                        trailingBtnTap: () {
                          BottomSheetComponent.showBottomSheet(context,
                              isShowHeader: false,
                              body: const CommonBottomSheetComponent(
                                title: StringConstants.youAreNowConnectedWith,
                                description: "Jessi",
                                btnText: StringConstants.message,
                                image:
                                    'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                                isImageProfilePic: true,
                              ));

                          //  Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Column(children: [
                          //     SizedBoxConstants.sizedBoxTwelveH(),
                          //     ProfileImageComponent(
                          //       url:
                          //           'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                          //     ),
                          //     SizedBoxConstants.sizedBoxTwelveH(),

                          //     TextComponent(
                          //       StringConstants.youAreNowConnectedWith,
                          //       style: FontStylesConstants.style18(
                          //           color: themeCubit.textColor,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     TextComponent(
                          //       "Jessi",
                          //       style: FontStylesConstants.style18(
                          //           fontWeight: FontWeight.bold,
                          //           color: themeCubit.primaryColor),
                          //     ),
                          //     SizedBoxConstants.sizedBoxTwelveH(),
                          //     // Row(
                          //     //   mainAxisAlignment:
                          //     //       MainAxisAlignment.spaceEvenly,
                          //     //   children: [
                          //     //     ButtonComponent(
                          //     //         giveDefaultPadding: false,
                          //     //         btnHeight: 35,
                          //     //         btnWidth: 150,
                          //     //         isSmallBtn: true,
                          //     //         bgcolor: ColorConstants.transparent,
                          //     //         buttonText: StringConstants.goBack),
                          //     //     ButtonComponent(
                          //     //         giveDefaultPadding: false,
                          //     //         btnHeight: 35,
                          //     //         bgcolor: themeCubit.primaryColor,
                          //     //         btnWidth: 150,
                          //     //         isSmallBtn: true,
                          //     //         buttonText: StringConstants.message),
                          //     //   ],
                          //     // ),
                          //     SizedBoxConstants.sizedBoxTwelveH(),
                          //   ]),
                          // ));
                        },
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    const DividerComponent(),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText: StringConstants.linkedIn,
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        trailingBtnTitle: StringConstants.connect,
                        trailingBtnTap: () {},
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              // SizedBoxConstants.sizedBoxTenH(),
              CardComponent(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(StringConstants.today,
                              style: FontStylesConstants.style14(
                                  color: themeCubit.textColor)),
                        ],
                      ),
                    ),
                    // ContactCard(
                    //     name: 'Jessi Ebert',
                    //     url:
                    //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                    //     title: 'title'),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText:
                            'Your friend has send you a friend request. lets get started',
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        // overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        // trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        // trailingBtnTitle: StringConstants.connect,
                        // trailingBtnTap: () {},
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    const DividerComponent(),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText:
                            'Your friend has send you a friend request. lets get started',
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        // overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        // trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        // trailingBtnTitle: StringConstants.connect,
                        // trailingBtnTap: () {},
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              SizedBoxConstants.sizedBoxTenH(),
              CardComponent(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(StringConstants.today,
                              style: FontStylesConstants.style14(
                                  color: themeCubit.textColor)),
                        ],
                      ),
                    ),
                    // ContactCard(
                    //     name: 'Jessi Ebert',
                    //     url:
                    //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                    //     title: 'title'),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText:
                            'Your friend has send you a friend request. lets get started',
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        // overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        // trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        // trailingBtnTitle: StringConstants.connect,
                        // trailingBtnTap: () {},
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    const DividerComponent(),
                    ListTileComponent(
                        // icon: Icons.location_on,
                        // iconColor: ColorConstants.white,
                        leadingText:
                            'Your friend has send you a friend request. lets get started',
                        reducePadding: true,
                        leadingsubText: 'Graphic Designer',
                        // overrideTrailingWithBtn: true,
                        // trailingIcon: Icons.add_circle,
                        // trailingIconSize: 30,
                        leadingIcon:
                            'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        leadingIconHeight: 40,
                        leadingIconWidth: 40,
                        isLeadingImageCircular: true,
                        // trailingBtnTitle: StringConstants.connect,
                        // trailingBtnTap: () {},
                        isLeadingImageSVG: true,

                        // isSocialConnected: true,
                        subIconColor: themeCubit.textColor,
                        // trailingText: "heelo",
                        onTap: () {
                          // BottomSheetComponent.showBottomSheet(
                          //   context,
                          //   isShowHeader: false,
                          //   // body: const SocialSheetComponent(
                          //   //   heading: StringConstants.whatsYourLinkedin,
                          //   //   isSvg: true,
                          //   //   textfieldHint: StringConstants.linkedinHintText,
                          //   //   image: AssetConstants.linkedin,
                          //   // ),
                          // );
                        }),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
