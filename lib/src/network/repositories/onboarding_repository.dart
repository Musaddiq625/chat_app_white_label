import 'package:chat_app_white_label/globals.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/shared_preference_constants.dart';
import '../../screens/app_setting_cubit/app_setting_cubit.dart';
import '../../utils/shared_preferences_util.dart';

class OnBoardingRepository {



  Future<UserModel> updateUserNameWithPhoto(
      String firstName, String lastName, List<String> profileImages) async {
    Response response = await getIt<DioClientNetwork>().postRequest(
      HttpConstants.users,
      {
        "firstName": firstName,
        "lastName": lastName,
        "userPhotos": profileImages
      },
    );
    return UserModel.fromJson(response.data);
  }


 static Future<UserModel> updateUserDobToGender(String userId,
      String dateOfBirth, String aboutMe, String gender) async {
    LoggerUtil.logs("Http Value ${HttpConstants.users}$userId");
    Response response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.users}$userId",
      {
        "dateOfBirth": dateOfBirth,
        "aboutMe": aboutMe,
        "gender": gender
      },
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateUserAboutYouToInterest(
      String bio, String socialLinks, String moreAbout,List<String> hobbies,List<String> creativity) async {
    Response response = await getIt<DioClientNetwork>().postRequest(HttpConstants.users,
      {
        "bio": bio,
        "socialLink": socialLinks,
        "moreAbout": moreAbout,
        "interest" : {
          "hobbies":hobbies,
          "creativity":creativity,
        }
      },
    );
    return UserModel.fromJson(response.data);
  }
}
