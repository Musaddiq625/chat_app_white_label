/// code : 200
/// message : "Delete successful"
/// description : ""

class DeleteGroupWrapper {
  DeleteGroupWrapper({
      this.code, 
      this.message, 
      this.description,});

  DeleteGroupWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }
  num? code;
  String? message;
  String? description;
DeleteGroupWrapper copyWith({  num? code,
  String? message,
  String? description,
}) => DeleteGroupWrapper(  code: code ?? this.code,
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