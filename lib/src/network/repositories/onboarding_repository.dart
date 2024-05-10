import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/wrappers/interest_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/more_about_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/on_boarding_response_wrapper.dart';

class OnBoardingRepository {
  static Future<OnBoardingResponseWrapper> updateUserNameWithPhoto(
      String? userId,
      String? firstName,
      String? lastName,
      List<String> profileImages) async {
    //Todo remove this when uploading image to server functionality is completed
    // profileImages = [
    //   "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww",
    //   "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8fHww"
    // ];

    var response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.users}$userId", //Todo change to userId
      {
        "firstName": firstName,
        "lastName": lastName,
        "userPhotos": profileImages
      },
    );
    return OnBoardingResponseWrapper.fromJson(response);
  }

  static Future<UserModel> chooseProfilePicture(String profileImage) async {
    profileImage =
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8fHww";
    var response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.users}/6621294ba6e2250c48538f73", //Todo change to userId

      {"password": profileImage}, //Todo change to profile when key is ready
    );
    return UserModel.fromJson(response);
  }

  static Future<OnBoardingResponseWrapper> updateUserDobToGender(
      String userId, String dateOfBirth, String aboutMe, String gender) async {
    // LoggerUtil.logs("Http Value ${HttpConstants.users}$userId");
    final response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.users}$userId",
      {"dateOfBirth": dateOfBirth, "aboutMe": aboutMe, "gender": gender},
    );
    return OnBoardingResponseWrapper.fromJson(response);
  }

  static Future<OnBoardingResponseWrapper> updateUserAboutYouToInterest(
      String userId,
      String bio,
      SocialLink? socialLink,
      MoreAbout? moreAbout,
      Interest? interest) async {
    // LoggerUtil.logs("SocialLink Value ${socialLink.toJson()}");
    final response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.users}$userId",
      {
        "bio": bio,
        "socialLink": socialLink?.toJson() ?? {},
        "moreAbout": moreAbout?.toJson() ?? {},
        "interest": interest?.toJson() ?? {}
      },
    );
    return OnBoardingResponseWrapper.fromJson(response);
  }

  static Future<MoreAboutWrapper> getMoreAboutData() async {
    final response = await getIt<DioClientNetwork>().postRequest(
      HttpConstants.moreAbout,
      {},
    );
    return MoreAboutWrapper.fromJson(response);
  }

  static Future<InterestResponseWrapper> getInterestData() async {
    final response = await getIt<DioClientNetwork>().postRequest(
      HttpConstants.interests,
      {},
    );
    return InterestResponseWrapper.fromJson(response);
  }
}
