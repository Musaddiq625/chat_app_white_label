import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:flutter/material.dart';

import 'icon_component.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    UIScaffold(
        bgImage: AssetConstants.backgroundImage,
        widget: Column(
          children: [Text('data')],
        )),
    // CustomIconWidget(
    //   iconData: Icons.home, // Example icon
    //   iconSize: 48.0, // Larger icon size
    //   iconColor: Colors.black87, // Blue color
    //   borderSize: 4.0, // Larger border size
    //   borderColor: Colors.black87, // Red border color
    //   circleSize: 70.0, // Increased circle size
    // ),
    CustomIconWidget(
      iconData: Icons.chat_bubble, // Example icon
      iconSize: 48.0, // Larger size
      iconColor: Colors.black87, // Blue color
      borderSize: 4.0, // Larger border size
      borderColor: Colors.black87,
      backgroundColor: Colors.grey,
      circleSize: 70.0, // Red border color
    ),
    CustomIconWidget(
      iconData: Icons.add, // Example icon
      iconSize: 48.0, // Larger size
      iconColor: Colors.black87, // Blue color
      borderSize: 4.0, // Larger border size
      borderColor: Colors.black87,
      circleSize: 70.0, // Red border color
    ),
    CustomIconWidget(
      iconData: Icons.people_alt, // Example icon
      iconSize: 48.0, // Larger size
      iconColor: Colors.black87, // Blue color
      borderSize: 4.0, // Larger border size
      borderColor: Colors.black87,
      circleSize: 70.0, // Red border color
    ),
    CustomIconWidget(
      iconData: Icons.person, // Example icon
      iconSize: 48.0, // Larger size
      iconColor: Colors.black87, // Blue color
      borderSize: 4.0, // Larger border size
      borderColor: Colors.black87,
      circleSize: 70.0, // Red border color
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
            onTap: () => BottomSheetComponent.showBottomSheet(context,
                body: Container(
                  child: Icon(Icons.delete),
                )),
            child: Container(child: _widgetOptions.elementAt(_selectedIndex))),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'My Feed',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'Inbox',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Create',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt),
                label: 'Community',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Me',
                backgroundColor: Colors.white),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
