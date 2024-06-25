/// code : 200
/// message : "Data retrieved successfully"
/// description : ""
/// data : [{"_id":"664ca30db0ba2627e8d8f94b","account_no":123456789,"account_title":"BasitABK","bank_code":"1234","userId":"66472edbbb880ed91c93213d","created_at":"2024-05-21T13:35:09.527Z","updated_at":"2024-05-21T13:35:09.527Z","__v":0}]
/// meta : {"totalCount":1,"defaultPageLimit":10,"pages":1,"pageSizes":10,"remainingCount":0}

class UserBankDetailWrapper {
  UserBankDetailWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  UserBankDetailWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BankDetail.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? code;
  String? message;
  String? description;
  List<BankDetail>? data;
  Meta? meta;
UserBankDetailWrapper copyWith({  num? code,
  String? message,
  String? description,
  List<BankDetail>? data,
  Meta? meta,
}) => UserBankDetailWrapper(  code: code ?? this.code,
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
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

/// totalCount : 1
/// defaultPageLimit : 10
/// pages : 1
/// pageSizes : 10
/// remainingCount : 0

class Meta {
  Meta({
      this.totalCount, 
      this.defaultPageLimit, 
      this.pages, 
      this.pageSizes, 
      this.remainingCount,});

  Meta.fromJson(dynamic json) {
    totalCount = json['totalCount'];
    defaultPageLimit = json['defaultPageLimit'];
    pages = json['pages'];
    pageSizes = json['pageSizes'];
    remainingCount = json['remainingCount'];
  }
  num? totalCount;
  num? defaultPageLimit;
  num? pages;
  num? pageSizes;
  num? remainingCount;
Meta copyWith({  num? totalCount,
  num? defaultPageLimit,
  num? pages,
  num? pageSizes,
  num? remainingCount,
}) => Meta(  totalCount: totalCount ?? this.totalCount,
  defaultPageLimit: defaultPageLimit ?? this.defaultPageLimit,
  pages: pages ?? this.pages,
  pageSizes: pageSizes ?? this.pageSizes,
  remainingCount: remainingCount ?? this.remainingCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = totalCount;
    map['defaultPageLimit'] = defaultPageLimit;
    map['pages'] = pages;
    map['pageSizes'] = pageSizes;
    map['remainingCount'] = remainingCount;
    return map;
  }

}

/// _id : "664ca30db0ba2627e8d8f94b"
/// account_no : 123456789
/// account_title : "BasitABK"
/// bank_code : "1234"
/// userId : "66472edbbb880ed91c93213d"
/// created_at : "2024-05-21T13:35:09.527Z"
/// updated_at : "2024-05-21T13:35:09.527Z"
/// __v : 0

class BankDetail {
  BankDetail({
      this.id, 
      this.accountNo, 
      this.accountTitle, 
      this.bankCode, 
      this.userId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  BankDetail.fromJson(dynamic json) {
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
BankDetail copyWith({  String? id,
  num? accountNo,
  String? accountTitle,
  String? bankCode,
  String? userId,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => BankDetail(  id: id ?? this.id,
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