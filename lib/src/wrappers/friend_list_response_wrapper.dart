/// code : 200
/// message : "Friend list retrieved successfully"
/// description : ""
/// data : [{"id":"661d18512214b560a0f7e3eb","firstName":"abdul basit 2","lastName":"khan","aboutMe":"testing","image":"https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"}]
/// meta : null

class FriendListResponseWrapper {
  FriendListResponseWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  FriendListResponseWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FriendListData.fromJson(v));
      });
    }
    meta = json['meta'];
  }
  num? code;
  String? message;
  String? description;
  List<FriendListData>? data;
  dynamic meta;
FriendListResponseWrapper copyWith({  num? code,
  String? message,
  String? description,
  List<FriendListData>? data,
  dynamic meta,
}) => FriendListResponseWrapper(  code: code ?? this.code,
  message: message ?? this.message,
  description: description ?? this.description,
  data: data ?? this.data,
  meta: meta ?? this.meta,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['meta'] = meta;
    return map;
  }

}

/// id : "661d18512214b560a0f7e3eb"
/// firstName : "abdul basit 2"
/// lastName : "khan"
/// aboutMe : "testing"
/// image : "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"

class FriendListData {
  FriendListData({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.aboutMe, 
      this.image,
      this.phoneNumber,});

  FriendListData.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    aboutMe = json['aboutMe'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? aboutMe;
  String? image;
  String? phoneNumber;
FriendListData copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? aboutMe,
  String? image,
  String? phoneNumber,
}) => FriendListData(  id: id ?? this.id,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  aboutMe: aboutMe ?? this.aboutMe,
  image: image ?? this.image,
  phoneNumber: phoneNumber ?? this.phoneNumber,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['aboutMe'] = aboutMe;
    map['image'] = image;
    map['phoneNumber'] = phoneNumber;
    return map;
  }

}