part of 'user_screen_cubit.dart';

@immutable
sealed class UserScreenState {}

class UserScreenInitial extends UserScreenState {}

class UserScreenLoadingState extends UserScreenState {}
class UpdateUserScreenLoadingState extends UserScreenState {}
class FetchEventsGoingToLoadingState extends UserScreenState {}
class FetchGroupsToLoadingState extends UserScreenState {}
class FetchMyEventsDataLoadingState extends UserScreenState {}

class UserScreenSuccessState extends UserScreenState {
  final List<UserModel>? userModelList;

  UserScreenSuccessState(this.userModelList);
}

class FetchEventsGoingToSuccessState extends UserScreenState {
  final EventsGoingToResponseWrapper eventsGoingToResponseWrapper;

  FetchEventsGoingToSuccessState(this.eventsGoingToResponseWrapper);
}
class FetchMyEventsDataSuccessState extends UserScreenState {
  final EventResponseWrapper? eventResponseWrapper;
  final List<EventModel>? eventModel;

  FetchMyEventsDataSuccessState(this.eventResponseWrapper,this.eventModel);
}

class FetchGroupsToSuccessState extends UserScreenState {
  final EventsGoingToResponseWrapper eventsGoingToResponseWrapper;

  FetchGroupsToSuccessState(this.eventsGoingToResponseWrapper);
}

class UpdateUserScreenSuccessState extends UserScreenState {
  final UserModel? userModel;

  UpdateUserScreenSuccessState(this.userModel);
}

class InterestSuccessState extends UserScreenState {
  final InterestResponseWrapper interestData;

  InterestSuccessState(this.interestData);
}

class UpdateUserScreenFailureState extends UserScreenState {
  final String error;

  UpdateUserScreenFailureState(this.error);
}

class UserScreenFailureState extends UserScreenState {
  final String error;

  UserScreenFailureState(this.error);
}
class FetchEventsGoingToFailureState extends UserScreenState {
  final String error;

  FetchEventsGoingToFailureState(this.error);
}

class FetchGroupsToFailureState extends UserScreenState {
  final String error;

  FetchGroupsToFailureState(this.error);
}
class FetchMyEventsDataFailureState extends UserScreenState {
  final String error;

  FetchMyEventsDataFailureState(this.error);
}


class InterestFailureState extends UserScreenState {
  final String error;

  InterestFailureState(this.error);
}
