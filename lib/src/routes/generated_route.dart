import 'package:chat_app_white_label/src/screens/all_user_screen.dart';
import 'package:chat_app_white_label/src/screens/chat_screen.dart';
import 'package:chat_app_white_label/src/screens/login/login_screen.dart';
import 'package:chat_app_white_label/src/screens/otp/otp_screen.dart';
import 'package:chat_app_white_label/src/screens/profile/profile_screen.dart';
import 'package:chat_app_white_label/src/screens/splash/splash_screen.dart';
import 'package:chat_app_white_label/src/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../screens/calls_screen.dart';
import '../screens/status_screen.dart';

Route generateRoute(RouteSettings settings) {
  materialRoute(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
  switch (settings.name) {
    case RouteConstants.chatScreen:
      return materialRoute(const ChatScreen());

    case RouteConstants.profileScreen:
      final arg = settings.arguments! as String;
      return materialRoute(ProfileScreen(
        phoneNumber: arg,
      ));

    case RouteConstants.splashScreen:
      return materialRoute(const SplashScreen());

    case RouteConstants.welcomeScreen:
      return materialRoute(const WelcomeScreen());

    case RouteConstants.allUserScreen:
      return materialRoute(const AllUsersScreen());

    case RouteConstants.loginScreen:
      return materialRoute(LoginScreen());

    case RouteConstants.otpScreen:
      final arg = settings.arguments! as OtpScreenArg;
      return materialRoute(OTPScreen(
        otpScreenArg: arg,
      ));

    case RouteConstants.statusScreen:
      return materialRoute(const StatusScreen());

    case RouteConstants.callScreen:
      return materialRoute(const CallScreen());

    default:
      return materialRoute(const SplashScreen());
  }
}
