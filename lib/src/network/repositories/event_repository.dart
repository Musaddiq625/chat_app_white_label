
import 'package:chat_app_white_label/src/models/event_model.dart';

import '../../../main.dart';
import '../../constants/http_constansts.dart';
import '../../wrappers/event_response_wrapper.dart';
import '../dio_client_network.dart';

class EventRepository{


  static Future<EventResponseWrapper> createEvent(EventModel eventModel) async {
    // LoggerUtil.logs("Http Value ${HttpConstants.users}$userId");
    final response = await getIt<DioClientNetwork>().putRequest(
      HttpConstants.event,
      eventModel.createEventToJson(),
    );
    return EventResponseWrapper.fromJson(response);
  }


}