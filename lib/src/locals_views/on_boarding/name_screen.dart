import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../models/OnBoardingNewModel.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  bool _isFirstName = false;
  bool _isSecondName = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  OnBoardingNewModel? onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }

  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: enterName(),
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

            TextComponent(
              StringConstants.whatsYourName,
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            SizedBoxConstants.sizedBoxThirtyH(),
            TextField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: ColorConstants.white,
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: 30),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: StringConstants.firstName,
                hintStyle: TextStyle(
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 30),
              ),
                onChanged: (value) {
                  setState(() {
                    _isFirstName=value.length >=2 && value.trim().isNotEmpty;
                  });
                }
            ),
            TextField(
              controller: _secondNameController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: ColorConstants.white,
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: 30),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: StringConstants.lastName,
                hintStyle: TextStyle(
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 30),
              ),
                onChanged: (value) {
                  setState(() {
                    _isSecondName=value.length >=2 && value.trim().isNotEmpty;
                  });
                }
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: _isFirstName && _isSecondName
                  ? themeCubit.primaryColor
                  : ColorConstants.lightGray.withOpacity(0.2),
              textColor:_isFirstName && _isSecondName
                  ? ColorConstants.black
                  : ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                onBoardingModel?.firstName=_firstNameController.text;
                onBoardingModel?.lastName=_secondNameController.text;
                NavigationUtil.push(
                    context, RouteConstants.uploadProfileScreen);
              }),
        )
      ],
    );
  }
}
