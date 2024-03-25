


import '../../../models/chat_model.dart';

sealed class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenSuccessState extends HomeScreenState {
  final ChatModel groupData;
  HomeScreenSuccessState(this.groupData);
}

class HomeScreenFailureState extends HomeScreenState {
  final String error;

  HomeScreenFailureState(this.error);
}
