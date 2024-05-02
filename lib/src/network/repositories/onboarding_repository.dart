import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:dio/dio.dart';

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
}
