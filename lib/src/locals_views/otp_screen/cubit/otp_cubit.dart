import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../../../main.dart';
import '../../../network/repositories/auth_repository.dart';
import '../../../utils/service/firbase_service.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  FirebaseService firebaseService = getIt<FirebaseService>();
  UserModel? userDetailModel;

  OTPCubit() : super(OTPInitial());

  Future<void> otpUser(
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

      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (userData != null) {
        if (userData.isProfileCompleted == true) {
          if (fcmToken != null) {
            // Assuming `phoneNumber` is the UID or some unique identifier for the user
            await FirebaseUtils.addFcmToken(phoneNumber, fcmToken);
          }
          emit(OTPSuccessOldUserState(userData));
        } else {
          emit(OTPSuccessNewUserState(phoneNumber, fcmToken));
        }
      } else {
        await FirebaseUtils.createUser(phoneNumber);
        emit(OTPSuccessNewUserState(phoneNumber, fcmToken));
      }
    } catch (e) {
      emit(OTPFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }


  Future<void> verifyOtpUser(String identifier,String otp) async {
    emit(OTPLoadingState());

    try {
      var resp = await AuthRepository.verifyOtp(identifier,otp);
      // LoggerUtil.logs("userDetailModel ${userDetailModel?.toJson()}");
      emit(OTPSuccessUserState(resp.data));
      LoggerUtil.logs(resp);
    } catch (error) {
      emit(OTPFailureState(error.toString()));
      LoggerUtil.logs("General Error: $error");
    }
  }


  resendOtptoUser(String phoneNumber) async {
    emit(OTPLoadingState());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          emit(OtpSuccessResendState(verificationId));
          // _verificationId = verificationId;
          //_resendToken = resendToken!;
        },
        timeout: const Duration(seconds: 60),
        // forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String verificationId) {
          // verificationId = _verificationId;
        },
      );
    } catch (e) {
      print("Error $e");
    }
  }


}
