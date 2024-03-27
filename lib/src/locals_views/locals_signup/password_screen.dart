import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_field_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class PasswordScreen extends StatefulWidget {
  String? routeType;

  PasswordScreen({super.key, this.routeType});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: setPassword());
  }

  Widget setPassword() {
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
              IconComponent(
                iconData: Icons.arrow_back_ios_new_outlined,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: Colors.white,
                circleSize: 30,
                iconSize: 20,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Set your",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              Text(
                "account's password?",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 20,
              ),

              TextFieldComponent(
                _phoneNumbercontroller,
                title: "Password",
                hintText: "",
                fieldColor: ColorConstants.lightGray.withOpacity(0.5),
                textColor: themeCubit.textColor,
              ),
              const SizedBox(
                height: 20,
              ),

              TextFieldComponent(
                _phoneNumbercontroller,
                title: "Confirm Password",
                hintText: "",
                fieldColor: ColorConstants.lightGray.withOpacity(0.5),
                textColor: themeCubit.textColor,
              ),
              const SizedBox(
                height: 20,
              ),
              TextComponent(
                StringConstants.passwordValidation,
                style: TextStyle(
                  fontSize: 12,
                  color: themeCubit.textColor,
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
                  if (widget.routeType == "OnBoarding") {
                    NavigationUtil.push(context, RouteConstants.nameScreen);
                  } else if (widget.routeType == "phoneNumber") {
                    NavigationUtil.push(context, RouteConstants.signUpNumber,
                        args: "afterEmail");
                  }
                }),
          )
        ],
      ),
    );
  }
}
