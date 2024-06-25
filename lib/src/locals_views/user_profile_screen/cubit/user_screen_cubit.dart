import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/all_groups_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/events_going_to_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/friend_list_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:flutter/foundation.dart';

import '../../../models/event_model.dart';
import '../../../wrappers/logout_wrapper.dart';

part 'user_screen_state.dart';

class UserScreenCubit extends Cubit<UserScreenState> {
  UserScreenCubit() : super(UserScreenInitial());

  UserModel userModel = UserModel();
  List<UserModel> userModelList = [];
  List<EventModel> eventModelList = [];
  EventResponseWrapper eventResponseWrapper = EventResponseWrapper();
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();
  FriendListResponseWrapper friendListResponseWrapper =
      FriendListResponseWrapper();
  EventsGoingToResponseWrapper eventsGoingToResponseWrapper =
      EventsGoingToResponseWrapper();
  AllGroupsWrapper allGroupsWrapper = AllGroupsWrapper();
  MoreAbout moreAbout = MoreAbout();

  void initializeUserData(List<UserModel> user) => userModelList = user;

  void initializeFriendListResponseWrapperData(
          FriendListResponseWrapper friendListResponse) =>
      friendListResponseWrapper = friendListResponse;

  void initializeInterestData(InterestResponseWrapper interest) =>
      interestWrapper = interest;

  void initializeEventWrapperData(EventResponseWrapper event) =>
      eventResponseWrapper = event;

  void initializeEventsGoingToResponseWrapperData(
          EventsGoingToResponseWrapper eventsGoingToResponse) =>
      eventsGoingToResponseWrapper = eventsGoingToResponse;

  void initializeAllGroupsResponseWrapperData(
          AllGroupsWrapper allGroupsWrapperResponse) =>
      allGroupsWrapper = allGroupsWrapperResponse;

  Future<void> fetchUserData(String id) async {
    emit(UserScreenLoadingState());
    try {
      var resp = await AuthRepository.fetchUserData(id);

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(UserScreenSuccessState(resp.data));
      } else {
        emit(UserScreenFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(UserScreenFailureState(e.toString()));
    }
  }

  Future<void> fetchEventYouGoingToData() async {
    emit(FetchEventsGoingToLoadingState());
    try {
      var resp = await AuthRepository.fetchEventYouGoingToData();

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch EventsYouAreGoingToResponse Data${resp.toJson()}");
        emit(FetchEventsGoingToSuccessState(resp));
      } else {
        emit(FetchEventsGoingToFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(FetchEventsGoingToFailureState(e.toString()));
    }
  }
  Future<void> logoutUser() async {
    emit(LogoutUserLoadingState());
    try {
      var resp = await AuthRepository.userLogout();

      if (resp.code == 200) {

        emit(LogoutUserSuccessState(resp));
      } else {
        emit(LogoutFailureState(resp.message ?? ""));
      }
    } catch (e) {
      emit(LogoutFailureState(e.toString()));
    }
  }

  Future<void> fetchGroupsData() async {
    emit(FetchGroupsToLoadingState());
    try {
      var resp = await AuthRepository.fetchGroupsData();

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch GroupsGoingToResponse Data${resp.toJson()}");
        emit(FetchGroupsToSuccessState(resp));
      } else {
        emit(FetchGroupsToFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(FetchGroupsToFailureState(e.toString()));
    }
  }

  Future<void> fetchMyEventsData() async {
    // emit(FetchMyEventsDataLoadingState());
    // try {
      var resp = await AuthRepository.fetchMyEventsData();

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch EventsGoingToResponse-- Data${resp.toJson()}");
        emit(FetchMyEventsDataSuccessState(resp, resp.data2));
      } else {
        emit(FetchMyEventsDataFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    // } catch (e) {
    //   emit(FetchMyEventsDataFailureState(e.toString()));
    // }
  }

  Future<void> fetchMyFriendListData() async {
    emit(FetchMyFriendListDataLoadingState());
    try {
      var resp = await AuthRepository.fetchMyFriendListData();

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch fetchMyFriendListData Data${resp.toJson()}");
        emit(FetchMyFriendListSuccessState(resp));
      } else {
        emit(FetchMyFriendListFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(FetchMyFriendListFailureState(e.toString()));
    }
  }




  Future<void> updateUserData(String id, UserModel userModel) async {
    emit(UpdateUserScreenLoadingState());
    try {
      var resp = await AuthRepository.updateUserData(id, userModel);
      LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
      emit(UpdateUserScreenSuccessState(resp.data2));
    } catch (e) {
      emit(UpdateUserScreenFailureState(e.toString()));
    }
  }

  Future<void> getInterestData() async {
    // emit(OnBoardingUserLoadingState());
    try {
      var resp = await OnBoardingRepository.getInterestData();
      emit(InterestSuccessState(resp));
      // LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(InterestFailureState(e.toString()));
    }
  }

  void updateUserFirstName(String firstName) {
    userModelList.first = userModelList.first.copyWith(firstName: firstName);
  }

  void updateUserLastName(String lastName) {
    userModelList.first = userModelList.first.copyWith(lastName: lastName);
  }

  void updatePhoneNumber(String phoneNumber) {
    userModelList.first =
        userModelList.first.copyWith(phoneNumber: phoneNumber);
  }

  void updateGender(String gender) {
    userModelList.first = userModelList.first.copyWith(gender: gender);
  }

  void updateDob(String dob) {
    userModelList.first = userModelList.first.copyWith(dateOfBirth: dob);
  }

  void updateBio(String bio) {
    userModelList.first = userModelList.first.copyWith(bio: bio);
  }

  Future<void> uploadUserPhoto(List<String> profileImages) async {
    userModelList.first =
        userModelList.first.copyWith(userPhotos: profileImages);
  }

  void updateInterest(Interest interest) {
    userModelList.first = userModelList.first.copyWith(interest: interest);
  }

  void updateMoreAboutYou(MoreAbout moreAbout) {
    userModelList.first = userModelList.first.copyWith(moreAbout: moreAbout);
  }

  void updateSocialLinks(SocialLink socialLink) {
    userModelList.first = userModelList.first.copyWith(socialLink: socialLink);
  }
}
