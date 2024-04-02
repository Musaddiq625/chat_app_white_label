
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../utils/logger_util.dart';
import '../../../utils/service/firbase_service.dart';

part 'signup_state.dart';
class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit(): super(SignUpInitial());
  FirebaseService firebaseService = getIt<FirebaseService>();

  loginUser(String phoneNumber) async {
    emit(SignUpLoadingState());

    try {
      LoggerUtil.logs(phoneNumber);
      await firebaseService.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseService.auth.signInWithCredential(credential);
          emit(SignUpSignInState());
        },
        verificationFailed: (FirebaseAuthException error) {
          print(
              "Verification Error $error"); // You might want to display an error message to the user
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          emit(SignUpSignUpState(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (error) {
      // Handle general errors
      emit(SignUpFailureState(error.toString()));
      print(
          error); // You might want to display a general error message to the user
    }
  }

  Future<void> loginUsers(String phoneNumber) async {
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


}