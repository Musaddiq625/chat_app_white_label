part of 'group_cubit.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoadingState extends GroupState {}

class ViewGroupLoadingState extends GroupState {}

class CreateGroupSuccessState extends GroupState {
  final EventModel? eventModel;

  CreateGroupSuccessState(this.eventModel);
}
class ViewGroupSuccessState extends GroupState {
  final EventModel? eventModel;

  ViewGroupSuccessState(this.eventModel);
}

class CreateGroupFailureState extends GroupState {
  final String error;

  CreateGroupFailureState(this.error);
}
class ViewGroupFailureState extends GroupState {
  final String error;

  ViewGroupFailureState(this.error);
}

