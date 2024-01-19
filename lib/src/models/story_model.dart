import 'package:chat_app_white_label/src/models/story_detail_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModels {
  final String? id;
  final String? name;
  final String? image;
  final String? userId;
  final List<StoryDetailModel> stories;

  StoryModels({
    required this.id,
    required this.name,
    required this.image,
    required this.userId,
    required this.stories,
  });

  factory StoryModels.fromDocument(DocumentSnapshot doc) {
    return StoryModels(
      id: doc.id,
      name: doc['name'] as String,
      image: doc['image'] as String,
      userId: doc['userId'] as String,
      stories: (doc['stories'] as List<dynamic>)
          .map((story) => StoryDetailModel.fromMap(story))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'userId': userId,
      'stories': stories.map((story) => story.toMap()).toList(),
    };
  }
}
