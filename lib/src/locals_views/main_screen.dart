import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/locals_views/chat_listing/chat_listing_screen.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/user_profile.dart';
import 'package:flutter/material.dart';

import '../components/bottom_nav_componenet.dart';
import '../components/ui_scaffold.dart';
import 'settings_screens/allow_notification_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeScreen(),
      Container(),
      ChatListingScreen(),
      NotificationScreen(),
      UserProfile(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      extendBody: true,
      removeSafeAreaPadding: false,
      widget: Stack(children: [
        IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ]),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
