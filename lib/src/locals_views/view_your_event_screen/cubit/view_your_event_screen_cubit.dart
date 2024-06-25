import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/event_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/foundation.dart';

part 'view_your_event_screen_state.dart';

class ViewYourEventScreenCubit extends Cubit<ViewYourEventScreenState> {
  ViewYourEventScreenCubit() : super(ViewYourEventScreenInitial());

  UserModel userModel = UserModel();
  EventModel eventModel = EventModel();
  EventRequest eventRequest = EventRequest();

  void initializeUserData(UserModel user) => userModel = user;

  void initializeEventData(EventModel event) => eventModel = event;

  Future<void> viewOwnEventDataById(String id) async {
    emit(ViewYourEventScreenLoadingState());
    try {
      var resp = await EventRepository.viewOwnEventById(id);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(ViewYourEventScreenSuccessState(resp.data?.first));
    } catch (e) {
      emit(ViewYourEventScreenFailureState(e.toString()));
    }
  }

  Future<void> eventVisibilityById(String id,bool isVisibility) async {
    emit(EventVisibilityLoadingState());
    try {
      var resp = await EventRepository.eventVisibilityById(id,isVisibility);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJsonSingleData()}");
      emit(EventVisibilitySuccessState(resp.data2));
    } catch (e) {
      emit(EventVisibilityFailureState(e.toString()));
    }
  }

  Future<void> replyQueryById(String eventId,String id,String requestStatus,Query query) async {
    emit(SendEventRequestQueryAndStatusLoadingState());
    try {
      var resp = await EventRepository.sendEventRequestQueryAndStatus(eventId,id,requestStatus,query);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(SendEventRequestQueryAndStatusSuccessState(resp.data));
    } catch (e) {
      emit(SendEventRequestQueryAndStatusFailureState(e.toString()));
    }
  }


  Future<void> sendEventFavById(String eventId, bool fav) async {
    emit(ViewEventFavRequestLoadingState());
    try {
      var resp = await EventRepository.sendEventFavById(eventId, fav);
      LoggerUtil.logs(" Event data by favourite${resp.toJson()}");
      emit(ViewEventFavSuccessState(resp.data));
    } catch (e) {
      emit(ViewEventFavRequestFailureState(e.toString()));
    }
  }





  addQuery(Query queryReply) {
    eventRequest = eventRequest.copyWith(query: queryReply);
  }
}
