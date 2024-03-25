

import '../../../models/chat_model.dart';


sealed class LocalsEventScreenState {}

class LocalsEventScreenInitial extends LocalsEventScreenState {}

class LocalsEventScreenLoadingState extends LocalsEventScreenState {}

class LocalsEventScreenSuccessState extends LocalsEventScreenState {
  final ChatModel groupData;
  LocalsEventScreenSuccessState(this.groupData);
}

class LocalsEventScreenFailureState extends LocalsEventScreenState {
  final String error;

  LocalsEventScreenFailureState(this.error);
}
