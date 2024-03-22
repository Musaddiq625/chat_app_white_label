import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class LocalsSignUpWithEmail extends StatefulWidget {
  const LocalsSignUpWithEmail({super.key});

  @override
  State<LocalsSignUpWithEmail> createState() => _LocalsSignUpWithEmailState();
}

class _LocalsSignUpWithEmailState extends State<LocalsSignUpWithEmail> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: continueWithEmail());
  }

  Widget continueWithEmail() {
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
                iconData: Icons.arrow_back_ios,
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
                "What's your",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              Text(
                "email address?",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldComponent(
                _emailcontroller,
                hintText: "abc@gmail.com",
                fieldColor: ColorConstants.lightGray.withOpacity(0.5),
                textColor: themeCubit.textColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                StringConstants.verificationCodeSentToEmail,
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
                bgcolor: themeCubit.primaryColor,
                textColor: themeCubit.backgroundColor,
                buttonText: StringConstants.continues,
                onPressedFunction: () {}),
          )
        ],
      ),
    );
  }
}
