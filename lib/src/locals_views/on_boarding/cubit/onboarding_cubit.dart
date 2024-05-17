import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/wrappers/more_about_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wrappers/interest_response_wrapper.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserModel userModel = UserModel();
  MoreAboutWrapper moreAboutWrapper = MoreAboutWrapper();
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();

  void initializeUserData(UserModel user) => userModel = user;

  void initializeMoreAboutData(MoreAboutWrapper moreAbout) =>
      moreAboutWrapper = moreAbout;

  void initializeInterestData(InterestResponseWrapper interest) =>
      interestWrapper = interest;

  void updateUserName(String firstName, String lastName) {
    userModel = userModel.copyWith(firstName: firstName, lastName: lastName);
  }

  String getUserName() {
    return "${userModel.firstName} ${userModel.lastName}";
  }

  void setDobValues(String? dob) {
    userModel = userModel.copyWith(dateOfBirth: dob);
  }

  void setAboutMeValues(String? aboutMe) {
    userModel = userModel.copyWith(aboutMe: aboutMe);
  }

  void setGenderValues(String? gender) {
    // userModel?.gender = gender;
    userModel = userModel.copyWith(gender: gender);
  }

  void setAboutYou(String? bio, SocialLink socialLink, MoreAbout moreAbout) {
    userModel = userModel.copyWith(
        bio: bio, socialLink: socialLink, moreAbout: moreAbout);
  }

  void setInterest(Interest interest) {
    userModel = userModel.copyWith(interest: interest);
  }

  Future<void> uploadUserPhoto(List<String> profileImages) async {
    userModel = userModel.copyWith(userPhotos: profileImages);
  }

  userDetailDobToGenderStep(
      String userId, String dateOfBirth, String aboutMe, String gender) async {
    emit(OnBoardingUserDobToGenderLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserDobToGender(
          userId, dateOfBirth, aboutMe, gender);
      emit(OnBoardingDobToGenderSuccessState(resp.data));
      // LoggerUtil.logs(resp);
    } catch (e) {
      emit(OnBoardingDobToGenderFailureState(e.toString()));
    }
  }

  userDetailAboutYouToInterestStep(String userId, String bio,
      SocialLink? socialLink, MoreAbout? moreAbout, Interest? interest, bool? isProfileCompleted ) async {
    emit(OnBoardingUserAboutYouToInterestLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserAboutYouToInterest(
          userId, bio, socialLink, moreAbout, interest,isProfileCompleted);
      emit(OnBoardingAboutYouToInterestSuccessState(resp.data));
      print("resp data ${resp.toJson()}");
    } catch (e) {
      emit(OnBoardingAboutYouToInterestFailureState(e.toString()));
    }
  }

  Future<void> updateUserPhoto(List<String> profileImages) async {
    emit(OnBoardingUserNameImageLoadingState());
    try {
      // userModel = userModel.copyWith(image: profileImages.first);
      userModel = userModel.copyWith(userPhotos: profileImages);

      var resp = await OnBoardingRepository.updateUserNameWithPhoto(
          userModel.id, userModel.firstName, userModel.lastName, profileImages);
      emit(OnBoardingUserNameImageSuccessState(resp.data));
    } catch (e) {
      emit(OnBoardingUserNameImageFailureState(e.toString()));
    }
  }

  Future<void> getMoreAboutData() async {
    // emit(OnBoardingUserLoadingState());
    try {
      var resp = await OnBoardingRepository.getMoreAboutData();
      emit(OnBoardingMoreAboutSuccess(resp));
      // LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(OnBoardingMoreAboutFailureState(e.toString()));
    }
  }

  Future<void> getInterestData() async {
    // emit(OnBoardingUserLoadingState());
    try {
      var resp = await OnBoardingRepository.getInterestData();
      emit(OnBoardingInterestSuccess(resp));
      // LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(OnBoardingInterestFailureState(e.toString()));
    }
  }
}
