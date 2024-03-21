import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../constants/dark_theme_color_constants.dart';
import '../../constants/light_theme_color_constants.dart';

enum ThemeEvent { toggleTheme }

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(true); // Default to light theme

  bool get isDarkMode => state;

  Color get primaryColor => isDarkMode ? DarkTheme.primaryColor : LightTheme.primaryColor;
  Color get secondaryColor => isDarkMode ? DarkTheme.secondaryColor : LightTheme.secondaryColor;
  Color get backgroundColor => isDarkMode ? DarkTheme.backgroundColor : LightTheme.backgroundColor;
  Color get textColor => isDarkMode ? DarkTheme.textColor : LightTheme.textColor;

  @override
  Stream<bool> mapEventToState(ThemeEvent event) async* {
    if (event == ThemeEvent.toggleTheme) {
      yield !state; // Toggle between true (dark) and false (light)
    }
  }
}