part of 'edit_group_cubit.dart';

@immutable
abstract class EditGroupState {}

class EditGroupInitial extends EditGroupState {}

class EditGroupLoadingState extends EditGroupState {}


class EditGroupSuccessState extends EditGroupState {
  final EventModel? eventModel;

  EditGroupSuccessState(this.eventModel);
}

class EditGroupFailureState extends EditGroupState {
  final String error;

  EditGroupFailureState(this.error);
}

