import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:dio/dio.dart';

class DioClientNetwork {
  Future<Dio> _getApiClient() async {
    final dio = Dio(); //builtin
    final token = await getIt<SharedPreferencesUtil>()
        .getString(SharedPreferenceConstants.apiAuthToken);

    dio.options = BaseOptions(
      baseUrl: HttpConstants.base,
    );
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    dio.interceptors.clear();

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
    return dio;
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

  Future postRequest(String url, Map<String, dynamic> data) async {
    final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await dio.post(url, data: data);
        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      LoggerUtil.logs('eeeee:: $e');

      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future putRequest(String url, dynamic data) async {
    final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await dio.put(url, data: data);

        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      LoggerUtil.logs('eeeee:: $e');

      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future getRequest(String url, {Map<String, dynamic>? queryParameter}) async {
    final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await dio.get(url, queryParameters: queryParameter);
        return response.data;
      } else {
        return _internetError;
      }
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
      );
    }
  }

  Future patchRequest(String url, Map<String, dynamic> data) async {
    final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await dio.patch(url, data: data);
        return response.data;
      } else {
        return _internetError;
      }
    } on SocketException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
        data: data,
      );
    } on FormatException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
        data: data,
      );
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
        data: data,
      );
    }
  }

  Future deleteRequest(String url) async {
    final dio = await _getApiClient();
    try {
      final connected = await _checkInternetConnectivity();
      if (connected) {
        final response = await dio.delete(url);
        return response.data;
      } else {
        return _internetError;
      }
    } on SocketException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
      );
    } on FormatException catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
      );
    } catch (e) {
      return NetworkExceptions.getDioException(
        e,
        dio,
        HttpConstants.base + url,
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
