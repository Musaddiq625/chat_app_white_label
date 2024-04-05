import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../utils/logger_util.dart';
import '../../../utils/service/firbase_service.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  FirebaseService firebaseService = getIt<FirebaseService>();

  Future<void> loginUser(String phoneNumber) async {
    emit(SignUpLoadingState());

    try {
      print("Phone1 ");
      LoggerUtil.logs(phoneNumber);
      await firebaseService.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Phone2 $credential");
          try {
            // Sign in with the credential
            // final UserCredential userCredential = await firebaseService.auth.signInWithCredential(credential);
            // if (userCredential.user != null) {
            //   emit(LoginSuccessSignInState());
            // } else {
            //   emit(LoginFailureState('Unable to sign in with the provided credential.'));
            // }
          } catch (e) {
            print("Phone2 $e credential $credential");
            emit(SignUpFailureState(e.toString()));
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          emit(SignUpFailureState(error.toString()));
          LoggerUtil.logs("Verification Error: $error");
          print("Phone3 $error ");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print("Phone4 $verificationId");
          emit(SignUpSignUpState(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Phone5 $verificationId");
          // emit(LoginCodeAutoRetrievalTimeoutState(verificationId));
        },
      );
    } catch (error) {
      emit(SignUpFailureState(error.toString()));
      LoggerUtil.logs("General Error: $error");
    }
  }

  Future<void> loginWithEmail(String email) async {
    try {
      print("Phone1 ");
      LoggerUtil.logs(email);
      // await firebaseService.auth.fetchSignInMethodsForEmail(

      // email: email,
      // verificationCompleted: (PhoneAuthCredential credential) async {
      //   print("Phone2 $credential");
      //   try {
      //     // Sign in with the credential
      //     // final UserCredential userCredential = await firebaseService.auth.signInWithCredential(credential);
      //     // if (userCredential.user != null) {
      //     //   emit(LoginSuccessSignInState());
      //     // } else {
      //     //   emit(LoginFailureState('Unable to sign in with the provided credential.'));
      //     // }
      //   } catch (e) {
      //     print("Phone2 $e credential $credential");
      //     emit(SignUpFailureState(e.toString()));
      //   }
      // },
      // verificationFailed: (FirebaseAuthException error) {
      //   emit(SignUpFailureState(error.toString()));
      //   LoggerUtil.logs("Verification Error: $error");
      //   print("Phone3 $error ");
      // },
      // codeSent: (String verificationId, int? forceResendingToken) {
      //   print("Phone4 $verificationId");
      //   emit(SignUpSignUpState(verificationId));
      // },
      // codeAutoRetrievalTimeout: (String verificationId) {
      //   print("Phone5 $verificationId");
      //   // emit(LoginCodeAutoRetrievalTimeoutState(verificationId));
      // },
      // );
    } catch (error) {
      emit(SignUpFailureState(error.toString()));
      LoggerUtil.logs("General Error: $error");
    }
  }
}
