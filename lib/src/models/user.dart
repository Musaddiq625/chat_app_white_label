class User {
  final String id;
  final String? name;
  final String? image;
  final String? about;
  final String? phoneNumber;
  final List<String>? chatsIds;
  final bool? isProfileComplete;

  User({
    required this.id,
    this.name,
    this.image,
    this.about,
    this.phoneNumber,
    this.chatsIds,
    this.isProfileComplete,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      about: map['about'],
      phoneNumber: map['phoneNumber'],
      chatsIds: List<String>.from(map['chats_ids']),
      isProfileComplete: map['is_profile_complete'],

    );
  }
}
