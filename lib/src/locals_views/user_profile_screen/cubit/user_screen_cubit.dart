import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:flutter/foundation.dart';

part 'user_screen_state.dart';

class UserScreenCubit extends Cubit<UserScreenState> {
  UserScreenCubit() : super(UserScreenInitial());

  UserModel userModel = UserModel();
  List<UserModel> userModelList = [];
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();

  void initializeUserData(List<UserModel> user) => userModelList = user;

  void initializeInterestData(InterestResponseWrapper interest) =>
      interestWrapper = interest;

  Future<void> fetchUserData(String id) async {
    emit(UserScreenLoadingState());
    try {
      var resp = await AuthRepository.fetchUserData(id);

      if(resp.code == 200){
        LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
        emit(UserScreenSuccessState(resp.data));
      }
      else{
        emit(UserScreenFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }

    } catch (e) {
      emit(UserScreenFailureState(e.toString()));
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
