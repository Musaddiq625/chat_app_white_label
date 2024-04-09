import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/check_box_listtile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
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
  String? _selectedOption;

  final Map<String, dynamic> _ListofIdentities = {
    "Male": true,
    "Female": true,
    "Non Binary": true,
    "Rather Not Say": true,
  };

  @override
  void initState() {
    super.initState();
    _selectedOption = _ListofIdentities.entries.first.key;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: const AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
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
                      enablePadding: false,
                      isChecked: isSelected,
                      identity, onPressed: () {
                    setState(() {
                      _selectedOption = (identity);
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
              horizontalLength:
                  AppConstants.responsiveWidth(context, percentage: 35),
              textColor: _selectedOption != null
                  ? ColorConstants.black
                  : ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                NavigationUtil.push(context, RouteConstants.aboutYouScreen);
              })
        ],
      ),
    );
  }
}
