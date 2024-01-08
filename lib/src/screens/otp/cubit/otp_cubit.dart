import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

import '../../../../main.dart';
import '../../../constants/firebase_constants.dart';
import '../../../utils/service/firbase_auth_service.dart';


part 'otp_state.dart';


class OTPCubit extends Cubit<OTPState> {
  FirebaseService firebaseService = getIt<FirebaseService>();

  OTPCubit() : super(OTPInitial()) {}

  otpUser(String verificationId, String otpController, String phoneNumber, bool isProfileComplete) async {
    emit(OTPLoadingState());

    try {
      firebaseService.auth.setPersistence(Persistence.LOCAL);
      firebaseService.auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otpController,
        ),
      );
      final usersCollection =
      firebaseService.firestore.collection(FirebaseConstants.users);
      final userDocs = await usersCollection.get();

      bool userExists = false;
      for (var doc in userDocs.docs) {
        if (doc.id ==
            phoneNumber.replaceAll('+', '')) {
          userExists = true;
          break;
        }
      }

      final user = firebaseService.auth.currentUser;
      print("User- ${user}");
      print("UserId = ${user?.uid}");
      // final userDoc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(user?.uid)
      //     .get();
      if (userExists) {
       emit(OTPSuccessOldUserState(phoneNumber));
        // User exists, navigate to profile screen
        // NavigationUtil.push(
        //     context, RouteConstants.chatScreen);
        // NavigationUtil.push(context, RouteConstants.chatScreen);

      } else {
        print("UserIds = ${user?.uid}");
        // User does not exist, create a new user document in Firestore
        await firebaseService.firestore
            .collection('users')
            .doc(phoneNumber.replaceAll('+', ''))
            .set({
          'id': phoneNumber.replaceAll('+', ''),
          'phoneNumber': phoneNumber,
          'is_profile_complete': false,
        });
        // Navigate to chat screen
        //  NavigationUtil.push(context, RouteConstants.profileScreen,args:widget.otpScreenArgphoneNumber);
        emit(OTPSuccessNewUserState(phoneNumber));

      }
    } catch (e) {
      emit(OTPFailureState(e.toString()));
      // Sign-in failed, handle the exception
      print(e);
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