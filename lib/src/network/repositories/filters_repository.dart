

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/http_constansts.dart';
import 'package:chat_app_white_label/src/models/get_filters_data_model.dart';
import 'package:chat_app_white_label/src/network/dio_client_network.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/event_response_wrapper.dart';

class FilterRepository{

  static Future<GetFiltersDataModel> getFilters() async {
    final response = await getIt<DioClientNetwork>().postRequest(
      HttpConstants.categories,{
    }
    );
    return GetFiltersDataModel.fromJson(response);
  }

  static Future<EventResponseWrapper> sendFilters(String pageValue,String? startDate,String? endDate,String? dateFilter,List<String>categories, bool? isFree) async {
    final response = await getIt<DioClientNetwork>()
        .postRequest(HttpConstants.event,{
      "startDate": startDate,
      "endDate": endDate,
      "date_filter": dateFilter,
      "categories": categories,
      "isFree": isFree
    },queryParameters: {
      'pages': pageValue,
    });
    final x = EventResponseWrapper.filterEventFromJson(response);
    return x;
  }

}

