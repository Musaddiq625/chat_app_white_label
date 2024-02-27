import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
// import 'package:groves_app/constants/enum/locale_enum.dart';

class UIDirection {
  static TextDirection getDirection() {
    return TextDirection.ltr;
  //   if (Get.locale.toString() == LocaleEnum.ar.toString()) {
  //     return TextDirection.rtl;
  //   } else {
  //     //LocaleEnum.en
  //     //LocaleEnum.es
  //     //LocaleEnum.jp
  //     return TextDirection.ltr;
  //   }
  }
  //
  // static bool get isDirectionRtl =>
  //    Get.locale.toString() == LocaleEnum.ar.toString();

}
