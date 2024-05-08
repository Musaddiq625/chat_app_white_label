/// code : 200
/// message : "Data retrieved successfully"
/// description : ""
/// data : [{"hobbies":[{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071XK2MPEJ-d0a4934748/image_480.png","value":"Mustafa 1"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 2"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 3"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 4"}],"creativity":[{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072GTXN89F-d03747b972/image_720.png","value":"Jawad 1"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071PMD0J23-8690f51689/image_160.png","value":"Jawad 2"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F0726ND2ZEY-89786ca497/image_160.png","value":"Jawad 3"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071XK2MPEJ-d0a4934748/image_480.png","value":"Jawad 4"}],"_id":"6638a460d243e634e5e6c2a6","__v":2}]
/// meta : {"totalCount":1,"defaultPageLimit":10,"pages":1,"pageSizes":10}

class InterestResponseWrapper {
  InterestResponseWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.data, 
      this.meta,});

  InterestResponseWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? code;
  String? message;
  String? description;
  List<Data>? data;
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

/// hobbies : [{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071XK2MPEJ-d0a4934748/image_480.png","value":"Mustafa 1"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 2"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 3"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072451U0KV-fd73e6d95a/image_480.png","value":"Mustafa 4"}]
/// creativity : [{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F072GTXN89F-d03747b972/image_720.png","value":"Jawad 1"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071PMD0J23-8690f51689/image_160.png","value":"Jawad 2"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F0726ND2ZEY-89786ca497/image_160.png","value":"Jawad 3"},{"icon":"https://files.slack.com/files-tmb/TPDGW7HNH-F071XK2MPEJ-d0a4934748/image_480.png","value":"Jawad 4"}]
/// _id : "6638a460d243e634e5e6c2a6"
/// __v : 2

class Data {
  Data({
      this.hobbies, 
      this.creativity, 
      this.id, 
      this.v,});

  Data.fromJson(dynamic json) {
    if (json['hobbies'] != null) {
      hobbies = [];
      json['hobbies'].forEach((v) {
        hobbies?.add(Hobbies.fromJson(v));
      });
    }
    if (json['creativity'] != null) {
      creativity = [];
      json['creativity'].forEach((v) {
        creativity?.add(Creativity.fromJson(v));
      });
    }
    id = json['_id'];
    v = json['__v'];
  }
  List<Hobbies>? hobbies;
  List<Creativity>? creativity;
  String? id;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hobbies != null) {
      map['hobbies'] = hobbies?.map((v) => v.toJson()).toList();
    }
    if (creativity != null) {
      map['creativity'] = creativity?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }

}

/// icon : "https://files.slack.com/files-tmb/TPDGW7HNH-F072GTXN89F-d03747b972/image_720.png"
/// value : "Jawad 1"

class Creativity {
  Creativity({
      this.icon, 
      this.value,});

  Creativity.fromJson(dynamic json) {
    icon = json['icon'];
    value = json['value'];
  }
  String? icon;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['value'] = value;
    return map;
  }

}

/// icon : "https://files.slack.com/files-tmb/TPDGW7HNH-F071XK2MPEJ-d0a4934748/image_480.png"
/// value : "Mustafa 1"

class Hobbies {
  Hobbies({
      this.icon, 
      this.value,});

  Hobbies.fromJson(dynamic json) {
    icon = json['icon'];
    value = json['value'];
  }
  String? icon;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['value'] = value;
    return map;
  }

}