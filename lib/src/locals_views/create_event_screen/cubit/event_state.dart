part of 'event_cubit.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoadingState extends EventState {}

class CreateEventSuccessState extends EventState {
  final EventModel? eventModel;

  CreateEventSuccessState(this.eventModel);

}

class CreateEventFailureState extends EventState {
  final String error;
  CreateEventFailureState(this.error);
}