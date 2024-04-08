/// id : 121221
/// user_id : "11111"
/// start_date : "14545641225"
/// end_date : "88969656956"
/// title : "Aftar"
/// description : "test discription"
/// event_favourite_by : ["123","456"]
/// event_images : ["img1","img2"]
/// event_participant : ["11","12"]
/// event_request : ["11","12"]
/// is_free : true
/// is_guest_approved : true
/// is_questions_required : true
/// location : "Karachi,Pakistan"
/// pricing : {"original_price":"100000","discounted_price":"5111","coupon_code":{"code":"0","coupon_discounted_price":"5111","expiry_date":"543666222"}}
/// questions : {"question_1":{"answer":"answer","is_public":true,"is_required":true,"question":"test"}}
/// query: {"user_id":{"question":"abc question","answer":"answer pf the question"}}
/// visibility : {"is_private":false,"is_public":true}

class EventDataModel {
  EventDataModel({
      this.id, 
      this.userId, 
      this.startDate, 
      this.endDate, 
      this.title, 
      this.description, 
      this.eventFavouriteBy, 
      this.eventImages, 
      this.eventParticipant, 
      this.eventRequestId,
      this.isFree,
      this.isGuestApproved, 
      this.isQuestionsRequired, 
      this.location, 
      this.pricing, 
      this.questions, 
      // this.query,
      this.visibility,});

  EventDataModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    title = json['title'];
    description = json['description'];
    eventFavouriteBy = json['event_favourite_by'] != null ? json['event_favourite_by'].cast<String>() : [];
    eventImages = json['event_images'] != null ? json['event_images'].cast<String>() : [];
    eventParticipant = json['event_participant'] != null ? json['event_participant'].cast<String>() : [];
    eventRequestId = json['event_request'] != null ? json['event_request'].cast<String>() : [];
    isFree = json['is_free'];
    isGuestApproved = json['is_guest_approved'];
    isQuestionsRequired = json['is_questions_required'];
    location = json['location'];
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    questions = json['questions'] != null ? Questions.fromJson(json['questions']) : null;
    // query = json['query'] != null ? Query.fromJson(json['query']) : null;
    visibility = json['visibility'] != null ? Visibility.fromJson(json['visibility']) : null;
  }
  String? id;
  String? userId;
  String? startDate;
  String? endDate;
  String? title;
  String? description;
  List<String>? eventFavouriteBy;
  List<String>? eventImages;
  List<String>? eventParticipant;
  List<String>? eventRequestId;
  bool? isFree;
  bool? isGuestApproved;
  bool? isQuestionsRequired;
  String? location;
  Pricing? pricing;
  Questions? questions;
  // Query? query;
  Visibility? visibility;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['title'] = title;
    map['description'] = description;
    map['event_favourite_by'] = eventFavouriteBy;
    map['event_images'] = eventImages;
    map['event_participant'] = eventParticipant;
    map['event_request'] = eventRequestId;
    map['is_free'] = isFree;
    map['is_guest_approved'] = isGuestApproved;
    map['is_questions_required'] = isQuestionsRequired;
    map['location'] = location;
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    if (questions != null) {
      map['questions'] = questions?.toJson();
    }
    // if (query != null) {
    //   map['query'] = query?.toJson();
    // }
    if (visibility != null) {
      map['visibility'] = visibility?.toJson();
    }
    return map;
  }

}

/// is_private : false
/// is_public : true

class Visibility {
  Visibility({
      this.isPrivate, 
      this.isPublic,});

  Visibility.fromJson(dynamic json) {
    isPrivate = json['is_private'];
    isPublic = json['is_public'];
  }
  bool? isPrivate;
  bool? isPublic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_private'] = isPrivate;
    map['is_public'] = isPublic;
    return map;
  }

}

/// question_1 : {"answer":"answer","is_public":true,"is_required":true,"question":"test"}

class Questions {
  Questions({
      this.question1,});

  Questions.fromJson(dynamic json) {
    question1 = json['question_1'] != null ? Question1.fromJson(json['question_1']) : null;
  }
  Question1? question1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (question1 != null) {
      map['question_1'] = question1?.toJson();
    }
    return map;
  }

}

/// answer : "answer"
/// is_public : true
/// is_required : true
/// question : "test"

class Question1 {
  Question1({
      this.answer, 
      this.isPublic, 
      this.isRequired, 
      this.question,});

  Question1.fromJson(dynamic json) {
    answer = json['answer'];
    isPublic = json['is_public'];
    isRequired = json['is_required'];
    question = json['question'];
  }
  String? answer;
  bool? isPublic;
  bool? isRequired;
  String? question;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    map['is_public'] = isPublic;
    map['is_required'] = isRequired;
    map['question'] = question;
    return map;
  }

}



// /// user_id : {"question":"abc question","answer":"test answer"}
//
// class Query {
//   Query({
//     this.userId,});
//
//   Query.fromJson(dynamic json) {
//     userId = json['user_id'] != null ? QueryUserId.fromJson(json['user_id']) : null;
//   }
//   QueryUserId? userId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (userId != null) {
//       map['user_id'] = userId?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// question : "abc question"
// /// answer : "test answer"
//
// class QueryUserId {
//   QueryUserId({
//     this.answer,
//     this.question,});
//
//   QueryUserId.fromJson(dynamic json) {
//     answer = json['answer'];
//     question = json['question'];
//   }
//   String? answer;
//   String? question;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['answer'] = answer;
//     map['question'] = question;
//     return map;
//   }
//
// }

/// original_price : "100000"
/// discounted_price : "5111"
/// coupon_code : {"code":"0","coupon_discounted_price":"5111","expiry_date":"543666222"}

class Pricing {
  Pricing({
      this.originalPrice, 
      this.discountedPrice, 
      this.couponCode,});

  Pricing.fromJson(dynamic json) {
    originalPrice = json['original_price'];
    discountedPrice = json['discounted_price'];
    couponCode = json['coupon_code'] != null ? CouponCode.fromJson(json['coupon_code']) : null;
  }
  String? originalPrice;
  String? discountedPrice;
  CouponCode? couponCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original_price'] = originalPrice;
    map['discounted_price'] = discountedPrice;
    if (couponCode != null) {
      map['coupon_code'] = couponCode?.toJson();
    }
    return map;
  }

}

/// code : "0"
/// coupon_discounted_price : "5111"
/// expiry_date : "543666222"

class CouponCode {
  CouponCode({
      this.code, 
      this.couponDiscountedPrice, 
      this.expiryDate,});

  CouponCode.fromJson(dynamic json) {
    code = json['code'];
    couponDiscountedPrice = json['coupon_discounted_price'];
    expiryDate = json['expiry_date'];
  }
  String? code;
  String? couponDiscountedPrice;
  String? expiryDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['coupon_discounted_price'] = couponDiscountedPrice;
    map['expiry_date'] = expiryDate;
    return map;
  }

}