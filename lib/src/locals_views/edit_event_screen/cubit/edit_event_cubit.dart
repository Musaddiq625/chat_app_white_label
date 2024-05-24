import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/ticket_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/ticket_model_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repositories/event_repository.dart';

part 'edit_event_state.dart';

class EditEventCubit extends Cubit<EditEventState> {
  EditEventCubit() : super(EventInitial());

  UserModel userModel = UserModel();
  EventModel eventModel = EventModel();
  EventRequest eventRequestModel = EventRequest();
  List<EventModel> eventModelList = [];
  EventResponseWrapper eventResponseWrapper = EventResponseWrapper();

  // List<EventModel> eventModelList = EventModel();
  Venue venue = Venue();
  Query query = Query();
  Pricing? pricing;

  void initializeUserData(UserModel user) => userModel = user;

  void initializeEventData(EventModel event) => eventModel = event;

  void initializeEventListData(List<EventModel> event) =>
      eventModelList = event;

  void initializeEventWrapperData(EventResponseWrapper event) =>
      eventResponseWrapper = event;

  Future<void> updateEventData(EventModel eventData) async {
    emit(EditEventLoadingState());
    try {
      eventModel = eventModel.copyWith(venue: [venue]);
      eventModel = eventModel.copyWith(pricing: pricing ?? Pricing(price: '0'));
      eventModel = eventModel.copyWith(
          isPublic: eventModel.isPublic ?? true,
          isApprovalRequired: eventModel.isApprovalRequired ?? true,
          isFree: pricing?.price == '0'
              ? true
              : false || pricing?.price == null
                  ? true
                  : false);
      var resp = await EventRepository.updateEvent(eventModel);
      emit(EditEventSuccessState(resp.data));
      LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(EditEventFailureState(e.toString()));
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

  addEventRequestQuery(String queryQuest) {
    query = query.copyWith(question: queryQuest,answer: "");
  }
  addEventRequestAnswers(List<EventQuestions> eventQuestions) {
    eventRequestModel =eventRequestModel.copyWith(eventQuestions: eventQuestions);
  }
}
