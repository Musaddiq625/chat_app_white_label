import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/create_event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/home_screen/home_screen.dart';
import 'package:chat_app_white_label/src/locals_views/settings_screens/notification_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/user_profile.dart';
import 'package:chat_app_white_label/src/screens/chat_screen/chat_screen.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/theme_cubit/theme_cubit.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const BottomNavBar({ Key? key,
      required this.selectedIndex,
      required this.onItemTapped,}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  // int _selectedIndex = 0;


  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   // if (index == 1) {
  //   //   NavigationUtil.push(context, RouteConstants.createEventScreen);
  //   // } else if (index == 2) {
  //   //   NavigationUtil.push(context, RouteConstants.chatListingScreen);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
      child:
      BottomNavigationBar(
        selectedFontSize: 0,
        backgroundColor: themeCubit.darkBackgroundColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.home,
              colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 0 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: create(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.message,
              colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 2 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              width: 25,
              height: 30,
              AssetConstants.notifications,
              color:
              widget.selectedIndex == 3 ? themeCubit.primaryColor : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 25,
              AssetConstants.profile,
              colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 4 ? themeCubit.primaryColor : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: '',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: themeCubit.primaryColor,
        onTap: widget.onItemTapped,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget create() {
    return PopupMenuButton(
      offset: Offset(0, -90),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set the border radius
      ),
      color: ColorConstants.darkBackgrounddColor,
      key: _key,
      icon: Icon(
        Icons.add_circle_sharp,
        color: ColorConstants.lightGray,
        size: 30,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(children: [
            IconComponent(
              svgData: AssetConstants.message,
              iconColor: ColorConstants.lightGray,
            ),
            TextComponent(
              StringConstants.createAEvent,
              style: FontStylesConstants.style14(
                  color: ColorConstants.white),
            ),
          ]),
          height: 0,
          value: 'createEvent',
        ),
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          height: 0,
          child: DividerCosntants.divider1,
          value: 'remove_connection',
        ),
        PopupMenuItem(
          height: 0,
          child: Row(children: [
            IconComponent(
              iconData: Icons.groups,
              iconColor: ColorConstants.lightGray,
            ),
            TextComponent(
              StringConstants.createAGroup,
              style: FontStylesConstants.style14(
                  color: ColorConstants.white),
            ),
          ]),
          value: 'makeAGroup',
        ),
      ],
      // onSelected: onMenuItemSelected,
      onSelected: (value) {
        if (value == 'createEvent') {
          NavigationUtil.push(context, RouteConstants.createEventScreen);
          // Handle share action
        } else if (value == 'makeAGroup') {
          // Handle something else action
        }
        // Add more conditions as needed
      },
    );
  }
}
