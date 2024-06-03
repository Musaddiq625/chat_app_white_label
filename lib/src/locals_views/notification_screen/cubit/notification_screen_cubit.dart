import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';

import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/all_groups_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/events_going_to_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/notification_listing_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../models/event_model.dart';

part 'notification_screen_state.dart';

class NotificationScreenCubit extends Cubit<NotificationScreenState> {
  NotificationScreenCubit() : super(NotificationScreenInitial());

  UserModel userModel = UserModel();
  List<UserModel> userModelList = [];
  List<EventModel> eventModelList = [];
  EventResponseWrapper eventResponseWrapper = EventResponseWrapper();
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();
  NotificationListingWrapper notificationListingWrapper = NotificationListingWrapper();
  EventsGoingToResponseWrapper eventsGoingToResponseWrapper =EventsGoingToResponseWrapper();
  AllGroupsWrapper allGroupsWrapper =AllGroupsWrapper();
  MoreAbout moreAbout = MoreAbout();

  void initializeUserData(List<UserModel> user) => userModelList = user;

  void initializeInterestData(InterestResponseWrapper interest) =>
      interestWrapper = interest;

  void initializeNotificationData(NotificationListingWrapper notificationData) =>
      notificationListingWrapper = notificationData;


  void initializeEventWrapperData(EventResponseWrapper event) =>
      eventResponseWrapper = event;

  void initializeEventsGoingToResponseWrapperData(EventsGoingToResponseWrapper eventsGoingToResponse) =>
      eventsGoingToResponseWrapper = eventsGoingToResponse;

  void initializeAllGroupsResponseWrapperData(AllGroupsWrapper allGroupsWrapperResponse) =>
      allGroupsWrapper = allGroupsWrapperResponse;

  Future<void> fetchNotificationData() async {
    emit(NotificationScreenLoadingState());
    try {
      var resp = await AuthRepository.fetchNotificationData();

      if (resp.code == 200) {
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(NotificationSuccessState(resp));
      } else {
        emit(NotificationScreenFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (e) {
      emit(NotificationScreenFailureState(e.toString()));
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
