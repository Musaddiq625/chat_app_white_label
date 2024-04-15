import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/cubit/signup_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/otp_screen/otp_screen.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWithNumber extends StatefulWidget {
  final String? routeType;

  const SignUpWithNumber({super.key, this.routeType});

  @override
  State<SignUpWithNumber> createState() => _SignUpWithNumberState();
}

class _SignUpWithNumberState extends State<SignUpWithNumber> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  late SignUpCubit signUpCubit = BlocProvider.of<SignUpCubit>(context);
  final _formKey = GlobalKey<FormState>();
  bool isFieldsValidate = false;

  @override
  void initState() {
    super.initState();
    // signUpCubit = BlocProvider.of<SignUpCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        LoggerUtil.logs('login state: $state');
        if (state is SignUpLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        } else if (state is SignUpSignUpState) {
          LoadingDialog.hideLoadingDialog(context);
          if (widget.routeType == "afterEmail") {
            NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                args: OtpArg(
                    state.verificationId,
                    "${_countryCodeController.text}${_phoneNumbercontroller.text}",
                    _countryCodeController.text,
                    "afterEmail"));
          } else {
            NavigationUtil.push(
              context,
              RouteConstants.otpScreenLocal,
              args: OtpArg(
                  state.verificationId,
                  "${_countryCodeController.text}${_phoneNumbercontroller.text}",
                  _countryCodeController.text,
                  "number"),
            );
          }
        } else if (state is SignUpSignInState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
        } else if (state is SignUpFailureState) {
          LoadingDialog.hideLoadingDialog(context);

          ToastComponent.showToast(state.error,
              makeToastPositionTop: true, context: context);
        } else if (state is SignUpCancleState) {
          LoadingDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: const AppBarComponent(""),
            removeSafeAreaPadding: false,
            bgColor: themeCubit.backgroundColor,
            widget: continueWithNumber());
      },
    );
  }

  Widget continueWithNumber() {
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      setState(() {
                        _phoneNumbercontroller.text =
                            StringConstants.testingPhoneNo;
                      });
                    }
                  },
                  child: TextComponent(
                    StringConstants.whatsYourPhoneNumber,
                    style: TextStyle(
                        fontSize: 22,
                        color: themeCubit.textColor,
                        fontFamily: FontConstants.fontProtestStrike),
                  ),
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CountryCodePicker(
                      // padding: EdgeInsets.zero,
                      textStyle: TextStyle(
                          color: themeCubit.textColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 30),
                      onChanged: (CountryCode countryCode) {
                        _countryCodeController.text =
                            '+${countryCode.dialCode!}';
                        LoggerUtil.logs("country code ${countryCode.dialCode}");
                      },
                      initialSelection: 'pk',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    Expanded(
                      child: TextFieldComponent(
                        _phoneNumbercontroller,
                        maxLength: AppConstants.phoneNumberMaxLength,
                        keyboardType: TextInputType.phone,
                        autoFocus: true,
                        hintText: StringConstants.phoneTextFieldHint,
                        validator: (phone) => ValidationService.validatePhone(
                            phone!.trim(),
                            fieldName: StringConstants.phoneNumber),
                        onChanged: (phone) {
                          handlePhoneOnChange();
                          // setState(() {
                          // _phoneNumberValid = _formKey.currentState!.validate();
                          // });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                const TextComponent(
                  StringConstants.verificationCodeSent,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.lightGray,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Spacer(),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: ButtonComponent(
                  bgcolor: themeCubit.primaryColor,
                  textColor: ColorConstants.black,
                  buttonText: StringConstants.continues,
                  onPressed: isFieldsValidate ? onContinuePressed : null),
            )
          ],
        ),
      ),
    );
  }

  void onContinuePressed() async {
    if (_formKey.currentState!.validate()) {
      NavigationUtil.push(
        context,
        RouteConstants.otpScreenLocal,
        args: OtpArg(
            '0000', // state.verificationId,
            "${_countryCodeController.text}${_phoneNumbercontroller.text}",
            _countryCodeController.text,
            "number"),
      );
      // await signUpCubit.loginUser(
      //   (_countryCodeController.text + _phoneNumbercontroller.text).trim(),
      // );
    }
  }

  void handlePhoneOnChange() {
    if (isFieldsValidate != _formKey.currentState!.validate()) {
      isFieldsValidate = _formKey.currentState!.validate();
      setState(() {});
    }
  }
}
