part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenSuccessState extends HomeScreenState {}

class HomeScreenFailureState extends HomeScreenState {
  final String error;

  HomeScreenFailureState(this.error);
}
