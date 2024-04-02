import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';
import '../otp_screen/otp_screen.dart';

class SignUpWithEmail extends StatefulWidget {
  String? routeType;
  SignUpWithEmail({
    super.key,
    this.routeType,
  });

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  bool _isEmailValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: const AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: continueWithEmail());
  }

  Widget continueWithEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                //     borderColor: Colors.transparent,
                //     backgroundColor: ColorConstants.iconBg,
                //     iconColor: Colors.white,
                //     circleSize: 30,
                //     iconSize: 20,
                //   ),
                // ),
                // SizedBoxConstants.sizedBoxForthyH(),
                TextComponent(
                  StringConstants.whatsYourEmailAddress,
                  style: TextStyle(
                      fontSize: 22,
                      color: themeCubit.textColor,
                      fontFamily: FontConstants.fontProtestStrike),
                ),
                SizedBoxConstants.sizedBoxThirtyH(),
                TextFieldComponent(_emailcontroller,
                    validator: (email) {
                      return ValidationService.validateEmail(email!);
                    },
                    hintText: "abc@gmail.com",
                    textColor: themeCubit.textColor,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid = value.length >= 8 &&
                            value.trim().isNotEmpty &&
                            _formKey.currentState!.validate();
                      });
                    }),
                SizedBoxConstants.sizedBoxForthyH(),
                const TextComponent(
                  StringConstants.verificationCodeSentToEmail,
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
                  bgcolor: _isEmailValid
                      ? themeCubit.primaryColor
                      : ColorConstants.lightGray.withOpacity(0.2),
                  textColor: _isEmailValid
                      ? ColorConstants.black
                      : ColorConstants.lightGray,
                  buttonText: StringConstants.continues,
                  onPressedFunction: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.routeType == "number") {
                        NavigationUtil.push(
                            context, RouteConstants.otpScreenLocal,
                            args: OtpArg("", "", "", "setPasswordAfterNumber"));
                      } else {
                        NavigationUtil.push(
                            context, RouteConstants.otpScreenLocal,
                            args:
                                OtpArg("", "", "", "setPasswordBeforeNumber"));
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
