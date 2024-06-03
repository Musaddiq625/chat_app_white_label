/// code : 200
/// message : "Data retrieved successfully"
/// description : ""
/// data : {"todayNotifications":[{"_id":"66597dd54f0acc4b3818874f","recieverId":"66472edbbb880ed91c93213d","eventId":"665498bc22bc471deedfe2ba","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: basit test","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: basit test"},"data":{"eventId":"665498bc22bc471deedfe2ba","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T07:35:49.771Z","updated_at":"2024-05-31T07:35:49.771Z","__v":0},{"_id":"6659748786ed6b522cb2a411","recieverId":"66472edbbb880ed91c93213d","eventId":"6657154bc5f8737c41f9b48d","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event:  Test Group 01","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event:  Test Group 01"},"data":{"eventId":"6657154bc5f8737c41f9b48d","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:56:07.500Z","updated_at":"2024-05-31T06:56:07.500Z","__v":0},{"_id":"6659747286ed6b522cb2a410","recieverId":"66472edbbb880ed91c93213d","eventId":"664c37ee454535ccf644cf4d","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: Event Check","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: Event Check"},"data":{"eventId":"664c37ee454535ccf644cf4d","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:55:46.511Z","updated_at":"2024-05-31T06:55:46.511Z","__v":0},{"_id":"6659745c86ed6b522cb2a40f","recieverId":"66472edbbb880ed91c93213d","eventId":"66474d652af426e389f2086f","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: Live Event","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: Live Event"},"data":{"eventId":"66474d652af426e389f2086f","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:55:24.727Z","updated_at":"2024-05-31T06:55:24.727Z","__v":0}],"earlierThisWeekNotifications":[{"_id":"6659741486ed6b522cb2a40e","recieverId":"66472edbbb880ed91c93213d","eventId":"6642150a48ed4352b0a71f1c","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: test basit","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: test basit"},"data":{"eventId":"6642150a48ed4352b0a71f1c","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-28T06:54:12.814Z","updated_at":"2024-05-31T06:54:12.814Z","__v":0}]}
/// meta : {"totalCount":6,"defaultPageLimit":10,"pages":1,"pageSizes":10,"remainingCount":0}

class NotificationListingWrapper {
  NotificationListingWrapper({
    this.code,
    this.message,
    this.description,
    this.data,
    this.meta,
  });

  NotificationListingWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    data =
        json['data'] != null ? NotificationData.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  num? code;
  String? message;
  String? description;
  NotificationData? data;
  Meta? meta;

  NotificationListingWrapper copyWith({
    num? code,
    String? message,
    String? description,
    NotificationData? data,
    Meta? meta,
  }) =>
      NotificationListingWrapper(
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

/// totalCount : 6
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

/// todayNotifications : [{"_id":"66597dd54f0acc4b3818874f","recieverId":"66472edbbb880ed91c93213d","eventId":"665498bc22bc471deedfe2ba","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: basit test","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: basit test"},"data":{"eventId":"665498bc22bc471deedfe2ba","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T07:35:49.771Z","updated_at":"2024-05-31T07:35:49.771Z","__v":0},{"_id":"6659748786ed6b522cb2a411","recieverId":"66472edbbb880ed91c93213d","eventId":"6657154bc5f8737c41f9b48d","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event:  Test Group 01","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event:  Test Group 01"},"data":{"eventId":"6657154bc5f8737c41f9b48d","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:56:07.500Z","updated_at":"2024-05-31T06:56:07.500Z","__v":0},{"_id":"6659747286ed6b522cb2a410","recieverId":"66472edbbb880ed91c93213d","eventId":"664c37ee454535ccf644cf4d","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: Event Check","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: Event Check"},"data":{"eventId":"664c37ee454535ccf644cf4d","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:55:46.511Z","updated_at":"2024-05-31T06:55:46.511Z","__v":0},{"_id":"6659745c86ed6b522cb2a40f","recieverId":"66472edbbb880ed91c93213d","eventId":"66474d652af426e389f2086f","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: Live Event","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: Live Event"},"data":{"eventId":"66474d652af426e389f2086f","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-31T06:55:24.727Z","updated_at":"2024-05-31T06:55:24.727Z","__v":0}]
/// earlierThisWeekNotifications : [{"_id":"6659741486ed6b522cb2a40e","recieverId":"66472edbbb880ed91c93213d","eventId":"6642150a48ed4352b0a71f1c","type":"event","resource_id":"","title":"Event Liked","text":"Jawwad test 1 liked your event: test basit","payload":{"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: test basit"},"data":{"eventId":"6642150a48ed4352b0a71f1c","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"},"read_status":true,"created_at":"2024-05-28T06:54:12.814Z","updated_at":"2024-05-31T06:54:12.814Z","__v":0}]

class NotificationData {
  NotificationData({
    this.todayNotifications,
    this.earlierThisWeekNotifications,
  });

  NotificationData.fromJson(dynamic json) {
    if (json['todayNotifications'] != null) {
      todayNotifications = [];
      json['todayNotifications'].forEach((v) {
        todayNotifications?.add(TodayNotifications.fromJson(v));
      });
    }
    if (json['earlierThisWeekNotifications'] != null) {
      earlierThisWeekNotifications = [];
      json['earlierThisWeekNotifications'].forEach((v) {
        earlierThisWeekNotifications?.add(TodayNotifications.fromJson(v));
      });
    }
  }

  List<TodayNotifications>? todayNotifications;
  List<TodayNotifications>? earlierThisWeekNotifications;

  NotificationData copyWith({
    List<TodayNotifications>? todayNotifications,
    List<TodayNotifications>? earlierThisWeekNotifications,
  }) =>
      NotificationData(
        todayNotifications: todayNotifications ?? this.todayNotifications,
        earlierThisWeekNotifications:
            earlierThisWeekNotifications ?? this.earlierThisWeekNotifications,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (todayNotifications != null) {
      map['todayNotifications'] =
          todayNotifications?.map((v) => v.toJson()).toList();
    }
    if (earlierThisWeekNotifications != null) {
      map['earlierThisWeekNotifications'] =
          earlierThisWeekNotifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "6659741486ed6b522cb2a40e"
/// recieverId : "66472edbbb880ed91c93213d"
/// eventId : "6642150a48ed4352b0a71f1c"
/// type : "event"
/// resource_id : ""
/// title : "Event Liked"
/// text : "Jawwad test 1 liked your event: test basit"
/// payload : {"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: test basit"},"data":{"eventId":"6642150a48ed4352b0a71f1c","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"}
/// read_status : true
/// created_at : "2024-05-28T06:54:12.814Z"
/// updated_at : "2024-05-31T06:54:12.814Z"
/// __v : 0

class EarlierThisWeekNotifications {
  EarlierThisWeekNotifications({
    this.id,
    this.recieverId,
    this.eventId,
    this.type,
    this.resourceId,
    this.title,
    this.text,
    this.payload,
    this.readStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  EarlierThisWeekNotifications.fromJson(dynamic json) {
    id = json['_id'];
    recieverId = json['recieverId'];
    eventId = json['eventId'];
    type = json['type'];
    resourceId = json['resource_id'];
    title = json['title'];
    text = json['text'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    readStatus = json['read_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }

  String? id;
  String? recieverId;
  String? eventId;
  String? type;
  String? resourceId;
  String? title;
  String? text;
  Payload? payload;
  bool? readStatus;
  String? createdAt;
  String? updatedAt;
  num? v;

  EarlierThisWeekNotifications copyWith({
    String? id,
    String? recieverId,
    String? eventId,
    String? type,
    String? resourceId,
    String? title,
    String? text,
    Payload? payload,
    bool? readStatus,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      EarlierThisWeekNotifications(
        id: id ?? this.id,
        recieverId: recieverId ?? this.recieverId,
        eventId: eventId ?? this.eventId,
        type: type ?? this.type,
        resourceId: resourceId ?? this.resourceId,
        title: title ?? this.title,
        text: text ?? this.text,
        payload: payload ?? this.payload,
        readStatus: readStatus ?? this.readStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['recieverId'] = recieverId;
    map['eventId'] = eventId;
    map['type'] = type;
    map['resource_id'] = resourceId;
    map['title'] = title;
    map['text'] = text;
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    map['read_status'] = readStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

/// notification : {"title":"Event Liked!","body":"Jawwad test 1 liked your event: test basit"}
/// data : {"eventId":"6642150a48ed4352b0a71f1c","type":"event"}
/// to : "c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"

class Payload {
  Payload({
    this.notification,
    this.data,
    this.to,
  });

  Payload.fromJson(dynamic json) {
    notification = json['notification'] != null
        ? Notification.fromJson(json['notification'])
        : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    to = json['to'];
  }

  Notification? notification;
  Data? data;
  String? to;

  Payload copyWith({
    Notification? notification,
    Data? data,
    String? to,
  }) =>
      Payload(
        notification: notification ?? this.notification,
        data: data ?? this.data,
        to: to ?? this.to,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['to'] = to;
    return map;
  }
}

/// eventId : "6642150a48ed4352b0a71f1c"
/// type : "event"

class Data {
  Data({
    this.eventId,
    this.type,
    this.userImage,
    this.userId,
  });

  Data.fromJson(dynamic json) {
    eventId = json['eventId'];
    type = json['type'];
    userImage = json['userImage'];
    userId = json['userId'];
  }

  String? eventId;
  String? type;
  String? userImage;
  String? userId;

  Data copyWith({
    String? eventId,
    String? type,
  }) =>
      Data(
        eventId: eventId ?? this.eventId,
        type: type ?? this.type,
        userImage: userImage ?? this.userImage,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventId'] = eventId;
    map['type'] = type;
    map['userImage'] = userImage;
    map['userId'] = userId;
    return map;
  }
}

/// title : "Event Liked!"
/// body : "Jawwad test 1 liked your event: test basit"

class Notification {
  Notification({
    this.title,
    this.body,
  });

  Notification.fromJson(dynamic json) {
    title = json['title'];
    body = json['body'];
  }

  String? title;
  String? body;

  Notification copyWith({
    String? title,
    String? body,
  }) =>
      Notification(
        title: title ?? this.title,
        body: body ?? this.body,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    return map;
  }
}

/// _id : "66597dd54f0acc4b3818874f"
/// recieverId : "66472edbbb880ed91c93213d"
/// eventId : "665498bc22bc471deedfe2ba"
/// type : "event"
/// resource_id : ""
/// title : "Event Liked"
/// text : "Jawwad test 1 liked your event: basit test"
/// payload : {"notification":{"title":"Event Liked!","body":"Jawwad test 1 liked your event: basit test"},"data":{"eventId":"665498bc22bc471deedfe2ba","type":"event"},"to":"c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"}
/// read_status : true
/// created_at : "2024-05-31T07:35:49.771Z"
/// updated_at : "2024-05-31T07:35:49.771Z"
/// __v : 0

class TodayNotifications {
  TodayNotifications({
    this.id,
    this.recieverId,
    this.eventId,
    this.type,
    this.resourceId,
    this.title,
    this.text,
    this.payload,
    this.readStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  TodayNotifications.fromJson(dynamic json) {
    id = json['_id'];
    recieverId = json['recieverId'];
    eventId = json['eventId'];
    type = json['type'];
    resourceId = json['resource_id'];
    title = json['title'];
    text = json['text'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    readStatus = json['read_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }

  String? id;
  String? recieverId;
  String? eventId;
  String? type;
  String? resourceId;
  String? title;
  String? text;
  Payload? payload;
  bool? readStatus;
  String? createdAt;
  String? updatedAt;
  num? v;

  TodayNotifications copyWith({
    String? id,
    String? recieverId,
    String? eventId,
    String? type,
    String? resourceId,
    String? title,
    String? text,
    Payload? payload,
    bool? readStatus,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      TodayNotifications(
        id: id ?? this.id,
        recieverId: recieverId ?? this.recieverId,
        eventId: eventId ?? this.eventId,
        type: type ?? this.type,
        resourceId: resourceId ?? this.resourceId,
        title: title ?? this.title,
        text: text ?? this.text,
        payload: payload ?? this.payload,
        readStatus: readStatus ?? this.readStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['recieverId'] = recieverId;
    map['eventId'] = eventId;
    map['type'] = type;
    map['resource_id'] = resourceId;
    map['title'] = title;
    map['text'] = text;
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    map['read_status'] = readStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

/// notification : {"title":"Event Liked!","body":"Jawwad test 1 liked your event: basit test"}
/// data : {"eventId":"665498bc22bc471deedfe2ba","type":"event"}
/// to : "c0L58E77TH2gNWUXkL5lrl:APA91bGA2OE86DBXgBjJfl6OJzOXPokEpDMoOxlPMzv9tB6qAGITX3LdZJNg7eQXInG6y7G5LcaJbMXzG_Pg34u5loMUDzXQ1qz0dow2yx7_8wfp70BttsiNUiNpnq8lGvrBMBHR9MDj"

// class Payload {
//   Payload({
//       this.notification,
//       this.data,
//       this.to,});
//
//   Payload.fromJson(dynamic json) {
//     notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
//     data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
//     to = json['to'];
//   }
//   Notification? notification;
//   NotificationData? data;
//   String? to;
// Payload copyWith({  Notification? notification,
//   NotificationData? data,
//   String? to,
// }) => Payload(  notification: notification ?? this.notification,
//   data: data ?? this.data,
//   to: to ?? this.to,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (notification != null) {
//       map['notification'] = notification?.toJson();
//     }
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     map['to'] = to;
//     return map;
//   }
//
// }
//
// /// eventId : "665498bc22bc471deedfe2ba"
// /// type : "event"
//
// class Data {
//   Data({
//       this.eventId,
//       this.type,});
//
//   Data.fromJson(dynamic json) {
//     eventId = json['eventId'];
//     type = json['type'];
//   }
//   String? eventId;
//   String? type;
// NotificationData copyWith({  String? eventId,
//   String? type,
// }) => NotificationData(  eventId: eventId ?? this.eventId,
//   type: type ?? this.type,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['eventId'] = eventId;
//     map['type'] = type;
//     return map;
//   }
//
// }
//
// /// title : "Event Liked!"
// /// body : "Jawwad test 1 liked your event: basit test"
//
// class Notification {
//   Notification({
//       this.title,
//       this.body,});
//
//   Notification.fromJson(dynamic json) {
//     title = json['title'];
//     body = json['body'];
//   }
//   String? title;
//   String? body;
// Notification copyWith({  String? title,
//   String? body,
// }) => Notification(  title: title ?? this.title,
//   body: body ?? this.body,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['title'] = title;
//     map['body'] = body;
//     return map;
//   }
//
// }
