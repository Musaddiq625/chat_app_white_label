part of 'event_screen_cubit.dart';

@immutable
sealed class EventScreenState {}

class EventScreenInitial extends EventScreenState {}

class EventScreenLoadingState extends EventScreenState {}

class EventScreenSuccessState extends EventScreenState {}

class EventScreenFailureState extends EventScreenState {
  final String error;

  EventScreenFailureState(this.error);
}
