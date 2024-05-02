part of 'onboarding_cubit.dart';

@immutable
abstract class OnBoardingState{}

class OnBoardingInitial extends OnBoardingState{}

class OnBoardingLoadingState extends OnBoardingState {}

class OnBoardingUserDataFirstStepSuccessState extends OnBoardingState{
  // final String firstName;
  // final String lastName;
  // final List<File> userImages;
  // final String selectedImage;

  // OnBoardingUserDataFirstStepSuccessState(this.firstName,this.lastName,this.userImages,this.selectedImage);
}

class OnBoardingUserStepTwoState  extends OnBoardingState{
   final String? dob;
   final String? aboutMe;
   final String? gender;

  OnBoardingUserStepTwoState(
      this.dob,
      this.aboutMe,
      this.gender
      );
}

class OnBoardingUserDataSecondStepSuccessState extends OnBoardingState{
  // final String dob;
  // final String aboutMe;
  // final String gender;
  // final List<File> moreAboutMe;
  // final List<File> interest;

  // OnBoardingUserDataSecondStepSuccessState(
  //     this.dob,this.aboutMe,this.gender,this.moreAboutMe,this.interest
  //
  //     );
}

class OnBoardingFailureState extends OnBoardingState {
  final String error;
  OnBoardingFailureState(this.error);
}
