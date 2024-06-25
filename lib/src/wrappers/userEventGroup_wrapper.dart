/// code : 200
/// message : "Event going"
/// description : ""
/// data : {"events":[{"eventFavouriteBy":["66683061de8af77273dd65ca"],"eventParticipants":[],"images":["https://locals.se-sto-1.linodeobjects.com/event/IMG_20240529_103654.jpg"],"categories":[],"questions":[],"venue":[{"startDatetime":"2024-06-28 18:04:00.000","endDatetime":"2024-06-29 18:04:00.000","location":"","capacity":"Unlimited"}],"event_request":[{"id":"1718114108997","event_questions":[{"questionId":"1718113115543","answer":"agagaga"}],"query":{"question":"avavHhahaa","answer":""},"user_id":"66683061de8af77273dd65ca","name":"Test Adil","aboutMe":"Tester weuno","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000100.jpg","phoneNumber":"+923330124245","request_status":"Pending"},{"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","phoneNumber":"921122334455","request_status":"Pending"}],"_id":"66684bb8f60fa58442a8f9a1","title":"tteesst1","type":"event","description":"testtttt111","pricing":{"originalPrice":"null","price":"0"},"isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66472edbbb880ed91c93213d","userName":"Jawwad test 1","userImages":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg","userAboutMe":"testing","isVisibility":true,"isDeleted":false,"createdAt":"2024-06-11T13:06:00.700Z","updatedAt":"2024-06-11T13:06:00.700Z","__v":3,"eventTotalParticipants":0,"isFavourite":true,"totalEarned":0,"ticketSold":0,"acceptedCount":0}],"groups":[{"eventFavouriteBy":[],"eventParticipants":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":["art","music","health"],"questions":[{"questionId":"1716271079331","question":"what is your age ?","isPublic":false,"isRequired":false,"sequence":1},{"questionId":"2","question":"what is your age tell me ?","isPublic":false,"isRequired":false,"sequence":2}],"venue":[{"startDatetime":"2024-05-29 14:35:00.000","endDatetime":"2024-05-30 14:37:00.000","location":"","capacity":"Unlimited"}],"event_request":[{"id":"1716277537767","event_questions":[{"questionId":"1716271079331","answer":"test"},{"questionId":"2","answer":"check"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"3","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66446810417d623c10806219","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"4","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"663a229b562982688715a300","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"5","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6639d8d326988f5d1b85fedb","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"},{"id":"6","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6638c31fd243e634e5e6c2a8","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"}],"_id":"664c37ee454535ccf644cf4d","title":"Event Check","description":"event is testing for checking the responese updating model value","pricing":{"originalPrice":"null","price":"0"},"isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66472edbbb880ed91c93213d","userName":"jawwad test","userImages":"/data/user/0/com.example.chat_app_white_label/cache/378a7cb3-258f-4374-bb7a-6fcdbc9f894d4665609214217877182.jpg","userAboutMe":"testing","isVisibility":true,"createdAt":"2024-05-21T05:58:06.883Z","updatedAt":"2024-05-21T05:58:06.883Z","__v":10,"type":"event","eventTotalParticipants":3,"isFavourite":true,"isDeleted":false,"totalEarned":0,"ticketSold":0,"acceptedCount":3}],"totalCount":{"eventsCount":1,"groupsCount":1}}
/// meta : {"totalCount":85,"defaultPageLimit":10,"pages":1,"pageSizes":10,"remainingCount":75}

class UserEventGroupWrapper {
  UserEventGroupWrapper({
    this.code,
    this.message,
    this.description,
    this.data,
    this.meta,
  });

  UserEventGroupWrapper.fromJson(dynamic json) {
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

  UserEventGroupWrapper copyWith({
    num? code,
    String? message,
    String? description,
    Data? data,
    Meta? meta,
  }) =>
      UserEventGroupWrapper(
        code: code ?? this.code,
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

/// totalCount : 85
/// defaultPageLimit : 10
/// pages : 1
/// pageSizes : 10
/// remainingCount : 75

class Meta {
  Meta({
    this.totalCount,
    this.defaultPageLimit,
    this.pages,
    this.pageSizes,
    this.remainingCount,
  });

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

  Meta copyWith({
    num? totalCount,
    num? defaultPageLimit,
    num? pages,
    num? pageSizes,
    num? remainingCount,
  }) =>
      Meta(
        totalCount: totalCount ?? this.totalCount,
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

/// events : [{"eventFavouriteBy":["66683061de8af77273dd65ca"],"eventParticipants":[],"images":["https://locals.se-sto-1.linodeobjects.com/event/IMG_20240529_103654.jpg"],"categories":[],"questions":[],"venue":[{"startDatetime":"2024-06-28 18:04:00.000","endDatetime":"2024-06-29 18:04:00.000","location":"","capacity":"Unlimited"}],"event_request":[{"id":"1718114108997","event_questions":[{"questionId":"1718113115543","answer":"agagaga"}],"query":{"question":"avavHhahaa","answer":""},"user_id":"66683061de8af77273dd65ca","name":"Test Adil","aboutMe":"Tester weuno","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000100.jpg","phoneNumber":"+923330124245","request_status":"Pending"},{"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","phoneNumber":"921122334455","request_status":"Pending"}],"_id":"66684bb8f60fa58442a8f9a1","title":"tteesst1","type":"event","description":"testtttt111","pricing":{"originalPrice":"null","price":"0"},"isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66472edbbb880ed91c93213d","userName":"Jawwad test 1","userImages":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg","userAboutMe":"testing","isVisibility":true,"isDeleted":false,"createdAt":"2024-06-11T13:06:00.700Z","updatedAt":"2024-06-11T13:06:00.700Z","__v":3,"eventTotalParticipants":0,"isFavourite":true,"totalEarned":0,"ticketSold":0,"acceptedCount":0}]
/// groups : [{"eventFavouriteBy":[],"eventParticipants":[],"images":["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"],"categories":["art","music","health"],"questions":[{"questionId":"1716271079331","question":"what is your age ?","isPublic":false,"isRequired":false,"sequence":1},{"questionId":"2","question":"what is your age tell me ?","isPublic":false,"isRequired":false,"sequence":2}],"venue":[{"startDatetime":"2024-05-29 14:35:00.000","endDatetime":"2024-05-30 14:37:00.000","location":"","capacity":"Unlimited"}],"event_request":[{"id":"1716277537767","event_questions":[{"questionId":"1716271079331","answer":"test"},{"questionId":"2","answer":"check"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"3","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66446810417d623c10806219","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"4","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"663a229b562982688715a300","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"5","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6639d8d326988f5d1b85fedb","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"},{"id":"6","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6638c31fd243e634e5e6c2a8","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"}],"_id":"664c37ee454535ccf644cf4d","title":"Event Check","description":"event is testing for checking the responese updating model value","pricing":{"originalPrice":"null","price":"0"},"isFree":true,"isPublic":true,"isApprovalRequired":true,"isQuestionPublic":false,"userId":"66472edbbb880ed91c93213d","userName":"jawwad test","userImages":"/data/user/0/com.example.chat_app_white_label/cache/378a7cb3-258f-4374-bb7a-6fcdbc9f894d4665609214217877182.jpg","userAboutMe":"testing","isVisibility":true,"createdAt":"2024-05-21T05:58:06.883Z","updatedAt":"2024-05-21T05:58:06.883Z","__v":10,"type":"event","eventTotalParticipants":3,"isFavourite":true,"isDeleted":false,"totalEarned":0,"ticketSold":0,"acceptedCount":3}]
/// totalCount : {"eventsCount":1,"groupsCount":1}

class Data {
  Data({
    this.events,
    this.groups,
    this.totalCounts,
  });

  Data.fromJson(dynamic json) {
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups?.add(Groups.fromJson(v));
      });
    }
    totalCounts = json['totalCounts'] != null
        ? TotalCounts.fromJson(json['totalCounts'])
        : null;
  }

  List<Events>? events;
  List<Groups>? groups;
  TotalCounts? totalCounts;

  Data copyWith({
    List<Events>? events,
    List<Groups>? groups,
    TotalCounts? totalCount,
  }) =>
      Data(
        events: events ?? this.events,
        groups: groups ?? this.groups,
        totalCounts: totalCount ?? this.totalCounts,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (events != null) {
      map['events'] = events?.map((v) => v.toJson()).toList();
    }
    if (groups != null) {
      map['groups'] = groups?.map((v) => v.toJson()).toList();
    }
    if (totalCounts != null) {
      map['totalCounts'] = totalCounts?.toJson();
    }
    return map;
  }
}

/// eventsCount : 1
/// groupsCount : 1

class TotalCounts {
  TotalCounts({
    this.eventsCount,
    this.groupsCount,
  });

  TotalCounts.fromJson(dynamic json) {
    eventsCount = json['events'];
    groupsCount = json['groups'];
  }

  num? eventsCount;
  num? groupsCount;

  TotalCounts copyWith({
    num? eventsCount,
    num? groupsCount,
  }) =>
      TotalCounts(
        eventsCount: eventsCount ?? this.eventsCount,
        groupsCount: groupsCount ?? this.groupsCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['events'] = eventsCount;
    map['groups'] = groupsCount;
    return map;
  }
}

/// eventFavouriteBy : []
/// eventParticipants : []
/// images : ["https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg"]
/// categories : ["art","music","health"]
/// questions : [{"questionId":"1716271079331","question":"what is your age ?","isPublic":false,"isRequired":false,"sequence":1},{"questionId":"2","question":"what is your age tell me ?","isPublic":false,"isRequired":false,"sequence":2}]
/// venue : [{"startDatetime":"2024-05-29 14:35:00.000","endDatetime":"2024-05-30 14:37:00.000","location":"","capacity":"Unlimited"}]
/// event_request : [{"id":"1716277537767","event_questions":[{"questionId":"1716271079331","answer":"test"},{"questionId":"2","answer":"check"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"3","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"66446810417d623c10806219","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"4","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"663a229b562982688715a300","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Accepted"},{"id":"5","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6639d8d326988f5d1b85fedb","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"},{"id":"6","event_questions":[{"questionId":"1716271079331","answer":"q batao"},{"questionId":"2","answer":"test"}],"query":{"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"},"user_id":"6638c31fd243e634e5e6c2a8","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg","request_status":"Rejected"}]
/// _id : "664c37ee454535ccf644cf4d"
/// title : "Event Check"
/// description : "event is testing for checking the responese updating model value"
/// pricing : {"originalPrice":"null","price":"0"}
/// isFree : true
/// isPublic : true
/// isApprovalRequired : true
/// isQuestionPublic : false
/// userId : "66472edbbb880ed91c93213d"
/// userName : "jawwad test"
/// userImages : "/data/user/0/com.example.chat_app_white_label/cache/378a7cb3-258f-4374-bb7a-6fcdbc9f894d4665609214217877182.jpg"
/// userAboutMe : "testing"
/// isVisibility : true
/// createdAt : "2024-05-21T05:58:06.883Z"
/// updatedAt : "2024-05-21T05:58:06.883Z"
/// __v : 10
/// type : "event"
/// eventTotalParticipants : 3
/// isFavourite : true
/// isDeleted : false
/// totalEarned : 0
/// ticketSold : 0
/// acceptedCount : 3

class Groups {
  Groups(
      {this.eventFavouriteBy,
      this.eventParticipants,
      this.images,
      this.categories,
      this.questions,
      this.venue,
      this.eventRequest,
      this.id,
      this.title,
      this.description,
      this.pricing,
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
      this.type,
      this.eventTotalParticipants,
      this.isFavourite,
      this.isDeleted,
      this.isMyEvent,
      this.totalEarned,
      this.ticketSold,
      this.acceptedCount,
      this.members});

  Groups.fromJson(dynamic json) {
    eventFavouriteBy = json['eventFavouriteBy'] != null
        ? json['eventFavouriteBy'].cast<String>()
        : [];
    if (json['eventParticipants'] != null) {
      eventParticipants = [];
      json['eventParticipants'].forEach((v) {
        eventParticipants?.add(EventParticipants.fromJson(v));
      });
    }
    images = json['images'] != null ? json['images'].cast<String>() : [];
    categories = json['categories'] != null ? json['categories'].cast<String>() : [];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
    if (json['venue'] != null) {
      venue = [];
      json['venue'].forEach((v) {
        venue?.add(Venue.fromJson(v));
      });
    }
    if (json['event_request'] != null) {
      eventRequest = [];
      json['event_request'].forEach((v) {
        eventRequest?.add(EventRequest.fromJson(v));
      });
    }
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    pricing =
        json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
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
    type = json['type'];
    eventTotalParticipants = json['eventTotalParticipants'];
    isFavourite = json['isFavourite'];
    isDeleted = json['isDeleted'];
    isMyEvent = json['isMyEvent'];
    totalEarned = json['totalEarned'];
    ticketSold = json['ticketSold'];
    acceptedCount = json['acceptedCount'];
    members = json['members'];
  }

  List<dynamic>? eventFavouriteBy;
  List<dynamic>? eventParticipants;
  List<String>? images;
  List<String>? categories;
  List<Questions>? questions;
  List<Venue>? venue;
  List<EventRequest>? eventRequest;
  String? id;
  String? title;
  String? description;
  Pricing? pricing;
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
  String? type;
  num? eventTotalParticipants;
  bool? isFavourite;
  bool? isDeleted;
  bool? isMyEvent;
  num? totalEarned;
  num? ticketSold;
  num? acceptedCount;
  num? members;

  Groups copyWith({
    List<String>? eventFavouriteBy,
    List<dynamic>? eventParticipants,
    List<String>? images,
    List<String>? categories,
    List<Questions>? questions,
    List<Venue>? venue,
    List<EventRequest>? eventRequest,
    String? id,
    String? title,
    String? description,
    Pricing? pricing,
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
    String? type,
    num? eventTotalParticipants,
    bool? isFavourite,
    bool? isDeleted,
    bool? isMyEvent,
    num? totalEarned,
    num? ticketSold,
    num? acceptedCount,
    num? members,
  }) =>
      Groups(
        eventFavouriteBy: eventFavouriteBy ?? this.eventFavouriteBy,
        eventParticipants: eventParticipants ?? this.eventParticipants,
        images: images ?? this.images,
        categories: categories ?? this.categories,
        questions: questions ?? this.questions,
        venue: venue ?? this.venue,
        eventRequest: eventRequest ?? this.eventRequest,
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        pricing: pricing ?? this.pricing,
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
        type: type ?? this.type,
        eventTotalParticipants:
            eventTotalParticipants ?? this.eventTotalParticipants,
        isFavourite: isFavourite ?? this.isFavourite,
        isDeleted: isDeleted ?? this.isDeleted,
        isMyEvent: isMyEvent ?? this.isMyEvent,
        totalEarned: totalEarned ?? this.totalEarned,
        ticketSold: ticketSold ?? this.ticketSold,
        acceptedCount: acceptedCount ?? this.acceptedCount,
        members: members?? this.members,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventFavouriteBy != null) {
      map['eventFavouriteBy'] = eventFavouriteBy;
    }
    if (eventParticipants != null) {
      map['eventParticipants'] =
          eventParticipants?.map((v) => v.toJson()).toList();
    }
    map['images'] = images;
    map['categories'] = categories;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    if (venue != null) {
      map['venue'] = venue?.map((v) => v.toJson()).toList();
    }
    if (eventRequest != null) {
      map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['title'] = title;
    map['description'] = description;
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
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
    map['type'] = type;
    map['eventTotalParticipants'] = eventTotalParticipants;
    map['isFavourite'] = isFavourite;
    map['isDeleted'] = isDeleted;
    map['isMyEvent'] = isMyEvent;
    map['totalEarned'] = totalEarned;
    map['ticketSold'] = ticketSold;
    map['acceptedCount'] = acceptedCount;
    map['members'] = members;
    return map;
  }
}

class EventParticipants {
  EventParticipants({
    this.id,
    this.name,
    this.image,
    this.aboutMe,
  });

  EventParticipants.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    aboutMe = json['aboutMe'];
  }

  String? id;
  String? name;
  String? image;
  String? aboutMe;

  EventParticipants copyWith({
    String? id,
    String? name,
    String? image,
    String? aboutMe,
  }) =>
      EventParticipants(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        aboutMe: aboutMe ?? this.aboutMe,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['aboutMe'] = aboutMe;
    return map;
  }
}

/// originalPrice : "null"
/// price : "0"

class Pricing {
  Pricing({
    this.originalPrice,
    this.price,
  });

  Pricing.fromJson(dynamic json) {
    originalPrice = json['originalPrice'];
    price = json['price'];
  }

  String? originalPrice;
  String? price;

  Pricing copyWith({
    String? originalPrice,
    String? price,
  }) =>
      Pricing(
        originalPrice: originalPrice ?? this.originalPrice,
        price: price ?? this.price,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originalPrice'] = originalPrice;
    map['price'] = price;
    return map;
  }
}

/// id : "1716277537767"
/// event_questions : [{"questionId":"1716271079331","answer":"test"},{"questionId":"2","answer":"check"}]
/// query : {"question":"kaam chor hai backend developer","answer":"tu kaam kiya karoo na sahi se"}
/// user_id : "66332e92b9bc57c02be94bfc"
/// name : "tesss tsdasdasdasd"
/// aboutMe : "asdasdasdasd"
/// image : "/data/user/0/com.example.chat_app_white_label/cache/156ee579-1274-4ff4-9545-63ba8b1de7f3182102428399825395.jpg"
/// request_status : "Accepted"

class EventRequest {
  EventRequest({
    this.id,
    this.eventQuestions,
    this.query,
    this.userId,
    this.name,
    this.aboutMe,
    this.image,
    this.requestStatus,
  });

  EventRequest.fromJson(dynamic json) {
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
  String? image;
  String? requestStatus;

  EventRequest copyWith({
    String? id,
    List<EventQuestions>? eventQuestions,
    Query? query,
    String? userId,
    String? name,
    String? aboutMe,
    String? image,
    String? requestStatus,
  }) =>
      EventRequest(
        id: id ?? this.id,
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

/// question : "kaam chor hai backend developer"
/// answer : "tu kaam kiya karoo na sahi se"

class Query {
  Query({
    this.question,
    this.answer,
  });

  Query.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }

  String? question;
  String? answer;

  Query copyWith({
    String? question,
    String? answer,
  }) =>
      Query(
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}

/// questionId : "1716271079331"
/// answer : "test"

class EventQuestions {
  EventQuestions({
    this.questionId,
    this.answer,
  });

  EventQuestions.fromJson(dynamic json) {
    questionId = json['questionId'];
    answer = json['answer'];
  }

  String? questionId;
  String? answer;

  EventQuestions copyWith({
    String? questionId,
    String? answer,
  }) =>
      EventQuestions(
        questionId: questionId ?? this.questionId,
        answer: answer ?? this.answer,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['answer'] = answer;
    return map;
  }
}

/// startDatetime : "2024-05-29 14:35:00.000"
/// endDatetime : "2024-05-30 14:37:00.000"
/// location : ""
/// capacity : "Unlimited"

class Venue {
  Venue({
    this.startDatetime,
    this.endDatetime,
    this.location,
    this.capacity,
  });

  Venue.fromJson(dynamic json) {
    startDatetime = json['startDatetime'];
    endDatetime = json['endDatetime'];
    location = json['location'];
    capacity = json['capacity'].toString();
  }

  String? startDatetime;
  String? endDatetime;
  String? location;
  String? capacity;

  Venue copyWith({
    String? startDatetime,
    String? endDatetime,
    String? location,
    String? capacity,
  }) =>
      Venue(
        startDatetime: startDatetime ?? this.startDatetime,
        endDatetime: endDatetime ?? this.endDatetime,
        location: location ?? this.location,
        capacity: capacity ?? this.capacity,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startDatetime'] = startDatetime;
    map['endDatetime'] = endDatetime;
    map['location'] = location;
    map['capacity'] = capacity;
    return map;
  }
}

/// questionId : "1716271079331"
/// question : "what is your age ?"
/// isPublic : false
/// isRequired : false
/// sequence : 1

class Questions {
  Questions({
    this.questionId,
    this.question,
    this.isPublic,
    this.isRequired,
    this.sequence,
  });

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

  Questions copyWith({
    String? questionId,
    String? question,
    bool? isPublic,
    bool? isRequired,
    num? sequence,
  }) =>
      Questions(
        questionId: questionId ?? this.questionId,
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

/// eventFavouriteBy : ["66683061de8af77273dd65ca"]
/// eventParticipants : []
/// images : ["https://locals.se-sto-1.linodeobjects.com/event/IMG_20240529_103654.jpg"]
/// categories : []
/// questions : []
/// venue : [{"startDatetime":"2024-06-28 18:04:00.000","endDatetime":"2024-06-29 18:04:00.000","location":"","capacity":"Unlimited"}]
/// event_request : [{"id":"1718114108997","event_questions":[{"questionId":"1718113115543","answer":"agagaga"}],"query":{"question":"avavHhahaa","answer":""},"user_id":"66683061de8af77273dd65ca","name":"Test Adil","aboutMe":"Tester weuno","image":"https://locals.se-sto-1.linodeobjects.com/profile/1000000100.jpg","phoneNumber":"+923330124245","request_status":"Pending"},{"user_id":"66332e92b9bc57c02be94bfc","name":"tesss tsdasdasdasd","aboutMe":"asdasdasdasd","image":"https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240527_195057.jpg","phoneNumber":"921122334455","request_status":"Pending"}]
/// _id : "66684bb8f60fa58442a8f9a1"
/// title : "tteesst1"
/// type : "event"
/// description : "testtttt111"
/// pricing : {"originalPrice":"null","price":"0"}
/// isFree : true
/// isPublic : true
/// isApprovalRequired : true
/// isQuestionPublic : false
/// userId : "66472edbbb880ed91c93213d"
/// userName : "Jawwad test 1"
/// userImages : "https://locals.se-sto-1.linodeobjects.com/profile/IMG_20240529_103650.jpg"
/// userAboutMe : "testing"
/// isVisibility : true
/// isDeleted : false
/// createdAt : "2024-06-11T13:06:00.700Z"
/// updatedAt : "2024-06-11T13:06:00.700Z"
/// __v : 3
/// eventTotalParticipants : 0
/// isFavourite : true
/// totalEarned : 0
/// ticketSold : 0
/// acceptedCount : 0

class Events {
  Events({
    this.eventFavouriteBy,
    this.eventParticipants,
    this.images,
    this.categories,
    this.questions,
    this.venue,
    this.eventRequest,
    this.id,
    this.title,
    this.type,
    this.description,
    this.pricing,
    this.isFree,
    this.isPublic,
    this.isApprovalRequired,
    this.isQuestionPublic,
    this.userId,
    this.userName,
    this.userImages,
    this.userAboutMe,
    this.isVisibility,
    this.isDeleted,
    this.isMyEvent,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.eventTotalParticipants,
    this.isFavourite,
    this.totalEarned,
    this.ticketSold,
    this.acceptedCount,
  });

  Events.fromJson(dynamic json) {
    eventFavouriteBy = json['eventFavouriteBy'] != null
        ? json['eventFavouriteBy'].cast<String>()
        : [];
    if (json['eventParticipants'] != null) {
      eventParticipants = [];
      json['eventParticipants'].forEach((v) {
        eventParticipants?.add(EventParticipants.fromJson(v));
      });
    }
    images = json['images'] != null ? json['images'].cast<String>() : [];
    categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
    if (json['venue'] != null) {
      venue = [];
      json['venue'].forEach((v) {
        venue?.add(Venue.fromJson(v));
      });
    }
    if (json['event_request'] != null) {
      eventRequest = [];
      json['event_request'].forEach((v) {
        eventRequest?.add(EventRequest.fromJson(v));
      });
    }
    id = json['_id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    pricing =
        json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    isFree = json['isFree'];
    isPublic = json['isPublic'];
    isApprovalRequired = json['isApprovalRequired'];
    isQuestionPublic = json['isQuestionPublic'];
    userId = json['userId'];
    userName = json['userName'];
    userImages = json['userImages'];
    userAboutMe = json['userAboutMe'];
    isVisibility = json['isVisibility'];
    isDeleted = json['isDeleted'];
    isMyEvent = json['isMyEvent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    eventTotalParticipants = json['eventTotalParticipants'];
    isFavourite = json['isFavourite'];
    totalEarned = json['totalEarned'];
    ticketSold = json['ticketSold'];
    acceptedCount = json['acceptedCount'];
  }

  List<String>? eventFavouriteBy;
  List<dynamic>? eventParticipants;
  List<String>? images;
  List<dynamic>? categories;
  List<dynamic>? questions;
  List<Venue>? venue;
  List<EventRequest>? eventRequest;
  String? id;
  String? title;
  String? type;
  String? description;
  Pricing? pricing;
  bool? isFree;
  bool? isPublic;
  bool? isApprovalRequired;
  bool? isQuestionPublic;
  String? userId;
  String? userName;
  String? userImages;
  String? userAboutMe;
  bool? isVisibility;
  bool? isDeleted;
  bool? isMyEvent;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? eventTotalParticipants;
  bool? isFavourite;
  num? totalEarned;
  num? ticketSold;
  num? acceptedCount;

  Events copyWith({
    List<String>? eventFavouriteBy,
    List<dynamic>? eventParticipants,
    List<String>? images,
    List<String>? categories,
    List<dynamic>? questions,
    List<Venue>? venue,
    List<EventRequest>? eventRequest,
    String? id,
    String? title,
    String? type,
    String? description,
    Pricing? pricing,
    bool? isFree,
    bool? isPublic,
    bool? isApprovalRequired,
    bool? isQuestionPublic,
    String? userId,
    String? userName,
    String? userImages,
    String? userAboutMe,
    bool? isVisibility,
    bool? isDeleted,
    bool? isMyEvent,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? eventTotalParticipants,
    bool? isFavourite,
    num? totalEarned,
    num? ticketSold,
    num? acceptedCount,
  }) =>
      Events(
        eventFavouriteBy: eventFavouriteBy ?? this.eventFavouriteBy,
        eventParticipants: eventParticipants ?? this.eventParticipants,
        images: images ?? this.images,
        categories: categories ?? this.categories,
        questions: questions ?? this.questions,
        venue: venue ?? this.venue,
        eventRequest: eventRequest ?? this.eventRequest,
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        description: description ?? this.description,
        pricing: pricing ?? this.pricing,
        isFree: isFree ?? this.isFree,
        isPublic: isPublic ?? this.isPublic,
        isApprovalRequired: isApprovalRequired ?? this.isApprovalRequired,
        isQuestionPublic: isQuestionPublic ?? this.isQuestionPublic,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userImages: userImages ?? this.userImages,
        userAboutMe: userAboutMe ?? this.userAboutMe,
        isVisibility: isVisibility ?? this.isVisibility,
        isDeleted: isDeleted ?? this.isDeleted,
        isMyEvent: isMyEvent ?? this.isMyEvent,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        eventTotalParticipants:
            eventTotalParticipants ?? this.eventTotalParticipants,
        isFavourite: isFavourite ?? this.isFavourite,
        totalEarned: totalEarned ?? this.totalEarned,
        ticketSold: ticketSold ?? this.ticketSold,
        acceptedCount: acceptedCount ?? this.acceptedCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventFavouriteBy'] = eventFavouriteBy;
    if (eventParticipants != null) {
      map['eventParticipants'] =
          eventParticipants?.map((v) => v.toJson()).toList();
    }
    map['images'] = images;

    if (categories != null) {
      map['categories'] = categories;
    }
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    if (venue != null) {
      map['venue'] = venue?.map((v) => v.toJson()).toList();
    }
    if (eventRequest != null) {
      map['event_request'] = eventRequest?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['description'] = description;
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    map['isFree'] = isFree;
    map['isPublic'] = isPublic;
    map['isApprovalRequired'] = isApprovalRequired;
    map['isQuestionPublic'] = isQuestionPublic;
    map['userId'] = userId;
    map['userName'] = userName;
    map['userImages'] = userImages;
    map['userAboutMe'] = userAboutMe;
    map['isVisibility'] = isVisibility;
    map['isDeleted'] = isDeleted;
    map['isMyEvent'] = isMyEvent;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['eventTotalParticipants'] = eventTotalParticipants;
    map['isFavourite'] = isFavourite;
    map['totalEarned'] = totalEarned;
    map['ticketSold'] = ticketSold;
    map['acceptedCount'] = acceptedCount;
    return map;
  }
}
