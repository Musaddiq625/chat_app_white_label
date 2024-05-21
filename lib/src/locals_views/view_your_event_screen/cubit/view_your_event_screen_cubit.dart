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

  addQuery(Query queryReply) {
    eventRequest = eventRequest.copyWith(query: queryReply);
  }
}
