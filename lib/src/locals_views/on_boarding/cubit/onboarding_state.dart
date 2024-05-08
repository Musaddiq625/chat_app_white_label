part of 'onboarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoadingState extends OnBoardingState {}


class OnBoardingMoreAboutLoadingState extends OnBoardingState {}

class OnBoardingUserNameImageLoadingState extends OnBoardingState {}
class OnBoardingUserDobToGenderLoadingState extends OnBoardingState {}
class OnBoardingUserAboutYouToInterestLoadingState extends OnBoardingState {}



class OnBoardingMoreAboutSuccess extends OnBoardingState{
  final MoreAboutWrapper moreAbout;

  OnBoardingMoreAboutSuccess(this.moreAbout);
}

class OnBoardingInterestSuccess extends OnBoardingState{
  final InterestResponseWrapper interestData;

  OnBoardingInterestSuccess(this.interestData);
}


class OnBoardingUserNameImageSuccessState extends OnBoardingState {
  final UserModel? userModel;
  OnBoardingUserNameImageSuccessState(this.userModel);
}

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


class OnBoardingUserNameImageFailureState extends OnBoardingState {
  final String error;
  OnBoardingUserNameImageFailureState(this.error);
}
class OnBoardingMoreAboutFailureState extends OnBoardingState {
  final String error;
  OnBoardingMoreAboutFailureState(this.error);
}

class OnBoardingInterestFailureState extends OnBoardingState {
  final String error;
  OnBoardingInterestFailureState(this.error);
}