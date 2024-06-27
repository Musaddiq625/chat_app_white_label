import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/auth_repository.dart';
import 'package:chat_app_white_label/src/network/repositories/event_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/create_update_user_bank_detail_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/earning_detail_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/share_group_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/user_bank_detail_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/with_draw_amount_wrapper.dart';
import 'package:flutter/foundation.dart';

part 'earning_screen_state.dart';

class EarningScreenCubit extends Cubit<EarningScreenState> {
  EarningScreenCubit() : super(EarningScreenInitial());

  UserModel userModel = UserModel();
  EarningData earningData = EarningData();
  List<BankDetail> bankDetails = [];


  void initializeEarningData(EarningData earningDataValue) => earningData = earningDataValue;
  void initializeBankDetailData(List<BankDetail> bankDataValue) => bankDetails = bankDataValue;

  Future<void> earningDetailData() async {
    emit(EarningScreenLoadingState());
    try {
      var resp = await AuthRepository.earningDetailsData();
      LoggerUtil.logs("Fetch earningData data${resp.toJson()}");
      emit(EarningScreenSuccessState(resp));
    } catch (e) {
      emit(EarningScreenFailureState(e.toString()));
    }
  }
  Future<void> userBankDetailData() async {
    emit(UserBankDetailLoadingState());
    try {
      var resp = await AuthRepository.userBankDetailsData();
      LoggerUtil.logs("Fetch bankDetails data${resp.toJson()}");
      emit(UserBankDetailSuccessState(resp));
    } catch (e) {
      emit(UserBankDetailFailureState(e.toString()));
    }
  }
  Future<void> updateUserBankDetailData(String? id,String accountNumber,String accountTitle,String bankCode) async {
    emit(UpdateUserBankDetailLoadingState());
    try {
      var resp = await AuthRepository.updateUserBankDetailsData(id,accountNumber,accountTitle,bankCode);
      LoggerUtil.logs("Update bankDetails data${resp.toJson()}");
      emit(UpdateUserBankDetailSuccessState(resp));
    } catch (e) {
      emit(UpdateUserBankDetailFailureState(e.toString()));
    }
  }

  Future<void> withDrawAmountData(String? amount) async {
    emit(WithDrawAmountLoadingState());
    try {
      var resp = await AuthRepository.withDrawAmount(amount);
      LoggerUtil.logs("Update bankDetails data${resp.toJson()}");

      if(resp.code == 200){
        emit(WithDrawAmountSuccessState(resp));
      }
      else{
        emit(WithDrawAmountFailureState(resp.message.toString()));
      }
    } catch (e) {
      emit(WithDrawAmountFailureState(e.toString()));
    }
  }

}
