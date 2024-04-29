/// code : 200
/// message : "OTP generated succesfully `users`"
/// description : ""
/// data : {"otp":852313}
/// meta : null

class ForgetResponseWrapper {
  ForgetResponseWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  ForgetResponseWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'];
  }
  num? code;
  String? message;
  String? description;
  Data? data;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['meta'] = meta;
    return map;
  }

}

/// otp : 852313

class Data {
  Data({
      this.otp,});

  Data.fromJson(dynamic json) {
    otp = json['otp'];
  }
  num? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = otp;
    return map;
  }

}