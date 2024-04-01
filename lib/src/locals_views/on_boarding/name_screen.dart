import 'package:chat_app_white_label/src/constants/route_constants.dart';
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

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // InkWell(
            //   onTap:()=> NavigationUtil.pop(context),
            //   child: IconComponent(
            //     iconData: Icons.arrow_back_ios_new_outlined,
            //     borderColor: ColorConstants.transparent,
            //     backgroundColor: ColorConstants.iconBg,
            //     iconColor: ColorConstants.white,
            //     circleSize: 30,
            //     iconSize: 20,
            //   ),
            // ),
            // SizedBoxConstants.sizedBoxThirtyH(),
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
                print(value);
              },

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
                print(value);
              },
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: ColorConstants.lightGray.withOpacity(0.2),
              textColor: ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                NavigationUtil.push(
                    context, RouteConstants.uploadProfileScreen);
              }),
        )
      ],
    );
  }
}
