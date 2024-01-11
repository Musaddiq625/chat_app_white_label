import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/shareprefrence_constants.dart';
import 'package:chat_app_white_label/src/models/user.dart';
import 'package:chat_app_white_label/src/utils/shared_prefrence_utils.dart';
import 'package:flutter/material.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  String? phoneNumber = '923323333333' ;
  String? fcm;
  UserMoodel? user;

  Future<void> setPhoneNumber(String number) async {
    phoneNumber = number;
    emit(SetPhoneNumberState());
    await getIt<SharedPreferencesUtil>()
        .setString(SharedPreferenceConstants.phoneNumber, phoneNumber);
  }

  Future<void> setUser(UserMoodel userData) async {
    user = userData;
    emit(SetUserState());
    setPhoneNumber(userData.id ?? '');
  }

  Future<void> setFcm(String fcmToken) async {
    fcm = fcmToken;
    emit(SetFcmState());
  }
}
