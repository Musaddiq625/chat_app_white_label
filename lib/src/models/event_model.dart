/// _id : "12312313123213123"
/// userId : "6638c31fd243e634e5e6c2a8"
/// title : "test Events"
/// description : "Tech"
/// images : ["yes","yes","yes","yes"]
/// venue : [{"startDatetime":"","endDatetime":"","location":"ABC Jagah","capacity":"10"}]
/// questions : [{"questionId":"111","question":"Ek Question Hai Ya","isPublic":true,"isRequired":false,"sequence":1},{"questionId":"222","question":"Ek Question Hai Ya","isPublic":true,"isRequired":false,"sequence":1}]
/// pricing : {"originalPrice":"0","price":"0","couponCode":[{"code":"","discountAmount":"0","expiryDate":""}]}
/// eventFavouriteBy : ["11","12"]
/// eventParticipants : ["11","12"]
/// event_request : [{"id":"111","user_id":"123123","request_status":"accept/rejected/true/false","event_questions":[{"questionId":"111","answer":"answer of the question"},{"questionId":"111","answer":"answer of the question"}],"query":{"question":"abc query","answer":"abc answer of the query"}},{"id":"123","user_id":"123112312323","request_status":"accept/rejected/true/false","event_questions":[{"questionId":"111","answer":"answer of the question"},{"questionId":"111","answer":"answer of the question"}],"query":{"question":"abc query","answer":"abc answer of the query"}}]
/// isFree : false
/// isPublic : false
/// isApprovalRequired : false
/// isQuestionPublic : false

class EventModel {
  EventModel({
      this.id, 
      this.userId, 
      this.title, 
      this.description, 
      this.images, 
      this.venues,
      this.question,
      this.pricing, 
      this.eventFavouriteBy, 
      this.eventParticipant, 
      this.eventRequest, 
      this.isFree, 
      this.isPublic, 
      this.isApprovalRequired, 
      this.isQuestionPublic,});

  EventModel.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['venue'] != null) {
      venues = [];
      json['venue'].forEach((v) {
        venues?.add(Venue.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      question = [];
      json['questions'].forEach((v) {
        question?.add(Question.fromJson(v));
      });
    }
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    eventFavouriteBy = json['eventFavouriteBy'] != null ? json['eventFavouriteBy'].cast<String>() : [];
    eventParticipant = json['eventParticipants'] != null ? json['eventParticipants'].cast<String>() : [];
    if (json['event_request'] != null) {
      eventRequest = [];
      json['event_request'].forEach((v) {
        eventRequest?.add(EventRequest.fromJson(v));
      });
    }
    isFree = json['isFree'];
    isPublic = json['isPublic'];
    isApprovalRequired = json['isApprovalRequired'];
    isQuestionPublic = json['isQuestionPublic'];
  }
  String? id;
  String? userId;
  String? title;
  String? description;
  List<String>? images;
  List<Venue>? venues;
  List<Question>? question;
  Pricing? pricing;
  List<String>? eventFavouriteBy;
  List<String>? eventParticipant;
  List<EventRequest>? eventRequest;
  bool? isFree;
  bool? isPublic;
  bool? isApprovalRequired;
  bool? isQuestionPublic;
EventModel copyWith({  String? id,
  String? userId,
  String? title,
  String? description,
  List<String>? images,
  List<Venue>? venue,
  List<Question>? question,
  Pricing? pricing,
  List<String>? eventFavouriteBy,
  List<String>? eventParticipant,
  List<EventRequest>? eventRequest,
  bool? isFree,
  bool? isPublic,
  bool? isApprovalRequired,
  bool? isQuestionPublic,
}) => EventModel(  id: id ?? this.id,
  userId: userId ?? this.userId,
  title: title ?? this.title,
  description: description ?? this.description,
  images: images ?? this.images,
  venues: venue ?? this.venues,
  question: question ?? this.question,
  pricing: pricing ?? this.pricing,
  eventFavouriteBy: eventFavouriteBy ?? this.eventFavouriteBy,
  eventParticipant: eventParticipant ?? this.eventParticipant,
  eventRequest: eventRequest ?? this.eventRequest,
  isFree: isFree ?? this.isFree,
  isPublic: isPublic ?? this.isPublic,
  isApprovalRequired: isApprovalRequired ?? this.isApprovalRequired,
  isQuestionPublic: isQuestionPublic ?? this.isQuestionPublic,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['images'] = images;
    if (venues != null) {
      map['venue'] = venues?.map((v) => v.toJson()).toList();
    }
    if (question != null) {
      map['questions'] = question?.map((v) => v.toJson()).toList();
    }
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    map['eventFavouriteBy'] = eventFavouriteBy;
    map['eventParticipants'] = eventParticipant;
    if (eventRequest != null) {
      map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
    }
    map['isFree'] = isFree;
    map['isPublic'] = isPublic;
    map['isApprovalRequired'] = isApprovalRequired;
    map['isQuestionPublic'] = isQuestionPublic;
    return map;
  }

  Map<String, dynamic> createEventToJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['images'] = images;
    if (venues != null) {
      map['venue'] = venues?.map((v) => v.toJson()).toList();
    }
    if (question != null) {
      map['questions'] = question?.map((v) => v.toJson()).toList();
    }
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    map['eventFavouriteBy'] = eventFavouriteBy ?? [];
    map['eventParticipants'] = eventParticipant ?? [];
    if (eventRequest != null) {
      map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
    }
    map['isFree'] = isFree;
    map['isPublic'] = isPublic;
    map['isApprovalRequired'] = isApprovalRequired;
    map['isQuestionPublic'] = isQuestionPublic ?? false;
    return map;
  }
}

/// id : "111"
/// user_id : "123123"
/// request_status : "accept/rejected/true/false"
/// event_questions : [{"questionId":"111","answer":"answer of the question"},{"questionId":"111","answer":"answer of the question"}]
/// query : {"question":"abc query","answer":"abc answer of the query"}

class EventRequest {
  EventRequest({
      this.id, 
      this.userId, 
      this.requestStatus, 
      this.eventQuestions, 
      this.query,});

  EventRequest.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    requestStatus = json['request_status'];
    if (json['event_questions'] != null) {
      eventQuestions = [];
      json['event_questions'].forEach((v) {
        eventQuestions?.add(EventQuestions.fromJson(v));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }
  String? id;
  String? userId;
  String? requestStatus;
  List<EventQuestions>? eventQuestions;
  Query? query;
EventRequest copyWith({  String? id,
  String? userId,
  String? requestStatus,
  List<EventQuestions>? eventQuestions,
  Query? query,
}) => EventRequest(  id: id ?? this.id,
  userId: userId ?? this.userId,
  requestStatus: requestStatus ?? this.requestStatus,
  eventQuestions: eventQuestions ?? this.eventQuestions,
  query: query ?? this.query,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['request_status'] = requestStatus;
    if (eventQuestions != null) {
      map['event_questions'] = eventQuestions?.map((v) => v.toJson()).toList();
    }
    if (query != null) {
      map['query'] = query?.toJson();
    }
    return map;
  }

}

/// question : "abc query"
/// answer : "abc answer of the query"

class Query {
  Query({
      this.question, 
      this.answer,});

  Query.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;
Query copyWith({  String? question,
  String? answer,
}) => Query(  question: question ?? this.question,
  answer: answer ?? this.answer,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

}

/// questionId : "111"
/// answer : "answer of the question"

class EventQuestions {
  EventQuestions({
      this.questionId, 
      this.answer,});

  EventQuestions.fromJson(dynamic json) {
    questionId = json['questionId'];
    answer = json['answer'];
  }
  String? questionId;
  String? answer;
EventQuestions copyWith({  String? questionId,
  String? answer,
}) => EventQuestions(  questionId: questionId ?? this.questionId,
  answer: answer ?? this.answer,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['answer'] = answer;
    return map;
  }

}

/// originalPrice : "0"
/// price : "0"
/// couponCode : [{"code":"","discountAmount":"0","expiryDate":""}]

class Pricing {
  Pricing({
      this.originalPrice, 
      this.price, 
      this.couponCode,});

  Pricing.fromJson(dynamic json) {
    originalPrice = json['originalPrice'];
    price = json['price'];
    if (json['couponCode'] != null) {
      couponCode = [];
      json['couponCode'].forEach((v) {
        couponCode?.add(CouponCode.fromJson(v));
      });
    }
  }
  String? originalPrice;
  String? price;
  List<CouponCode>? couponCode;
Pricing copyWith({  String? originalPrice,
  String? price,
  List<CouponCode>? couponCode,
}) => Pricing(  originalPrice: originalPrice ?? this.originalPrice,
  price: price ?? this.price,
  couponCode: couponCode ?? this.couponCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originalPrice'] = originalPrice;
    map['price'] = price;
    if (couponCode != null) {
      map['couponCode'] = couponCode?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : ""
/// discountAmount : "0"
/// expiryDate : ""

class CouponCode {
  CouponCode({
      this.code, 
      this.discountAmount, 
      this.expiryDate,});

  CouponCode.fromJson(dynamic json) {
    code = json['code'];
    discountAmount = json['discountAmount'];
    expiryDate = json['expiryDate'];
  }
  String? code;
  String? discountAmount;
  String? expiryDate;
CouponCode copyWith({  String? code,
  String? discountAmount,
  String? expiryDate,
}) => CouponCode(  code: code ?? this.code,
  discountAmount: discountAmount ?? this.discountAmount,
  expiryDate: expiryDate ?? this.expiryDate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['discountAmount'] = discountAmount;
    map['expiryDate'] = expiryDate;
    return map;
  }

}

/// questionId : "111"
/// question : "Ek Question Hai Ya"
/// isPublic : true
/// isRequired : false
/// sequence : 1

class Question {
  Question({
      this.questionId, 
      this.question, 
      this.isPublic, 
      this.isRequired, 
      this.sequence,});

  Question.fromJson(dynamic json) {
    questionId = json['questionId'];
    question = json['question'];
    isPublic = json['isPublic'];
    isRequired = json['isRequired'];
    sequence = json['sequence'];
  }
  String? questionId;
  String? question;
  bool? isPublic;
  bool? isRequired;
  num? sequence;
Question copyWith({  String? questionId,
  String? question,
  bool? isPublic,
  bool? isRequired,
  num? sequence,
}) => Question(  questionId: questionId ?? this.questionId,
  question: question ?? this.question,
  isPublic: isPublic ?? this.isPublic,
  isRequired: isRequired ?? this.isRequired,
  sequence: sequence ?? this.sequence,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['question'] = question;
    map['isPublic'] = isPublic;
    map['isRequired'] = isRequired;
    map['sequence'] = sequence;
    return map;
  }

}

/// startDatetime : ""
/// endDatetime : ""
/// location : "ABC Jagah"
/// capacity : "10"

class Venue {
  Venue({
      this.startDatetime, 
      this.endDatetime, 
      this.location, 
      this.capacity,});

  Venue.fromJson(dynamic json) {
    startDatetime = json['startDatetime'];
    endDatetime = json['endDatetime'];
    location = json['location'];
    capacity = json['capacity'];
  }
  String? startDatetime;
  String? endDatetime;
  String? location;
  String? capacity;
Venue copyWith({  String? startDatetime,
  String? endDatetime,
  String? location,
  String? capacity,
}) => Venue(  startDatetime: startDatetime ?? this.startDatetime,
  endDatetime: endDatetime ?? this.endDatetime,
  location: location ?? this.location,
  capacity: capacity ?? this.capacity,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startDatetime'] = startDatetime;
    map['endDatetime'] = endDatetime;
    map['location'] = location ?? "";
    map['capacity'] = capacity;
    return map;
  }

}