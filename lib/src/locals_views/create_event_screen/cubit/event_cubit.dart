import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/get_filters_data_model.dart';
import 'package:chat_app_white_label/src/models/ticket_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/filters_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/ticket_model_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repositories/auth_repository.dart';
import '../../../network/repositories/event_repository.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  UserModel userModel = UserModel();
  EventModel eventModel = EventModel();
  EventRequest eventRequestModel = EventRequest();
  List<EventModel> eventModelList = [];
  List<EventModel> searchEventModelList = [];
  EventResponseWrapper eventResponseWrapper = EventResponseWrapper();
  EventResponseWrapper searchEventResponseWrapper = EventResponseWrapper();
  FiltersListModel filtersListModel = FiltersListModel();

  // List<EventModel> eventModelList = EventModel();
  Venue venue = Venue();
  Query query = Query();
  Pricing? pricing;

  String? selectedDateFilter;
  List<String>? selectedCategories;
  bool? isFreeValue ;
  bool? isFilteredApply ;
  String? isFree;

  void initializeUserData(UserModel user) => userModel = user;

  void initializeEventData(EventModel event) => eventModel = event;

  void initializeEventListData(List<EventModel> event) =>
      eventModelList = event;

  void initializeEventWrapperData(EventResponseWrapper event) =>
      eventResponseWrapper = event;
  void initializeSearchEventWrapperData(EventResponseWrapper event) =>
      searchEventResponseWrapper = event;

  void initializeFiltersListModel(FiltersListModel filtersList) =>
      filtersListModel = filtersList;

  Future<void> createEventData(EventModel eventData) async {
    emit(EventLoadingState());
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
      eventModel = eventModel.copyWith(type: "event");
      var resp = await EventRepository.createEvent(eventModel);
      emit(CreateEventSuccessState(resp.data));
      LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(CreateEventFailureState(e.toString()));
    }
  }


  Future<void> updateFcm(String fcm,String deviceId) async {
    emit(UpdateFcmTokenLoadingState());

    try {
      // var resp =
      await AuthRepository.updateFCM(fcm,deviceId);
      // print("Fcm token ${fcmToken}");
      emit(UpdateFcmTokenSuccessState());
    } catch (error) {
      emit(UpdateFcmTokenFailureState(error.toString()));
      LoggerUtil.logs("General Error: $error");
    }
  }

  Future<void> fetchEventDataByKeys(String pageValue) async {
    emit(EventFetchLoadingState());
    // try {
    var resp = await EventRepository.fetchEventByKeys(pageValue);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(EventFetchSuccessState(resp, resp.data2));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }

  Future<void> fetchEventDataByKeysPagination(String pageValue) async {
    // emit(EventFetchLoadingState());
    // try {
    var resp = await EventRepository.fetchEventByKeys(pageValue);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(EventFetchSuccessState(resp, resp.data2));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }
Future<void> searchEventDataByKeys(String pageValue,String value) async {
    emit(SearchEventFetchLoadingState());
    // try {
    var resp = await EventRepository.searchEvent(pageValue, value);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(SearchEventFetchSuccessState(resp, resp.data2));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }
  Future<void> searchEventDataByNewPageValueKeys(String pageValue,String value) async {
    emit(EventFetchPaginationSearchLoadingState());
    // try {
    var resp = await EventRepository.searchEvent(pageValue, value);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(EventFetchPaginationSearchSuccessState(resp, resp.data2));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }

  Future<void> sendEventFilters(String pageValue,String? startDate,String? endDate,String? dateFilter,List<String>categories, bool? isFree) async {
    emit(EventFiltersLoadingState());
    // try {
    var resp = await FilterRepository.sendFilters(pageValue,startDate, endDate,dateFilter,categories,isFree);
    LoggerUtil.logs(" Event data by favourite${resp.toJson()}");
    emit(EventFiltersSuccessState(resp, resp.data2));
    // } catch (e) {
    //   emit(EventFiltersFailureState(e.toString()));
    // }
  }

  Future<void> getFilterCategories() async {
    emit(GetFiltersDataLoadingState());
    try {
      var resp = await FilterRepository.getFilters();
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(GetFiltersDataSuccessState(resp.filterListModel));
    } catch (e) {
      emit(GetFiltersDataFailureState(e.toString()));
    }
  }

  Future<void> eventReport(String id) async {
    emit(EventReportLoadingState());
    // try {
    var resp = await EventRepository.evenReport(id);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(EventReportSuccessState(resp.data));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }

  Future<void> eventDisLike(String id) async {
    emit(EventDisLikeLoadingState());
    // try {
    var resp = await EventRepository.evenDisLike(id);
    LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
    emit(EventDisLikeSuccessState(resp.data));
    // } catch (e) {
    //   emit(EventFetchFailureState(e.toString()));
    // }
  }

  Future<void> sendEventFavById(String eventId, bool fav) async {
    emit(EventFavRequestLoadingState());
    try {
      var resp = await EventRepository.sendEventFavById(eventId, fav);
      LoggerUtil.logs(" Event data by favourite${resp.toJson()}");
      emit(EventFavSuccessState(resp.data));
    } catch (e) {
      emit(EventFavRequestFailureState(e.toString()));
    }
  }



  Future<void> fetchEventDataById(String id) async {
    emit(EventFetchByIdLoadingState());
    // try {
    var resp = await EventRepository.fetchEventById(id);
    LoggerUtil.logs("Fetch Event data by Id${resp.toJson()}");
    emit(EventFetchByIdSuccessState(resp.data?.first));
    //  } catch (e) {
    //  emit(EventFetchByIdFailureState(e.toString()));
    //}
  }

  Future<void> sendEventRequest(
      String eventId, EventRequest eventRequest) async {
    emit(SendEventRequestLoadingState());
    try {
      var resp =
          await EventRepository.sendEventJoinRequest(eventId, eventRequest);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(SendEventRequestSuccessState(resp.data));
    } catch (e) {
      emit(SendEventRequestFailureState(e.toString()));
    }
  }

  Future<void> sendGroupJoinRequest(
      String eventId,String requestStatus ,EventRequest eventRequest) async {
    emit(SendEventRequestLoadingState());
    try {
      var resp =
          await EventRepository.sendGroupJoinRequest(eventId,requestStatus,eventRequest);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(SendEventRequestSuccessState(resp.data));
    } catch (e) {
      emit(SendEventRequestFailureState(e.toString()));
    }
  }

  Future<void> buyTicketRequest(TicketModel ticketModel) async {
    emit(BuyTicketRequestLoadingState());
    try {
      var resp = await EventRepository.buyTicketRequest(ticketModel);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(BuyTicketRequestSuccessState(resp));
    } catch (e) {
      emit(BuyTicketRequestFailureState(e.toString()));
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
    query = query.copyWith(question: queryQuest, answer: "");
  }

  addEventRequestAnswers(List<EventQuestions> eventQuestions) {
    eventRequestModel =
        eventRequestModel.copyWith(eventQuestions: eventQuestions);
  }
}
