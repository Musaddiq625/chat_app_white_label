part of 'otp_cubit.dart';

@immutable
abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPLoadingState extends OTPState {}

class OTPSuccessOldUserState extends OTPState {
  final UserModel user;

  OTPSuccessOldUserState(this.user);
}

class OtpSuccessResendState extends OTPState {
  final String verificationId;

  OtpSuccessResendState(this.verificationId);
}

class OTPSuccessUserState extends OTPState {
  final UserModel? userModel;

  OTPSuccessUserState(this.userModel);

}

class OTPSuccessNewUserState extends OTPState {
  final String phoneNumber;
  final String? fcmToken;

  OTPSuccessNewUserState(this.phoneNumber, this.fcmToken);
}

class OTPCancleState extends OTPState {}

class OTPFailureState extends OTPState {
  final String error;

  OTPFailureState(this.error);
}
