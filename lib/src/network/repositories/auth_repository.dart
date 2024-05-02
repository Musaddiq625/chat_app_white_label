import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/wrappers/forget_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/login_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/send_otp_response_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/signup_response_wrapper.dart';
import 'package:http/http.dart';

class AuthRepository {
  // static Future<LoginResponseWrapper> login(
  //     String email, String password) async {
  //   final response = await getIt<DioClientNetwork>().postRequest(
  //       HttpConstants.login, {"email": email, "password": password});
  //   return LoginResponseWrapper.fromJson(response);
  // }

  // static Future<SignupResponseWrapper> signUp(UserModel user) async {
  //   Response response = await getIt<DioClientNetwork>()
  //       .postRequest(HttpConstants.login, user.SignupToJson());
  //
  //   return SignupResponseWrapper.fromJson(response);
  // }

  static Future<SendOtpResponseWrapper> login(String email) async {
    DioClientNetwork.initializeDio(removeToken: false);
    final response = await getIt<DioClientNetwork>().postRequest(
        HttpConstants.sendOtp, {"email": email});
    return SendOtpResponseWrapper.fromJson(response);
  }


  static Future<LoginResponseWrapper> verifyOtp(String email,String otp) async {
    final response = await getIt<DioClientNetwork>().postRequest(
        HttpConstants.verifyOtp, {"email": email,"otp":otp});
    return LoginResponseWrapper.fromJson(response);
  }

  Future<ForgetResponseWrapper> forgetPassword(String email) async {
    Response response = await getIt<DioClientNetwork>()
        .postRequest(HttpConstants.forgetPassword, {"email": email});

    return ForgetResponseWrapper.fromJson(response);
  }
}
