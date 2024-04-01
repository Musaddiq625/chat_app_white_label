import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';
import '../otp_screen/otp_screen.dart';

class SignUpWithNumber extends StatefulWidget {
  String? routeType;
   SignUpWithNumber({super.key, this.routeType});

  @override
  State<SignUpWithNumber> createState() => _SignUpWithNumberState();
}

class _SignUpWithNumberState extends State<SignUpWithNumber> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: continueWithNumber());
  }

  Widget continueWithNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap:()=> NavigationUtil.pop(context),
                child: IconComponent(
                  iconData: Icons.arrow_back_ios_new_outlined,
                  backgroundColor: ColorConstants.iconBg,
                ),
              ),
              SizedBoxConstants.sizedBoxForthyH(),
              TextComponent(
                StringConstants.whatsYourPhoneNumber,
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              Row(
                children: <Widget>[
                  CountryCodePicker(
                    textStyle: TextStyle(
                        color: themeCubit.textColor,
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 30),
                    onChanged: (CountryCode countryCode) {
                      _countryCodeController.text = '+${countryCode.dialCode!}';
                      print("country code ${countryCode.dialCode}");
                    },
                    initialSelection: 'pk',
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneNumbercontroller,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: ColorConstants.white,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 30),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "1234 123456",
                        hintStyle: TextStyle(
                            color: ColorConstants.lightGray,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 30),
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        // Limit to 12 characters
                        FilteringTextInputFormatter.digitsOnly,
                        // Accept only digits
                      ],
                    ),
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              TextComponent(
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
                bgcolor: ColorConstants.lightGray.withOpacity(0.2),
                textColor: ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressedFunction: () {
                  if(widget.routeType == "afterEmail"){
                    NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                        args: OtpArg(
                            "", "","","afterEmail"
                        ));
                  }
                  else{
                    NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                        args: OtpArg(
                            "", "","","number"
                        ));
                  }
                }),
          )
        ],
      ),
    );
  }
}
