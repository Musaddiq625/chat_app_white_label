class StoriesNewModel {
  StoriesNewModel({
    this.storyId,
    this.userId,
    this.storyImage,
    this.storyMsg,
    this.time,
    this.userSeenList,
  });

  StoriesNewModel.fromJson(dynamic json) {
    storyId = json['story_id'];
    userId = json['user_id'];
    storyImage = json['story_image'];
    storyMsg = json['story_msg'];
    time = json['time'];
    userSeenList = json['user_seen_list'] != null
        ? json['user_seen_list'].cast<String>()
        : [];
  }

  String? storyId;
  String? userId;
  String? storyImage;
  String? storyMsg;
  String? time;
  List<String>? userSeenList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['story_id'] = storyId;
    map['user_id'] = userId;
    map['story_image'] = storyImage;
    map['story_msg'] = storyMsg;
    map['time'] = time;
    map['user_seen_list'] = userSeenList;
    return map;
  }
}
