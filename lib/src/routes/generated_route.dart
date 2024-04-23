import 'dart:io';

import 'package:chat_app_white_label/src/locals_views/chat_listing/chat_listing_screen.dart';
import 'package:chat_app_white_label/src/locals_views/chat_room/chat_room_screen.dart';
import 'package:chat_app_white_label/src/locals_views/done_screen/done_screen.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/all_event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/create_group_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/password_screen.dart';
import 'package:chat_app_white_label/src/locals_views/locals_signup/signup_with_email.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/about_you_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/dob_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/gender_selection.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/interest_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/name_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/select_profile_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/upload_picture_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/what_do_you_do_screen.dart';
import 'package:chat_app_white_label/src/locals_views/otp_screen/otp_screen.dart';
import 'package:chat_app_white_label/src/locals_views/settings_screens/allow_notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/settings_screens/privacy_policy_screen.dart';
import 'package:chat_app_white_label/src/locals_views/settings_screens/settings_screen.dart';
import 'package:chat_app_white_label/src/locals_views/settings_screens/terms_of_use_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/all_connections.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/edit_profile_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/user_profile.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_event_screen/view_your_event_screen.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/screens/chat_room/camera_screen.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/create_group_screen.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/group_chat_room.dart';
import 'package:chat_app_white_label/src/screens/login/login_screen.dart';
import 'package:chat_app_white_label/src/screens/otp/otp_screen.dart';
// import 'package:chat_app_white_label/src/screens/profile/edit_profile_screen.dart';

// import 'package:chat_app_white_label/src/screens/splash/splash_screen.dart';
import 'package:chat_app_white_label/src/screens/view_profile_screen/view_user_profile_screen.dart';
import 'package:chat_app_white_label/src/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../locals_views/create_event_screen/create_event_screen.dart';

// import 'package:chat_app_white_label/src/screens/home_screen.dart';
import '../locals_views/earnings_screen/earning_screen.dart';
import '../locals_views/home_screen/home_screen.dart';
import '../locals_views/locals_signup/signup_with_number.dart';

// import 'package:chat_app_white_label/src/screens/profile/profile_screen.dart';
import '../locals_views/profile_screen/profile_screen.dart';
import '../locals_views/splash_screen/splash_screen.dart';
import '../screens/calls_screen.dart';
import '../screens/status_screen.dart';

Route generateRoute(RouteSettings settings) {
  materialRoute(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
  switch (settings.name) {
    case RouteConstants.homeScreen:
      return materialRoute(const HomeScreen());

    // case RouteConstants.chatRoomScreen:
    //   final arg = settings.arguments as List;
    //   return materialRoute(ChatRoomScreen(
    //     chatUser: arg[0],
    //     unreadCount: arg[1],
    //   ));

    // case RouteConstants.profileScreen:
    //   final arg = settings.arguments! as String;
    //   return materialRoute(ProfileScreen(
    //     phoneNumber: arg,
    //   ));

    case RouteConstants.eventScreen:
      // final arg = settings.arguments! as String;
      return materialRoute(const EventScreen());

    case RouteConstants.editProfileScreen:
      // final arg = settings.arguments as bool;
      return materialRoute(const EditProfileScreen());

    // case RouteConstants.splashScreen:
    //   return materialRoute(const SplashScreen());

    case RouteConstants.welcomeScreen:
      return materialRoute(const WelcomeScreen());

    // case RouteConstants.contactsScreen:
    //   return materialRoute(const ContactsScreen());

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

    // case RouteConstants.selectContactsScreen:
    //   final arg = settings.arguments! as SelectContactsScreenArg;
    //   return materialRoute(SelectContactsScreen(
    //     selectContactsScreenArg: arg,
    //   ));
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

    // case RouteConstants.viewGroupProfile:
    //   final arg = settings.arguments as ChatModel;
    //   return materialRoute(ViewGroupProfileScreen(group: arg));

    case RouteConstants.chatListingScreen:
      return materialRoute(const ChatListingScreen());

    case RouteConstants.doneScreen:
      return materialRoute(const DoneScreen());

    case RouteConstants.chatRoomScreen:
      return materialRoute(const ChatRoomScreen());

    case RouteConstants.createEventScreen:
      return materialRoute(const CreateEventScreen());

    case RouteConstants.createGroupScreenLocals:
      return materialRoute(const CreateGroupScreens());

    case RouteConstants.homeScreenLocal:
      return materialRoute(const HomeScreen());

    case RouteConstants.signUpEmail:
      final arg = settings.arguments as String?;
      return materialRoute(SignUpWithEmail(
        routeType: arg,
      ));
      return materialRoute(SignUpWithEmail());

    case RouteConstants.signUpNumber:
      final arg = settings.arguments as String?;
      return materialRoute(SignUpWithNumber(
        routeType: arg,
      ));
    // return materialRoute( SignUpWithNumber());

    case RouteConstants.passwordScreen:
      final arg = settings.arguments as String?;
      return materialRoute(PasswordScreen(
        routeType: arg,
      ));
    // return materialRoute(PasswordScreen());

    case RouteConstants.otpScreenLocal:
      final arg = settings.arguments as OtpArg;
      return materialRoute(OtpScreen(
        otpArg: arg,
      ));
    // return materialRoute(const OtpScreen());

    case RouteConstants.profileScreenLocal:
      return materialRoute(ProfileScreen());

    case RouteConstants.splashScreenLocal:
      return materialRoute(const SplashScreen());

    case RouteConstants.nameScreen:
      return materialRoute(const NameScreen());

    case RouteConstants.uploadProfileScreen:
      return materialRoute(const UploadPictureScreen());

    case RouteConstants.userProfileScreen:
      return materialRoute(const UserProfile());

    case RouteConstants.allConnectionScreen:
      return materialRoute(const AllConnections());

    case RouteConstants.viewYourEventScreen:
      return materialRoute(const ViewYourEventScreen());

    case RouteConstants.viewGroupScreen:
      return materialRoute(const ViewGroupScreen());

    case RouteConstants.settingsScreen:
      return materialRoute(const SettingsScreen());

    case RouteConstants.notificationScreen:
      return materialRoute(const NotificationScreen());

    case RouteConstants.allowNotificationScreen:
      return materialRoute(const AllowNotificationScreen());
    case RouteConstants.termsOfUseScreen:
      return materialRoute(const TermsOfUseScreen());
    case RouteConstants.privacyPolicyScreen:
      return materialRoute(const PrivacyPolicyScreen());

    case RouteConstants.allEventScreen:
      return materialRoute(const AllEventScreen());

    case RouteConstants.earningScreen:
      return materialRoute(const EarningScreen());

    case RouteConstants.mainScreen:
      return materialRoute(MainScreen());

    case RouteConstants.viewYourEventScreen:
      return materialRoute(ViewYourEventScreen());

    case RouteConstants.selectProfileScreen:
      final arg = settings.arguments as List<String>;

      return materialRoute(SelectProfileImageScreen(
        selectedImages: arg,
      ));

    case RouteConstants.dobScreen:
      return materialRoute(const DOBScreen());

    case RouteConstants.genderScreen:
      return materialRoute(const GenderSelection());

    case RouteConstants.interestScreen:
      return materialRoute(const InterestScreen());

    case RouteConstants.aboutYouScreen:
      return materialRoute(const AboutYouScreen());

    case RouteConstants.whatDoYouDoScreen:
      return materialRoute(const WhatDoYouDoScreen());

    default:
      return materialRoute(const SplashScreen());
  }
}
