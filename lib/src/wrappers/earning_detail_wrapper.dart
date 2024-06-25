/// code : 200
/// message : "Earnings retrieved successfully"
/// description : ""
/// data : {"totalEarnings":149456,"earningsDetails":[{"eventName":"test basit","username":"Jawwad test 1","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg","price":34234},{"eventName":"test basit","username":"John Cena","image":"","price":34234},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":6000},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":6000},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"Live Event","username":"Sir Taha Irshad","image":"https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg","price":50},{"eventName":"test basit","username":"sda da","image":"sadsad","price":34234},{"eventName":"test basit","username":"sda da","image":"sadsad","price":34234},{"eventName":"assadasdsad","username":"Test Adil","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000650.jpg","price":0},{"eventName":"assadasdsad","username":"Test Adil","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000650.jpg","price":0},{"eventName":"assadasdsad","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":5},{"eventName":"assadasdsad","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":5},{"eventName":"HELLO WORLD","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":10}]}
/// meta : null

class EarningDetailWrapper {
  EarningDetailWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  EarningDetailWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data = json['data'] != null ? EarningData.fromJson(json['data']) : null;
    meta = json['meta'];
  }
  num? code;
  String? message;
  String? description;
  EarningData? data;
  dynamic meta;
EarningDetailWrapper copyWith({  num? code,
  String? message,
  String? description,
  EarningData? data,
  dynamic meta,
}) => EarningDetailWrapper(  code: code ?? this.code,
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

/// totalEarnings : 149456
/// earningsDetails : [{"eventName":"test basit","username":"Jawwad test 1","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg","price":34234},{"eventName":"test basit","username":"John Cena","image":"","price":34234},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":6000},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":6000},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"test basit","username":"tesss tsdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","price":150},{"eventName":"Live Event","username":"Sir Taha Irshad","image":"https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg","price":50},{"eventName":"test basit","username":"sda da","image":"sadsad","price":34234},{"eventName":"test basit","username":"sda da","image":"sadsad","price":34234},{"eventName":"assadasdsad","username":"Test Adil","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000650.jpg","price":0},{"eventName":"assadasdsad","username":"Test Adil","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000650.jpg","price":0},{"eventName":"assadasdsad","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":5},{"eventName":"assadasdsad","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":5},{"eventName":"HELLO WORLD","username":"test adi","image":"https://locals.se-sto-1.linodeobjects.com/profile/images (6).jpg","price":10}]

class EarningData {
  EarningData({
      this.totalEarnings, 
      this.earningsDetails,});

  EarningData.fromJson(dynamic json) {
    totalEarnings = json['totalEarnings'];
    if (json['earningsDetails'] != null) {
      earningsDetails = [];
      json['earningsDetails'].forEach((v) {
        earningsDetails?.add(EarningsDetails.fromJson(v));
      });
    }
  }
  num? totalEarnings;
  List<EarningsDetails>? earningsDetails;
EarningData copyWith({  num? totalEarnings,
  List<EarningsDetails>? earningsDetails,
}) => EarningData(  totalEarnings: totalEarnings ?? this.totalEarnings,
  earningsDetails: earningsDetails ?? this.earningsDetails,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalEarnings'] = totalEarnings;
    if (earningsDetails != null) {
      map['earningsDetails'] = earningsDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// eventName : "test basit"
/// username : "Jawwad test 1"
/// image : "https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg"
/// price : 34234

class EarningsDetails {
  EarningsDetails({
      this.eventName, 
      this.username, 
      this.image, 
      this.price,});

  EarningsDetails.fromJson(dynamic json) {
    eventName = json['eventName'];
    username = json['username'];
    image = json['image'];
    price = json['price'];
  }
  String? eventName;
  String? username;
  String? image;
  num? price;
EarningsDetails copyWith({  String? eventName,
  String? username,
  String? image,
  num? price,
}) => EarningsDetails(  eventName: eventName ?? this.eventName,
  username: username ?? this.username,
  image: image ?? this.image,
  price: price ?? this.price,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventName'] = eventName;
    map['username'] = username;
    map['image'] = image;
    map['price'] = price;
    return map;
  }

}