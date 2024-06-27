/// code : 200
/// message : "Withdraw Successful"
/// description : ""
/// data : {"_id":"667bca7b004cf0c344b066c7","user_id":"66472edbbb880ed91c93213d","amount":10,"transaction_id":null,"status":"success","__v":0}
/// meta : null

class WithDrawAmountWrapper {
  WithDrawAmountWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  WithDrawAmountWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data = json['data'] != null ? WithDraw.fromJson(json['data']) : null;
    meta = json['meta'];
  }
  num? code;
  String? message;
  String? description;
  WithDraw? data;
  dynamic meta;
WithDrawAmountWrapper copyWith({  num? code,
  String? message,
  String? description,
  WithDraw? data,
  dynamic meta,
}) => WithDrawAmountWrapper(  code: code ?? this.code,
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

/// _id : "667bca7b004cf0c344b066c7"
/// user_id : "66472edbbb880ed91c93213d"
/// amount : 10
/// transaction_id : null
/// status : "success"
/// __v : 0

class WithDraw {
  WithDraw({
      this.id, 
      this.userId, 
      this.amount, 
      this.transactionId, 
      this.status, 
      this.v,});

  WithDraw.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    status = json['status'];
    v = json['__v'];
  }
  String? id;
  String? userId;
  num? amount;
  dynamic transactionId;
  String? status;
  num? v;
WithDraw copyWith({  String? id,
  String? userId,
  num? amount,
  dynamic transactionId,
  String? status,
  num? v,
}) => WithDraw(  id: id ?? this.id,
  userId: userId ?? this.userId,
  amount: amount ?? this.amount,
  transactionId: transactionId ?? this.transactionId,
  status: status ?? this.status,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['transaction_id'] = transactionId;
    map['status'] = status;
    map['__v'] = v;
    return map;
  }

}