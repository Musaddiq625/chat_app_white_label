import 'dart:developer';
import 'package:flutter/foundation.dart';

class LoggerUtil {
  static logs(logs) {
    // if (kDebugMode) {
      print(logs.toString());
      log(logs.toString());
    // }
  }
}
