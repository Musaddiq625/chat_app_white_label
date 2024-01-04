part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class SetTokenState extends AppState {}

class SetFcmState extends AppState {}
