import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserModel userModel = UserModel();

  void initializeUserData(UserModel user) => userModel = user;

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

   void setAboutYou (String? bio, SocialLink socialLink,MoreAbout moreAbout){
    userModel= userModel.copyWith(bio:bio,socialLink: socialLink, moreAbout: moreAbout);
   }

  void setInterest (Interest interest){
    userModel= userModel.copyWith(interest:interest);
  }

  userDetailDobToGenderStep(String userId, String dateOfBirth, String aboutMe, String gender) async {
    emit(OnBoardingLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserDobToGender(
          userId, dateOfBirth, aboutMe, gender);
      emit(OnBoardingDobToGenderSuccessState(resp.data));
      // LoggerUtil.logs(resp);
    } catch (e) {
      emit(OnBoardingDobToGenderFailureState(e.toString()));
    }
  }

  userDetailAboutYouToInterestStep(String userId, String bio, SocialLink? socialLink, MoreAbout? moreAbout, Interest? interest) async {
    emit(OnBoardingLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserAboutYouToInterest(
          userId, bio, socialLink, moreAbout,interest);
      emit(OnBoardingAboutYouToInterestSuccessState(resp.data));
      // LoggerUtil.logs(resp);
    } catch (e) {
      emit(OnBoardingAboutYouToInterestFailureState(e.toString()));
    }
  }

  Future<void> updateUserPhoto(List<String> profileImages) async {
    emit(OnBoardingLoadingState());
    try {
      userModel = userModel.copyWith(image: profileImages.first);

      await OnBoardingRepository.updateUserNameWithPhoto(
          userModel.firstName!, userModel.lastName!, profileImages);
      emit(OnBoardingUserNameImageSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
