import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';
import '../../../constants/string_constants.dart';
import '../../../utils/service/firbase_auth_service.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  LoginCubit() : super(LoginInitial()) {}

  loginUser(String phoneNumber, String phoneCode) async {
    emit(LoginLoadingState());

    try {
      await firebaseService.auth.verifyPhoneNumber(
        phoneNumber:
        "$phoneCode$phoneNumber",
        verificationCompleted:
            (PhoneAuthCredential credential) async {
          // Sign in with the credential
          await firebaseService.auth.signInWithCredential(credential);
          // Navigate to the home screen (or desired screen)
              emit(LoginSuccessSignInState());
          // NavigationUtil.push(context, RouteConstants.chatScreen);
        },
        verificationFailed: (FirebaseAuthException error) {
          // Handle error
          print(
              "Verification Error ${error}"); // You might want to display an error message to the user
        },
        codeSent:
            (String verificationId, int? forceResendingToken) {

              emit(LoginSuccessSignUpState(verificationId));
          // Store verification ID for later use in OTP screen
          // (Assuming you'll pass it to the OTP screen)
          // NavigationUtil.push(context, RouteConstants.otpScreen,
          //     args: OtpScreenArg(
          //         verificationId,
          //         "${_countryCodeController.text}${_controller.text}",
          //         _countryCodeController.text));
          // NavigationUtil.push(context, RouteConstants.otpScreen,
          //     args: OtpScreenArg(
          //         verificationId,
          //         "${_countryCodeController.text}${_controller.text}",
          //         _countryCodeController.text));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OTPScreen(
          //             verificationId: verificationId,
          //             phoneNumber:
          //                 "${_countryCodeController.text}${_controller.text}",
          //             phoneCode:
          //                 "${_countryCodeController.text}")));
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


    //   final response = await networkRepository.loginUserRepo(
    //     email: email,
    //     password: password,
    //   );
    //   if (response.status == true) {
    //       emit(LoginSuccessSignUpState());
    //
    //   } else {
    //     emit(LoginFailureState(
    //         response.message ?? StringConstants.errSomethingWentWrong));
    //   }
    // }

  }
}