import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/more_about_me_model.dart';
import 'package:chat_app_white_label/src/models/social_link_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/firebase_utils.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  String? firstName;
  String? lastName;
  List<String>? userImages;
  String? dateOfBirth;
  String? aboutMe;
  String? gender;
  String? bio;
  SocialLinkModel? socialLinkModel;
  MoreAboutMe? moreAboutMeModel;
  List<String>? hobbies;
  List<String>? creativity;

  userDetailFirstStep(String? selectedImage) async {
    emit(OnBoardingLoadingState());
    try {
      await FirebaseUtils.updateUserStepOne(
          firstName, lastName, userImages, selectedImage);
      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }

  userDetailSecondStep(String selectedImage) async {
    emit(OnBoardingLoadingState());
    try {
      await FirebaseUtils.updateUserStepTwo(dateOfBirth, aboutMe, gender, bio,
          moreAboutMeModel, socialLinkModel, hobbies, creativity);
      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
