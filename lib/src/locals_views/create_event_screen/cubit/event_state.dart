part of 'event_cubit.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoadingState extends EventState {}

class EventFetchLoadingState extends EventState {}

class EventFetchByIdLoadingState extends EventState {}

class SendEventRequestLoadingState extends EventState {}

class BuyTicketRequestLoadingState extends EventState {}

class CreateEventSuccessState extends EventState {
  final EventModel? eventModel;

  CreateEventSuccessState(this.eventModel);
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
