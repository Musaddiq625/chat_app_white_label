import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../main.dart';
import '../../../utils/service/firbase_auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  FirebaseService firebaseService = getIt<FirebaseService>();

  loginUser(String phoneNumber) async {
    emit(LoginLoadingState());

    try {
      LoggerUtil.logs(phoneNumber);
      await firebaseService.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await firebaseService.auth.signInWithCredential(credential);
          // emit(LoginSuccessSignInState());
        },
        verificationFailed: (FirebaseAuthException error) {
          print(
              "Verification Error $error"); // You might want to display an error message to the user
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          emit(LoginSuccessSignUpState(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (error) {
      // Handle general errors
      emit(LoginFailureState(error.toString()));
      print(
          error); // You might want to display a general error message to the user
    }
  }
}
