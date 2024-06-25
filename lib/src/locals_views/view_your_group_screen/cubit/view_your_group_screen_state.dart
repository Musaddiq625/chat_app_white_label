part of 'view_your_event_screen_cubit.dart';

@immutable
sealed class ViewYourGroupScreenState {}

class ViewYourGroupScreenInitial extends ViewYourGroupScreenState {}

class ViewYourGroupScreenLoadingState extends ViewYourGroupScreenState {}

class GroupVisibilityLoadingState extends ViewYourGroupScreenState {}
class ShareGroupLoadingState extends ViewYourGroupScreenState {}

class SendGroupRequestQueryAndStatusLoadingState
    extends ViewYourGroupScreenState {}

class ViewYourGroupScreenSuccessState extends ViewYourGroupScreenState {
  final EventModel? eventModel;

  ViewYourGroupScreenSuccessState(this.eventModel);
}
class ShareGroupSuccessState extends ViewYourGroupScreenState {
  final ShareGroupWrapper? shareGroupWrapper;

  ShareGroupSuccessState(this.shareGroupWrapper);
}

class SendGroupRequestQueryAndStatusSuccessState
    extends ViewYourGroupScreenState {
  final EventModel? eventModel;

  SendGroupRequestQueryAndStatusSuccessState(this.eventModel);
}

class GroupVisibilitySuccessState extends ViewYourGroupScreenState {
  final EventModel? eventModel;

  GroupVisibilitySuccessState(this.eventModel);
}

class ViewYourGroupScreenFailureState extends ViewYourGroupScreenState {
  final String error;

  ViewYourGroupScreenFailureState(this.error);
}
class ShareGroupFailureState extends ViewYourGroupScreenState {
  final String error;

  ShareGroupFailureState(this.error);
}

class GroupVisibilityFailureState extends ViewYourGroupScreenState {
  final String error;

  GroupVisibilityFailureState(this.error);
}

class SendGroupRequestQueryAndStatusFailureState
    extends ViewYourGroupScreenState {
  final String error;

  SendGroupRequestQueryAndStatusFailureState(this.error);
}
