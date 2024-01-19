class StoryNewModel {
  StoryNewModel({
      this.id,
      this.userId, 
      this.name, 
      this.image, 
      this.stories,});

  StoryNewModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    image = json['image'];
    stories = json['stories'] != null ? json['stories'].cast<String>() : [];
  }
  String? id;
  String? userId;
  String? name;
  String? image;
  List<String>? stories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['image'] = image;
    map['stories'] = stories;
    return map;
  }

}