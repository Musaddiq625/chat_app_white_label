/// id : 111
/// first_name : "firstname"
/// last_name : "second name"
/// phone_code : "000"
/// phone_no : "1123233"
/// email : "abc@gmail.com"
/// date_of_birth : "02/05/1990"
/// gender : "male"
/// county : "pakistan"
/// city : "karachi"
/// about_me : "test"
/// bio : "discription"
/// profile_image : "imageselected"
/// user_photos : ["img1","img2"]
/// social_link : {"linkedin":true,"instagram":false}
/// more_about : {"diet":{"name":"Diet","value":"yes"},"workout":{"name":"Workout","value":"yes"},"height":{"name":"height","value":"5'6"},"weight":{"name":"weight","value":"60"},"smoking":{"name":"smoking","value":true},"drinking":{"name":"drinking","value":true}}
/// hobbies : ["cricket","football"]
/// creativity : ["reading","calligraphy"]
/// social_login : {"google":"google-id","apple":"apple-id"}
/// corporate_profile : [{"company":"<string>","role":"<string>"}]
/// my_event : ["event-1","event-2"]
/// saved_event : ["event-3"]
/// report_event : ["event-4"]
/// friends : ["friend-1-id","friend-2-id","friend-3-id",null]
/// blocked_friends : ["friend-1-id","friend-2-id",null]
/// is_email_verified : true
/// is_phone_verified : true
/// notification_token : "tokenvalue"
/// created_at : "02/02/2022"
/// updated_at : "03/04/2023"
/// status : "active/disabled/blocked/deleted"

class UserDetailModel {
  UserDetailModel({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.phoneCode, 
      this.phoneNo, 
      this.email, 
      this.dateOfBirth, 
      this.gender, 
      this.county, 
      this.city, 
      this.aboutMe, 
      this.bio, 
      this.profileImage, 
      this.userPhotos, 
      this.socialLink, 
      this.moreAbout, 
      this.hobbies, 
      this.creativity, 
      this.socialLogin, 
      this.corporateProfile, 
      this.myEvent, 
      this.savedEvent, 
      this.reportEvent, 
      this.friends, 
      this.blockedFriends, 
      this.isEmailVerified, 
      this.isPhoneVerified, 
      this.notificationToken, 
      this.createdAt, 
      this.updatedAt, 
      this.status,});

  UserDetailModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneCode = json['phone_code'];
    phoneNo = json['phone_no'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    county = json['county'];
    city = json['city'];
    aboutMe = json['about_me'];
    bio = json['bio'];
    profileImage = json['profile_image'];
    userPhotos = json['user_photos'] != null ? json['user_photos'].cast<String>() : [];
    socialLink = json['social_link'] != null ? SocialLink.fromJson(json['social_link']) : null;
    moreAbout = json['more_about'] != null ? MoreAbout.fromJson(json['more_about']) : null;
    hobbies = json['hobbies'] != null ? json['hobbies'].cast<String>() : [];
    creativity = json['creativity'] != null ? json['creativity'].cast<String>() : [];
    socialLogin = json['social_login'] != null ? SocialLogin.fromJson(json['social_login']) : null;
    if (json['corporate_profile'] != null) {
      corporateProfile = [];
      json['corporate_profile'].forEach((v) {
        corporateProfile?.add(CorporateProfile.fromJson(v));
      });
    }
    myEvent = json['my_event'] != null ? json['my_event'].cast<String>() : [];
    savedEvent = json['saved_event'] != null ? json['saved_event'].cast<String>() : [];
    reportEvent = json['report_event'] != null ? json['report_event'].cast<String>() : [];
    friends = json['friends'] != null ? json['friends'].cast<String>() : [];
    blockedFriends = json['blocked_friends'] != null ? json['blocked_friends'].cast<String>() : [];
    isEmailVerified = json['is_email_verified'];
    isPhoneVerified = json['is_phone_verified'];
    notificationToken = json['notification_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? phoneCode;
  String? phoneNo;
  String? email;
  String? dateOfBirth;
  String? gender;
  String? county;
  String? city;
  String? aboutMe;
  String? bio;
  String? profileImage;
  List<String>? userPhotos;
  SocialLink? socialLink;
  MoreAbout? moreAbout;
  List<String>? hobbies;
  List<String>? creativity;
  SocialLogin? socialLogin;
  List<CorporateProfile>? corporateProfile;
  List<String>? myEvent;
  List<String>? savedEvent;
  List<String>? reportEvent;
  List<String>? friends;
  List<String>? blockedFriends;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? notificationToken;
  String? createdAt;
  String? updatedAt;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone_code'] = phoneCode;
    map['phone_no'] = phoneNo;
    map['email'] = email;
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;
    map['county'] = county;
    map['city'] = city;
    map['about_me'] = aboutMe;
    map['bio'] = bio;
    map['profile_image'] = profileImage;
    map['user_photos'] = userPhotos;
    if (socialLink != null) {
      map['social_link'] = socialLink?.toJson();
    }
    if (moreAbout != null) {
      map['more_about'] = moreAbout?.toJson();
    }
    map['hobbies'] = hobbies;
    map['creativity'] = creativity;
    if (socialLogin != null) {
      map['social_login'] = socialLogin?.toJson();
    }
    if (corporateProfile != null) {
      map['corporate_profile'] = corporateProfile?.map((v) => v.toJson()).toList();
    }
    map['my_event'] = myEvent;
    map['saved_event'] = savedEvent;
    map['report_event'] = reportEvent;
    map['friends'] = friends;
    map['blocked_friends'] = blockedFriends;
    map['is_email_verified'] = isEmailVerified;
    map['is_phone_verified'] = isPhoneVerified;
    map['notification_token'] = notificationToken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    return map;
  }

}

/// company : "<string>"
/// role : "<string>"

class CorporateProfile {
  CorporateProfile({
      this.company, 
      this.role,});

  CorporateProfile.fromJson(dynamic json) {
    company = json['company'];
    role = json['role'];
  }
  String? company;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company'] = company;
    map['role'] = role;
    return map;
  }

}

/// google : "google-id"
/// apple : "apple-id"

class SocialLogin {
  SocialLogin({
      this.google, 
      this.apple,});

  SocialLogin.fromJson(dynamic json) {
    google = json['google'];
    apple = json['apple'];
  }
  String? google;
  String? apple;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['google'] = google;
    map['apple'] = apple;
    return map;
  }

}

/// diet : {"name":"Diet","value":"yes"}
/// workout : {"name":"Workout","value":"yes"}
/// height : {"name":"height","value":"5'6"}
/// weight : {"name":"weight","value":"60"}
/// smoking : {"name":"smoking","value":true}
/// drinking : {"name":"drinking","value":true}

class MoreAbout {
  MoreAbout({
      this.diet, 
      this.workout, 
      this.height, 
      this.weight, 
      this.smoking, 
      this.drinking,});

  MoreAbout.fromJson(dynamic json) {
    diet = json['diet'] != null ? Diet.fromJson(json['diet']) : null;
    workout = json['workout'] != null ? Workout.fromJson(json['workout']) : null;
    height = json['height'] != null ? Height.fromJson(json['height']) : null;
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    smoking = json['smoking'] != null ? Smoking.fromJson(json['smoking']) : null;
    drinking = json['drinking'] != null ? Drinking.fromJson(json['drinking']) : null;
  }
  Diet? diet;
  Workout? workout;
  Height? height;
  Weight? weight;
  Smoking? smoking;
  Drinking? drinking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (diet != null) {
      map['diet'] = diet?.toJson();
    }
    if (workout != null) {
      map['workout'] = workout?.toJson();
    }
    if (height != null) {
      map['height'] = height?.toJson();
    }
    if (weight != null) {
      map['weight'] = weight?.toJson();
    }
    if (smoking != null) {
      map['smoking'] = smoking?.toJson();
    }
    if (drinking != null) {
      map['drinking'] = drinking?.toJson();
    }
    return map;
  }

}

/// name : "drinking"
/// value : true

class Drinking {
  Drinking({
      this.name, 
      this.value,});

  Drinking.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  bool? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// name : "smoking"
/// value : true

class Smoking {
  Smoking({
      this.name, 
      this.value,});

  Smoking.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  bool? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// name : "weight"
/// value : "60"

class Weight {
  Weight({
      this.name, 
      this.value,});

  Weight.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// name : "height"
/// value : "5'6"

class Height {
  Height({
      this.name, 
      this.value,});

  Height.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// name : "Workout"
/// value : "yes"

class Workout {
  Workout({
      this.name, 
      this.value,});

  Workout.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// name : "Diet"
/// value : "yes"

class Diet {
  Diet({
      this.name, 
      this.value,});

  Diet.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];
  }
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}

/// linkedin : true
/// instagram : false

class SocialLink {
  SocialLink({
      this.linkedin, 
      this.instagram,});

  SocialLink.fromJson(dynamic json) {
    linkedin = json['linkedin'];
    instagram = json['instagram'];
  }
  bool? linkedin;
  bool? instagram;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['linkedin'] = linkedin;
    map['instagram'] = instagram;
    return map;
  }

}