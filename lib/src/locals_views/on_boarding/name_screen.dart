import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/models/user_detail_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/font_styles.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isFieldsValidate = false;

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
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(StringConstants.whatsYourName,
                  style:
                      FontStylesConstants.style22(color: ColorConstants.white)),
              SizedBoxConstants.sizedBoxThirtyH(),
              TextFieldComponent(
                _firstNameController,
                keyboardType: TextInputType.name,
                hintText: StringConstants.firstName,
                allowSpaces: false,
                onChanged: (_) {
                  handleFieldsOnChange();
                },
                validator: (firstName) => ValidationService.validateText(
                    firstName!.trim(),
                    fieldName: StringConstants.firstName),
              ),
              TextFieldComponent(
                _secondNameController,
                keyboardType: TextInputType.name,
                hintText: StringConstants.lastName,
                allowSpaces: false,
                onChanged: (_) {
                  handleFieldsOnChange();
                },
                validator: (lastName) => ValidationService.validateText(
                    lastName!.trim(),
                    fieldName: StringConstants.lastName),
              ),
            ],
          ),
        ),
        SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: themeCubit.primaryColor,
                textColor: isFieldsValidate
                    ? ColorConstants.black
                    : ColorConstants.grey1,
                buttonText: StringConstants.continues,
                onPressed: isFieldsValidate ? onContinuePressed : null))
      ],
    );
  }

  void handleFieldsOnChange() {
    if (isFieldsValidate != _formKey.currentState!.validate()) {
      isFieldsValidate = _formKey.currentState!.validate();
      setState(() {});
    }
  }

  void onContinuePressed() {
    //Todo add in shared pref
    onBoardingCubit.updateUserName(
        _firstNameController.text, _secondNameController.text);
    AppConstants.closeKeyboard();
    NavigationUtil.push(context, RouteConstants.uploadProfileScreen);
  }
}
