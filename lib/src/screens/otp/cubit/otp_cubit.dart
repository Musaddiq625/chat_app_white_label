import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../main.dart';
import '../../../utils/service/firbase_service.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  OTPCubit() : super(OTPInitial()) {}

  otpUser(
    String verificationId,
    String otpCode,
    String phoneNumber,
  ) async {
    emit(OTPLoadingState());

    try {
      LoggerUtil.logs("Verification Id $verificationId");
      // firebaseService.auth.setPersistence(Persistence.LOCAL);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      await firebaseService.auth.signInWithCredential(credential);
      final userData = await FirebaseUtils.getCurrentUser();

      if (userData != null) {
        if (userData.isProfileComplete == true) {
          emit(OTPSuccessOldUserState(userData));
        } else {
          emit(OTPSuccessNewUserState(phoneNumber));
        }
      } else {
        await FirebaseUtils.createUser(phoneNumber);
        emit(OTPSuccessNewUserState(phoneNumber));
      }
    } catch (e) {
      emit(OTPFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}
