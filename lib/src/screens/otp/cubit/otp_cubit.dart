import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../main.dart';
import '../../../utils/service/firbase_auth_service.dart';

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
    final FirebaseAuth _auth = FirebaseAuth.instance;
   // try {
      LoggerUtil.logs("Verification Id $verificationId");
      // firebaseService.auth.setPersistence(Persistence.LOCAL);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      // await firebaseService.auth.signInWithCredential(credential);


      try {
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          print('Logged in successfully');
          final userData = await FirebaseUtils.getUserData(phoneNumber);
          if (userData != null) {
            if (userData.isProfileComplete == true) {
              emit(OTPSuccessOldUserState(userData));
            } else {
              emit(OTPSuccessNewUserState(phoneNumber));
            }
          } else {
            await firebaseService.firestore
                .collection('users')
                .doc(phoneNumber.replaceAll('+', ''))
                .set({
              'id': phoneNumber.replaceAll('+', ''),
              'phoneNumber': phoneNumber,
              'is_profile_complete': false,
            });

            emit(OTPSuccessNewUserState(phoneNumber));
          }
        }
      } on FirebaseAuthException catch (e) {
        print(e.message);
        emit(OTPFailureState(e.toString()));
        LoggerUtil.logs(e.toString());
      }
    }


   // }
   // //catch (e) {
   //    emit(OTPFailureState(e.toString()));
   //    LoggerUtil.logs(e.toString());
    //}
  }

