part of 'edit_event_cubit.dart';

@immutable
abstract class EditEventState {}

class EventInitial extends EditEventState {}

class EditEventLoadingState extends EditEventState {}


class EditEventSuccessState extends EditEventState {
  final EventModel? eventModel;

  EditEventSuccessState(this.eventModel);
}

class EditEventFailureState extends EditEventState {
  final String error;

  EditEventFailureState(this.error);
}

