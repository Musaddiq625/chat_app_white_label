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
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutYouScreen extends StatefulWidget {
  final bool comingFromEditProfile;
  const AboutYouScreen({super.key, this.comingFromEditProfile = false});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  FixedExtentScrollController? scrollController =
      new FixedExtentScrollController();

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

  @override
  Widget build(BuildContext context) {
    return widget.comingFromEditProfile
        ? onBoarding()
        : UIScaffold(
            appBar: widget.comingFromEditProfile
                ? null
                : AppBarComponent(
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
        // const SizedBox(
        //   height: 10,
        // ),
        if (!widget.comingFromEditProfile)
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
              subText: _tempmoreAboutValue[StringConstants.diet],
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.diet,
                    "${StringConstants.whatIsYour + StringConstants.diet} ?",
                    StringConstants.diet,
                    _moreAboutYou[StringConstants.diet]);
              }),
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
              subText: _tempmoreAboutValue[StringConstants.workout],
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.workout,
                    "${StringConstants.doYou + StringConstants.workout} ?",
                    StringConstants.workout,
                    _moreAboutYou[StringConstants.workout]);
              }),
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
              subText: _tempmoreAboutValue[StringConstants.height],
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.height,
                    "${StringConstants.whatIsYour + StringConstants.height} ?",
                    StringConstants.height,
                    _moreAboutYou[StringConstants.height],
                    isHeight: true);
              }),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.smoking,
              leadingIcon: AssetConstants.smoking,
              subIconColor: ColorConstants.iconBg,
              subText: _tempmoreAboutValue[StringConstants.smoking],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.smoking,
                    "${StringConstants.doYou + StringConstants.smoke} ?",
                    StringConstants.smoking,
                    _moreAboutYou[StringConstants.smoking]);
              }),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.drinking,
              leadingIcon: AssetConstants.drinking,
              subIconColor: ColorConstants.iconBg,
              subText: _tempmoreAboutValue[StringConstants.drinking],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.drinking,
                    "${StringConstants.doYou + StringConstants.drink} ?",
                    StringConstants.drinking,
                    _moreAboutYou[StringConstants.drinking]);
              }),
          const SizedBox(
            height: 10,
          ),
          ListTileComponent(
              // icon: Icons.location_on,
              // iconColor: ColorConstants.white,
              iconText: StringConstants.pets,
              leadingIcon: AssetConstants.pets,
              subIconColor: ColorConstants.iconBg,
              subText: _tempmoreAboutValue[StringConstants.pets],
              subTextColor: themeCubit.textColor,
              onTap: () {
                moreAboutYouSelection(
                    AssetConstants.pets,
                    "${StringConstants.doYouHave + StringConstants.pets} ?",
                    StringConstants.pets,
                    _moreAboutYou[StringConstants.pets]);
              }),
        ],
      ),
    );
  }

  Future<void> moreAboutYouSelection(
      String image, String title, String key, Map<String, dynamic> data,
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
                            initialItem: height.indexOf(selectedValue ?? "0"),
                          ),
                          onSelectedItemChanged: (value) {
                            addSelection(height[value]);

                            setState1(() {});
                            // setState(() {});
                          },
                          children: height.map((e) {
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
                          subIcon: null,
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
                      textColor: themeCubit.backgroundColor,
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
}
