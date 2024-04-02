import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class WhatDoYouDoScreen extends StatefulWidget {
  const WhatDoYouDoScreen({super.key});

  @override
  State<WhatDoYouDoScreen> createState() => _WhatDoYouDoScreenState();
}

class _WhatDoYouDoScreenState extends State<WhatDoYouDoScreen> {
  bool _isDiscriptionValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

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
              StringConstants.whatDoYouDo,
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
                hintText: StringConstants.whatDoYouDoHintText,
                hintStyle: TextStyle(
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 30),
              ),
              maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    _isDiscriptionValid=value.length >=4 && value.trim().isNotEmpty;
                  });
                }
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: _isDiscriptionValid
                  ? themeCubit.primaryColor
                  : ColorConstants.lightGray.withOpacity(0.2),
              textColor:_isDiscriptionValid
                  ? ColorConstants.black
                  : ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                NavigationUtil.push(context, RouteConstants.genderScreen);
              }),
        )
      ],
    );
  }
}
