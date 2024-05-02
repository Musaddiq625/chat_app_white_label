import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/check_box_listtile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  String? _selectedOption;

  // late final OnBoardingUserStepTwoState onBoardingUserStepTwoState;
  final Map<String, dynamic> _ListofIdentities = {
    "Male": true,
    "Female": true,
    "Non Binary": true,
    "Rather Not Say": true,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       localContacts = await ContactsService.getContacts(withThumbnails: false);
      LoggerUtil.logs(
          "In Binding onBoardingUserStepTwoState ${onBoardingCubit.userModel.toJson()} ");
    });


    LoggerUtil.logs(
        "onBoardingUserStepTwoState ${onBoardingCubit.userModel.id} ${onBoardingCubit.userModel.aboutMe} ${onBoardingCubit.userModel.dateOfBirth}");

    LoggerUtil.logs(
        "onBoardingUserStepTwoState ${onBoardingCubit.userModel.toJson()} ");
    // LoggerUtil.logs(
    //     "onBoardingUserStepTwoState dob:${onBoardingUserStepTwoState.dob} aboutMe:${onBoardingUserStepTwoState.aboutMe} gender:${onBoardingUserStepTwoState.gender}");
    _selectedOption = _ListofIdentities.entries.first.key;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is OnBoardingUserDataSecondStepSuccessState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.push(context, RouteConstants.aboutYouScreen);
        } else {
          LoadingDialog.hideLoadingDialog(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: AppBarComponent(""),
            removeSafeAreaPadding: false,
            bgColor: themeCubit.backgroundColor,
            widget: onBoarding());
      },
    );
  }

  Widget onBoarding() {
    return enterName();
  }

  enterName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextComponent(
                  StringConstants.howDoYouIdentify,
                  style: TextStyle(
                      fontSize: 22,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _ListofIdentities.length,
                itemBuilder: (context, index) {
                  final identity = _ListofIdentities.keys.elementAt(index);
                  // print('IDENTITY: ${identity}');
                  bool isSelected = (identity == _selectedOption);
                  return CheckboxListTileComponent(
                      leadingText: identity,
                      enablePadding: false,
                      isChecked: isSelected,
                      onPressed: () {
                        setState(() {
                          _selectedOption = (identity);
                          LoggerUtil.logs("_selectedOption ${_selectedOption}");
                        });
                      });
                },
              ),
            ],
          ),
          ButtonComponent(
              bgcolor: _selectedOption != null
                  ? themeCubit.primaryColor
                  : ColorConstants.lightGray.withOpacity(0.2),
              textColor: _selectedOption != null
                  ? ColorConstants.black
                  : ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressed: () {
                onBoardingCubit.setGenderValues(_selectedOption);
                onBoardingCubit.userDetailSecondStep(
                    onBoardingCubit.userModel.id.toString(),
                    onBoardingCubit.userModel.dateOfBirth.toString(),
                    onBoardingCubit.userModel.aboutMe.toString(),
                    onBoardingCubit.userModel.gender.toString());
                // NavigationUtil.push(context, RouteConstants.aboutYouScreen);
              })
        ],
      ),
    );
  }
}
