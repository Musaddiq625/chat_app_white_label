import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ShareBottomSheet {
  static shareBottomSheet(
      BuildContext context, List<ContactModel> contacts, String type) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);

    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          constraints:  BoxConstraints(maxHeight: AppConstants.responsiveHeight(context,percentage: 70)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                    child: TextComponent(
                      "${StringConstants.share} ${type}",
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: themeCubit.textColor,
                        circleSize: 50,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                              ClipboardData(text: "www.locals.com/event"))
                          .then((value) => ToastComponent.showToast(
                              StringConstants.copiedToClipboard,
                              context: context));
                    },
                    child: IconComponent(
                      // iconData: Icons.link,
                      svgData: AssetConstants.copyLink,
                      borderColor: Colors.transparent,
                      backgroundColor: themeCubit.primaryColor,
                      iconColor: ColorConstants.black,
                      circleSize: 60,
                      customText: StringConstants.copyLink,
                      customTextColor: themeCubit.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Share.share('www.locals.com/event');
                    },
                    child: IconComponent(
                      iconData: Icons.facebook,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.blue,
                      circleSize: 60,
                      iconSize: 30,
                      customText: StringConstants.facebook,
                      customTextColor: themeCubit.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share('www.locals.com/event');
                    },
                    child: Column(
                      children: [
                        ImageComponent(
                          height: 60,
                          width: 60,
                          imgUrl: AssetConstants.instagram,
                          imgProviderCallback: (imageProvider) {},
                        ),
                        SizedBoxConstants.sizedBoxTenH(),
                        TextComponent(
                          StringConstants.instagram,
                          style: FontStylesConstants.style12(
                              color: ColorConstants.white),
                        )
                      ],
                    ),
                  ),
                  IconComponent(
                    svgData: AssetConstants.share,
                    iconColor: ColorConstants.black,
                    borderColor: Colors.transparent,
                    // backgroundColor:ColorConstants.transparent,
                    circleSize: 60,
                    onTap: () {
                      Share.share('www.locals.com/event');
                    },
                    customText: StringConstants.share,
                    customTextColor: themeCubit.textColor,
                  )
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              const Divider(
                thickness: 0.1,
              ),
              if(contacts.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 16),
                child: TextComponent(StringConstants.yourConnections,
                    style: FontStylesConstants.style18(
                        color: themeCubit.primaryColor)),
              ),
              if(contacts.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (ctx, index) {
                    bool isLast = index == contacts!.length - 1;
                    return ContactCard(
                      imageSize: 50,
                      showDivider: (!isLast),
                      name: contacts[index].name,
                      title: contacts[index].title,
                      url: contacts[index].url,
                      // contact: contacts[index],
                      onShareTap: () {
                        Navigator.pop(context);
                        shareWithConnectionBottomSheet(
                            StringConstants.fireWorks,
                            contacts[index].name,
                            context,
                            type);
                      },
                      onProfileTap: () {
                        NavigationUtil.push(
                            context, RouteConstants.profileScreenLocal);
                      },
                    );
                  },
                ),
              ),
              if(contacts.isNotEmpty)
              SizedBoxConstants.sizedBoxTenH()
            ],
          ),
        ));
  }

  static shareWithConnectionBottomSheet(
      String eventName, String userName, BuildContext context, String type) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            const ProfileImageComponent(url: ''),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: FontStylesConstants.style20(),
                // style: TextStyle(
                //     fontSize: 20,
                //     fontFamily: FontConstants.fontProtestStrike,
                //     height: 1.5),
                children: <TextSpan>[
                  TextSpan(text: StringConstants.areYouSureYouwantToShare),
                  TextSpan(text: "\n" + type + " "),
                  TextSpan(
                    text: eventName,
                    style: TextStyle(color: themeCubit.primaryColor),
                  ),
                  TextSpan(text: " with \n"),
                  TextSpan(
                    text: "$userName?",
                    style: TextStyle(color: themeCubit.primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => {
                          Navigator.pop(context),
                          // shareEventBottomSheet(context),
                        },
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(color: themeCubit.textColor),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  bgcolor: themeCubit.primaryColor,
                  isSmallBtn: true,
                  textColor: themeCubit.backgroundColor,
                  buttonText: StringConstants.yesShareIt,
                  onPressed: () {
                    Navigator.pop(context);
                    yesShareItBottomSheet(context, type);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  static yesShareItBottomSheet(BuildContext context, String type) {
    navigateToBack(context);
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: "${type} ${StringConstants.shared}",
        image: AssetConstants.garland,
      ),
    );
  }

  static navigateToBack(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
  }
}
