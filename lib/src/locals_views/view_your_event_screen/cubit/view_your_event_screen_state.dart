part of 'view_your_event_screen_cubit.dart';

@immutable
sealed class ViewYourEventScreenState {}

class ViewYourEventScreenInitial extends ViewYourEventScreenState {}

class ViewYourEventScreenLoadingState extends ViewYourEventScreenState {}

class SendEventRequestQueryAndStatusLoadingState
    extends ViewYourEventScreenState {}

class ViewYourEventScreenSuccessState extends ViewYourEventScreenState {
  final EventModel? eventModel;

  ViewYourEventScreenSuccessState(this.eventModel);
}

class SendEventRequestQueryAndStatusSuccessState
    extends ViewYourEventScreenState {
  final EventModel? eventModel;

  SendEventRequestQueryAndStatusSuccessState(this.eventModel);
}

class ViewYourEventScreenFailureState extends ViewYourEventScreenState {
  final String error;

  ViewYourEventScreenFailureState(this.error);
}

class SendEventRequestQueryAndStatusFailureState
    extends ViewYourEventScreenState {
  final String error;

  SendEventRequestQueryAndStatusFailureState(this.error);
}
