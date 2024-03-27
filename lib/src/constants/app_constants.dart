import 'package:flutter/material.dart';

class AppConstants {
  static const String httpsSlash = 'https://';

  static double responsiveHeight(BuildContext context,
      {double percentage = 100}) {
    return MediaQuery.of(context).size.height * (percentage) / 100;
  }

  static double responsiveWidth(BuildContext context, {double percentage = 100}) {
    return MediaQuery.of(context).size.width * (percentage) / 100;
  }
}
