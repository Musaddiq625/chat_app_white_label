import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/theme_cubit/theme_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      NavigationUtil.push(context, RouteConstants.createEventScreen);
    }
    else if (index == 2) {
      NavigationUtil.push(context, RouteConstants.chatListingScreen);
    }

  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
      child: BottomNavigationBar(
        backgroundColor: themeCubit.darkBackgroundColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.home,
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'My Feed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.add,
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.message,
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.profile,
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: themeCubit.primaryColor,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
