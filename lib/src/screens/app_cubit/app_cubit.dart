import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/shareprefrence_constants.dart';
import 'package:chat_app_white_label/src/utils/shared_prefrence_utils.dart';
import 'package:flutter/material.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  String? token;
  String? fcm;

  Future<void> setToken(String userToken) async {
    token = userToken;
    emit(SetTokenState());
    await getIt<SharedPreferencesUtil>()
        .setString(SharedPreferenceConstants.token, userToken);
  }

  Future<void> setFcm(String fcmToken) async {
    fcm = fcmToken;
    emit(SetFcmState());
  }
}
