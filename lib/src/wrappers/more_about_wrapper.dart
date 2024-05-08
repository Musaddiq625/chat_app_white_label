/// code : 200
/// message : "Data retrieved successfully"
/// description : ""
/// data : [{"diet":["Vegan","Vegetarians","Love meat","Everything is fine","I'd rather not say"],"workout":["Active","Sometimes","Almost Never","I'd rather not say"],"height":["4'0 (122 cm)","4'3 (130 cm)","4'4 (132 cm)","4'5 (134 cm)","4'6 (137 cm)","4'7 (139 cm)","4'8 (142 cm)","4'9 (144 cm)","4'10 (147 cm)","4'11 (149 cm)","5'0 (152 cm)","5'3 (160 cm)","5'4 (163 cm)","5'5 (165 cm)","5'6 (168 cm)","5'7 (170 cm)","5'8 (173 cm)","5'9 (175 cm)","5'10 (178 cm)","5'11 (180 cm)","6'0 (183 cm)","6'3 (190 cm)","6'4 (193 cm)","6'5 (196 cm)","6'6 (198 cm)","6'7 (201 cm)","6'8 (203 cm)","6'9 (206 cm)","6'10 (208 cm)","6'11 (211 cm)","7'0 (213 cm)","7'3 (221 cm)","7'4 (224 cm)","7'5 (226 cm)","7'6 (229 cm)","7'7 (231 cm)","7'8 (234 cm)","7'9 (236 cm)","7'10 (239 cm)","7'11 (241 cm)","8'0 (244 cm)","8'3 (251 cm)","8'4 (254 cm)","8'5 (257 cm)","8'6 (259 cm)","8'7 (262 cm)","8'8 (264 cm)","8'9 (267 cm)","8'10 (270 cm)","8'11 (272 cm)"],"smoking":["Socially","Regularly","Never","I'd rather not say"],"drinking":["Socially","Regularly","Never","I'd rather not say"],"pets":["Cat","Dog","Other","I'd rather not say"],"_id":"66389468f22bde3dbc3b0201","__v":2}]
/// meta : {"totalCount":1,"defaultPageLimit":10,"pages":1,"pageSizes":10}

class MoreAboutWrapper {
  MoreAboutWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  MoreAboutWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MoreAboutList.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? code;
  String? message;
  String? description;
  List<MoreAboutList>? data;
  Meta? meta;

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

class Meta {
  Meta({
      this.totalCount, 
      this.defaultPageLimit, 
      this.pages, 
      this.pageSizes,});

  Meta.fromJson(dynamic json) {
    totalCount = json['totalCount'];
    defaultPageLimit = json['defaultPageLimit'];
    pages = json['pages'];
    pageSizes = json['pageSizes'];
  }
  num? totalCount;
  num? defaultPageLimit;
  num? pages;
  num? pageSizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = totalCount;
    map['defaultPageLimit'] = defaultPageLimit;
    map['pages'] = pages;
    map['pageSizes'] = pageSizes;
    return map;
  }

}

/// diet : ["Vegan","Vegetarians","Love meat","Everything is fine","I'd rather not say"]
/// workout : ["Active","Sometimes","Almost Never","I'd rather not say"]
/// height : ["4'0 (122 cm)","4'3 (130 cm)","4'4 (132 cm)","4'5 (134 cm)","4'6 (137 cm)","4'7 (139 cm)","4'8 (142 cm)","4'9 (144 cm)","4'10 (147 cm)","4'11 (149 cm)","5'0 (152 cm)","5'3 (160 cm)","5'4 (163 cm)","5'5 (165 cm)","5'6 (168 cm)","5'7 (170 cm)","5'8 (173 cm)","5'9 (175 cm)","5'10 (178 cm)","5'11 (180 cm)","6'0 (183 cm)","6'3 (190 cm)","6'4 (193 cm)","6'5 (196 cm)","6'6 (198 cm)","6'7 (201 cm)","6'8 (203 cm)","6'9 (206 cm)","6'10 (208 cm)","6'11 (211 cm)","7'0 (213 cm)","7'3 (221 cm)","7'4 (224 cm)","7'5 (226 cm)","7'6 (229 cm)","7'7 (231 cm)","7'8 (234 cm)","7'9 (236 cm)","7'10 (239 cm)","7'11 (241 cm)","8'0 (244 cm)","8'3 (251 cm)","8'4 (254 cm)","8'5 (257 cm)","8'6 (259 cm)","8'7 (262 cm)","8'8 (264 cm)","8'9 (267 cm)","8'10 (270 cm)","8'11 (272 cm)"]
/// smoking : ["Socially","Regularly","Never","I'd rather not say"]
/// drinking : ["Socially","Regularly","Never","I'd rather not say"]
/// pets : ["Cat","Dog","Other","I'd rather not say"]
/// _id : "66389468f22bde3dbc3b0201"
/// __v : 2

class MoreAboutList {
  MoreAboutList({
      this.diet, 
      this.workout, 
      this.height, 
      this.smoking, 
      this.drinking, 
      this.pets, 
      this.id, 
      this.v,});

  MoreAboutList.fromJson(dynamic json) {
    diet = json['diet'] != null ? json['diet'].cast<String>() : [];
    workout = json['workout'] != null ? json['workout'].cast<String>() : [];
    height = json['height'] != null ? json['height'].cast<String>() : [];
    smoking = json['smoking'] != null ? json['smoking'].cast<String>() : [];
    drinking = json['drinking'] != null ? json['drinking'].cast<String>() : [];
    pets = json['pets'] != null ? json['pets'].cast<String>() : [];
    id = json['_id'];
    v = json['__v'];
  }
  List<String>? diet;
  List<String>? workout;
  List<String>? height;
  List<String>? smoking;
  List<String>? drinking;
  List<String>? pets;
  String? id;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diet'] = diet;
    map['workout'] = workout;
    map['height'] = height;
    map['smoking'] = smoking;
    map['drinking'] = drinking;
    map['pets'] = pets;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }

}