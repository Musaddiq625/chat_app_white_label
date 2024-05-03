import 'dart:convert';

import 'package:chat_app_white_label/src/models/user_model.dart';

/// message : "User created successfully `users`"
/// code : 200
/// status : true
/// data : {"authToken":[],"status":"active","_id":"662f58c17a78afd5d216b5dd","email":"shewry127@gmail.com","password":"$2b$10$xyFTzp1Q7.zI/oFyahLtK.9JTAc5zB5r3hmzTb2yxz9XSpxWngRh.","firstName":"khan","lastName":"muhammad","__v":0}
/// meta : null

OnBoardingResponseWrapper userWrapperFromJson(String str) =>
    OnBoardingResponseWrapper.fromJson(json.decode(str));
String userWrapperToJson(OnBoardingResponseWrapper data) =>
    json.encode(data.toJson());

class OnBoardingResponseWrapper {
  String? message;
  int? code;
  bool? status;
  UserModel? data;
  dynamic meta;

  OnBoardingResponseWrapper({
    this.message,
    this.code,
    this.status,
    this.data,
    this.meta,
  });

  OnBoardingResponseWrapper.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
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

UserModel dataFromJson(String str) => UserModel.fromJson(json.decode(str));
String dataToJson(UserModel data) => json.encode(data.toJson());
