part of 'edit_group_cubit.dart';

@immutable
abstract class EditGroupState {}

class EditGroupInitial extends EditGroupState {}

class EditGroupLoadingState extends EditGroupState {}
class DeleteGroupLoadingState extends EditGroupState {}


class EditGroupSuccessState extends EditGroupState {
  final EventModel? eventModel;

  EditGroupSuccessState(this.eventModel);
}
class DeleteGroupSuccessState extends EditGroupState {
  final DeleteGroupWrapper deleteGroupWrapper;

  DeleteGroupSuccessState(this.deleteGroupWrapper);
}

class EditGroupFailureState extends EditGroupState {
  final String error;

  EditGroupFailureState(this.error);
}

class DeleteGroupFailureState extends EditGroupState {
  final String error;

  DeleteGroupFailureState(this.error);
}

