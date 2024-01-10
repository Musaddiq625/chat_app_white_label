part of 'otp_cubit.dart';

@immutable
abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPLoadingState extends OTPState {}

class OTPSuccessOldUserState extends OTPState {
  final UserModel user;

  OTPSuccessOldUserState(this.user);
}

class OTPSuccessNewUserState extends OTPState {
  final String phoneNumber;

  OTPSuccessNewUserState(this.phoneNumber);
}

class OTPCancleState extends OTPState {}

class OTPFailureState extends OTPState {
  final String error;

  OTPFailureState(this.error);
}
