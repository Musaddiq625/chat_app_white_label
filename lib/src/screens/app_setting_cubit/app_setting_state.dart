part of 'app_setting_cubit.dart';

@immutable
sealed class AppSettingState {}

final class AppSettingInitial extends AppSettingState {}

final class SetFlavorState extends AppSettingState {}
