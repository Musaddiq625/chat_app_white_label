import 'package:cloud_firestore/cloud_firestore.dart';

class Stories {
  Stories({
      required this.storyid,
      required this.storyMsg,
      required this.storyImage,
      required this.time,});

  Stories.fromJson(dynamic json) {
    storyid = json['storyid'];
    storyMsg = json['storyMsg'];
    storyImage = json['storyImage'];
    time = json['time'];
  }
  String? storyid;
  String? storyMsg;
  String? storyImage;
  Timestamp? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['storyid'] = storyid;
    map['storyMsg'] = storyMsg;
    map['storyImage'] = storyImage;
    map['time'] = time;
    return map;
  }

}