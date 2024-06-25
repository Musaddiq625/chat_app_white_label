import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/cubit/notification_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/user_profile.dart';
import 'package:chat_app_white_label/src/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bottom_nav_componenet.dart';
import '../../components/ui_scaffold.dart';

class MainScreen extends StatefulWidget {
  String? value;
  MainScreen({super.key,this.value});

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late NotificationScreenCubit notificationScreenCubit =
      BlocProvider.of<NotificationScreenCubit>(context);
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = int.parse(widget.value ?? "0");
    _screens = <Widget>[
      HomeScreen(),
      Container(),
      ChatScreen(),
      // ChatListingScreen(),
      NotificationScreen(),
      UserProfile(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      return;
    } else if (index == 3) {
      notificationScreenCubit.fetchNotificationData();
    } else if (index == 4) {
      userScreenCubit.fetchEventYouGoingToData();
      userScreenCubit.fetchGroupsData();
      userScreenCubit.fetchMyEventsData();
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
      child: PopScope(
        canPop: _selectedIndex == 0 ? false : false,
        onPopInvoked: (didPop) {
          if (_selectedIndex == 0) {
            return;
          } else {
            setState(() {
              _selectedIndex = 0;
            });
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
      ),
    );
  }
}
