import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/tag_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  List<String> selectedTags = [];
  List<Map<String, dynamic>> tagList = [
    {
      'iconData': Icons.favorite,
      'name': "Women",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "Active",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Dog(s)",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Regularly",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Socially",
    },
    {
      'iconData': Icons.height,
      'name': "5'7(170cm)",
    },
    // Add more tag data items as required
  ];

  List<String> selectedInterestTagList = [];
  List<Map<String, dynamic>> interestTagList = [
    {
      'iconData': Icons.favorite,
      'name': "Cinema",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "City Event",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Foods & restaurants",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Networking",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Workout",
    },
    {
      'iconData': Icons.height,
      'name': "Dancing",
    },
    // Add more tag data items as required
  ];

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
      widget: onBoarding(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: ButtonComponent(
            bgcolor: themeCubit.primaryColor,
            textColor: themeCubit.backgroundColor,
            buttonText: StringConstants.continues,
            onPressedFunction: () {
              NavigationUtil.push(context, RouteConstants.doneScreen);
            }),
      ),
    );
  }

  Widget onBoarding() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            TextComponent(
              StringConstants.whatsYourInterest,
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            TextComponent(
              StringConstants.pickUp4Things,
              style: TextStyle(
                fontSize: 12,
                color: ColorConstants.lightGray,
              ),
              maxLines: 4,
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            hobbies(),
            SizedBoxConstants.sizedBoxTwentyH(),
            creativity(),
            SizedBoxConstants.sizedBoxTwentyH(),
            hobbies(),
            SizedBoxConstants.sizedBoxTwentyH(),
            creativity(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ],
    );
  }

  hobbies() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          StringConstants.hobbiesAndInterests,
          style: TextStyle(
            fontSize: 14,
            color: themeCubit.textColor,
          ),
        ),
        SizedBoxConstants.sizedBoxTenH(),
        Wrap(
          children: [
            ...tagList
                .map((tag) => Row(mainAxisSize: MainAxisSize.min, children: [
                      TagComponent(
                        iconData: tag['iconData'],
                        customTextColor: selectedTags.contains(tag['name'])
                            ? ColorConstants.black
                            : themeCubit.textColor,
                        backgroundColor: selectedTags.contains(tag['name'])
                            ? themeCubit.primaryColor
                            : ColorConstants.lightGray.withOpacity(0.3),
                        iconColor: selectedTags.contains(tag['name'])
                            ? themeCubit.backgroundColor
                            : themeCubit.primaryColor,
                        customIconText: tag['name'],
                        circleHeight: 35,
                        iconSize: 20,
                        onTap: () {
                          setState(() {
                            if (selectedTags.contains(tag['name'])) {
                              selectedTags.remove(tag['name']);
                            } else if (selectedTags.length < 4) {
                              selectedTags.add(tag['name']);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ]))
                .toList(),
          ],
        )
      ],
    );
  }

  creativity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          StringConstants.creativity,
          style: TextStyle(
            fontSize: 14,
            color: themeCubit.textColor,
          ),
        ),
        SizedBoxConstants.sizedBoxTenH(),
        Wrap(
          children: [
            ...interestTagList
                .map((tag) => Row(mainAxisSize: MainAxisSize.min, children: [
                      TagComponent(
                        iconData: tag['iconData'],
                        customTextColor: selectedInterestTagList.contains(tag['name'])
                            ? ColorConstants.black
                            : themeCubit.textColor,
                        backgroundColor: selectedInterestTagList.contains(tag['name'])
                            ? themeCubit.primaryColor
                            : ColorConstants.lightGray.withOpacity(0.3),
                        iconColor: selectedInterestTagList.contains(tag['name'])
                            ? themeCubit.backgroundColor
                            : themeCubit.primaryColor,
                        customIconText: tag['name'],
                        circleHeight: 35,
                        iconSize: 20,
                        onTap: () {
                          setState(() {
                            if (selectedInterestTagList.contains(tag['name'])) {
                              selectedInterestTagList.remove(tag['name']);
                            } else if (selectedInterestTagList.length < 4) {
                              selectedInterestTagList.add(tag['name']);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ]))
                .toList(),
          ],
        )
      ],
    );
  }
}
