class UserMoodel {
  final String? id;
  final String? name;
  final String? subName;
  final String? image;
  final String? about;
  final String? phoneNumber;
  final List<String>? chatsIds;
  final bool? isProfileComplete;

  UserMoodel({
    this.id,
    this.name,
    this.subName,
    this.image,
    this.about,
    this.phoneNumber,
    this.chatsIds,
    this.isProfileComplete,
  });

  factory UserMoodel.fromMap(Map<String, dynamic> map) {
    return UserMoodel(
      id: map['id'],
      name: map['name'],
      subName: map['subName'],
      image: map['image'],
      about: map['about'],
      phoneNumber: map['phoneNumber'],
      chatsIds: map['chat_ids'] == null ? [] : List<String>.from(map['chat_ids']),
      isProfileComplete: map['is_profile_complete'],
    );
  }
}
