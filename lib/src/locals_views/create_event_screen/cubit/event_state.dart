part of 'event_cubit.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoadingState extends EventState {}


class EventFetchLoadingState extends EventState {}
class SearchEventFetchLoadingState extends EventState {}
class EventFetchPaginationSearchLoadingState extends EventState {}
class UpdateFcmTokenSuccessState extends EventState {}
class GetFiltersDataLoadingState extends EventState {}

class EventFetchByIdLoadingState extends EventState {}

class SendEventRequestLoadingState extends EventState {}

class EventReportLoadingState extends EventState {}

class EventDisLikeLoadingState extends EventState {}
class EventFiltersLoadingState extends EventState {}

class BuyTicketRequestLoadingState extends EventState {}

class EventFavRequestLoadingState extends EventState {}
class UpdateFcmTokenLoadingState extends EventState {}

class CreateEventSuccessState extends EventState {
  final EventModel? eventModel;

  CreateEventSuccessState(this.eventModel);
}
class EventFiltersSuccessState extends EventState {
  final EventResponseWrapper? eventModelWrapper;
  final List<EventModel>? eventModel;
  EventFiltersSuccessState(this.eventModelWrapper, this.eventModel);
}

class EventFavSuccessState extends EventState {
  final EventModel? eventModel;

  EventFavSuccessState(this.eventModel);
}
class GetFiltersDataSuccessState extends EventState {
  final FiltersListModel? getFiltersDataModel;

  GetFiltersDataSuccessState(this.getFiltersDataModel);
}

class EventReportSuccessState extends EventState {
  final EventModel? eventModel;

  EventReportSuccessState(this.eventModel);
}

class EventDisLikeSuccessState extends EventState {
  final EventModel? eventModel;

  EventDisLikeSuccessState(this.eventModel);
}

class EventFetchByIdSuccessState extends EventState {
  final EventModel? eventModel;

  EventFetchByIdSuccessState(this.eventModel);
}

class EventFetchSuccessState extends EventState {
  final EventResponseWrapper? eventModelWrapper;
  final List<EventModel>? eventModel;

  EventFetchSuccessState(this.eventModelWrapper, this.eventModel);
}

class SearchEventFetchSuccessState extends EventState {
  final EventResponseWrapper? eventModelWrapper;
  final List<EventModel>? eventModel;

  SearchEventFetchSuccessState(this.eventModelWrapper, this.eventModel);
}

class EventFetchPaginationSearchSuccessState extends EventState {
  final EventResponseWrapper? eventModelWrapper;
  final List<EventModel>? eventModel;

  EventFetchPaginationSearchSuccessState(this.eventModelWrapper, this.eventModel);
}

class SendEventRequestSuccessState extends EventState {
  final EventModel? eventModel;

  SendEventRequestSuccessState(this.eventModel);
}

class BuyTicketRequestSuccessState extends EventState {
  final TicketModelWrapper? ticketModelWrapper;

  BuyTicketRequestSuccessState(this.ticketModelWrapper);
}

class CreateEventFailureState extends EventState {
  final String error;

  CreateEventFailureState(this.error);
}

class EventFetchFailureState extends EventState {
  final String error;

  EventFetchFailureState(this.error);
}

class EventFetchByIdFailureState extends EventState {
  final String error;

  EventFetchByIdFailureState(this.error);
}

class SendEventRequestFailureState extends EventState {
  final String error;

  SendEventRequestFailureState(this.error);
}

class BuyTicketRequestFailureState extends EventState {
  final String error;

  BuyTicketRequestFailureState(this.error);
}

class EventFavRequestFailureState extends EventState {
  final String error;

  EventFavRequestFailureState(this.error);
}

class EventReportRequestFailureState extends EventState {
  final String error;

  EventReportRequestFailureState(this.error);
}
class EventFiltersFailureState extends EventState {
  final String error;

  EventFiltersFailureState(this.error);
}

class EventDisLikeRequestFailureState extends EventState {
  final String error;

  EventDisLikeRequestFailureState(this.error);
}

class GetFiltersDataFailureState extends EventState {
  final String error;

  GetFiltersDataFailureState (this.error);
}

class UpdateFcmTokenFailureState extends EventState {
  final String error;

  UpdateFcmTokenFailureState(this.error);
}
