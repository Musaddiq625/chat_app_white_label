import 'package:chat_app_white_label/src/locals_views/chat_listing/chat_listing_screen.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/user_profile.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bottom_nav_componenet.dart';
import '../../components/ui_scaffold.dart';

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
    return BlocListener<MainScreenCubit, MainScreenState>(
      listener: (context, state) {
        if (state is UpdateIndexState) {
          _selectedIndex = state.selectedIndex;
          setState(() {});
        }
      },
      child: UIScaffold(
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
      ),
    );
  }
}
