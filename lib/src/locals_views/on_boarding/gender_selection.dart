import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  String? _selectedOption;
  String _selectedMale = 'Male';
  String _selectedFemale = 'Female';
  String _seletedNonBinary = 'Non Binary';
  String _selectedRatherNotSay = 'Rather Not Say';

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
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
      /*      InkWell(
              onTap:()=> NavigationUtil.pop(context),
              child: IconComponent(
                iconData: Icons.arrow_back_ios_new_outlined,
                borderColor: ColorConstants.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: ColorConstants.white,
                circleSize: 30,
                iconSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),*/
            TextComponent(
              StringConstants.howDoYouIdentify,
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  StringConstants.male,
                  style: TextStyle(
                      fontSize: 30,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _selectedOption == 'Male',
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOption = value ? 'Male' : null;
                        });
                      }
                    },
                    shape: CircleBorder(),
                    activeColor: ColorConstants.primaryColor,
                    checkColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  StringConstants.female,
                  style: TextStyle(
                      fontSize: 30,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _selectedOption == 'Female',
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOption = value ? 'Female' : null;
                        });
                      }
                    },
                    shape: CircleBorder(),
                    activeColor: ColorConstants.primaryColor,
                    checkColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  StringConstants.nonBinary,
                  style: TextStyle(
                      fontSize: 30,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _selectedOption == 'Non Binary',
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOption = value ? 'Non Binary' : null;
                        });
                      }
                    },
                    shape: CircleBorder(),
                    activeColor: ColorConstants.primaryColor,
                    checkColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  StringConstants.ratherNotSay,
                  style: TextStyle(
                      fontSize: 30,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _selectedOption == 'Rather not say',
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOption = value ? 'Rather not say' : null;
                        });
                      }
                    },
                    shape: CircleBorder(),
                    activeColor: ColorConstants.primaryColor,
                    checkColor: Colors.black,
                  ),
                ),
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
              onPressedFunction: () {
                NavigationUtil.push(context, RouteConstants.aboutYouScreen);
              }),
        )
      ],
    );
  }
}
