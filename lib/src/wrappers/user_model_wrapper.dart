import 'package:chat_app_white_label/src/models/user_model.dart';

/// code : 200
/// message : "Operation successful"
/// description : ""
/// data : {"_id":"664466e91d98d12f648b045f","eventId":"664207f6040489e86238079e","userId":"66308eff24f3be297421a427","transectionId":"123123asdasdasdasd","ticketQty":60,"ticketPrice":100,"ticketTotalPrice":6000,"dateTime":"2024-05-15T07:40:25.392Z","created_at":"2024-05-15T07:40:25.392Z","updated_at":"2024-05-15T07:40:25.392Z","__v":0}
/// meta : null

class UserModelWrapper {
  UserModelWrapper({
    this.code,
    this.message,
    this.description,
    this.data,
    this.data2,
    this.meta,
  });

  UserModelWrapper.fromListJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UserModel.fromJson(v));
      });
    }
    // data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    meta = json['meta'];
  }
  UserModelWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data2 = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    // data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    meta = json['meta'];
  }

  num? code;
  String? message;
  String? description;
  List<UserModel>? data;
  UserModel? data2;
  dynamic meta;

  UserModelWrapper copyWith({
    num? code,
    String? message,
    String? description,
    List<UserModel>? data,
    UserModel? data2,
    dynamic meta,
  }) =>
      UserModelWrapper(
        code: code ?? this.code,
        message: message ?? this.message,
        description: description ?? this.description,
        data: data ?? this.data,
        data2: data2 ?? this.data2,
        meta: meta ?? this.meta,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    if (map['data'] != null) {
      data = [];
      map['data'].forEach((v) {
        data?.add(UserModel.fromJson(v));
      });
    }
    if (data2 != null) {
      map['data'] = data2?.toJson();
    }
    map['meta'] = meta;
    return map;
  }
}
