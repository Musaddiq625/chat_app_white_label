import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/connect_social_sheet_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/route_constants.dart';
import '../../models/user_model.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../wrappers/more_about_wrapper.dart';

class AboutYouScreen extends StatefulWidget {
  final bool comingFromEditProfile;
  UserModel? userModel;


   AboutYouScreen({super.key, this.comingFromEditProfile = false, this.userModel});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  late UserScreenCubit userScreenCubit = BlocProvider.of<UserScreenCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController instaController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  FixedExtentScrollController? scrollController =
      new FixedExtentScrollController();
  var data = {
    'Diet': ['Love Meat', 'vegeterian', 'vegan', 'Everything is fine'],
    'Workout': ['Active', 'Sometimes', 'Almost Never', 'id rather not say'],
    'Smoking': ['Socially', 'Regularly', 'Never', 'id rather not say'],
    'Drinking': ['Socially', 'Regularly', 'Never', 'id rather not say'],
    'Pets': ['Cat', 'Dog', 'Never', 'id rather not say'],
    // Add more keys as needed
  };
  final Map<String, dynamic> _moreAboutYou = {
    StringConstants.diet: {
      "Love Meat": true,
      "vegeterian": false,
      "vegan": false,
      "Everything is fine": false,
      "i'd rather not say ": false
    },
    StringConstants.workout: {
      "Active": true,
      "Sometimes": false,
      "Almost Never": false,
      "i'd rather not say": false
    },
    StringConstants.height: {"starting_feet": 3, "starting_inches": 3},
    StringConstants.smoking: {
      "Socially": true,
      "Regularly": false,
      "Never": false,
      "i'd rather not say ": false
    },

    // StringConstants.smoking: {},
    // {
    // smoking: [a, b, c],
    // }
    // a, b, c
    // smoking = {
    // a: false,
    // b: false,
    // c: false
    // }

    StringConstants.drinking: {
      "Socially": true,
      "Regularly": false,
      "Never": false,
      "i'd rather not say ": false
    },
    StringConstants.pets: {
      "Cat": true,
      "Dog": false,
      "Other": false,
      "i'd rather not say ": false
    },
  };

  final Map<String, dynamic> _tempmoreAboutValue = {};

  List<String> newHeight = [];

  List<String> height = [
    '3\'3 (99 cm)',
    '3\'4 (102 cm)',
    '3\'5 (104 cm)',
    '3\'6 (107 cm)',
    '3\'7 (109 cm)',
    '3\'8 (112 cm)',
    '3\'9 (114 cm)',
    '3\'10 (117 cm)',
    '3\'11 (119 cm)',
    '4\'0 (122 cm)',
    '4\'3 (130 cm)',
    '4\'4 (132 cm)',
    '4\'5 (134 cm)',
    '4\'6 (137 cm)',
    '4\'7 (139 cm)',
    '4\'8 (142 cm)',
    '4\'9 (144 cm)',
    '4\'10 (147 cm)',
    '4\'11 (149 cm)',
    '5\'0 (152 cm)',
    '5\'3 (160 cm)',
    '5\'4 (163 cm)',
    '5\'5 (165 cm)',
    '5\'6 (168 cm)',
    '5\'7 (170 cm)',
    '5\'8 (173 cm)',
    '5\'9 (175 cm)',
    '5\'10 (178 cm)',
    '5\'11 (180 cm)',
    '6\'0 (183 cm)',
    '6\'3 (190 cm)',
    '6\'4 (193 cm)',
    '6\'5 (196 cm)',
    '6\'6 (198 cm)',
    '6\'7 (201 cm)',
    '6\'8 (203 cm)',
    '6\'9 (206 cm)',
    '6\'10 (208 cm)',
    '6\'11 (211 cm)',
    '7\'0 (213 cm)',
    '7\'3 (221 cm)',
    '7\'4 (224 cm)',
    '7\'5 (226 cm)',
    '7\'6 (229 cm)',
    '7\'7 (231 cm)',
    '7\'8 (234 cm)',
    '7\'9 (236 cm)',
    '7\'10 (239 cm)',
    '7\'11 (241 cm)',
    '8\'0 (244 cm)',
    '8\'3 (251 cm)',
    '8\'4 (254 cm)',
    '8\'5 (257 cm)',
    '8\'6 (259 cm)',
    '8\'7 (262 cm)',
    '8\'8 (264 cm)',
    '8\'9 (267 cm)',
    '8\'10 (270 cm)',
    '8\'11 (272 cm)',
    '9\'0 (274 cm)',
    '9\'3 (280 cm)',
    '9\'4 (283 cm)',
    '9\'5 (286 cm)',
    '9\'6 (289 cm)',
    '9\'7 (291 cm)',
    '9\'8 (294 cm)',
    '9\'9 (297 cm)',
    '9\'10 (300 cm)',
    '9\'11 (302 cm)',
    '10\'0 (305 cm)',
  ];


  var parsedDataOutPut;

  @override
  void initState() {
    onBoardingCubit.getMoreAboutData();
    if( widget.userModel?.bio == "null" || widget.userModel?.bio == null ){
      _bioController.text = "";
    }
    else{
      _bioController.text = widget.userModel?.bio ?? "";
    }
    linkedInController.text = widget.userModel?.socialLink?.linkedin ?? "";
    facebookController.text = widget.userModel?.socialLink?.facebook ?? "";
    instaController.text = widget.userModel?.socialLink?.instagram ?? "";
    instaController.text = widget.userModel?.socialLink?.instagram ?? "";
    _tempmoreAboutValue[StringConstants.diet] = widget.userModel?.moreAbout?.diet;
    _tempmoreAboutValue[StringConstants.workout] = widget.userModel?.moreAbout?.workout;
    _tempmoreAboutValue[StringConstants.height] = widget.userModel?.moreAbout?.height;
    _tempmoreAboutValue[StringConstants.smoking] = widget.userModel?.moreAbout?.smoking;
    _tempmoreAboutValue[StringConstants.drinking] = widget.userModel?.moreAbout?.drinking;
    _tempmoreAboutValue[StringConstants.pets] = widget.userModel?.moreAbout?.pets;
    // print("_bioController Values ${_bioController.text} - ${userScreenCubit.userModelList.first.bio} - ${widget.userModel?.bio} ");
    // onBoardingCubit.initializeMoreAboutData();
    // print("MoreAboutData Values ${onBoardingCubit.moreAboutWrapper.toJson()}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<OnboardingCubit, OnBoardingState>(
        listener: (context, state) {
          print("state $state");
          if (state is OnBoardingMoreAboutSuccess) {
            // LoadingDialog.hideLoadingDialog(context);
            onBoardingCubit.initializeMoreAboutData(state.moreAbout);
            parsedDataOutPut= parseData(convertData(onBoardingCubit.moreAboutWrapper.data));
            if(onBoardingCubit.moreAboutWrapper.data?.first.height != null){
              newHeight= onBoardingCubit.moreAboutWrapper.data!.first.height!;
            }
          } else if (state is OnBoardingMoreAboutFailureState) {
            // LoadingDialog.hideLoadingDialog(context);
            LoggerUtil.logs("Error ${state.error}");
          }
          // TODO: implement listener
        },
      builder: (context, state) {
        return widget.comingFromEditProfile
            ? onBoarding()
            : UIScaffold(
                appBar: widget.comingFromEditProfile
                    ? null
                    : AppBarComponent(
                        "",
                        action: GestureDetector(
                          onTap: ()=> NavigationUtil.push(context, RouteConstants.interestScreen),
                          child: TextComponent(StringConstants.skip,
                              style: TextStyle(
                                fontSize: 14,
                                color: themeCubit.textColor,
                              )),
                        ),
                      ),
                removeSafeAreaPadding: false,
                bgColor: themeCubit.backgroundColor,
                widget: onBoarding(),
            floatingActionButton: ButtonComponent(
              isSmallBtn: true,
                bgcolor: _bioController.value.text.isNotEmpty
                    ? themeCubit.primaryColor
                    : ColorConstants.blackLightBtn,
                textColor: _bioController.value.text.isNotEmpty
                    ? ColorConstants.black
                    : ColorConstants.lightGray,
            buttonText: StringConstants.continues,
            btnWidth: AppConstants.responsiveWidth(context,percentage: 90),
            onPressed: () {
                if(_bioController.value.text.isNotEmpty) {
                  SocialLink socialLink = SocialLink(
                    linkedin: linkedInController.text,
                    instagram: instaController.text,
                    facebook: facebookController.text,
                  );
                  MoreAbout moreAbout = MoreAbout(
                    diet: _tempmoreAboutValue[StringConstants.diet],
                    workout: _tempmoreAboutValue[StringConstants.workout],
                    height: _tempmoreAboutValue[StringConstants.height],
                    // weight: _tempmoreAboutValue[StringConstants.weight],
                    smoking: _tempmoreAboutValue[StringConstants.smoking],
                    drinking: _tempmoreAboutValue[StringConstants.drinking],
                    pets: _tempmoreAboutValue[StringConstants.pets],
                  );
                  onBoardingCubit.setAboutYou(_bioController.text.toString(), socialLink, moreAbout);
                  NavigationUtil.push(context, RouteConstants.interestScreen);
                }

            })
        );
      }
    );
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
                  if (widget.comingFromEditProfile)
                    TextComponent(StringConstants.aboutMe,
                        style: TextStyle(
                          fontSize: 14,
                          color: themeCubit.textSecondaryColor,
                        ))
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(StringConstants.tellUsABitAboutYourSelf,
                            style: FontStylesConstants.style22(
                              color: themeCubit.textColor,
                            )),
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
                      ],
                    ),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  SizedBoxConstants.sizedBoxSixH(),
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
                    onChanged: (_){
                      if(widget.comingFromEditProfile){
                        userScreenCubit.updateBio(_bioController.text);
                      }
                    },
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
            if(onBoardingCubit.moreAboutWrapper.data != null)
            moreAboutYou(),
          ],
        ),
        // const SizedBox(
        //   height: 10,
        // ),
SizedBoxConstants.sizedBoxSixtyH(),
        //////////////
        // if (!widget.comingFromEditProfile)
        //   Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: ButtonComponent(
        //         bgcolor: themeCubit.primaryColor,
        //         textColor: themeCubit.backgroundColor,
        //         buttonText: StringConstants.continues,
        //         onPressed: () {
        //           SocialLink socialLink = SocialLink(
        //             linkedin: linkedInController.text,
        //             instagram: instaController.text,
        //             facebook: facebookController.text,
        //           );
        //           MoreAbout moreAbout = MoreAbout(
        //             diet: _tempmoreAboutValue[StringConstants.diet],
        //             workout: _tempmoreAboutValue[StringConstants.workout],
        //             height: _tempmoreAboutValue[StringConstants.height],
        //             // weight: _tempmoreAboutValue[StringConstants.weight],
        //             smoking: _tempmoreAboutValue[StringConstants.smoking],
        //             drinking: _tempmoreAboutValue[StringConstants.pets],
        //             pets: _tempmoreAboutValue[StringConstants.pets],
        //           );
        //           onBoardingCubit.setAboutYou(_bioController.text.toString(), socialLink, moreAbout);
        //           // onBoardingCubit.userDetailAboutYouToInterestStep(
        //           //   onBoardingCubit.userModel.id.toString(),
        //           //     _bioController.text.toString(), socialLink, moreAbout
        //           // );
        //           NavigationUtil.push(context, RouteConstants.interestScreen);
        //         }),
        //   )
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
              leadingText: StringConstants.linkedIn,
              trailingIcon: linkedInController.text.isNotEmpty
                  ? Icons.check_circle
                  : Icons.add_circle,
              trailingIconSize: 30,
              leadingIcon: AssetConstants.linkedin,
              // isLeadingImageProfileImage: true,
              isLeadingImageSVG: true,
              isSocialConnected: true,
              subIconColor: linkedInController.text.isNotEmpty
                  ? themeCubit.primaryColor
                  : themeCubit.textColor,
              trailingText: linkedInController.text.isNotEmpty
                  ? StringConstants.connected
                  : "",
              subTextColor: themeCubit.primaryColor,
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: StatefulBuilder(
                    builder: (context,state) {
                      return SocialSheetComponent(
                        heading: StringConstants.whatsYourLinkedin,
                        isSvg: true,
                        textfieldHint: StringConstants.linkedinHintText,
                        image: AssetConstants.linkedin,
                        textEditingController: linkedInController,
                        onUpdate: (newValue) {
                          setState(() {
                            linkedInController.text = newValue;
                            SocialLink socialLink = SocialLink(
                              linkedin: linkedInController.text,
                              instagram: instaController.text,
                              facebook: facebookController.text,
                            );
                            if(widget.comingFromEditProfile){
                              userScreenCubit.updateSocialLinks(socialLink);
                            }

                          });
                        },
                      );
                    }
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
              leadingText: StringConstants.instagram,
              subIconColor: instaController.text.isNotEmpty
                  ? themeCubit.primaryColor
                  : themeCubit.textColor,
              trailingIconSize: 30,
              trailingIcon: instaController.text.isNotEmpty
                  ? Icons.check_circle
                  : Icons.add_circle,
              trailingText: instaController.text.isNotEmpty
                  ? StringConstants.connected
                  : "",
              subTextColor: themeCubit.primaryColor,
              // isLeadingImageCircular: true,
              isLeadingImageSVG: true,
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: SocialSheetComponent(
                    heading: StringConstants.whatsYourInstagram,
                    isSvg: true,
                    textfieldHint: StringConstants.instagramHintText,
                    image: AssetConstants.instagram,
                    textEditingController: instaController,
                    onUpdate: (newValue) {
                      setState(() {
                        instaController.text = newValue;
                      });
                      SocialLink socialLink = SocialLink(
                        linkedin: linkedInController.text,
                        instagram: instaController.text,
                        facebook: facebookController.text,
                      );
                      if(widget.comingFromEditProfile){
                        userScreenCubit.updateSocialLinks(socialLink);
                      }
                    },
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
              leadingText: StringConstants.facebook,
              subIconColor: facebookController.text.isNotEmpty
                  ? themeCubit.primaryColor
                  : themeCubit.textColor,
              trailingIconSize: 30,
              trailingIcon: facebookController.text.isNotEmpty
                  ? Icons.check_circle
                  : Icons.add_circle,
              trailingText: facebookController.text.isNotEmpty
                  ? StringConstants.connected
                  : "",
              subTextColor: themeCubit.primaryColor,
              // isLeadingImageCircular: true,
              isLeadingImageSVG: true,
              onTap: () {
                BottomSheetComponent.showBottomSheet(
                  context,
                  isShowHeader: false,
                  body: SocialSheetComponent(
                    heading: StringConstants.whatsYourFacebook,
                    isSvg: true,
                    textfieldHint: StringConstants.facebookHintText,
                    image: AssetConstants.facebook,
                    textEditingController: facebookController,
                    onUpdate: (newValue) {
                      setState(() {
                        facebookController.text = newValue;
                      });
                      SocialLink socialLink = SocialLink(
                        linkedin: linkedInController.text,
                        instagram: instaController.text,
                        facebook: facebookController.text,
                      );
                      if(widget.comingFromEditProfile){
                        userScreenCubit.updateSocialLinks(socialLink);
                      }
                    },
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
          if(onBoardingCubit.moreAboutWrapper.data?.first.diet != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Diet",//StringConstants.diet,
              trailingIcon: Icons.arrow_forward_ios,
              subIconColor: ColorConstants.iconBg,
              leadingIcon: AssetConstants.diet,
              overrideLeadingIconSize: 15,
              isLeadingImageSVG: true,
              trailingText: _tempmoreAboutValue[StringConstants.diet],
              onTap: () {

                moreAboutYouSelection(
                    AssetConstants.diet,
                    "${StringConstants.whatIsYour + StringConstants.diet} ?",
                    StringConstants.diet,
                    parsedDataOutPut[StringConstants.diet]
                   // _moreAboutYou[StringConstants.diet]

                );
              }),
          if(onBoardingCubit.moreAboutWrapper.data?.first.workout != null)
          const SizedBox(
            height: 10,
          ),
          if(onBoardingCubit.moreAboutWrapper.data?.first.workout != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Workout",//StringConstants.workout,
              trailingIcon: Icons.arrow_forward_ios,
              leadingIcon: AssetConstants.workout,
              isLeadingImageSVG: true,
              overrideLeadingIconSize: 15,
              subIconColor: ColorConstants.iconBg,
              trailingText: _tempmoreAboutValue[StringConstants.workout],
              onTap: () {
                // var parsedDataOutPut= parseData(data);
                moreAboutYouSelection(
                    AssetConstants.workout,
                    "${StringConstants.doYou + StringConstants.workout} ?",
                    StringConstants.workout,
                    // _moreAboutYou[StringConstants.workout]
                    parsedDataOutPut[StringConstants.workout],
                );
              }),
          if(onBoardingCubit.moreAboutWrapper.data?.first.height != null)
          const SizedBox(
            height: 10,
          ),
          if(onBoardingCubit.moreAboutWrapper.data?.first.height != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Height",//StringConstants.height,
              leadingIcon: AssetConstants.height,
              trailingIcon: Icons.arrow_forward_ios,
              isLeadingImageSVG: true,
              overrideLeadingIconSize: 15,
              subIconColor: ColorConstants.iconBg,
              trailingText: _tempmoreAboutValue[StringConstants.height],
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.height,
                    "${StringConstants.whatIsYour + StringConstants.height} ?",
                    StringConstants.height,
                    parsedDataOutPut[StringConstants.height],
                    // _moreAboutYou[StringConstants.height],
                    isHeight: true);
              }),
          if(onBoardingCubit.moreAboutWrapper.data?.first.smoking != null)
          const SizedBox(
            height: 10,
          ),
          if(onBoardingCubit.moreAboutWrapper.data?.first.smoking != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Smoking",//StringConstants.smoking,
              trailingIcon: Icons.arrow_forward_ios,
              leadingIcon: AssetConstants.smoking,
              subIconColor: ColorConstants.iconBg,
              trailingText: _tempmoreAboutValue[StringConstants.smoking],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.smoking,
                    "${StringConstants.doYou + StringConstants.smoke} ?",
                    StringConstants.smoking,
                    parsedDataOutPut[StringConstants.smoking]);
              }),
          if(onBoardingCubit.moreAboutWrapper.data?.first.drinking != null)
          const SizedBox(
            height: 10,
          ),
          if(onBoardingCubit.moreAboutWrapper.data?.first.drinking != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Drinking",//StringConstants.drinking,
              leadingIcon: AssetConstants.drinking,
              trailingIcon: Icons.arrow_forward_ios,
              subIconColor: ColorConstants.iconBg,
              trailingText: _tempmoreAboutValue[StringConstants.drinking],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.drinking,
                    "${StringConstants.doYou + StringConstants.drink} ?",
                    StringConstants.drinking,
                    parsedDataOutPut[StringConstants.drinking]);
              }),
          if(onBoardingCubit.moreAboutWrapper.data?.first.pets != null)
          const SizedBox(
            height: 10,
          ),
          if(onBoardingCubit.moreAboutWrapper.data?.first.pets != null)
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              leadingText: "Pets",//StringConstants.pets,
              trailingIcon: Icons.arrow_forward_ios,
              leadingIcon: AssetConstants.pets,
              subIconColor: ColorConstants.iconBg,
              trailingText: _tempmoreAboutValue[StringConstants.pets],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.pets,
                    "${StringConstants.doYouHave + StringConstants.pets} ?",
                    StringConstants.pets,
                    parsedDataOutPut[StringConstants.pets]);
              }),
        ],
      ),
    );
  }

  Future<void> moreAboutYouSelection(
      String image, String title, String key, Map<String, dynamic>? data,
      {bool isHeight = false}) {
    String? selectedValue = "";
    bool selection = false;
    selectedValue = _tempmoreAboutValue[key];
    String? heightValue;

    // _tempmoreaboutvalue[key] = "vegan"

    void addSelection(String key) {
      selectedValue = "";
      selectedValue = key;
      selection = true;
    }

    void removeSelection() {
      selectedValue = "";
      selection = false;
    }

    return BottomSheetComponent.showBottomSheet(context,
        isShowHeader: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StatefulBuilder(
            builder: (context, setState1) {
              if (isHeight) {
                selection =
                    true; // make selection true when the sheet opens to enable the button
              }

              return Column(
                children: [
                  SizedBoxConstants.sizedBoxTwentyH(),
                  ImageComponent(
                    imgUrl: image,
                    height: 35,
                    width: 35,
                    imgProviderCallback: (imgProvider) {},
                  ),
                  SizedBoxConstants.sizedBoxTwelveH(),
                  TextComponent(
                    title,
                    style: FontStylesConstants.style22(
                      color: themeCubit.textColor,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxTwelveH(),
                  if (isHeight)
                    SizedBox(
                        height: 200,
                        // padding: const EdgeInsets.only(top: 32),
                        child: CupertinoPicker(
                          itemExtent: 50,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          scrollController: FixedExtentScrollController(
                            initialItem: newHeight.indexOf(selectedValue ?? "0")//height.indexOf(selectedValue ?? "0"),
                          ),
                          onSelectedItemChanged: (value) {
                            addSelection(newHeight[value]);  // addSelection(height[value]);

                            setState1(() {});
                            // setState(() {});
                          },
                          // children: height.map((e) {
                          children: newHeight.map((e) {
                            return Container(
                              alignment: Alignment.center,
                              child: TextComponent(
                                e,
                                style: FontStylesConstants.style22(
                                    color: Colors.white),
                              ),
                            );
                          }).toList(),

                          // List.generate(100, (index) {
                          //   final feet = 3 + index ~/ 12;
                          //   final inches = (3 + index % 12) % 12;
                          //   final heightInCm =
                          //       ((feet * 30.48) + (inches * 2.54)).toInt();

                          //   return GestureDetector(
                          //     onTap: () {
                          //       setState1(() {
                          //         heightValue = "$feet'$inches"
                          //             '" ( ${(heightInCm)} cm)';
                          //         if (heightValue != null) {
                          //           addSelection(heightValue!);
                          //         }
                          //       });
                          //     },
                          //     child: Container(
                          // alignment: Alignment.center,
                          //       child: TextComponent(
                          //         // "$feet'$inches"
                          //         // '" ( ${(heightInCm)} cm)',
                          //         "$feet'$inches"
                          //         '" ( ${(heightInCm)} cm)',
                          // style: FontStylesConstants.style22(
                          //     color: Colors.white),
                          //       ),
                          //     ),
                          //   );
                          // })),
                        ))
                  else
                    if(data != null)
                    Column(
                        children: data.entries.map((e) {
                      if (e.key == selectedValue) {
                        setState1(() {
                          selection = true;
                        });
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTileComponent(
                          title: e.key,
                          titleSize: 14,
                          onTap: () {
                            setState1(() {
                              if (selectedValue == e.key) {
                                removeSelection();
                              } else {
                                addSelection(e.key);
                              }
                            });
                          },
                          backgroundColor: selectedValue == e.key
                              ? themeCubit.primaryColor
                              : themeCubit.darkBackgroundColor100,
                          titleColor: selectedValue == e.key
                              ? themeCubit.backgroundColor
                              : null,
                          trailingIcon: null,
                        ),
                      );
                    }).toList()),
                  SizedBoxConstants.sizedBoxTwelveH(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonComponent(
                      buttonText: isHeight
                          ? StringConstants.done
                          : StringConstants.save,
                      textColor: selection?themeCubit.backgroundColor:themeCubit.textColor,
                      bgcolor: themeCubit.primaryColor,
                      onPressed: selection == false
                          ? null
                          : () {
                              // _tempmoreAboutValue.clear();

                              // if (selectedValue != null && selectedValue != "")
                              if (selection) {
                                if (!isHeight) {
                                  _moreAboutYou[key][selectedValue] = selection;
                                }
                                _tempmoreAboutValue.addAll(
                                    {key: selectedValue}); //"Diet":"vegan"
                                setState(() {});
                                NavigationUtil.pop(context);
                              }

                              if(widget.comingFromEditProfile){
                                userScreenCubit.moreAbout =MoreAbout(
                                  diet: _tempmoreAboutValue[StringConstants.diet],
                                  workout: _tempmoreAboutValue[StringConstants.workout],
                                  height: _tempmoreAboutValue[StringConstants.height],
                                  // weight: _tempmoreAboutValue[StringConstants.weight],
                                  smoking: _tempmoreAboutValue[StringConstants.smoking],
                                  drinking: _tempmoreAboutValue[StringConstants.drinking],
                                  pets: _tempmoreAboutValue[StringConstants.pets],
                                );
                                // userScreenCubit.updateMoreAboutYou(moreAbout);

                              }

                              // _tempmoreAboutValue
                              //     .addAll({selectedMoreAboutValue: selection});
                              // print(_tempmoreAboutValue);
                            },
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }


  Map<String, Map<String, dynamic>> parseData(Map<String, List<String>> inputData) {
    Map<String, Map<String, dynamic>> parsedData = {};

    // Iterate over each key in the input data
    inputData.forEach((key, values) {
      // Create a map for the current key with values set to false
      Map<String, dynamic> keyValueMap = {};
      values.forEach((value) {
        keyValueMap[value] = false;
      });

      // Add the map to the parsed data
      parsedData[key] = keyValueMap;
    });

    return parsedData;
  }

  Map<String, List<String>> convertData(List<MoreAboutList>? data) {
    Map<String, List<String>> convertedData = {};

    data?.forEach((item) {
      if (item.diet != null) {
        convertedData['diet'] = item.diet!;
      }
      if (item.workout != null) {
        convertedData['workout'] = item.workout!;
      }
      if (item.smoking != null) {
        convertedData['smoking'] = item.smoking!;
      }
      if (item.drinking != null) {
        convertedData['drinking'] = item.drinking!;
      }
      if (item.pets != null) {
        convertedData['pets'] = item.pets!;
      }
      // Add more keys as needed
    });

    return convertedData;
  }
}
