class UserModel {
  String? id;
  String? name;
  String? subName;
  String? image;
  String? about;
  String? phoneNumber;
  String? fcmToken;
  List<String>? chats;
  bool? isProfileComplete;
  bool? isOnline;
  String? lastActive;
  String? pushToken;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.subName,
    this.about,
    this.fcmToken,
    this.phoneNumber,
    this.chats,
    this.isProfileComplete,
    this.isOnline,
    this.lastActive,
    this.pushToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        subName: json['sub_name'],
        image: json['image'],
        about: json['about'],
        fcmToken: json['fcm_token'],
        phoneNumber: json['phoneNumber'],
        chats: json['chats'] == null ? [] : json['chats'].cast<String>(),
        isProfileComplete: json['is_profile_complete'],
        isOnline: json['is_online'],
        lastActive: json['last_active'],
        pushToken: json['push_token']);
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sub_name'] = subName;
    data['image'] = image;
    data['about'] = about;
    data['fcm_token'] = fcmToken;
    data['phoneNumber'] = phoneNumber;
    data['chats'] = chats;
    data['is_profile_complete'] = isProfileComplete;
    data['is_online'] = isOnline;
    data['last_active'] = lastActive;
    data['push_token'] = pushToken;
    return data;
  }
}
