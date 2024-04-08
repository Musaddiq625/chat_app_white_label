import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_detail_model.dart';
import 'package:flutter/material.dart';
import '../../../models/OnBoardingNewModel.dart';
import '../../../utils/firebase_utils.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserDetailModel? userDetailModel;

  userDetailFirstStep(String? selectedImage) async {

    emit(OnBoardingLoadingState());
    try {
      userDetailModel?.profileImage = selectedImage;
      await FirebaseUtils.updateUserStepOne(userDetailModel);
      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }

  userDetailSecondStep(String selectedImage) async {
    emit(OnBoardingLoadingState());
    try {
      await FirebaseUtils.updateUserStepTwo(userDetailModel
          // dateOfBirth, aboutMe, gender, bio,
          // moreAboutMeModel, socialLinkModel, hobbies, creativity
      );


      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
