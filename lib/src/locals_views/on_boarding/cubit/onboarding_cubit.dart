

import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/firebase_utils.dart';
import '../../../utils/loading_dialog.dart';

part 'onboarding_state.dart';


class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  String? firstName;
  String? lastName;
  List<String>? userImages;
  String? dateOfBirth;
  String? dateOfBirth;

  userDetailFirstStep(String selectedImage)async{
    emit(OnBoardingLoadingState());
    try{
      await FirebaseUtils.updateUserStepOne(firstName!,lastName!,userImages!,selectedImage);
      emit(OnBoardingUserDataFirstStepSuccessState());
    }
    catch(e){
      emit(OnBoardingFailureState(e.toString()));
    }
  }

  userDetailSecondStep(String selectedImage)async{
    emit(OnBoardingLoadingState());
    try{
      await FirebaseUtils.updateUserStepOne(firstName!,lastName!,userImages!,selectedImage);
      emit(OnBoardingUserDataFirstStepSuccessState());
    }
    catch(e){
      emit(OnBoardingFailureState(e.toString()));
    }
  }
}
