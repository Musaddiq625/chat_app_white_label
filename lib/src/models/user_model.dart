class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? dateOfBirth;
  String? gender;
  String? image;
  String? aboutMe;
  String? phoneNumber;
  String? fcmToken;
  List<String>? chats;
  bool? isProfileComplete;
  bool? isOnline;
  String? lastActive;
  String? pushToken;
  String? status;
  bool? isProfileCompleted;
  String? token;
  List<dynamic>? blockedFriendIds;
  List<dynamic>? favouriteEvent;
  List<dynamic>? authToken;

  UserModel({
    this.id,
    this.firstName,
    this.image,
    this.lastName,
    this.email,
    this.password,
    this.dateOfBirth,
    this.gender,
    this.aboutMe,
    this.fcmToken,
    this.phoneNumber,
    this.chats,
    this.isProfileComplete,
    this.isOnline,
    this.lastActive,
    this.pushToken,
    this.status,
    this.isProfileCompleted,
    this.token,
    this.blockedFriendIds,
    this.favouriteEvent,
    this.authToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      image: json['image'],
      aboutMe: json['aboutMe'],
      fcmToken: json['fcm_token'],
      phoneNumber: json['phoneNumber'],
      chats: json['chats'] == null ? [] : json['chats'].cast<String>(),
      isProfileComplete: json['is_profile_complete'],
      isOnline: json['is_online'],
      lastActive: json['last_active'],
      pushToken: json['push_token'],
      status: json['status'],
      isProfileCompleted: json['isProfileCompleted'],
      token: json['token'],
      blockedFriendIds: json['blockedFriendIds'],
      favouriteEvent: json['favouriteEvent'],
      authToken: json['authToken'],
    );
  }
  //
  // factory UserModel.fromJsonSignUp(Map<String, dynamic> json) {
  //   return UserModel(
  //       firstName: json['firstName'],
  //       lastName: json['lastName'],
  //       email: json['email'],
  //       password: json['password'],
  //       image: json['image'],
  //       phoneNumber: json['phoneNumber'],
  //       isProfileComplete: json['is_profile_complete']);
  // }
  //
  // factory UserModel.fromJsonLogin(Map<String, dynamic> json) {
  //   return UserModel(
  //       firstName: json['firstName'],
  //       lastName: json['lastName'],
  //       email: json['email'],
  //       password: json['password'],
  //       image: json['image'],
  //       phoneNumber: json['phoneNumber'],
  //       isProfileComplete: json['is_profile_complete']);
  // }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['image'] = image;
    data['aboutMe'] = aboutMe;
    data['fcm_token'] = fcmToken;
    data['phoneNumber'] = phoneNumber;
    data['chats'] = chats;
    data['is_profile_complete'] = isProfileComplete;
    data['is_online'] = isOnline;
    data['last_active'] = lastActive;
    data['push_token'] = pushToken;
    data['status'] = status;
    data['isProfileCompleted'] = isProfileCompleted;
    data['token'] = token;
    data['blockedFriendIds'] = blockedFriendIds;
    data['favouriteEvent'] = favouriteEvent;
    data['authToken'] = authToken;
    return data;
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? image,
    String? dateOfBirth,
    String? gender,
    String? aboutMe,
    String? fcmToken,
    String? phoneNumber,
    List<String>? chats,
    bool? isProfileComplete,
    bool? isOnline,
    String? lastActive,
    String? pushToken,
    String? status,
    bool? isProfileCompleted,
    String? token,
    List<dynamic>? blockedFriendIds,
    List<dynamic>? favouriteEvent,
    List<dynamic>?authToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      aboutMe: aboutMe ?? this.aboutMe,
      fcmToken: fcmToken ?? this.fcmToken,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      chats: chats ?? this.chats,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      pushToken: pushToken ?? this.pushToken,
      status: status ?? this.status,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      token: token ?? this.token,
      blockedFriendIds: blockedFriendIds ?? this.blockedFriendIds,
      favouriteEvent: favouriteEvent ?? this.favouriteEvent,
      authToken: authToken ?? this.authToken,
    );
  }

  // Map<String, dynamic> LoginToJson() {
  //   final data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['firstName'] = firstName;
  //   data['lastName'] = lastName;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['image'] = image;
  //   data['about'] = about;
  //   data['fcm_token'] = fcmToken;
  //   data['phoneNumber'] = phoneNumber;
  //   data['chats'] = chats;
  //   data['is_profile_complete'] = isProfileComplete;
  //
  //   return data;
  // }
  //
  // Map<String, dynamic> SignupToJson() {
  //   final data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['firstName'] = firstName;
  //   data['lastName'] = lastName;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['image'] = image;
  //   data['about'] = about;
  //   data['fcm_token'] = fcmToken;
  //   data['phoneNumber'] = phoneNumber;
  //   data['chats'] = chats;
  //   data['is_profile_complete'] = isProfileComplete;
  //
  //   return data;
  // }
}
