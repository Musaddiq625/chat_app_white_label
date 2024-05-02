part of 'onboarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoadingState extends OnBoardingState {}

class OnBoardingUserNameImageSuccessState extends OnBoardingState {}

class OnBoardingUserDataSecondStepSuccessState extends OnBoardingState {}

class OnBoardingUserStepTwoState extends OnBoardingState {
  final String? dob;
  final String? aboutMe;
  final String? gender;

  OnBoardingUserStepTwoState(this.dob, this.aboutMe, this.gender);
}

class OnBoardingFailureState extends OnBoardingState {
  final String error;
  OnBoardingFailureState(this.error);
}
