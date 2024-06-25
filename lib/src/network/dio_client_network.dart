import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:dio/dio.dart';

class DioClientNetwork {
  static late Dio _dio; //builtin

  // Future<Dio> _getApiClient() async {
  static Future<Dio> initializeDio({bool removeToken = false}) async {
    _dio = Dio();
    final token = await getIt<SharedPreferencesUtil>()
        .getString(SharedPreferenceConstants.apiAuthToken);
    final device_id = await getIt<SharedPreferencesUtil>()
        .getString(SharedPreferenceConstants.deviceId);

    _dio.options = BaseOptions(
      baseUrl: HttpConstants.base,
    );
    if (token != null && token.isNotEmpty) {
      LoggerUtil.logs("token value $token");
      // _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.headers = {
        'device-id': device_id,
        'x-access-token': token,
      };
      // _dio.options.headers["device"]= device_id;
      // _dio.options.headers['x-access-token'] = token;
    } else {
      LoggerUtil.logs("token is null $token");
    }
    _dio.interceptors.clear();

    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
    return _dio;
  }

  Future<bool> _checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  final _internetError = {
    'message': 'Please check your internet connection',
    'errorCode': 'internet_connection_error',
  };

  Future postRequest(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? queryParameters}) async {
    // final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response =
            await _dio.post(url, data: data, queryParameters: queryParameters);
        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      LoggerUtil.logs('eeeee:: $e');

      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future putRequest(String url, dynamic data) async {
    // final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await _dio.put(url, data: data);

        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      LoggerUtil.logs('eeeee:: $e');

      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future getRequest(String url, {Map<String, dynamic>? queryParameter}) async {
    // final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await _dio.get(url, queryParameters: queryParameter);
        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
      );
    }
  }

  Future patchRequest(String url, Map<String, dynamic> data) async {
    // final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await _dio.patch(url, data: data);
        return response.data;
      } else {
        return _internetError;
      }
    } on SocketException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    } on FormatException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future deleteRequest(String url, Map<String, dynamic> data) async {
    // final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await _dio.delete(url, data: data);
        return response.data;
      } else {
        return _internetError;
      }
    } on SocketException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    } on FormatException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        _dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }
}

final sharedPref = getIt<SharedPreferencesUtil>();

Future<void> unAuthorize() async {
  await Future.wait([
    sharedPref.removeValue(SharedPreferenceConstants.apiAuthToken),
    sharedPref.removeValue(SharedPreferenceConstants.user),
    sharedPref.removeValue(SharedPreferenceConstants.misc),
  ]).then(
    (value) {
      // return NavigationUtil.popAllAndPush(
      //   navigationService.navigatorKey.currentContext!,
      //   RouteConstants.loginSelection,
      //   previousScreen: RouteConstants.home,
      //   args: true,
      // );
    },
  );
}

abstract class NetworkExceptions {
  static getDioException(
    Object error,
    Dio dio,
    String url, {
    dynamic data,
  }) async {
    if (error is Exception) {
      try {
        if (error is DioException && error.error is! SocketException) {
          // await navigationService.navigateTo(
          //   RouteConstants.customTest,
          //   args: customTestCubit.customTestModelList.last?.copyWith(
          //     apis: [
          //       Apis(
          //         // api: url,
          //         // headers: Headers_.fromJson(dio.options.headers),
          //         // statusCode: error.response?.statusCode,
          //         // request: error.requestOptions.data,
          //         // response: error.response?.data,
          //         error: error.error,
          //       )
          //     ],
          //   ),
          // //   // args: TestCaseModel(
          // //   //   api: url,
          // //   //   statusCode: error.response?.statusCode,
          // //   //   headers: dio.options.headers,
          // //   //   request: data,
          // //   //   response: error.response?.data,
          // //   // ),
          // );
          switch (error.response?.statusCode) {
            case 401:
              return unAuthorize();

            //   return {
            //
            //   'status': false,
            //   'message': StringConstants.loginExpired,
            //
            // };
            case 402:
              // await navigationService.navigateTo(
              //   RouteConstants.customTest,
              //   args: TestCaseModel(
              //     statusCode: error.response?.statusCode,
              //     headers: dio.options.headers,
              //   ),
              // );
              return {
                'status': false,
                'message': StringConstants.loginExpired,
              };
            default:
              return {
                'status': false,
                'message': error.response?.data['message'],
                'data': error.response?.data['data'],
              };
          }
        }
      } catch (_) {
        return {
          'status': false,
          'message': 'Unexpected error occurred',
          'code': 500
        };
      }
    }
  }
}
