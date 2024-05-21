import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/ticket_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/wrappers/ticket_model_wrapper.dart';
import 'package:chat_app_white_label/src/wrappers/view_event_response_wrapper.dart';

import '../../../main.dart';
import '../../constants/http_constansts.dart';
import '../../wrappers/event_response_wrapper.dart';
import '../dio_client_network.dart';

class EventRepository {
  static Future<EventResponseWrapper> createEvent(EventModel eventModel) async {
    LoggerUtil.logs("eventModel.createEventToJson ${eventModel.toJson()}");
    final response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.event}/",
      eventModel.createEventToJson(),
    );
    return EventResponseWrapper.fromJson(response);
  }

  static Future<EventResponseWrapper> updateEvent(EventModel eventModel) async {
    LoggerUtil.logs(
        "eventModel.updateEventToJson ${eventModel.updateEventToJson()}");
    final response = await getIt<DioClientNetwork>().putRequest(
      "${HttpConstants.event}/${eventModel.id}",
      eventModel.updateEventToJson(),
    );
    return EventResponseWrapper.fromJson(response);
  }

  static Future<EventResponseWrapper> fetchEventByKeys(String pageValue) async {
    // await DioClientNetwork.initializeDio(removeToken: false);
    // LoggerUtil.logs("Http Value ${HttpConstants.users}$userId");
    final response =
        await getIt<DioClientNetwork>().postRequest(HttpConstants.event, {
      "keys": [
        "_id",
        "title",
        "userId",
        "isMyEvent",
        "venue",
        "images",
        "isFavourite",
        "eventFavouriteBy",
        "event_request",
        "eventParticipants",
        "eventTotalParticipants"
      ]
    }, queryParameters: {
      'pages': pageValue,
    });
    final x = EventResponseWrapper.keysFromJson(response);
    return x;
  }

  static Future<ViewEventResponseWrapper> fetchEventById(String id) async {
    final response =
        await getIt<DioClientNetwork>().postRequest(HttpConstants.event, {
      "query": {
        "_id": {"\$eq": id}
      }
    });
    final x = ViewEventResponseWrapper.fromJson(response);
    return x;
  }

  static Future<ViewEventResponseWrapper> viewOwnEventById(String id) async {
    final response =
        await getIt<DioClientNetwork>().postRequest(HttpConstants.event, {
      "query": {
        "_id": {"\$eq": id}
      }
    });
    final x = ViewEventResponseWrapper.fromJson(response);
    return x;
  }

  static Future<EventResponseWrapper> sendEventFavById(
      String eventId, bool fav) async {
    final response = await getIt<DioClientNetwork>()
        .putRequest("${HttpConstants.event}/$eventId", {"isFavourite": fav});
    final x = EventResponseWrapper.fromJson(response);
    return x;
  }

  static Future<EventResponseWrapper> sendEventRequestQueryAndStatus(
      String eventId,
      String eventRequestId,
      String requestStatus,
      Query queryReply) async {
    final response = await getIt<DioClientNetwork>()
        .putRequest("${HttpConstants.event}/$eventId", {
      "event_request": [
        {"id": eventRequestId, "query": queryReply.toJson()}
      ]
    });
    final x = EventResponseWrapper.fromJson(response);
    return x;
  }

  static Future<EventResponseWrapper> sendEventJoinRequest(
      String eventId, EventRequest eventRequestModel) async {
    final response = await getIt<DioClientNetwork>()
        .putRequest("${HttpConstants.event}/$eventId", {
      "createRequest ": true,
      "event_request": [eventRequestModel.toRequestJson()]
    });
    final x = EventResponseWrapper.fromJson(response);
    return x;
  }

  static Future<TicketModelWrapper> buyTicketRequest(
      TicketModel ticketModel) async {
    final response = await getIt<DioClientNetwork>()
        .putRequest("${HttpConstants.getTicket}/", ticketModel.toJson());
    final x = TicketModelWrapper.fromJson(response);
    return x;
  }
}
