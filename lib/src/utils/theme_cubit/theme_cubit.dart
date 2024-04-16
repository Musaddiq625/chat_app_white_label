import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_state.dart';

import '../../constants/dark_theme_color_constants.dart';
import '../../constants/light_theme_color_constants.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
  }

  void toggleTheme() {
    if (isDarkMode) {
      setDarkMode(false);
      emit(ThemeUpdate(_isDarkMode));
    } else {
      setDarkMode(true);
      emit(ThemeUpdate(_isDarkMode));
    }
  }

  Color get primaryColor =>
      _isDarkMode ? DarkTheme.primaryColor : LightTheme.primaryColor;
  Color get secondaryColor =>
      _isDarkMode ? DarkTheme.secondaryColor : LightTheme.secondaryColor;
  Color get backgroundColor =>
      _isDarkMode ? DarkTheme.backgroundColor : LightTheme.backgroundColor;
  Color get darkBackgroundColor => _isDarkMode
      ? DarkTheme.darkBackgroundColor
      : LightTheme.darkBackgroundColor;
  Color get darkBackgroundColor100 => _isDarkMode
      ? DarkTheme.darkBackgroundColor100
      : LightTheme.darkBackgroundColor;
  Color get textColor =>
      _isDarkMode ? DarkTheme.textColor : LightTheme.textColor;
  Color get textSecondaryColor => _isDarkMode
      ? DarkTheme.textSecondaryColor
      : LightTheme.textSecondaryColor;
}
