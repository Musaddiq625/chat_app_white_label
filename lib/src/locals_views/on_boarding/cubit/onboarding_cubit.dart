import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserModel _userDetailModel = UserModel();

  void updateUserName(String firstName, String lastName) {
    _userDetailModel =
        _userDetailModel.copyWith(firstName: firstName, lastName: lastName);
  }

  String getUserName() {
    return "${_userDetailModel.firstName} ${_userDetailModel.lastName}";
  }

  Future<void> updateUserPhoto(List<String> profileImages) async {
  void setDobValues(String? dob) {
    _userDetailModel = _userDetailModel.copyWith(dateOfBirth: dob);
  }

  void setAboutMeValues(String? aboutMe) {
    _userDetailModel = _userDetailModel.copyWith(aboutMe: aboutMe);
  }

  void setGenderValues(String? gender) {
    // userModel?.gender = gender;
    _userDetailModel = _userDetailModel.copyWith(gender: gender);
  }

  // void secondStepInputValues(String? dob,String? aboutMe,String? gender){
  //   userModel?.dateOfBirth = dob;
  //   userModel?.aboutMe = aboutMe;
  //   userModel?.gender = gender;
  // }

  userDetailSecondStep(
      String userId, String dateOfBirth, String aboutMe, String gender) async {
    emit(OnBoardingLoadingState());
    try {
      DioClientNetwork.initializeDio();
      _userDetailModel = _userDetailModel.copyWith(image: profileImages.first);

      await OnBoardingRepository.updateUserNameWithPhoto(
          _userDetailModel.firstName!,
          _userDetailModel.lastName!,
          profileImages);
      emit(OnBoardingUserNameImageSuccessState());
      var resp = await OnBoardingRepository.updateUserDobToGender(
          userId, dateOfBirth, aboutMe, gender);
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
