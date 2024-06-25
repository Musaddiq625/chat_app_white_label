import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_group_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../models/contact.dart';
import '../wrappers/friend_list_response_wrapper.dart';

class SuccessShareBottomSheet extends StatefulWidget {
  final String successTitle;
  final String eventId;
  final String type;

  // final List<Map<String, dynamic>> contacts;
  final List<FriendListData> contacts;

  final Function()? onCopyLink;
  final Function()? onFacbook;
  final Function()? onInstagram;
  final Function()? onShare;
  final Function()? onContactShareTap;

  SuccessShareBottomSheet(
      {super.key,
      required this.contacts,
      required this.successTitle,
      required this.eventId,
      required this.type,
      this.onCopyLink,
      this.onFacbook,
      this.onInstagram,
      this.onShare,
      this.onContactShareTap});

  @override
  State<SuccessShareBottomSheet> createState() =>
      _SuccessShareBottomSheetState();
}

class _SuccessShareBottomSheetState extends State<SuccessShareBottomSheet> {
  List<FriendListData> filteredContacts = [];
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  TextEditingController searchControllerConnections = TextEditingController();

  String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      filteredContacts = widget.contacts;
      userId = await getIt<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.userIdValue);
    });


    // Initialize with all contacts
  }

  @override
  Widget build(BuildContext context) {

    late final viewYourGroupCubit =
    BlocProvider.of<ViewYourGroupScreenCubit>(context);


    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      constraints: BoxConstraints(
          maxHeight: AppConstants.responsiveHeight(context, percentage: 80)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => NavigationUtil.popAllAndPush(
                    context, RouteConstants.mainScreen),
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
              ImageComponent(
                imgUrl: AssetConstants.confetti,
                imgProviderCallback: (imageProvider) {},
                height: 80,
                width: 80,
                isAsset: true,
              ),
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
                  style: TextStyle(fontSize: 15, color: themeCubit.textColor),
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
                onTap: (){widget.onCopyLink;
                Share.share("https://locals.weuno.com/${(widget.type=="Event"?"event":"group")}/${widget.eventId}id?=${userId}");
                  },
              ),
              IconComponent(
                iconData: Icons.facebook,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.blue,
                circleSize: 60,
                iconSize: 30,
                customText: StringConstants.facebook,
                customTextColor: themeCubit.textColor,
                onTap:(){ widget.onFacbook;
                Share.share("https://locals.weuno.com/${(widget.type=="Event"?"event":"group")}/${widget.eventId}id?=${userId}");
                  },
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
                onTap: (){
                  widget.onInstagram;
                  Share.share("https://locals.weuno.com/${(widget.type=="Event"?"event":"group")}/${widget.eventId}id?=${userId}");
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
                customText: StringConstants.share,
                customTextColor: themeCubit.textColor,
                onTap: (){
                  widget.onShare;
                    Share.share("https://locals.weuno.com/${(widget.type=="Event"?"event":"group")}/${widget.eventId}id?=${userId}");

                },
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (filteredContacts.isNotEmpty)
            const Divider(
              thickness: 0.1,
            ),
          const SizedBox(
            height: 5,
          ),
          if (filteredContacts.isNotEmpty)
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
          if (filteredContacts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, top: 10, bottom: 16, right: 18),
              child: SearchTextField(
                filledColor: ColorConstants.backgroundColor.withOpacity(0.3),
                title: "Search",
                hintText: "Search name, postcode..",
                onSearch: (text) {
                  setState(() {
                    filteredContacts = widget.contacts
                        .where((contact) =>
                    ( contact.firstName ??"")
                                .toLowerCase()
                                .contains(text.toLowerCase()) ||
                        ( contact.lastName??"")
                                .toLowerCase()
                                .contains(text.toLowerCase()) ||
                        (contact.aboutMe ?? "")
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                        .toList();
                  });
                },
                textEditingController: searchControllerConnections,
              ),
            ),
          if (filteredContacts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                // physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredContacts.length,
                itemBuilder: (ctx, index) {
                  final contact = filteredContacts[index];
                  return ContactCard(
                    imageSize: 45,
                    name: "${contact.firstName} ${contact.lastName}",
                    title: contact.aboutMe ?? "",
                    url: contact.image!,
                    // contact: contacts[index],
                    onShareTap: () {
                       viewYourGroupCubit.shareGroup(widget.eventId,widget.type ,contact.id!);
                      NavigationUtil.popAllAndPush(context, RouteConstants.mainScreen);
                      widget.onContactShareTap;
                    },
                  );
                },
              ),
            ),
          SizedBoxConstants.sizedBoxThirtyH(),
        ],
      ),
    );
  }
}
