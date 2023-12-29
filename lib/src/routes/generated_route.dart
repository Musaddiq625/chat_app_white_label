import 'package:chat_app_white_label/src/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../screens/calls_screen.dart';
import '../screens/status_screen.dart';


Route generateRoute(RouteSettings settings) {
  _materialRoute(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
  switch (settings.name) {
    // case RouteConstants.splashRoute:
    //   bool? skipDelay = settings.arguments as bool?;
    //   return _materialRoute(SplashScreen(
    //     skipDelay: skipDelay ?? false,
    //   ));
    case RouteConstants.chatScreenRoute:
      return _materialRoute(const ChatScreen());
    case RouteConstants.statusScreenRoute:
      return _materialRoute(const StatusScreen());
    case RouteConstants.callScreenRoute:
      return _materialRoute(const CallScreen());
    default:
      return _materialRoute(const ChatScreen());
  }
}
