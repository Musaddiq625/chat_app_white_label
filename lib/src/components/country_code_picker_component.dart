import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCodePickerComponent extends StatelessWidget {
  final Function(CountryCode) onChange;
  final bool isSignupScreen;

  const CountryCodePickerComponent({
    super.key,
    required this.onChange,
    this.isSignupScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

    return CountryCodePicker(
      padding: EdgeInsets.zero,
      textStyle: TextStyle(
          color: themeCubit.textColor,
          fontFamily: isSignupScreen
              ? FontConstants.fontProtestStrike
              : FontConstants.inter,
          fontSize: 15),
      onChanged: (CountryCode countryCode) => onChange(countryCode),
      initialSelection: 'pk',
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }
}
