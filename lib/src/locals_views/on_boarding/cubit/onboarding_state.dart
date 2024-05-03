part of 'onboarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoadingState extends OnBoardingState {}

class OnBoardingUserNameImageSuccessState extends OnBoardingState {}

class OnBoardingDobToGenderSuccessState extends OnBoardingState {
  final UserModel? userModel;

  OnBoardingDobToGenderSuccessState(this.userModel);

}

class OnBoardingAboutYouToInterestSuccessState extends OnBoardingState {
  final UserModel? userModel;

  OnBoardingAboutYouToInterestSuccessState(this.userModel);

}

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

class OnBoardingAboutYouToInterestFailureState extends OnBoardingState {
  final String error;
  OnBoardingAboutYouToInterestFailureState(this.error);
}

class OnBoardingDobToGenderFailureState extends OnBoardingState {
  final String error;
  OnBoardingDobToGenderFailureState(this.error);
}