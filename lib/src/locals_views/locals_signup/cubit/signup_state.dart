part of 'signup_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSignUpState extends SignUpState {
  // final String verificationId;

  // SignUpSignUpState(this.verificationId);
}

class SignUpSignInState extends SignUpState {}

class SignUpCancleState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String error;

  SignUpFailureState(this.error);
}
