part of 'user_screen_cubit.dart';

@immutable
sealed class UserScreenState {}

class UserScreenInitial extends UserScreenState {}

class UserScreenLoadingState extends UserScreenState {}
class UpdateUserScreenLoadingState extends UserScreenState {}

class UserScreenSuccessState extends UserScreenState {
  final List<UserModel>? userModelList;

  UserScreenSuccessState(this.userModelList);
}

class UpdateUserScreenSuccessState extends UserScreenState {
  final UserModel? userModel;

  UpdateUserScreenSuccessState(this.userModel);
}

class InterestSuccessState extends UserScreenState {
  final InterestResponseWrapper interestData;

  InterestSuccessState(this.interestData);
}

class UpdateUserScreenFailureState extends UserScreenState {
  final String error;

  UpdateUserScreenFailureState(this.error);
}

class UserScreenFailureState extends UserScreenState {
  final String error;

  UserScreenFailureState(this.error);
}

class InterestFailureState extends UserScreenState {
  final String error;

  InterestFailureState(this.error);
}
