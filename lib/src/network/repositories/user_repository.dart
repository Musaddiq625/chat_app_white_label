import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/wrappers/login_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/signup_response_wrapper.dart';
import 'package:http/http.dart';

class UserRepository {
  Future<LoginResponseWrapper> login(String email, String password) async {
    final response = await getIt<DioClientNetwork>().postRequest(
        HttpConstants.login, {"email": email, "password": password});
    return LoginResponseWrapper.fromJson(response);
  }

  Future<SignupResponseWrapper> signUp(UserModel user) async {
    Response response = await getIt<DioClientNetwork>()
        .postRequest(HttpConstants.login, user.SignupToJson());

    return SignupResponseWrapper.fromJson(response);
  }
}
