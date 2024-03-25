import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 late final themeCubit = BlocProvider.of<ThemeCubit>(context);
 final TextEditingController _firstNameController = TextEditingController();
 final TextEditingController _secondNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }


  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: enterName(),
    );
  }

  enterName(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconComponent(
              iconData: Icons.arrow_back_ios,
              borderColor: ColorConstants.transparent,
              backgroundColor: ColorConstants.iconBg,
              iconColor: ColorConstants.white,
              circleSize: 30,
              iconSize: 20,
            ),
            SizedBox(
              height: 30,
            ),
            TextComponent(
              "What's your",
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            TextComponent(
              "name?",
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            TextField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: ColorConstants.white,
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: 30),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "First Name",
                hintStyle: TextStyle(
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 30),
              ),
              onChanged: (value) {
                print(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                // Limit to 12 characters
                FilteringTextInputFormatter.digitsOnly,
                // Accept only digits
              ],
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
                hintText: "Last Name",
                hintStyle: TextStyle(
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 30),
              ),
              onChanged: (value) {
                print(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                // Limit to 12 characters
                FilteringTextInputFormatter.digitsOnly,
                // Accept only digits
              ],
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: ColorConstants.lightGray.withOpacity(0.2),
              textColor: ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {}),
        )
      ],
    );
  }
}
