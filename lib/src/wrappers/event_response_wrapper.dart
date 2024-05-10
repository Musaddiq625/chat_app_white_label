import 'dart:convert';

import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';

/// message : "User created successfully `users`"
/// code : 200
/// status : true
/// data : {"authToken":[],"status":"active","_id":"662f58c17a78afd5d216b5dd","email":"shewry127@gmail.com","password":"$2b$10$xyFTzp1Q7.zI/oFyahLtK.9JTAc5zB5r3hmzTb2yxz9XSpxWngRh.","firstName":"khan","lastName":"muhammad","__v":0}
/// meta : null

EventResponseWrapper userWrapperFromJson(String str) =>
    EventResponseWrapper.fromJson(json.decode(str));
String userWrapperToJson(EventResponseWrapper data) =>
    json.encode(data.toJson());

class EventResponseWrapper {
  String? message;
  int? code;
  bool? status;
  EventModel? data;
  dynamic meta;

  EventResponseWrapper({
    this.message,
    this.code,
    this.status,
    this.data,
    this.meta,
  });

  EventResponseWrapper.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? EventModel.fromJson(json['data']) : null;
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['meta'] = meta;
    return map;
  }
}

/// authToken : []
/// status : "active"
/// _id : "662f58c17a78afd5d216b5dd"
/// email : "shewry127@gmail.com"
/// password : "$2b$10$xyFTzp1Q7.zI/oFyahLtK.9JTAc5zB5r3hmzTb2yxz9XSpxWngRh."
/// firstName : "khan"
/// lastName : "muhammad"
/// __v : 0

EventModel dataFromJson(String str) => EventModel.fromJson(json.decode(str));
String dataToJson(EventModel data) => json.encode(data.toJson());
