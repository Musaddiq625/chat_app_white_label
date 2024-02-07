import 'package:chat_app_white_label/src/components/custom_alert_dialog.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<PermissionStatus> requestContactsPermission(context) async {
    var status = await Permission.contacts.status;
    LoggerUtil.logs('status is 1 $status');
    if (!status.isGranted) {
      final dialog = CustomAlertDialog(
          // title: 'Allow Contacts Access',
          message: 'Please allow access to your contacts.',
          makeHeadingCenter: true,
          // either denied or permanently denied
          // if permanently denied so open settings
          btnTextRight: status.isDenied ? 'Allow' : 'Open Settings',
          btnTapRight: () async {
            if (status.isDenied) {
              await Permission.contacts.request();
              NavigationUtil.pop(context);
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
      ).then((value) async {
        LoggerUtil.logs('.then');
        status = await Permission.contacts.status;
      });
      LoggerUtil.logs('status is 2 $status');
      return status;
    } else {
      LoggerUtil.logs('status is 3 $status');
      return status;
    }
  }
}
