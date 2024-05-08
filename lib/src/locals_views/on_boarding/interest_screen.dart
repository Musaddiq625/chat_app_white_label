import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/tag_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/navigation_util.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

  // List<Map<String, dynamic>> selectedInterestedTags = [];
  List<InterestData> selectedInterestedTags = [];
  List<Map<String, dynamic>> interestedTagList = [
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

  // List<String> selectedInterestTagList = [];
  // List<Map<String, dynamic>> selectedCreativityTagList = [];
  List<InterestData> selectedCreativityTagList = [];

  List<Map<String, dynamic>> creativityTagList = [
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

  // List<InterestData>? convertedCreativityList;
  List<InterestData> creativityNewTagList = [
    InterestData(icon: AssetConstants.smoking, value: "Cinema"),
    InterestData(icon: AssetConstants.sad.toString(), value: "City Event"),
    InterestData(icon: AssetConstants.drinking, value: "Foods & restaurants"),
    InterestData(icon: AssetConstants.delete, value: "Networking"),
    InterestData(icon: AssetConstants.smoking, value: "Workout"),
    InterestData(icon: AssetConstants.smoking, value: "Dancing"),

    // Add more tag data items as required
  ];
  List<InterestData> interestedNewTagList = [
    InterestData(icon: AssetConstants.smoking, value: "Cinema"),
    InterestData(icon: AssetConstants.sad.toString(), value: "City Event"),
    InterestData(icon: AssetConstants.drinking, value: "Foods & restaurants"),
    InterestData(icon: AssetConstants.delete, value: "Networking"),
    InterestData(icon: AssetConstants.smoking, value: "Workout"),
    InterestData(icon: AssetConstants.smoking, value: "Dancing"),

    // Add more tag data items as required
  ];

  List<Hobbies>? hobbiesData = [];
  List<Creativity>? creativityData = [];

  @override
  void initState() {
    // TODO: implement initState
    onBoardingCubit.getInterestData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  convertedCreativityList = selectedCreativityTagList.map((item) {
    //   return InterestData(
    //     icon: item['iconData'].toString(), // Assuming iconData is an IconData
    //     value: item['name'], // Assuming name is a String
    //   );
    // }).toList();
    return BlocConsumer<OnboardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is OnBoardingUserAboutYouToInterestLoadingState) {
          // LoadingDialog.showLoadingDialog(context);
        } else if (state is OnBoardingAboutYouToInterestSuccessState) {
          // LoadingDialog.hideLoadingDialog(context);
          onBoardingCubit.initializeUserData(state.userModel!);
          // NavigationUtil.push(context, RouteConstants.doneScreen);
        } else if (state is OnBoardingAboutYouToInterestFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          LoggerUtil.logs("Error ${state.error}");
        } else if (state is OnBoardingInterestSuccess) {
          onBoardingCubit.initializeInterestData(state.interestData);
          hobbiesData = onBoardingCubit.interestWrapper.data?.first.hobbies;
          creativityData =
              onBoardingCubit.interestWrapper.data?.first.creativity;
        } else if (state is OnBoardingInterestFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          LoggerUtil.logs("Error ${state.error}");
        }
      },
      builder: (context, state) {
        return UIScaffold(
          appBar: AppBarComponent(
            "",
            action: GestureDetector(
              onTap: () =>{
              onBoardingCubit.userDetailAboutYouToInterestStep(
              onBoardingCubit.userModel.id.toString(),
              onBoardingCubit.userModel.bio.toString(),
              onBoardingCubit.userModel.socialLink,
              onBoardingCubit.userModel.moreAbout,
              null),
                NavigationUtil.push(context, RouteConstants.doneScreen),
              },

              child: TextComponent(StringConstants.skip,
                  style:
                      FontStylesConstants.style14(color: themeCubit.textColor)),
            ),
          ),
          removeSafeAreaPadding: false,
          bgColor: themeCubit.backgroundColor,
          widget: onBoarding(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: ButtonComponent(
                bgcolor: selectedInterestedTags.isNotEmpty ||
                    selectedCreativityTagList.isNotEmpty
                    ? themeCubit.primaryColor
                    : ColorConstants.blackLightBtn,
                textColor: selectedInterestedTags.isNotEmpty ||
                    selectedCreativityTagList.isNotEmpty
                    ? ColorConstants.black
                    : ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressed: () {
                  if (selectedInterestedTags.isNotEmpty ||
                      selectedCreativityTagList.isNotEmpty) {
                    Interest interest = Interest(
                        hobbies: selectedInterestedTags,
                        creativity: selectedCreativityTagList);
                    onBoardingCubit.setInterest(interest);
                    onBoardingCubit.userDetailAboutYouToInterestStep(
                        onBoardingCubit.userModel.id.toString(),
                        onBoardingCubit.userModel.bio.toString(),
                        onBoardingCubit.userModel.socialLink,
                        onBoardingCubit.userModel.moreAbout,
                        onBoardingCubit.userModel.interest);

                    NavigationUtil.push(context, RouteConstants.doneScreen);
                  }


                }),
          ),
        );
      },
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
          children: [
            GestureDetector(
              onTap: () {
                // LoggerUtil.logs("selectedInterestTagList ${convertedCreativityList}");
              },
              child: TextComponent(
                StringConstants.whatsYourInterest,
                style: FontStylesConstants.style22(),
              ),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            TextComponent(
              StringConstants.pickUp4Things,
              style:
                  FontStylesConstants.style14(color: ColorConstants.lightGray),
              maxLines: 5,
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            hobbies(),
            SizedBoxConstants.sizedBoxTwentyH(),
            creativity(),
            // SizedBoxConstants.sizedBoxTwentyH(),
            // hobbies(),
            // SizedBoxConstants.sizedBoxTwentyH(),
            // creativity(),
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
          style: FontStylesConstants.style14(color: themeCubit.textColor),
        ),
        SizedBoxConstants.sizedBoxTenH(),
        Wrap(
          children: [
            ...?hobbiesData
                ?.map((tag) => Row(mainAxisSize: MainAxisSize.min, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TagComponent(
                          iconData: tag.icon,
                          customTextColor: selectedInterestedTags
                                  .any((item) => item.value == tag.value)
                              ? ColorConstants.black
                              : themeCubit.textColor,
                          backgroundColor: selectedInterestedTags
                                  .any((item) => item.value == tag.value)
                              ? themeCubit.primaryColor
                              : ColorConstants.lightGray.withOpacity(0.3),
                          iconColor: selectedInterestedTags.any((item) =>
                                  item.value ==
                                  tag.value) //selectedInterestedTags.contains(tag['name'])
                              ? themeCubit.backgroundColor
                              : themeCubit.primaryColor,
                          customIconText: tag.value,
                          circleHeight: 35,
                          iconSize: 20,
                          onTap: () {
                            setState(() {
                              bool isTagSelected = selectedInterestedTags
                                  .any((item) => item.value == tag.value);

                              if (isTagSelected) {
                                selectedInterestedTags.removeWhere(
                                    (item) => item.value == tag.value);
                              } else if (selectedInterestedTags.length < 4) {
                                var tagSelectedValue = InterestData(
                                  icon: tag.icon,
                                  value: tag.value,
                                );
                                selectedInterestedTags.add(tagSelectedValue);
                              }
                            });
                            // setState(() {
                            //   if (selectedInterestedTags.contains(tag['name'])) {
                            //     selectedInterestedTags.remove(tag['name']);
                            //   } else if (selectedInterestedTags.length < 4) {
                            //     selectedInterestedTags.add(tag['name']);
                            //   }
                            // });
                          },
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTenW()
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
        TextComponent(StringConstants.creativity,
            style: FontStylesConstants.style14(color: themeCubit.textColor)),
        SizedBoxConstants.sizedBoxTenH(),
        Wrap(
          children: [
            ...?creativityData
                ?.map((tag) => Row(mainAxisSize: MainAxisSize.min, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TagComponent(
                          iconData: tag.icon,
                          customTextColor: selectedCreativityTagList
                                  .any((item) => item.value == tag.value)
                              ? ColorConstants.black
                              : themeCubit.textColor,
                          backgroundColor: selectedCreativityTagList
                                  .any((item) => item.value == tag.value)
                              ? themeCubit.primaryColor
                              : ColorConstants.lightGray.withOpacity(0.3),
                          iconColor: selectedCreativityTagList
                                  .any((item) => item.value == tag.value)
                              ? themeCubit.backgroundColor
                              : themeCubit.primaryColor,
                          customIconText: tag.value,
                          circleHeight: 35,
                          iconSize: 20,
                          onTap: () {
                            // LoggerUtil.logs(tagSelectedValue);
                            // LoggerUtil.logs('bsbbs ${selectedCreativityTagList.map((e) => e.value)}');
                            setState(() {
                              // bool isTagSelected = selectedCreativityTagList
                              //     .any((item) => item['name'] == tag['name']);
                              bool isTagSelected = selectedCreativityTagList
                                  .any((item) => item.value == tag.value);
                              if (isTagSelected) {
                                selectedCreativityTagList.removeWhere(
                                    (item) => item.value == tag.value);
                              } else if (selectedCreativityTagList.length < 4) {
                                var tagSelectedValue = InterestData(
                                  icon: tag.icon,
                                  value: tag.value,
                                );
                                selectedCreativityTagList.add(tagSelectedValue);
                              }
                            });
                            LoggerUtil.logs(
                                " bsbbs ${selectedCreativityTagList.map((e) => e.value)}");
                          },
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTenW()
                    ]))
                .toList(),
          ],
        )
      ],
    );
  }
}
