import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact.dart';

class SuccessShareBottomSheet extends StatefulWidget {
  final String successTitle;
  // final List<Map<String, dynamic>> contacts;
  final List<ContactModel> contacts;

  final Function()? onCopyLink;
  final Function()? onFacbook;
  final Function()? onInstagram;
  final Function()? onShare;
  final Function()? onContactShareTap;

   SuccessShareBottomSheet({super.key, required this.contacts,required this.successTitle, this.onCopyLink, this.onFacbook, this.onInstagram, this.onShare, this.onContactShareTap});

  @override
  State<SuccessShareBottomSheet> createState() => _SuccessShareBottomSheetState();
}

class _SuccessShareBottomSheetState extends State<SuccessShareBottomSheet> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  TextEditingController searchControllerConnections = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      constraints: const BoxConstraints(maxHeight: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0, top: 15),
                  child: IconComponent(
                    iconData: Icons.close,
                    borderColor: Colors.transparent,
                    iconColor: themeCubit.textColor,
                    circleSize: 10,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              SizedBoxConstants.sizedBoxTenH(),
              ImageComponent(imgUrl: AssetConstants.confetti, imgProviderCallback: (imageProvider){},height: 80,width: 80,isAsset: true,),
              // Image.asset(
              //   AssetConstants.confetti,
              //   width: 100,
              //   height: 100,
              // ),
              Container(
                width: 300,
                padding: const EdgeInsets.only(top: 10),
                child: TextComponent(
                  widget.successTitle!,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontConstants.fontProtestStrike,
                      color: themeCubit.textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: TextComponent(
                  StringConstants.inviteYourFriend,
                  maxLines: 5,
                  style:
                  TextStyle(fontSize: 15, color: themeCubit.textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconComponent(
                // iconData: Icons.link,
                svgData: AssetConstants.copyLink,
                borderColor: Colors.transparent,
                backgroundColor: themeCubit.primaryColor,
                iconColor: ColorConstants.black,
                circleSize: 60,
                customText: StringConstants.copyLink,
                customTextColor: themeCubit.textColor,
                onTap: widget.onCopyLink,
              ),
              IconComponent(
                iconData: Icons.facebook,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.blue,
                circleSize: 60,
                iconSize: 30,
                customText: StringConstants.facebook,
                customTextColor: themeCubit.textColor,
                onTap:  widget.onFacbook,
              ),
              // IconComponent(
              //   svgDataCheck: false,
              //   svgData: AssetConstants.instagram,
              //   backgroundColor: Colors.transparent,
              //   borderColor: Colors.transparent,
              //   circleSize: 60,
              //   customText: StringConstants.instagram,
              //   customTextColor: themeCubit.textColor,
              //   iconSize: 60,
              // ),
              GestureDetector(
                onTap:  widget.onInstagram,
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
                customText: StringConstants.share,
                customTextColor: themeCubit.textColor,
                onTap:  widget.onShare,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 5),
            child: TextComponent(
              StringConstants.yourConnections,
              style: TextStyle(
                  color: themeCubit.primaryColor,
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, top: 10, bottom: 16, right: 18),
            child: SearchTextField(
              filledColor: ColorConstants.backgroundColor.withOpacity(0.3),
              title: "Search",
              hintText: "Search name, postcode..",
              onSearch: (text) {
                // widget.viewModel.onSearchStories(text);
              },
              textEditingController: searchControllerConnections,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.contacts.length,
              itemBuilder: (ctx, index) {
                return ContactCard(
                  name: widget.contacts[index].name,
                  title: widget.contacts[index].title,
                  url: widget.contacts[index].url,
                  // contact: contacts[index],
                  onShareTap: () {
                    Navigator.pop(context);
                    widget.onContactShareTap;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
