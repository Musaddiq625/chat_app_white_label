import 'dart:convert';
import 'dart:math';

import 'package:chat_app_white_label/src/utils/logger_util.dart';

class StringUtil {
  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  /// getLength('FirstSecondThird',length: 5,fromStart: true); //First
  /// getLength('FirstSecondThird',length: 5,fromEnd: true); // Third
  static String getLength(
    String? str, {
    required int length,
    bool fromStart = false,
    bool fromEnd = false,
  }) {
    try {
      if (str == null || str == '') return '';
      if (fromStart) return str.substring(0, length);
      if (fromEnd) return str.substring(str.length - length, str.length);
      return '';
    } catch (e) {
      LoggerUtil.logs('getLength error str=$str length=$length '
          'fromStart=$fromStart fromEnd=$fromEnd $e');
      return '';
    }
  }
}
