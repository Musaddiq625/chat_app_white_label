import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';

class PasswordScreen extends StatefulWidget {
  final String? routeType;

  const PasswordScreen({super.key, this.routeType});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _correctPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isFieldsValidate = false;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        StringConstants.setYourAccountPassword,
                        style: TextStyle(
                            fontSize: 22,
                            color: themeCubit.textColor,
                            fontFamily: FontConstants.fontProtestStrike),
                      ),
                      SizedBoxConstants.sizedBoxThirtyH(),
                      TextFieldComponent(
                        _passwordController,
                        title: StringConstants.password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        filled: true,

                        hintText: "",
                        // fieldColor: ColorConstants.lightGray.withOpacity(0.5),
                        textColor: themeCubit.textColor,
                        onChanged: (value) {
                          _handlePassOnChange(value);
                        },

                        validator: (password) {
                          return ValidationService.validatePassword(password!);
                        },
                      ),
                      SizedBoxConstants.sizedBoxTwentyH(),
                      TextFieldComponent(
                        _correctPasswordController,
                        title: StringConstants.confirmPassword,
                        hintText: "",
                        filled: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textColor: themeCubit.textColor,
                        onChanged: (value) {
                          _handleConfirmPassOnChange();
                          // _formKey.currentState!.validate();
                        },
                        validator: (confirmPassword) {
                          return ValidationService.validateConfirmPassword(
                            password: _passwordController.text,
                            confirmPass: confirmPassword,
                          );
                        },
                      ),
                      SizedBoxConstants.sizedBoxForthyH(),
                      const TextComponent(
                        StringConstants.passwordValidation,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.lightGray,
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ButtonComponent(
                          bgcolor: themeCubit.primaryColor,
                          textColor: ColorConstants.black,
                          buttonText: StringConstants.continues,
                          onPressed:
                              isFieldsValidate ? onContinuePressed : null))
                ],
              )),
        ));
  }

  void onContinuePressed() {
    if (_formKey.currentState!.validate()) {
      if (widget.routeType == "OnBoarding") {
        NavigationUtil.push(context, RouteConstants.nameScreen);
      } else if (widget.routeType == "phoneNumber") {
        NavigationUtil.push(context, RouteConstants.signUpNumber,
            args: "afterEmail");
      }
    }
  }

  void _handlePassOnChange(String passwordText) {
    if (isFieldsValidate != _formKey.currentState!.validate()) {
      isFieldsValidate = _formKey.currentState!.validate();
      setState(() {});
    }

    if (_correctPasswordController.text == passwordText &&
        (_correctPasswordController.text.isNotEmpty) &&
        (_passwordController.text.isNotEmpty) &&
        (_correctPasswordController.text == _passwordController.text)) {
      AppConstants.closeKeyboard();
    }
  }

  void _handleConfirmPassOnChange() {
    if (isFieldsValidate != _formKey.currentState!.validate()) {
      isFieldsValidate = _formKey.currentState!.validate();
      setState(() {});
    }
    if ((_correctPasswordController.text == _passwordController.text &&
        _formKey.currentState!.validate())) {
      AppConstants.closeKeyboard();
    }
  }
}
