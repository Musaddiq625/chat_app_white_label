import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_detail_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';

import '../../../utils/firebase_utils.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserDetailModel? userDetailModel;

  UserModel? userModel;

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

  void setDobValues(String? dob){
    userModel?.dateOfBirth = dob;
  }
  void setAboutMeValues(String? aboutMe){
    userModel?.aboutMe = aboutMe;
  }
  void setGenderValues(String? gender){
    userModel?.gender = gender;
  }


  // void secondStepInputValues(String? dob,String? aboutMe,String? gender){
  //   userModel?.dateOfBirth = dob;
  //   userModel?.aboutMe = aboutMe;
  //   userModel?.gender = gender;
  // }

  userDetailSecondStep(
      String dateOfBirth, String aboutMe, String gender) async {
    emit(OnBoardingLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserDobToGender(
          dateOfBirth, aboutMe, gender);
      // await FirebaseUtils.updateUserStepTwo(userDetailModel
      //     // dateOfBirth, aboutMe, gender, bio,
      //     // moreAboutMeModel, socialLinkModel, hobbies, creativity
      //     );
      emit(OnBoardingUserDataSecondStepSuccessState());
      LoggerUtil.logs(resp);
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
