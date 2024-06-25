part of 'view_your_event_screen_cubit.dart';

@immutable
sealed class ViewYourEventScreenState {}

class ViewYourEventScreenInitial extends ViewYourEventScreenState {}

class ViewYourEventScreenLoadingState extends ViewYourEventScreenState {}

class EventVisibilityLoadingState extends ViewYourEventScreenState {}

class ViewEventFavRequestLoadingState extends ViewYourEventScreenState {}

class ViewEventFavSuccessState extends ViewYourEventScreenState {
  final EventModel? eventModel;

  ViewEventFavSuccessState(this.eventModel);
}


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

class EventVisibilitySuccessState extends ViewYourEventScreenState {
  final EventModel? eventModel;

  EventVisibilitySuccessState(this.eventModel);
}

class ViewYourEventScreenFailureState extends ViewYourEventScreenState {
  final String error;

  ViewYourEventScreenFailureState(this.error);
}

class EventVisibilityFailureState extends ViewYourEventScreenState {
  final String error;

  EventVisibilityFailureState(this.error);
}


class ViewEventFavRequestFailureState extends ViewYourEventScreenState {
  final String error;

  ViewEventFavRequestFailureState(this.error);
}


class SendEventRequestQueryAndStatusFailureState
    extends ViewYourEventScreenState {
  final String error;

  SendEventRequestQueryAndStatusFailureState(this.error);
}
