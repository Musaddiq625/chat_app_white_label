import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';

class NavigationUtil {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Future<dynamic> pushOld(BuildContext context, Widget screen) {
    LoggerUtil.logs('pushOld to $screen');
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static Future<dynamic> push(BuildContext context, String routeName, {args}) {
    LoggerUtil.logs('push to $routeName');
    return Navigator.pushNamed(context, routeName, arguments: args);
  }

  static Future<dynamic> pushReplace(BuildContext context, String routeName,
      {args}) {
    LoggerUtil.logs('pushReplace to $routeName');
    return Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static void pop(BuildContext context, {args}) {
    LoggerUtil.logs('pop');
    return Navigator.pop(context, args);
  }

  static Future<void> popAllAndPush(BuildContext context, String routeName,
      {args}) async {
    LoggerUtil.logs('popAllAndPush to $routeName');
    await Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route route) => false,
        arguments: args);
  }
}
