


import '../../../models/chat_model.dart';

sealed class LocalsHomeScreenState {}

class LocalsHomeScreenInitial extends LocalsHomeScreenState {}

class LocalsHomeScreenLoadingState extends LocalsHomeScreenState {}

class LocalsHomeScreenSuccessState extends LocalsHomeScreenState {
  final ChatModel groupData;
  LocalsHomeScreenSuccessState(this.groupData);
}

class LocalsHomeScreenFailureState extends LocalsHomeScreenState {
  final String error;

  LocalsHomeScreenFailureState(this.error);
}
