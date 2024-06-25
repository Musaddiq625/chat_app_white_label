part of 'view_user_screen_cubit.dart';

@immutable
sealed class ViewUserScreenState {}

class ViewUserScreenInitial extends ViewUserScreenState {}

class ViewUserScreenLoadingState extends ViewUserScreenState {}
class ViewUserEventGroupLoadingState extends ViewUserScreenState {}
class ViewUserAllEventGroupLoadingState extends ViewUserScreenState {}
class SendFriendRequestLoadingState extends ViewUserScreenState {}


class ViewUserScreenSuccessState extends ViewUserScreenState {
  final List<UserModel>? userModelList;

  ViewUserScreenSuccessState(this.userModelList);
}

class ViewUserEventGroupSuccessState extends ViewUserScreenState {
  final UserEventGroupWrapper userEventGroupWrapper;

  ViewUserEventGroupSuccessState(this.userEventGroupWrapper);
}

class ViewUserAllEventGroupSuccessState extends ViewUserScreenState {
  final UserEventGroupWrapper userEventGroupWrapper;

  ViewUserAllEventGroupSuccessState(this.userEventGroupWrapper);
}
class SendFriendRequestSuccessState extends ViewUserScreenState {
  final SendFriendRequestWrapper sendFriendRequestWrapper;

  SendFriendRequestSuccessState(this.sendFriendRequestWrapper);
}

class ViewUserScreenFailureState extends ViewUserScreenState {
  final String error;

  ViewUserScreenFailureState(this.error);
}

class SendFriendRequestFailureState extends ViewUserScreenState {
  final String error;

  SendFriendRequestFailureState(this.error);
}

class ViewUserEventGroupFailureState extends ViewUserScreenState {
  final String error;

  ViewUserEventGroupFailureState(this.error);
}

class ViewUserAllEventGroupFailureState extends ViewUserScreenState {
  final String error;

  ViewUserAllEventGroupFailureState(this.error);
}

