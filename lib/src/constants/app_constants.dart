import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const String httpsSlash = 'https://';

  static String? userId;

  static int phoneNumberMaxLength = 10;
  static int otpMaxLength = 6;

  static bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }

  static Future<String?> uploadImage(
      String imagePath, String destination) async {
    final file = File(imagePath);
    if (!file.existsSync()) {
      throw Exception('File does not exist: $imagePath');
    }
    // Await the upload and capture the result (URL)
    return await AwsS3.uploadFile(
      accessKey: "DQEJGSA2VP1KBQZ551NI",
      secretKey: "OOFqyH9v2YBpon7C3m0pZSH0ruNxqGEVMeyRy0g5",
      file: file,
      bucket: "locals",
      region: "se-sto-1",
      domain: "linodeobjects.com",
      destDir: destination,
    );
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
