import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/event_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/share_group_wrapper.dart';
import 'package:flutter/foundation.dart';

part 'view_your_group_screen_state.dart';

class ViewYourGroupScreenCubit extends Cubit<ViewYourGroupScreenState> {
  ViewYourGroupScreenCubit() : super(ViewYourGroupScreenInitial());

  UserModel userModel = UserModel();
  EventModel eventModel = EventModel();
  EventRequest eventRequest = EventRequest();

  void initializeUserData(UserModel user) => userModel = user;

  void initializeEventData(EventModel event) => eventModel = event;

  Future<void> viewOwnEventDataById(String id) async {
    emit(ViewYourGroupScreenLoadingState());
    try {
      var resp = await EventRepository.viewOwnEventById(id);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(ViewYourGroupScreenSuccessState(resp.data?.first));
    } catch (e) {
      emit(ViewYourGroupScreenFailureState(e.toString()));
    }
  }

  Future<void> eventVisibilityById(String id,bool isVisibility) async {
    emit(GroupVisibilityLoadingState());
    try {
      var resp = await EventRepository.eventVisibilityById(id,isVisibility);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJsonSingleData()}");
      emit(GroupVisibilitySuccessState(resp.data2));
    } catch (e) {
      emit(GroupVisibilityFailureState(e.toString()));
    }
  }

  Future<void> shareGroup(String id,String type,String inviteId) async {
    emit(ShareGroupLoadingState());
    try {
      var resp = await EventRepository.shareGroup(id,type,inviteId);
      emit(ShareGroupSuccessState(resp));
    } catch (e) {
      emit(ShareGroupFailureState(e.toString()));
    }
  }

  Future<void> replyQueryById(String eventId,String id,String requestStatus,Query query) async {
    emit(SendGroupRequestQueryAndStatusLoadingState());
    try {
      var resp = await EventRepository.sendEventRequestQueryAndStatus(eventId,id,requestStatus,query);
      LoggerUtil.logs("Fetch Event data by keys${resp.toJson()}");
      emit(SendGroupRequestQueryAndStatusSuccessState(resp.data));
    } catch (e) {
      emit(SendGroupRequestQueryAndStatusFailureState(e.toString()));
    }
  }





  addQuery(Query queryReply) {
    eventRequest = eventRequest.copyWith(query: queryReply);
  }
}
