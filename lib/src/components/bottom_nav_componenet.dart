import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),

      child: BottomNavigationBar(
        backgroundColor:themeCubit.darkBackgroundColor ,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'My Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Inbox',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.groups),
          //   label: 'Community',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
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
