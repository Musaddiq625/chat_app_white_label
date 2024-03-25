import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/screens/chat_room/camera_screen.dart';
import 'package:chat_app_white_label/src/screens/contacts/contacts_screen.dart';
import 'package:chat_app_white_label/src/screens/chat_room/chat_room_screen.dart';
import 'package:chat_app_white_label/src/screens/home_screen.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/create_group_screen.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/select_contacts_screen.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/group_chat_room.dart';
import 'package:chat_app_white_label/src/screens/login/login_screen.dart';
import 'package:chat_app_white_label/src/screens/otp/otp_screen.dart';
import 'package:chat_app_white_label/src/screens/profile/profile_screen.dart';
import 'package:chat_app_white_label/src/screens/splash/splash_screen.dart';
import 'package:chat_app_white_label/src/screens/view_profile_screen/view_group_profile_screen.dart';
import 'package:chat_app_white_label/src/screens/view_profile_screen/view_user_profile_screen.dart';
import 'package:chat_app_white_label/src/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../locals_views/event_screen/event_screen.dart';
import '../screens/calls_screen.dart';
import '../screens/status_screen.dart';

Route generateRoute(RouteSettings settings) {
  materialRoute(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
  switch (settings.name) {
    case RouteConstants.homeScreen:
      return materialRoute(const HomeScreen());

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

    case RouteConstants.localsEventScreen:
      // final arg = settings.arguments! as String;
      return materialRoute(EventScreen());
    case RouteConstants.editProfileScreen:
      final arg = settings.arguments! as bool;
      return materialRoute(ProfileScreen(
        isEdit: arg,
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
      final arg = settings.arguments as bool;
      return materialRoute(CameraScreen(
        isGroup: arg,
      ));

    case RouteConstants.selectContactsScreen:
      final arg = settings.arguments! as SelectContactsScreenArg;
      return materialRoute(SelectContactsScreen(
        selectContactsScreenArg: arg,
      ));
    case RouteConstants.createGroupScreen:
      final arg = settings.arguments! as List;
      return materialRoute(CreateGroupScreen(
        contactsList: arg,
      ));
    case RouteConstants.groupChatRoomScreen:
      final arg = settings.arguments as ChatModel;
      return materialRoute(GroupChatRoomScreen(
        groupChat: arg,
      ));
    case RouteConstants.viewUserProfile:
      final arg = settings.arguments as UserModel;
      return materialRoute(ViewUserProfileScreen(user: arg));

    case RouteConstants.viewGroupProfile:
      final arg = settings.arguments as ChatModel;
      return materialRoute(ViewGroupProfileScreen(group: arg));

    default:
      return materialRoute(const SplashScreen());
  }
}
