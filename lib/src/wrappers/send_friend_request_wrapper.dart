/// code : 200
/// message : "Invitation sent successfully"
/// description : ""

class SendFriendRequestWrapper {
  SendFriendRequestWrapper({
      this.code, 
      this.message, 
      this.description,});

  SendFriendRequestWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }
  num? code;
  String? message;
  String? description;
  SendFriendRequestWrapper copyWith({  num? code,
  String? message,
  String? description,
}) => SendFriendRequestWrapper(  code: code ?? this.code,
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