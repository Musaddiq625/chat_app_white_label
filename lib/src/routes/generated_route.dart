import 'package:chat_app_white_label/src/screens/chat_room/camera_screen.dart';
import 'package:chat_app_white_label/src/screens/contacts/contacts_screen.dart';
import 'package:chat_app_white_label/src/screens/chat_room/chat_room_screen.dart';
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

    case RouteConstants.chatRoomScreen:
      final arg = settings.arguments as List;
      return materialRoute(ChatRoomScreen(
        chatUser: arg[0],
        unreadCount: arg[1],
      ));

    case RouteConstants.profileScreen:
      final arg = settings.arguments! as String;
      return materialRoute(ProfileScreen(
        phoneNumber: arg,
      ));

    case RouteConstants.splashScreen:
      return materialRoute(const SplashScreen());

    case RouteConstants.welcomeScreen:
      return materialRoute(const WelcomeScreen());

    case RouteConstants.contactsScreen:
      return materialRoute(const ContactsScreen());

    case RouteConstants.loginScreen:
      return materialRoute(const LoginScreen());

    case RouteConstants.otpScreen:
      final arg = settings.arguments as OtpScreenArg;
      return materialRoute(OTPScreen(
        otpScreenArg: arg,
      ));

    case RouteConstants.statusScreen:
      return materialRoute(const StatusScreen());

    case RouteConstants.callScreen:
      return materialRoute(const CallScreen());

    case RouteConstants.cameraScreen:
      return materialRoute(const CameraScreen());

    default:
      return materialRoute(const SplashScreen());
  }
}
