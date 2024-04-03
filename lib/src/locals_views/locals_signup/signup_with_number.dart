import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/cubit/signup_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/button_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';
import '../otp_screen/otp_screen.dart';

class SignUpWithNumber extends StatefulWidget {
  String? routeType;

  SignUpWithNumber({super.key, this.routeType});

  @override
  State<SignUpWithNumber> createState() => _SignUpWithNumberState();
}

class _SignUpWithNumberState extends State<SignUpWithNumber> {
  bool _phoneNumberValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  late SignUpCubit signUpCubit = BlocProvider.of<SignUpCubit>(context);
  final _formKey = GlobalKey<FormState>();

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
                // InkWell(
                //   onTap:()=> NavigationUtil.pop(context),
                //   child: IconComponent(
                //     iconData: Icons.arrow_back_ios_new_outlined,
                //     backgroundColor: ColorConstants.iconBg,
                //   ),
                // ),
                // SizedBoxConstants.sizedBoxForthyH(),
                TextComponent(
                  StringConstants.whatsYourPhoneNumber,
                  style: TextStyle(
                      fontSize: 22,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CountryCodePicker(
                      padding: EdgeInsets.zero,
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
                        keyboardType: TextInputType.phone,
                        hintText: StringConstants.phoneTextFieldHint,
                        validator: (phone) => ValidationService.validatePhone(
                            phone!,
                            fieldName: StringConstants.phoneNumber),
                        onChanged: (value) {
                          setState(() {
                            _phoneNumberValid = value.length >= 10 &&
                                value.trim().isNotEmpty &&
                                _formKey.currentState!.validate();
                          });
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
                  bgcolor: _phoneNumberValid
                      ? themeCubit.primaryColor
                      : ColorConstants.lightGray.withOpacity(0.2),
                  textColor: _phoneNumberValid
                      ? ColorConstants.black
                      : ColorConstants.lightGray,
                  buttonText: StringConstants.continues,
                  onPressedFunction: () {
                    if (_phoneNumbercontroller.text.isEmpty ||
                        _phoneNumbercontroller.text.length < 10) {
                      Fluttertoast.showToast(
                          msg: "Please enter a valid phone number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    signUpCubit.loginUsers(_countryCodeController.text +
                        _phoneNumbercontroller.text);

                    // if (_formKey.currentState!.validate()) {
                    //   if (widget.routeType == "afterEmail") {
                    //     NavigationUtil.push(
                    //         context, RouteConstants.otpScreenLocal,
                    //         args: OtpArg("", "", "", "afterEmail"));
                    //   } else {
                    //     NavigationUtil.push(
                    //         context, RouteConstants.otpScreenLocal,
                    //         args: OtpArg("", "", "", "number"));
                    //   }
                    // } else {
                    //   return null;
                    // }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
