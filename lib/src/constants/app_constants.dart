import 'package:flutter/material.dart';

class AppConstants {
  static const String httpsSlash = 'https://';

  static String? userId;

  static int phoneNumberMaxLength = 10;
  static int otpMaxLength = 6;


  static bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }

  static void openKeyboard(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static double responsiveHeight(BuildContext context,
      {double percentage = 100}) {
    return MediaQuery.of(context).size.height * (percentage) / 100;
  }

  static double responsiveWidth(BuildContext context,
      {double percentage = 100}) {
    return MediaQuery.of(context).size.width * (percentage) / 100;
  }

  static double bottomPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom + 10;
  }
}
