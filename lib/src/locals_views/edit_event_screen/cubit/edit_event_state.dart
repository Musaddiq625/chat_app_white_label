part of 'edit_event_cubit.dart';

@immutable
abstract class EditEventState {}

class EventInitial extends EditEventState {}

class EditEventLoadingState extends EditEventState {}
class DeleteEventLoadingState extends EditEventState {}


class EditEventSuccessState extends EditEventState {
  final EventModel? eventModel;

  EditEventSuccessState(this.eventModel);
}

class DeleteEventSuccessState extends EditEventState {
  final DeleteGroupWrapper deleteGroupWrapper;

  DeleteEventSuccessState(this.deleteGroupWrapper);
}



class DeleteEventFailureState extends EditEventState {
  final String error;

  DeleteEventFailureState(this.error);
}

class EditEventFailureState extends EditEventState {
  final String error;

  EditEventFailureState(this.error);
}

