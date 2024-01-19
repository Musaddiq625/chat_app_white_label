import 'package:cloud_firestore/cloud_firestore.dart';

class StoryDetailModel {
  final String storyid;
  final String storyMsg;
  final String storyImage;
  final Timestamp time;

  StoryDetailModel({
    required this.storyid,
    required this.storyMsg,
    required this.storyImage,
    required this.time,
  });

  factory StoryDetailModel.fromMap(Map<String, dynamic> map) {
    return StoryDetailModel(
      storyid: map['storyid'] as String,
      storyMsg: map['storyMsg'] as String,
      storyImage: map['storyImage'] as String,
      time: map['time'] as Timestamp,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storyid': storyid,
      'storyMsg': storyMsg,
      'storyImage': storyImage,
      'time': time,
    };
  }
}