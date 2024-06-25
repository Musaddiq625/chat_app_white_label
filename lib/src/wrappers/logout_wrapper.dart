/// code : 200
/// message : "Logout successfully"
/// description : ""

class LogoutWrapper {
  LogoutWrapper({
      this.code, 
      this.message, 
      this.description,});

  LogoutWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }
  num? code;
  String? message;
  String? description;
LogoutWrapper copyWith({  num? code,
  String? message,
  String? description,
}) => LogoutWrapper(  code: code ?? this.code,
  message: message ?? this.message,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    return map;
  }

}