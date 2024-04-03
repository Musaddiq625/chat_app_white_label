import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_field_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class PasswordScreen extends StatefulWidget {
  String? routeType;

  PasswordScreen({super.key, this.routeType});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _isPasswordValid = false;
  bool _isCorrectPasswordValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _correctPasswordController =
      TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: setPassword());
  }

  Widget setPassword() {
    return Padding(
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
                  filled: true,

                  hintText: "",
                  // fieldColor: ColorConstants.lightGray.withOpacity(0.5),
                  textColor: themeCubit.textColor,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordValid = value.length >= 8 &&
                          value.trim().isNotEmpty &&
                          _formKey.currentState!.validate();
                    });
                  },

                  validator: (password) =>
                      ValidationService.validatePassword(password!),
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                TextFieldComponent(
                  _correctPasswordController,
                  title: StringConstants.confirmPassword,
                  hintText: "",
                  filled: true,
                  textColor: themeCubit.textColor,
                  onChanged: (value) {
                    setState(() {
                      _isCorrectPasswordValid = value.length >= 8 &&
                          value.trim().isNotEmpty &&
                          _formKey.currentState!.validate();
                      ;
                    });
                  },
                  validator: (confirmPassword) {
                    return ValidationService.validateConfirmPassword(
                      confirmPass: confirmPassword!,
                      password: _passwordController.text,
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
                  bgcolor: _isPasswordValid && _isCorrectPasswordValid
                      ? themeCubit.primaryColor
                      : ColorConstants.lightGray.withOpacity(0.2),
                  textColor: _isPasswordValid && _isCorrectPasswordValid
                      ? ColorConstants.black
                      : ColorConstants.lightGray,
                  buttonText: StringConstants.continues,
                  onPressedFunction: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.routeType == "OnBoarding") {
                        NavigationUtil.push(context, RouteConstants.nameScreen);
                      } else if (widget.routeType == "phoneNumber") {
                        NavigationUtil.push(
                            context, RouteConstants.signUpNumber,
                            args: "afterEmail");
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
