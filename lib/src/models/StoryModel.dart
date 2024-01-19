import 'Stories.dart';

class StoryModel {
  StoryModel({
      required this.id,
      required this.name,
      required this.image,
      required this.userId,
      required this.stories,});

  StoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    userId = json['userId'];
    if (json['stories'] != null) {
      stories = [];
      json['stories'].forEach((v) {
        stories?.add(Stories.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? image;
  String? userId;
  List<Stories>? stories;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['userId'] = userId;
    if (stories != null) {
      map['stories'] = stories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}