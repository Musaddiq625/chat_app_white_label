import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/all_groups_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/events_going_to_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/friend_list_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/userEventGroup_wrapper.dart';
import 'package:flutter/foundation.dart';

import '../../../models/event_model.dart';
import '../../../wrappers/logout_wrapper.dart';
import '../../../wrappers/send_friend_request_wrapper.dart';

part 'view_user_screen_state.dart';

class ViewUserScreenCubit extends Cubit<ViewUserScreenState> {
  ViewUserScreenCubit() : super(ViewUserScreenInitial());

  UserModel userModel = UserModel();
  List<UserModel> userModelList = [];
  List<EventModel> eventModelList = [];
  EventResponseWrapper eventResponseWrapper = EventResponseWrapper();
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();
  FriendListResponseWrapper friendListResponseWrapper =
      FriendListResponseWrapper();
  UserEventGroupWrapper eventGroupWrapper =
  UserEventGroupWrapper();
  UserEventGroupWrapper userEventGroupWrapper =
  UserEventGroupWrapper();
  AllGroupsWrapper allGroupsWrapper = AllGroupsWrapper();
  MoreAbout moreAbout = MoreAbout();

  void initializeUserData(List<UserModel> user) => userModelList = user;

  void initializeUserEventGroupData(UserEventGroupWrapper userEvent) =>
      eventGroupWrapper = userEvent;

  void initializeAllUserEventGroupData(UserEventGroupWrapper userEvent) =>
      userEventGroupWrapper = userEvent;




  Future<void> fetchUserData(String id) async {
    emit(ViewUserScreenLoadingState());
    try {
      var resp = await AuthRepository.fetchUserData(id);

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(ViewUserScreenSuccessState(resp.data));
      } else {
        emit(ViewUserScreenFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(ViewUserScreenFailureState(e.toString()));
    }
  }

  Future<void> fetchEventGroupData(String id) async {
    emit(ViewUserEventGroupLoadingState());
    try {
      var resp = await AuthRepository.fetchUserEventGroupData(id);

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(ViewUserEventGroupSuccessState(resp));
      } else {
        emit(ViewUserEventGroupFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(ViewUserEventGroupFailureState(e.toString()));
    }
  }
  Future<void> fetchAllEventGroupData(String id,String eventType) async {
    emit(ViewUserAllEventGroupLoadingState());
    try {
      var resp = await AuthRepository.fetchAllUserEventGroupData(id,eventType);

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(ViewUserAllEventGroupSuccessState(resp));
      } else {
        emit(ViewUserAllEventGroupFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(ViewUserAllEventGroupFailureState(e.toString()));
    }
  }

Future<void> sendFriendRequest(String id,String requestType) async {
    emit(SendFriendRequestLoadingState());
    try {
      var resp = await AuthRepository.sendFriendRequest(id,requestType);

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(SendFriendRequestSuccessState(resp));
      } else {
        emit(SendFriendRequestFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(SendFriendRequestFailureState(e.toString()));
    }
  }

}
