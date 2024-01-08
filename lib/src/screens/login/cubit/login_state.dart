part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessSignUpState extends LoginState {
  final String verificationId;

  LoginSuccessSignUpState(this.verificationId);
}

class LoginSuccessSignInState extends LoginState {}

class LoginCancleState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}
