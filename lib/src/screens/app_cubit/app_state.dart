part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class SetPhoneNumberState extends AppState {}

class SetUserState extends AppState {}

class SetFcmState extends AppState {}
