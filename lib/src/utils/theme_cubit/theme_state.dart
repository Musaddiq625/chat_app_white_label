import 'package:flutter/cupertino.dart';

@immutable
sealed class ThemeState {}

class ThemeInitial extends ThemeState {
  late bool isDarkMode;
  ThemeInitial(isDarkMode);
}

class ThemeUpdate extends ThemeState {
  late bool isDarkMode;

  ThemeUpdate(isDarkMode);
}
