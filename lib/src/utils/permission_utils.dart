import 'package:chat_app_white_label/src/components/custom_alert_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<PermissionStatus> requestContactsPermission(context) async {
    var status = await Permission.contacts.status;
    LoggerUtil.logs('contacts permission status is $status');
    if (!status.isGranted) {
      final dialog = CustomAlertDialog(
          // title: 'Allow Contacts Access',
          message: 'Please allow access to your contacts.',
          makeHeadingCenter: true,
          // either denied or permanently denied
          // if permanently denied so open settings
          btnTextRight: status.isDenied ? 'Allow' : 'Open Settings',
          hideCancel: true,
          btnTapRight: () async {
            if (status.isDenied) {
              NavigationUtil.pop(context);
              await Permission.contacts.request();
            } else {
              await openAppSettings();
              status = await Permission.contacts.status;
              Navigator.pop(context);
              LoggerUtil.logs('status is openAppSettings $status');
            }
          });
      await showDialog(
        context: context,
        builder: (BuildContext context) => dialog,
      ).then((value) async => status = await Permission.contacts.status);
      return status;
    } else {
      return status;
    }
  }

  static Future<void> requestCameraAndMicPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    final microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
  }
}
