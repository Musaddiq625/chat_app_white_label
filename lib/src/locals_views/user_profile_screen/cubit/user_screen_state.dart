part of 'user_screen_cubit.dart';

@immutable
sealed class UserScreenState {}

class UserScreenInitial extends UserScreenState {}

class UserScreenLoadingState extends UserScreenState {}

class UserScreenSuccessState extends UserScreenState {
  final List<UserModel>? userModelList;

  UserScreenSuccessState(this.userModelList);
}


class UserScreenFailureState extends UserScreenState {
  final String error;

  UserScreenFailureState(this.error);
}
