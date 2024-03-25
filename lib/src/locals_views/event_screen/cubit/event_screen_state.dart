

import '../../../models/chat_model.dart';


sealed class EventScreenState {}

class EventScreenInitial extends EventScreenState {}

class EventScreenLoadingState extends EventScreenState {}

class EventScreenSuccessState extends EventScreenState {
  final ChatModel groupData;
  EventScreenSuccessState(this.groupData);
}

class EventScreenFailureState extends EventScreenState {
  final String error;

EventScreenFailureState(this.error);
}
