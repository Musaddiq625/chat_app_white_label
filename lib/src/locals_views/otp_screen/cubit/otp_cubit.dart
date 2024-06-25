import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
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


  Future<void> verifyOtpUser(String type,String identifier,String otp) async {
    if(type == "phoneNumber"){
      emit(OTPSuccessPhoneUserState());
    }else{
      emit(OTPLoadingState());
      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        print("Fcm token ${fcmToken}");
        final device_id = await getIt<SharedPreferencesUtil>()
            .getString(SharedPreferenceConstants.deviceId);
        var resp = await AuthRepository.verifyOtp(identifier,otp,fcmToken,device_id!);
        // LoggerUtil.logs("userDetailModel ${userDetailModel?.toJson()}");
        if(resp.code == 200){
          LoggerUtil.logs("test user data ${resp.data?.toJson()}");

          emit(OTPSuccessUserState(resp.data));
          LoggerUtil.logs(resp);
        }
        else{
          emit(OTPFailureState(resp.message ?? ""));
          LoggerUtil.logs("General Error: ${resp.message ?? ""}");
        }

      } catch (error) {
        emit(OTPFailureState(error.toString()));
        LoggerUtil.logs("General Error: $error");
      }
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
          // emit(OtpSuccessResendState(verificationId));
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


  Future<void> resendOtpUser(String identifier) async {
    emit(OTPLoadingState());

    try {
      var resp = await AuthRepository.login(identifier);
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("Fcm token ${fcmToken}");
      if(resp.code == 200){
        emit(OtpSuccessResendState());
        LoggerUtil.logs(resp);
      }
      else{
        emit(OTPFailureState(resp.message ?? ""));
        LoggerUtil.logs("General Error: ${resp.message ?? ""}");
      }
    } catch (error) {
      emit(OTPFailureState(error.toString()));
      LoggerUtil.logs("General Error: $error");
    }
  }


}
