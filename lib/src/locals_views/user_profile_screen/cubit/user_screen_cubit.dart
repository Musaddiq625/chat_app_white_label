import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';
import 'package:chat_app_white_label/src/network/repositories/event_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/foundation.dart';

part 'user_screen_state.dart';

class UserScreenCubit extends Cubit<UserScreenState> {
  UserScreenCubit() : super(UserScreenInitial());

  UserModel userModel = UserModel();
  List<UserModel> userModelList = [];

  void initializeUserData(List<UserModel> user) => userModelList = user;

  Future<void> fetchUserData(String id) async {
    emit(UserScreenLoadingState());
    // try {
      var resp = await AuthRepository.fetchUserData(id);
      LoggerUtil.logs("Fetch User data by Id${resp.toJson()}");
      emit(UserScreenSuccessState(resp.data));
    // } catch (e) {
    //   emit(UserScreenFailureState(e.toString()));
    // }
  }

}
