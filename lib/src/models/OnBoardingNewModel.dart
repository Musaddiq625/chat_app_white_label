/// id : 0
/// first_name : ""
/// last_name : ""
/// phone_no : ""
/// email_address : ""
/// password : ""
/// date_of_birth : ""
/// gender : ""
/// county : ""
/// city : ""
/// about_me : ""
/// bio : ""
/// profile_image : ""
/// user_photos : [""]
/// social_link : {"linkedin":true,"instagram":false}
/// more_about : {"diet":"","workout":"","height":0.0,"weight":0.0,"smoking":false,"drinking":false}
/// hobbie : [""]
/// creativity : [""]

class OnBoardingNewModel {
  OnBoardingNewModel({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.phoneNo, 
      this.emailAddress, 
      this.password, 
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
      this.hobbie, 
      this.creativity,});

  OnBoardingNewModel.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    emailAddress = json['email_address'];
    password = json['password'];
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
    hobbie = json['hobbie'] != null ? json['hobbie'].cast<String>() : [];
    creativity = json['creativity'] != null ? json['creativity'].cast<String>() : [];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? emailAddress;
  String? password;
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
  List<String>? hobbie;
  List<String>? creativity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone_no'] = phoneNo;
    map['email_address'] = emailAddress;
    map['password'] = password;
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
    map['hobbie'] = hobbie;
    map['creativity'] = creativity;
    return map;
  }

}

/// diet : ""
/// workout : ""
/// height : 0.0
/// weight : 0.0
/// smoking : false
/// drinking : false

class MoreAbout {
  MoreAbout({
      this.diet, 
      this.workout, 
      this.height, 
      this.weight, 
      this.smoking, 
      this.drinking,});

  MoreAbout.fromJson(dynamic json) {
    diet = json['diet'];
    workout = json['workout'];
    height = json['height'];
    weight = json['weight'];
    smoking = json['smoking'];
    drinking = json['drinking'];
  }
  String? diet;
  String? workout;
  num? height;
  num? weight;
  bool? smoking;
  bool? drinking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diet'] = diet;
    map['workout'] = workout;
    map['height'] = height;
    map['weight'] = weight;
    map['smoking'] = smoking;
    map['drinking'] = drinking;
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