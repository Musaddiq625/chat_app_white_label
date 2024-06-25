import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/repositories/onboarding_repository.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/more_about_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wrappers/interest_response_wrapper.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  UserModel userModel = UserModel();
  MoreAboutWrapper moreAboutWrapper = MoreAboutWrapper();
  InterestResponseWrapper interestWrapper = InterestResponseWrapper();

  void initializeUserData(UserModel user) => userModel = user;

  void initializeMoreAboutData(MoreAboutWrapper moreAbout) =>
      moreAboutWrapper = moreAbout;

  void initializeInterestData(InterestResponseWrapper interest) =>
      interestWrapper = interest;

  void updateUserName(String firstName, String lastName) {
    userModel = userModel.copyWith(firstName: firstName, lastName: lastName);
  }

  String getUserName() {
    return "${userModel.firstName} ${userModel.lastName}";
  }

  void setDobValues(String? dob) {
    userModel = userModel.copyWith(dateOfBirth: dob);
  }

  void setPhoneNumberValues(String? phoneNumberValues) {
    userModel = userModel.copyWith(phoneNumber: phoneNumberValues);
  }

  void setAboutMeValues(String? aboutMe) {
    userModel = userModel.copyWith(aboutMe: aboutMe);
  }

  void setGenderValues(String? gender) {
    // userModel?.gender = gender;
    userModel = userModel.copyWith(gender: gender);
  }

  void setAboutYou(String? bio, SocialLink socialLink, MoreAbout moreAbout) {
    userModel = userModel.copyWith(
        bio: bio, socialLink: socialLink, moreAbout: moreAbout);
  }

  void setInterest(Interest interest) {
    userModel = userModel.copyWith(interest: interest);
  }

  // Future<void> uploadUserPhoto(List<String> profileImages) async {
  //   for(int i=0 ;i<profileImages.length; i++){
  //     await  AwsS3.uploadFile(
  //         accessKey: "OOFqyH9v2YBpon7C3m0pZSH0ruNxqGEVMeyRy0g5",
  //         secretKey: "DQEJGSA2VP1KBQZ551NI",
  //         file: File(profileImages[i]),
  //         bucket: "locals",
  //         region: "se-sto-1",
  //         domain: "linodeobjects.com", // optional - Default: amazonaws.com
  //         metadata: {"test": "test"} // optional
  //     );
  //   }
  //
  //   userModel = userModel.copyWith(userPhotos: profileImages);
  // }

  Future<void> uploadUserPhoto(List<String> profileImages) async {
    emit(UploadImageLoadingState());

    try {
      // Map each imagePath to a Future that completes with the URL of the uploaded image
      List<Future<String?>> uploadFutures = profileImages.map((imagePath) async {
        final file = File(imagePath);
        print("file $file");
        if (!file.existsSync()) {
          throw Exception('File does not exist: $imagePath');
        }

        // Await the upload and capture the result (URL)
        String? uploadedImageUrl = await AwsS3.uploadFile(
            accessKey: "DQEJGSA2VP1KBQZ551NI",
            secretKey: "OOFqyH9v2YBpon7C3m0pZSH0ruNxqGEVMeyRy0g5",
            file: file,
            bucket: "locals",
            region: "se-sto-1",
            destDir: "profile",
            domain: "linodeobjects.com",
            metadata: {"test": "test"}
        );
print("ImageUrl ${uploadedImageUrl}");
        // Return the URL of the uploaded image
        return uploadedImageUrl;
      }).toList();

      // Wait for all uploads to complete and collect the URLs

      List<String?> uploadedUrls = await Future.wait(uploadFutures);
      print("uploadedUrls $uploadedUrls" );
      // Update userModel with the URLs of the uploaded images
      userModel = userModel.copyWith(userPhotos: uploadedUrls);
      emit(UploadImageSuccess(uploadedUrls));

    } catch (e) {
      emit(UploadImageFailureState(e.toString()));
      print('Failed to upload all photos: $e');
    }
  }

  userDetailDobToGenderStep(
      String userId, String dateOfBirth, String aboutMe, String gender) async {
    emit(OnBoardingUserDobToGenderLoadingState());
    try {
      var resp = await OnBoardingRepository.updateUserDobToGender(
          userId, dateOfBirth, aboutMe, gender);
      emit(OnBoardingDobToGenderSuccessState(resp.data));
      // LoggerUtil.logs(resp);
    } catch (e) {
      emit(OnBoardingDobToGenderFailureState(e.toString()));
    }
  }

  userDetailAboutYouToInterestStep(String userId, String bio,
      SocialLink? socialLink, MoreAbout? moreAbout, Interest? interest, bool? isProfileCompleted ) async {
    emit(OnBoardingUserAboutYouToInterestLoadingState());
    // try {
      LoggerUtil.logs("0 userDetailAboutYouToInterestStep resp data ");
      var resp = await OnBoardingRepository.updateUserAboutYouToInterest(
          userId, bio, socialLink, moreAbout, interest,isProfileCompleted);
      LoggerUtil.logs("1 userDetailAboutYouToInterestStep resp data ${resp.data?.toJson()}");
      emit(OnBoardingAboutYouToInterestSuccessState(resp.data));
      // print("resp data ${resp.toJson()}");
    // } catch (e) {
    //   emit(OnBoardingAboutYouToInterestFailureState(e.toString()));
    // }
  }

  Future<void> updateUserPhoto(List<String?> profileImages) async {
    emit(OnBoardingUserNameImageLoadingState());
    try {
      // userModel = userModel.copyWith(image: profileImages.first);
      userModel = userModel.copyWith(userPhotos: profileImages);

      var resp = await OnBoardingRepository.updateUserNameWithPhoto(
          userModel.id, userModel.firstName, userModel.lastName,userModel.phoneNumber,profileImages);
      emit(OnBoardingUserNameImageSuccessState(resp.data));
    } catch (e) {
      emit(OnBoardingUserNameImageFailureState(e.toString()));
    }
  }

  Future<void> getMoreAboutData() async {
    // emit(OnBoardingUserLoadingState());
    try {
      var resp = await OnBoardingRepository.getMoreAboutData();
      emit(OnBoardingMoreAboutSuccess(resp));
      // LoggerUtil.logs(resp.toJson());
    } catch (e) {
      emit(OnBoardingMoreAboutFailureState(e.toString()));
    }
  }

  Future<void> getInterestData() async {
    emit(OnBoardingInterestLoadingState());
    try {
      var resp = await OnBoardingRepository.getInterestData();
      emit(OnBoardingInterestSuccess(resp));
    } catch (e) {
      emit(OnBoardingInterestFailureState(e.toString()));
    }
  }
}
