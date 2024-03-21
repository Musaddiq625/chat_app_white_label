import 'package:flutter/cupertino.dart';

@immutable
sealed class ThemeState {}

class ThemeInitial extends ThemeState {
  ThemeInitial();
}


class ThemeUpdate extends ThemeState{
  late bool isDarkMode;


  ThemeUpdate(isDarkMode);
}