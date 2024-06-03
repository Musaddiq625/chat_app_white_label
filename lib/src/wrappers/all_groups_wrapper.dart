/// code : 200
/// message : "Event going"
/// description : ""
/// data : {"allGroups":[{"eventFavouriteBy":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":[],"questions":[],"event_request":[{"id":"1716991896063","query":{"question":null,"answer":null},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"}],"_id":"66571ccac5f8737c41f9b497","title":"test group","type":"group","description":"asdasdasdasd","isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66549d3522bc471deedfe2be","userName":"asdasd asdasdasd","userImages":"/data/user/0/com.example.chat_app_white_label/cache/e782aa27-76ab-4734-a6bb-74a6810f9967/IMG_20240529_103707.jpg","userAboutMe":"asdasdasd","isVisibility":true,"createdAt":"2024-05-29T12:17:14.426Z","updatedAt":"2024-05-29T12:17:14.426Z","__v":1,"totalEarned":0,"ticketSold":0,"members":1}],"myGroups":[{"eventFavouriteBy":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":[],"questions":[{"questionId":"1717051419115","question":"you intereestd in group to join","isPublic":false,"isRequired":false,"sequence":1}],"event_request":[{"id":"1717051785796","event_questions":[{"questionId":"1717051419115","answer":"joing the group"}],"query":{"question":"testttt","answer":"yes accepted"},"user_id":"66472edbbb880ed91c93213d","name":"Jawwad test 1","aboutMe":"testing","image":null,"request_status":"Accepted"}],"_id":"6657493b52a7bb84c1243295","title":"groupo","type":"group","description":"adsasdasdasd","isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66332e92b9bc57c02be94bfc","userName":"tesss tsdasdasdasd","userImages":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","userAboutMe":"asdasdasdasd","isVisibility":true,"createdAt":"2024-05-29T15:26:51.418Z","updatedAt":"2024-05-29T15:26:51.418Z","__v":1,"totalEarned":0,"ticketSold":0,"members":1}],"totalEventsCount":{"allGroups":1,"myGroups":1}}
/// meta : {"totalCount":12,"defaultPageLimit":10,"pages":1,"pageSizes":10,"remainingCount":2}

class AllGroupsWrapper {
  AllGroupsWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  AllGroupsWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? code;
  String? message;
  String? description;
  Data? data;
  Meta? meta;
AllGroupsWrapper copyWith({  num? code,
  String? message,
  String? description,
  Data? data,
  Meta? meta,
}) => AllGroupsWrapper(  code: code ?? this.code,
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
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

/// totalCount : 12
/// defaultPageLimit : 10
/// pages : 1
/// pageSizes : 10
/// remainingCount : 2

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

/// allGroups : [{"eventFavouriteBy":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":[],"questions":[],"event_request":[{"id":"1716991896063","query":{"question":null,"answer":null},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"}],"_id":"66571ccac5f8737c41f9b497","title":"test group","type":"group","description":"asdasdasdasd","isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66549d3522bc471deedfe2be","userName":"asdasd asdasdasd","userImages":"/data/user/0/com.example.chat_app_white_label/cache/e782aa27-76ab-4734-a6bb-74a6810f9967/IMG_20240529_103707.jpg","userAboutMe":"asdasdasd","isVisibility":true,"createdAt":"2024-05-29T12:17:14.426Z","updatedAt":"2024-05-29T12:17:14.426Z","__v":1,"totalEarned":0,"ticketSold":0,"members":1}]
/// myGroups : [{"eventFavouriteBy":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":[],"questions":[{"questionId":"1717051419115","question":"you intereestd in group to join","isPublic":false,"isRequired":false,"sequence":1}],"event_request":[{"id":"1717051785796","event_questions":[{"questionId":"1717051419115","answer":"joing the group"}],"query":{"question":"testttt","answer":"yes accepted"},"user_id":"66472edbbb880ed91c93213d","name":"Jawwad test 1","aboutMe":"testing","image":null,"request_status":"Accepted"}],"_id":"6657493b52a7bb84c1243295","title":"groupo","type":"group","description":"adsasdasdasd","isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66332e92b9bc57c02be94bfc","userName":"tesss tsdasdasdasd","userImages":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","userAboutMe":"asdasdasdasd","isVisibility":true,"createdAt":"2024-05-29T15:26:51.418Z","updatedAt":"2024-05-29T15:26:51.418Z","__v":1,"totalEarned":0,"ticketSold":0,"members":1}]
/// totalEventsCount : {"allGroups":1,"myGroups":1}

class Data {
  Data({
      this.allGroups, 
      this.myGroups, 
      this.totalEventsCount,});

  Data.fromJson(dynamic json) {
    if (json['allGroups'] != null) {
      allGroups = [];
      json['allGroups'].forEach((v) {
        allGroups?.add(MyGroups.fromJson(v));
      });
    }
    if (json['myGroups'] != null) {
      myGroups = [];
      json['myGroups'].forEach((v) {
        myGroups?.add(MyGroups.fromJson(v));
      });
    }
    totalEventsCount = json['totalEventsCount'] != null ? TotalEventsCount.fromJson(json['totalEventsCount']) : null;
  }
  List<MyGroups>? allGroups;
  List<MyGroups>? myGroups;
  TotalEventsCount? totalEventsCount;
Data copyWith({  List<MyGroups>? allGroups,
  List<MyGroups>? myGroups,
  TotalEventsCount? totalEventsCount,
}) => Data(  allGroups: allGroups ?? this.allGroups,
  myGroups: myGroups ?? this.myGroups,
  totalEventsCount: totalEventsCount ?? this.totalEventsCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (allGroups != null) {
      map['allGroups'] = allGroups?.map((v) => v.toJson()).toList();
    }
    if (myGroups != null) {
      map['myGroups'] = myGroups?.map((v) => v.toJson()).toList();
    }
    if (totalEventsCount != null) {
      map['totalEventsCount'] = totalEventsCount?.toJson();
    }
    return map;
  }

}

/// allGroups : 1
/// myGroups : 1

class TotalEventsCount {
  TotalEventsCount({
      this.allGroups, 
      this.myGroups,});

  TotalEventsCount.fromJson(dynamic json) {
    allGroups = json['allGroups'];
    myGroups = json['myGroups'];
  }
  num? allGroups;
  num? myGroups;
TotalEventsCount copyWith({  num? allGroups,
  num? myGroups,
}) => TotalEventsCount(  allGroups: allGroups ?? this.allGroups,
  myGroups: myGroups ?? this.myGroups,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allGroups'] = allGroups;
    map['myGroups'] = myGroups;
    return map;
  }

}

/// eventFavouriteBy : []
/// images : ["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"]
/// categories : []
/// questions : [{"questionId":"1717051419115","question":"you intereestd in group to join","isPublic":false,"isRequired":false,"sequence":1}]
/// event_request : [{"id":"1717051785796","event_questions":[{"questionId":"1717051419115","answer":"joing the group"}],"query":{"question":"testttt","answer":"yes accepted"},"user_id":"66472edbbb880ed91c93213d","name":"Jawwad test 1","aboutMe":"testing","image":null,"request_status":"Accepted"}]
/// _id : "6657493b52a7bb84c1243295"
/// title : "groupo"
/// type : "group"
/// description : "adsasdasdasd"
/// isFree : true
/// isPublic : true
/// isApprovalRequired : true
/// isQuestionPublic : false
/// userId : "66332e92b9bc57c02be94bfc"
/// userName : "tesss tsdasdasdasd"
/// userImages : "/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg"
/// userAboutMe : "asdasdasdasd"
/// isVisibility : true
/// createdAt : "2024-05-29T15:26:51.418Z"
/// updatedAt : "2024-05-29T15:26:51.418Z"
/// __v : 1
/// totalEarned : 0
/// ticketSold : 0
/// members : 1

class MyGroups {
  MyGroups({
      this.eventFavouriteBy, 
      this.images, 
      this.categories, 
      this.questions, 
      this.eventRequest, 
      this.id, 
      this.title, 
      this.type, 
      this.description, 
      this.isFree, 
      this.isPublic, 
      this.isApprovalRequired, 
      this.isQuestionPublic, 
      this.userId, 
      this.userName, 
      this.userImages, 
      this.userAboutMe, 
      this.isVisibility, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalEarned, 
      this.ticketSold, 
      this.members,});

  MyGroups.fromJson(dynamic json) {

    eventFavouriteBy = json['eventFavouriteBy'] != null ? json['eventFavouriteBy'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    categories = json['categories'] != null ? json['categories'].cast<String>() : [];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
    if (json['event_request'] != null) {
      eventRequest = [];
      json['event_request'].forEach((v) {
        eventRequest?.add(EventRequests.fromJson(v));
      });
    }
    id = json['_id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    isFree = json['isFree'];
    isPublic = json['isPublic'];
    isApprovalRequired = json['isApprovalRequired'];
    isQuestionPublic = json['isQuestionPublic'];
    userId = json['userId'];
    userName = json['userName'];
    userImages = json['userImages'];
    userAboutMe = json['userAboutMe'];
    isVisibility = json['isVisibility'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalEarned = json['totalEarned'];
    ticketSold = json['ticketSold'];
    members = json['members'];
  }
  List<String>? eventFavouriteBy;
  List<String>? images;
  List<String>? categories;
  List<Questions>? questions;
  List<EventRequests>? eventRequest;
  String? id;
  String? title;
  String? type;
  String? description;
  bool? isFree;
  bool? isPublic;
  bool? isApprovalRequired;
  bool? isQuestionPublic;
  String? userId;
  String? userName;
  String? userImages;
  String? userAboutMe;
  bool? isVisibility;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalEarned;
  num? ticketSold;
  num? members;
MyGroups copyWith({  List<String>? eventFavouriteBy,
  List<String>? images,
  List<String>? categories,
  List<Questions>? questions,
  List<EventRequests>? eventRequest,
  String? id,
  String? title,
  String? type,
  String? description,
  bool? isFree,
  bool? isPublic,
  bool? isApprovalRequired,
  bool? isQuestionPublic,
  String? userId,
  String? userName,
  String? userImages,
  String? userAboutMe,
  bool? isVisibility,
  String? createdAt,
  String? updatedAt,
  num? v,
  num? totalEarned,
  num? ticketSold,
  num? members,
}) => MyGroups(

  eventFavouriteBy: eventFavouriteBy ?? this.eventFavouriteBy,
  images: images ?? this.images,
  categories: categories ?? this.categories,
  questions: questions ?? this.questions,
  eventRequest: eventRequest ?? this.eventRequest,
  id: id ?? this.id,
  title: title ?? this.title,
  type: type ?? this.type,
  description: description ?? this.description,
  isFree: isFree ?? this.isFree,
  isPublic: isPublic ?? this.isPublic,
  isApprovalRequired: isApprovalRequired ?? this.isApprovalRequired,
  isQuestionPublic: isQuestionPublic ?? this.isQuestionPublic,
  userId: userId ?? this.userId,
  userName: userName ?? this.userName,
  userImages: userImages ?? this.userImages,
  userAboutMe: userAboutMe ?? this.userAboutMe,
  isVisibility: isVisibility ?? this.isVisibility,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
  totalEarned: totalEarned ?? this.totalEarned,
  ticketSold: ticketSold ?? this.ticketSold,
  members: members ?? this.members,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventFavouriteBy'] = eventFavouriteBy;
    map['images'] = images;
    map['categories'] = categories;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    if (eventRequest != null) {
      map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['description'] = description;
    map['isFree'] = isFree;
    map['isPublic'] = isPublic;
    map['isApprovalRequired'] = isApprovalRequired;
    map['isQuestionPublic'] = isQuestionPublic;
    map['userId'] = userId;
    map['userName'] = userName;
    map['userImages'] = userImages;
    map['userAboutMe'] = userAboutMe;
    map['isVisibility'] = isVisibility;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['totalEarned'] = totalEarned;
    map['ticketSold'] = ticketSold;
    map['members'] = members;
    return map;
  }

}

/// id : "1717051785796"
/// event_questions : [{"questionId":"1717051419115","answer":"joing the group"}]
/// query : {"question":"testttt","answer":"yes accepted"}
/// user_id : "66472edbbb880ed91c93213d"
/// name : "Jawwad test 1"
/// aboutMe : "testing"
/// image : null
/// request_status : "Accepted"

class EventRequests {
  EventRequests({
      this.id, 
      this.eventQuestions, 
      this.query, 
      this.userId, 
      this.name, 
      this.aboutMe, 
      this.image, 
      this.requestStatus,});

  EventRequests.fromJson(dynamic json) {
    id = json['id'];
    if (json['event_questions'] != null) {
      eventQuestions = [];
      json['event_questions'].forEach((v) {
        eventQuestions?.add(EventQuestions.fromJson(v));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
    userId = json['user_id'];
    name = json['name'];
    aboutMe = json['aboutMe'];
    image = json['image'];
    requestStatus = json['request_status'];
  }
  String? id;
  List<EventQuestions>? eventQuestions;
  Query? query;
  String? userId;
  String? name;
  String? aboutMe;
  dynamic image;
  String? requestStatus;
EventRequests copyWith({  String? id,
  List<EventQuestions>? eventQuestions,
  Query? query,
  String? userId,
  String? name,
  String? aboutMe,
  dynamic image,
  String? requestStatus,
}) => EventRequests(  id: id ?? this.id,
  eventQuestions: eventQuestions ?? this.eventQuestions,
  query: query ?? this.query,
  userId: userId ?? this.userId,
  name: name ?? this.name,
  aboutMe: aboutMe ?? this.aboutMe,
  image: image ?? this.image,
  requestStatus: requestStatus ?? this.requestStatus,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (eventQuestions != null) {
      map['event_questions'] = eventQuestions?.map((v) => v.toJson()).toList();
    }
    if (query != null) {
      map['query'] = query?.toJson();
    }
    map['user_id'] = userId;
    map['name'] = name;
    map['aboutMe'] = aboutMe;
    map['image'] = image;
    map['request_status'] = requestStatus;
    return map;
  }

}

/// question : "testttt"
/// answer : "yes accepted"

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

/// questionId : "1717051419115"
/// answer : "joing the group"

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

/// questionId : "1717051419115"
/// question : "you intereestd in group to join"
/// isPublic : false
/// isRequired : false
/// sequence : 1

class Questions {
  Questions({
      this.questionId, 
      this.question, 
      this.isPublic, 
      this.isRequired, 
      this.sequence,});

  Questions.fromJson(dynamic json) {
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
Questions copyWith({  String? questionId,
  String? question,
  bool? isPublic,
  bool? isRequired,
  num? sequence,
}) => Questions(  questionId: questionId ?? this.questionId,
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

/// eventFavouriteBy : []
/// images : ["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"]
/// categories : []
/// questions : []
/// event_request : [{"id":"1716991896063","query":{"question":null,"answer":null},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"}]
/// _id : "66571ccac5f8737c41f9b497"
/// title : "test group"
/// type : "group"
/// description : "asdasdasdasd"
/// isFree : true
/// isPublic : true
/// isApprovalRequired : true
/// isQuestionPublic : false
/// userId : "66549d3522bc471deedfe2be"
/// userName : "asdasd asdasdasd"
/// userImages : "/data/user/0/com.example.chat_app_white_label/cache/e782aa27-76ab-4734-a6bb-74a6810f9967/IMG_20240529_103707.jpg"
/// userAboutMe : "asdasdasd"
/// isVisibility : true
/// createdAt : "2024-05-29T12:17:14.426Z"
/// updatedAt : "2024-05-29T12:17:14.426Z"
/// __v : 1
/// totalEarned : 0
/// ticketSold : 0
/// members : 1

// class AllGroups {
//   AllGroups({
//       this.eventFavouriteBy,
//       this.images,
//       this.categories,
//       this.questions,
//       this.eventRequest,
//       this.id,
//       this.title,
//       this.type,
//       this.description,
//       this.isFree,
//       this.isPublic,
//       this.isApprovalRequired,
//       this.isQuestionPublic,
//       this.userId,
//       this.userName,
//       this.userImages,
//       this.userAboutMe,
//       this.isVisibility,
//       this.createdAt,
//       this.updatedAt,
//       this.v,
//       this.totalEarned,
//       this.ticketSold,
//       this.members,});
//
//   AllGroups.fromJson(dynamic json) {
//     if (json['eventFavouriteBy'] != null) {
//       eventFavouriteBy = [];
//       json['eventFavouriteBy'].forEach((v) {
//         eventFavouriteBy?.add(Dynamic.fromJson(v));
//       });
//     }
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     if (json['categories'] != null) {
//       categories = [];
//       json['categories'].forEach((v) {
//         categories?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['questions'] != null) {
//       questions = [];
//       json['questions'].forEach((v) {
//         questions?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['event_request'] != null) {
//       eventRequest = [];
//       json['event_request'].forEach((v) {
//         eventRequest?.add(EventRequest.fromJson(v));
//       });
//     }
//     id = json['_id'];
//     title = json['title'];
//     type = json['type'];
//     description = json['description'];
//     isFree = json['isFree'];
//     isPublic = json['isPublic'];
//     isApprovalRequired = json['isApprovalRequired'];
//     isQuestionPublic = json['isQuestionPublic'];
//     userId = json['userId'];
//     userName = json['userName'];
//     userImages = json['userImages'];
//     userAboutMe = json['userAboutMe'];
//     isVisibility = json['isVisibility'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     v = json['__v'];
//     totalEarned = json['totalEarned'];
//     ticketSold = json['ticketSold'];
//     members = json['members'];
//   }
//   List<dynamic>? eventFavouriteBy;
//   List<String>? images;
//   List<dynamic>? categories;
//   List<dynamic>? questions;
//   List<EventRequest>? eventRequest;
//   String? id;
//   String? title;
//   String? type;
//   String? description;
//   bool? isFree;
//   bool? isPublic;
//   bool? isApprovalRequired;
//   bool? isQuestionPublic;
//   String? userId;
//   String? userName;
//   String? userImages;
//   String? userAboutMe;
//   bool? isVisibility;
//   String? createdAt;
//   String? updatedAt;
//   num? v;
//   num? totalEarned;
//   num? ticketSold;
//   num? members;
// AllGroups copyWith({  List<dynamic>? eventFavouriteBy,
//   List<String>? images,
//   List<dynamic>? categories,
//   List<dynamic>? questions,
//   List<EventRequest>? eventRequest,
//   String? id,
//   String? title,
//   String? type,
//   String? description,
//   bool? isFree,
//   bool? isPublic,
//   bool? isApprovalRequired,
//   bool? isQuestionPublic,
//   String? userId,
//   String? userName,
//   String? userImages,
//   String? userAboutMe,
//   bool? isVisibility,
//   String? createdAt,
//   String? updatedAt,
//   num? v,
//   num? totalEarned,
//   num? ticketSold,
//   num? members,
// }) => AllGroups(  eventFavouriteBy: eventFavouriteBy ?? this.eventFavouriteBy,
//   images: images ?? this.images,
//   categories: categories ?? this.categories,
//   questions: questions ?? this.questions,
//   eventRequest: eventRequest ?? this.eventRequest,
//   id: id ?? this.id,
//   title: title ?? this.title,
//   type: type ?? this.type,
//   description: description ?? this.description,
//   isFree: isFree ?? this.isFree,
//   isPublic: isPublic ?? this.isPublic,
//   isApprovalRequired: isApprovalRequired ?? this.isApprovalRequired,
//   isQuestionPublic: isQuestionPublic ?? this.isQuestionPublic,
//   userId: userId ?? this.userId,
//   userName: userName ?? this.userName,
//   userImages: userImages ?? this.userImages,
//   userAboutMe: userAboutMe ?? this.userAboutMe,
//   isVisibility: isVisibility ?? this.isVisibility,
//   createdAt: createdAt ?? this.createdAt,
//   updatedAt: updatedAt ?? this.updatedAt,
//   v: v ?? this.v,
//   totalEarned: totalEarned ?? this.totalEarned,
//   ticketSold: ticketSold ?? this.ticketSold,
//   members: members ?? this.members,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (eventFavouriteBy != null) {
//       map['eventFavouriteBy'] = eventFavouriteBy?.map((v) => v.toJson()).toList();
//     }
//     map['images'] = images;
//     if (categories != null) {
//       map['categories'] = categories?.map((v) => v.toJson()).toList();
//     }
//     if (questions != null) {
//       map['questions'] = questions?.map((v) => v.toJson()).toList();
//     }
//     if (eventRequest != null) {
//       map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
//     }
//     map['_id'] = id;
//     map['title'] = title;
//     map['type'] = type;
//     map['description'] = description;
//     map['isFree'] = isFree;
//     map['isPublic'] = isPublic;
//     map['isApprovalRequired'] = isApprovalRequired;
//     map['isQuestionPublic'] = isQuestionPublic;
//     map['userId'] = userId;
//     map['userName'] = userName;
//     map['userImages'] = userImages;
//     map['userAboutMe'] = userAboutMe;
//     map['isVisibility'] = isVisibility;
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = v;
//     map['totalEarned'] = totalEarned;
//     map['ticketSold'] = ticketSold;
//     map['members'] = members;
//     return map;
//   }
//
// }
//
// /// id : "1716991896063"
// /// query : {"question":null,"answer":null}
// /// user_id : "66332e92b9bc57c02be94bfc"
// /// name : "tesss tsdasdasdasd"
// /// aboutMe : "asdasdasdasd"
// /// image : "/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg"
// /// request_status : "Accepted"
//
// class EventRequest {
//   EventRequest({
//       this.id,
//       this.query,
//       this.userId,
//       this.name,
//       this.aboutMe,
//       this.image,
//       this.requestStatus,});
//
//   EventRequest.fromJson(dynamic json) {
//     id = json['id'];
//     query = json['query'] != null ? Query.fromJson(json['query']) : null;
//     userId = json['user_id'];
//     name = json['name'];
//     aboutMe = json['aboutMe'];
//     image = json['image'];
//     requestStatus = json['request_status'];
//   }
//   String? id;
//   Query? query;
//   String? userId;
//   String? name;
//   String? aboutMe;
//   String? image;
//   String? requestStatus;
// EventRequest copyWith({  String? id,
//   Query? query,
//   String? userId,
//   String? name,
//   String? aboutMe,
//   String? image,
//   String? requestStatus,
// }) => EventRequest(  id: id ?? this.id,
//   query: query ?? this.query,
//   userId: userId ?? this.userId,
//   name: name ?? this.name,
//   aboutMe: aboutMe ?? this.aboutMe,
//   image: image ?? this.image,
//   requestStatus: requestStatus ?? this.requestStatus,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     if (query != null) {
//       map['query'] = query?.toJson();
//     }
//     map['user_id'] = userId;
//     map['name'] = name;
//     map['aboutMe'] = aboutMe;
//     map['image'] = image;
//     map['request_status'] = requestStatus;
//     return map;
//   }
//
// }
//
// /// question : null
// /// answer : null
//
// class Query {
//   Query({
//       this.question,
//       this.answer,});
//
//   Query.fromJson(dynamic json) {
//     question = json['question'];
//     answer = json['answer'];
//   }
//   dynamic question;
//   dynamic answer;
// Query copyWith({  dynamic question,
//   dynamic answer,
// }) => Query(  question: question ?? this.question,
//   answer: answer ?? this.answer,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['question'] = question;
//     map['answer'] = answer;
//     return map;
//   }
//
// }