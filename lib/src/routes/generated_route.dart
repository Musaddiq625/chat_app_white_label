import 'package:chat_app_white_label/src/screens/chat_screen.dart';
import 'package:chat_app_white_label/src/screens/loginScreen.dart';
import 'package:chat_app_white_label/src/screens/otpScreen.dart';
import 'package:chat_app_white_label/src/screens/welcome_screen.dart';
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
    case RouteConstants.chatScreen:
      return _materialRoute(const ChatScreen());
    case RouteConstants.welcomeScreen:
      return _materialRoute(const WelcomeScreen());
    case RouteConstants.loginScreen:
      return _materialRoute(LoginScreen());
    case RouteConstants.otpScreen:
      return _materialRoute( OTPScreen());
    case RouteConstants.statusScreen:
      return _materialRoute(const StatusScreen());
    case RouteConstants.callScreen:
      return _materialRoute(const CallScreen());
    default:
      return _materialRoute(const ChatScreen());
  }
}
