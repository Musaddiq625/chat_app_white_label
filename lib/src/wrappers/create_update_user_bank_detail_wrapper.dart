/// code : 200
/// message : "Operation successful"
/// description : ""
/// data : {"_id":"664ca30db0ba2627e8d8f94b","account_no":1234567890011,"account_title":"Basit","bank_code":"123","userId":"66472edbbb880ed91c93213d","created_at":"2024-05-21T13:35:09.527Z","updated_at":"2024-05-21T13:35:09.527Z","__v":0}
/// meta : null

class CreateUpdateUserBankDetailWrapper {
  CreateUpdateUserBankDetailWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  CreateUpdateUserBankDetailWrapper.fromJson(dynamic json) {
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
CreateUpdateUserBankDetailWrapper copyWith({  num? code,
  String? message,
  String? description,
  Data? data,
  dynamic meta,
}) => CreateUpdateUserBankDetailWrapper(  code: code ?? this.code,
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
      map['data'] = data?.toJson();
    }
    map['meta'] = meta;
    return map;
  }

}

/// _id : "664ca30db0ba2627e8d8f94b"
/// account_no : 1234567890011
/// account_title : "Basit"
/// bank_code : "123"
/// userId : "66472edbbb880ed91c93213d"
/// created_at : "2024-05-21T13:35:09.527Z"
/// updated_at : "2024-05-21T13:35:09.527Z"
/// __v : 0

class Data {
  Data({
      this.id, 
      this.accountNo, 
      this.accountTitle, 
      this.bankCode, 
      this.userId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    accountNo = json['account_no'];
    accountTitle = json['account_title'];
    bankCode = json['bank_code'];
    userId = json['userId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }
  String? id;
  num? accountNo;
  String? accountTitle;
  String? bankCode;
  String? userId;
  String? createdAt;
  String? updatedAt;
  num? v;
Data copyWith({  String? id,
  num? accountNo,
  String? accountTitle,
  String? bankCode,
  String? userId,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Data(  id: id ?? this.id,
  accountNo: accountNo ?? this.accountNo,
  accountTitle: accountTitle ?? this.accountTitle,
  bankCode: bankCode ?? this.bankCode,
  userId: userId ?? this.userId,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['account_no'] = accountNo;
    map['account_title'] = accountTitle;
    map['bank_code'] = bankCode;
    map['userId'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}