/// code : 200
/// message : "OTP generated successfully"
/// description : ""

class SendOtpResponseWrapper {
  SendOtpResponseWrapper({
      this.code, 
      this.message, 
      this.description,});

  SendOtpResponseWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }
  num? code;
  String? message;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    return map;
  }

}