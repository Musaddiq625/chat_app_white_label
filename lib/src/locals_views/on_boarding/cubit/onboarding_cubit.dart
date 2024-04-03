import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../models/OnBoardingNewModel.dart';
import '../../../utils/firebase_utils.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  OnBoardingNewModel? onBoardingModel;

  userDetailFirstStep(String? selectedImage) async {

    emit(OnBoardingLoadingState());
    try {
      onBoardingModel?.profileImage = selectedImage;
      await FirebaseUtils.updateUserStepOne(onBoardingModel);
      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }

  userDetailSecondStep(String selectedImage) async {
    emit(OnBoardingLoadingState());
    try {
      await FirebaseUtils.updateUserStepTwo(onBoardingModel
          // dateOfBirth, aboutMe, gender, bio,
          // moreAboutMeModel, socialLinkModel, hobbies, creativity
      );


      emit(OnBoardingUserDataFirstStepSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
