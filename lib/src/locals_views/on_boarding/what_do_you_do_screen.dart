import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/text_component.dart';
import '../../components/text_field_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/app_constants.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../models/user_detail_model.dart';
import '../../utils/navigation_util.dart';
import '../../utils/service/validation_service.dart';

class WhatDoYouDoScreen extends StatefulWidget {
  const WhatDoYouDoScreen({super.key});

  @override
  State<WhatDoYouDoScreen> createState() => _WhatDoYouDoScreenState();
}

class _WhatDoYouDoScreenState extends State<WhatDoYouDoScreen> {
  bool isFieldsValidate = false;
  UserDetailModel? userDetailModel;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _aboutMeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          "",
          action: TextComponent(StringConstants.skip,
              style: TextStyle(
                fontSize: 14,
                color: themeCubit.textColor,
              )),
        ),
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent(
                StringConstants.whatDoYouDo,
                style:FontStylesConstants.style22()),
              SizedBoxConstants.sizedBoxThirtyH(),
              TextFieldComponent(_aboutMeController,
                  keyboardType: TextInputType.multiline,
                  hintText: StringConstants.whatDoYouDoHintText,
                  onChanged: (_) {
                    handleFieldsOnChange();
                  },
                  validator: (whatDoYouDo) =>
                      ValidationService.validateEmptyField(
                        _aboutMeController.text
                      ),
                  maxLines: 50),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: isFieldsValidate
                  ? themeCubit.primaryColor
                  : ColorConstants.lightGray.withOpacity(0.2),
              textColor: isFieldsValidate
                  ? ColorConstants.black
                  : ColorConstants.lightGray,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                userDetailModel?.aboutMe = _aboutMeController.text;
                NavigationUtil.push(
                    context, RouteConstants.genderScreen);
              }),
        )
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
    userDetailModel?.aboutMe = _aboutMeController.text;
    AppConstants.closeKeyboard();
    NavigationUtil.push(context, RouteConstants.genderScreen);
  }
}
