import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_constants.dart';
import '../../../network/repositories/event_repository.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  UserModel userModel = UserModel();
  EventModel eventModel = EventModel();
  Venue venue = Venue();
  Pricing? pricing;

  void initializeUserData(UserModel user) => userModel = user;

  void initializeEventData(EventModel event) => eventModel = event;

  Future<void> createEventData(String? userId,EventModel eventData) async {
    emit(EventLoadingState());
    try {
      eventModel = eventModel.copyWith(venue: [venue]);
      eventModel = eventModel.copyWith(pricing: pricing ?? Pricing(price: '0'));
      eventModel = eventModel.copyWith(
          userId:   userId ,
          isPublic: eventModel.isPublic ?? true,
          isApprovalRequired: eventModel.isApprovalRequired ?? true,
          isFree: pricing?.price == '0'
              ? true
              : false || pricing?.price == null
                  ? true
                  : false);
      var resp = await EventRepository.createEvent(eventModel);
      emit(CreateEventSuccessState(resp.data));
      LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(CreateEventFailureState(e.toString()));
    }
  }

  addTitle(String title) {
    eventModel = eventModel.copyWith(title: title);
  }

  addDescription(String description) {
    eventModel = eventModel.copyWith(description: description);
  }

  addImage(String? image) {
    eventModel = eventModel.copyWith(images: [image ?? ""]);
  }

  addStartDate(String? startDate) {
    venue = venue.copyWith(startDatetime: startDate);
  }

  addEndDate(String? endDate) {
    venue = venue.copyWith(
        endDatetime: endDate, capacity: venue.capacity ?? "Unlimited");
  }

  addLocation(String location) {
    venue = venue.copyWith(location: location);
  }

  addPrice(String? price) {
    LoggerUtil.logs("PriceValue ${price}");
    pricing = Pricing();
    pricing = pricing!.copyWith(price: price ?? "0");
    eventModel = eventModel.copyWith(
      isFree: price == "0" ? true : false,
    );
  }

  addCapacity(String? capacity) {
    venue = venue.copyWith(capacity: capacity ?? "Unlimited");
  }

  addVisibility(bool isVisibility) {
    eventModel = eventModel.copyWith(isPublic: isVisibility);
  }

  addRequiredGuestApproval(bool isRequired) {
    eventModel = eventModel.copyWith(isApprovalRequired: isRequired);
  }

  addQuestions(List<Question> questions) {
    eventModel = eventModel.copyWith(question: questions);
  }
}
