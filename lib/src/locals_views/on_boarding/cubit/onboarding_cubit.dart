import 'dart:io';

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
    emit(OnBoardingLoadingState());
    try {
      DioClientNetwork.initializeDio();
      _userDetailModel = _userDetailModel.copyWith(image: profileImages.first);

      await OnBoardingRepository.updateUserNameWithPhoto(
          _userDetailModel.firstName!,
          _userDetailModel.lastName!,
          profileImages);
      emit(OnBoardingUserNameImageSuccessState());
    } catch (e) {
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
