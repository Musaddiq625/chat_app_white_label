part of 'notification_screen_cubit.dart';

@immutable
sealed class NotificationScreenState {}

class NotificationScreenInitial extends NotificationScreenState {}

class NotificationScreenLoadingState extends NotificationScreenState {}


class NotificationSuccessState extends NotificationScreenState {
  final NotificationListingWrapper notificationListingWrapper;

  NotificationSuccessState(this.notificationListingWrapper);
}


class NotificationScreenFailureState extends NotificationScreenState {
  final String error;

  NotificationScreenFailureState(this.error);
}