
/// _id : "123"
/// firstName : "John"
/// lastName : "Doe"
/// email : "john.doe@example.com"
/// password : "secret"
/// dateOfBirth : "1990-01-01"
/// gender : "Male"
/// image : "https://example.com/image.jpg"
/// aboutMe : "I love coding."
/// bio : "Software Developer"
/// fcmToken : "ABC123"
/// phoneNumber : "+1234567890"
/// chats : ["chat1","chat2"]
/// userPhotos : ["photo1.jpg","photo2.jpg"]
/// moreAbout : {"diet":"Vegetarian","workout":"Gym","height":"180cm","weight":"70kg","smoking":"No","drinking":"Yes"}
/// isProfileComplete : true
/// isOnline : false
/// lastActive : "2024-05-03T12:00:00Z"
/// pushToken : "XYZ789"
/// status : "Active"
/// isProfileCompleted : true
/// token : "TOKEN123"
/// blockedFriendIds : [1,2]
/// favouriteEvent : ["event1","event2"]
/// authToken : ["token1","token2"]

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    // this.password,
    this.dateOfBirth,
    this.friendConnection,
    this.gender,
    this.image,
    this.aboutMe,
    this.bio,
    this.fcmToken,
    this.phoneNumber,
    this.chats,
    this.userPhotos,
    this.moreAbout,
    this.socialLink,
    this.interest,
    this.isOnline,
    this.lastActive,
    this.pushToken,
    this.status,
    this.isProfileCompleted,
    this.token,
    this.blockedFriendIds,
    this.favouriteEvent,
    this.authToken,
    this.friends,
    this.isFriend,
    this.bankDetails,
  });

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    // password = json['password'];
    dateOfBirth = json['dateOfBirth'];
    friendConnection = json['friendConnection'].toString();
    gender = json['gender'];
    image = json['image'];
    aboutMe = json['aboutMe'];
    bio = json['bio'];
    fcmToken = json['fcmToken'];
    phoneNumber = json['phoneNumber'].toString();
    chats = json['chats'] != null ? json['chats'].cast<String>() : [];
    userPhotos = json['userPhotos'] != null ? json['userPhotos'].cast<String>() : [];
    moreAbout = json['moreAbout'] != null ? MoreAbout.fromJson(json['moreAbout']) : null;
    socialLink = json['socialLink'] != null ? SocialLink.fromJson(json['socialLink']) : null;
    interest = json['interest'] != null ? Interest.fromJson(json['interest']) : null;
    isOnline = json['is_online'];
    lastActive = json['lastActive'];
    pushToken = json['pushToken'];
    status = json['status'];
    isProfileCompleted = json['isProfileCompleted'];
    token = json['token'];
    blockedFriendIds = json['blockedFriendIds'] != null ? json['blockedFriendIds'].cast<num>() : [];
    favouriteEvent = json['favouriteEvent'] != null ? json['favouriteEvent'].cast<String>() : [];
    authToken = json['authToken'] != null ? json['authToken'].cast<String>() : [];
    if (json['friends'] != null) {
      friends = [];
      json['friends'].forEach((v) {
        friends?.add(Friends.fromJson(v));
      });
    }
    isFriend= json['isFriend'];
    bankDetails = json['bankDetails'] != null ? BankDetails.fromJson(json['bankDetails']) : null;
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  // String? password;
  String? dateOfBirth;
  String? friendConnection;
  String? gender;
  String? image;
  String? aboutMe;
  String? bio;
  String? fcmToken;
  String? phoneNumber;
  List<String>? chats;
  List<String?>? userPhotos;
  MoreAbout? moreAbout;
  SocialLink? socialLink;
  Interest? interest;
  bool? isOnline;
  String? lastActive;
  String? pushToken;
  String? status;
  bool? isProfileCompleted;
  String? token;
  List<num>? blockedFriendIds;
  List<String>? favouriteEvent;
  List<String>? authToken;
  List<Friends>? friends;
  String? isFriend;
  BankDetails? bankDetails;
  UserModel copyWith({  String? id,
    String? firstName,
    String? lastName,
    String? email,
    // String? password,
    String? dateOfBirth,
    String? friendConnection,
    String? gender,
    String? image,
    String? aboutMe,
    String? bio,
    String? fcmToken,
    String? phoneNumber,
    List<String>? chats,
    List<String?>? userPhotos,
    MoreAbout? moreAbout,
    SocialLink? socialLink,
    Interest? interest,
    bool? isOnline,
    String? lastActive,
    String? pushToken,
    String? status,
    bool? isProfileCompleted,
    String? token,
    List<num>? blockedFriendIds,
    List<String>? favouriteEvent,
    List<String>? authToken,
    List<Friends>? friends,
    String? isFriend,
    BankDetails? bankDetails,
  }) => UserModel(  id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    // password: password ?? this.password,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    friendConnection: friendConnection ?? this.friendConnection,
    gender: gender ?? this.gender,
    image: image ?? this.image,
    aboutMe: aboutMe ?? this.aboutMe,
    bio: bio ?? this.bio,
    fcmToken: fcmToken ?? this.fcmToken,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    chats: chats ?? this.chats,
    userPhotos: userPhotos ?? this.userPhotos,
    moreAbout: moreAbout ?? this.moreAbout,
    socialLink: socialLink ?? this.socialLink,
    interest: interest ?? this.interest,
    isOnline: isOnline ?? this.isOnline,
    lastActive: lastActive ?? this.lastActive,
    pushToken: pushToken ?? this.pushToken,
    status: status ?? this.status,
    isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    token: token ?? this.token,
    blockedFriendIds: blockedFriendIds ?? this.blockedFriendIds,
    favouriteEvent: favouriteEvent ?? this.favouriteEvent,
    authToken: authToken ?? this.authToken,
    friends: friends ?? this.friends,
    isFriend: isFriend ?? this.isFriend,
    bankDetails: bankDetails ?? this.bankDetails,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    // map['password'] = password;
    map['dateOfBirth'] = dateOfBirth;
    map['friendConnection'] = friendConnection;
    map['gender'] = gender;
    map['image'] = image;
    map['aboutMe'] = aboutMe;
    map['bio'] = bio;
    map['fcmToken'] = fcmToken;
    map['phoneNumber'] = phoneNumber;
    map['chats'] = chats;
    map['userPhotos'] = userPhotos;
    if (moreAbout != null) {
      map['moreAbout'] = moreAbout?.toJson();
    }
    if (socialLink != null) {
      map['socialLink'] = socialLink?.toJson();
    }
    if (interest != null) {
      map['interest'] = interest?.toJson();
    }
    map['is_online'] = isOnline;
    map['lastActive'] = lastActive;
    map['pushToken'] = pushToken;
    map['status'] = status;
    map['isProfileCompleted'] = isProfileCompleted;
    map['token'] = token;
    map['blockedFriendIds'] = blockedFriendIds;
    map['favouriteEvent'] = favouriteEvent;
    map['authToken'] = authToken;
    if (friends != null) {
      map['friends'] = friends?.map((v) => v.toJson()).toList();
    }
    map['isFriend'] = isFriend;
    if (bankDetails != null) {
      map['bankDetails'] = bankDetails?.toJson();
    }
    return map;
  }
  Map<String, dynamic> toUpdateJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    // map['password'] = password;
    map['dateOfBirth'] = dateOfBirth;

    map['gender'] = gender;
    map['image'] = image;
    map['aboutMe'] = aboutMe;
    map['bio'] = bio;
    map['fcmToken'] = fcmToken;
    map['phoneNumber'] = phoneNumber;
    map['chats'] = chats;
    map['userPhotos'] = userPhotos;
    if (moreAbout != null) {
      map['moreAbout'] = moreAbout?.toJson();
    }
    if (socialLink != null) {
      map['socialLink'] = socialLink?.toJson();
    }
    if (interest != null) {
      map['interest'] = interest?.toJson();
    }
    map['is_online'] = isOnline;
    map['lastActive'] = lastActive;
    map['pushToken'] = pushToken;
    map['status'] = status;
    map['isProfileCompleted'] = isProfileCompleted;
    map['token'] = token;
    map['blockedFriendIds'] = blockedFriendIds;
    map['favouriteEvent'] = favouriteEvent;
    map['authToken'] = authToken;
    return map;
  }

}


/// account_no : 123456789
/// account_title : "BasitABK"
/// bank_code : "1234"

class BankDetails {
  BankDetails({
    this.accountNo,
    this.accountTitle,
    this.bankCode,});

  BankDetails.fromJson(dynamic json) {
    accountNo = json['account_no'];
    accountTitle = json['account_title'];
    bankCode = json['bank_code'];
  }
  num? accountNo;
  String? accountTitle;
  String? bankCode;
  BankDetails copyWith({  num? accountNo,
    String? accountTitle,
    String? bankCode,
  }) => BankDetails(  accountNo: accountNo ?? this.accountNo,
    accountTitle: accountTitle ?? this.accountTitle,
    bankCode: bankCode ?? this.bankCode,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_no'] = accountNo;
    map['account_title'] = accountTitle;
    map['bank_code'] = bankCode;
    return map;
  }

}

/// userID : "661d18512214b560a0f7e3eb"
/// username : "abdul basit 2 khan"
/// useraboutMe : "testing"
/// image : "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"

class Friends {
  Friends({
    this.id,
    this.firstName,
    this.lastName,
    this.aboutMe,
    this.image,});

  Friends.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    aboutMe = json['aboutMe'];
    image = json['image'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? aboutMe;
  String? image;
  Friends copyWith({
    String? id,
    String? username,
    String? useraboutMe,
    String? image,
  }) => Friends(  id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    aboutMe: aboutMe ?? this.aboutMe,
    image: image ?? this.image,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['aboutMe'] = aboutMe;
    map['image'] = image;
    return map;
  }

}


/// diet : "Vegetarian"
/// workout : "Gym"
/// height : "180cm"
/// weight : "70kg"
/// smoking : "No"
/// drinking : "Yes"

class MoreAbout {
  MoreAbout({
    this.diet,
    this.workout,
    this.height,
    // this.weight,
    this.smoking,
    this.drinking,
    this.pets,});

  MoreAbout.fromJson(dynamic json) {
    diet = json['diet'];
    workout = json['workout'];
    height = json['height'];
    // weight = json['weight'];
    smoking = json['smoking'];
    drinking = json['drinking'];
    pets = json['pets'];
  }
  String? diet;
  String? workout;
  String? height;
  // String? weight;
  String? smoking;
  String? drinking;
  String? pets;
  MoreAbout copyWith({  String? diet,
    String? workout,
    String? height,
    // String? weight,
    String? smoking,
    String? drinking,
    String? pets,
  }) => MoreAbout(  diet: diet ?? this.diet,
    workout: workout ?? this.workout,
    height: height ?? this.height,
    // weight: weight ?? this.weight,
    smoking: smoking ?? this.smoking,
    drinking: drinking ?? this.drinking,
    pets: pets ?? this.pets,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diet'] = diet;
    map['workout'] = workout;
    map['height'] = height;
    // map['weight'] = weight;
    map['smoking'] = smoking;
    map['drinking'] = drinking;
    map['pets'] = pets;
    return map;
  }

}



class SocialLink {
  SocialLink({
    this.linkedin,
    this.instagram,
    this.facebook,
   });

  SocialLink.fromJson(dynamic json) {
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    facebook = json['facebook'];

  }
  String? linkedin;
  String? instagram;
  String? facebook;

  SocialLink copyWith({  String? diet,
    String? linkedin,
    String? instagram,
    String? facebook,

  }) => SocialLink(
    linkedin: linkedin ?? this.linkedin,
    instagram: instagram ?? this.instagram,
    facebook: facebook ?? this.facebook,

  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['linkedin'] = linkedin;
    map['instagram'] = instagram;
    map['facebook'] = facebook;
    return map;
  }

}


/// hobbies : [{"icon":"Icons.favorite","value":"women"},{"icon":"Icons.active","value":"active"},{"icon":"Icons.dog","value":"dog"}]
/// creativity : [{"icon":"Icons.favorite","value":"women"},{"icon":"Icons.active","value":"active"},{"icon":"Icons.dog","value":"dog"}]
class Interest {
  Interest({
    this.hobbies,
    this.creativity,});

  Interest.fromJson(dynamic json) {
    if (json['hobbies'] != null) {
      hobbies = [];
      json['hobbies'].forEach((v) {
        hobbies?.add(InterestData.fromJson(v));
      });
    }
    if (json['creativity'] != null) {
      creativity = [];
      json['creativity'].forEach((v) {
        creativity?.add(InterestData.fromJson(v));
      });
    }
  }
  List<InterestData>? hobbies;
  List<InterestData>? creativity;
  Interest copyWith({  List<InterestData>? hobbies,
    List<InterestData>? creativity,
  }) => Interest(  hobbies: hobbies ?? this.hobbies,
    creativity: creativity ?? this.creativity,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hobbies != null) {
      map['hobbies'] = hobbies?.map((v) => v.toJson()).toList();
    }
    if (creativity != null) {
      map['creativity'] = creativity?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
/// icon : "Icons.favorite"
/// value : "women"

// class Creativity {
//   Creativity({
//     this.icon,
//     this.value,});
//
//   Creativity.fromJson(dynamic json) {
//     icon = json['icon'];
//     value = json['value'];
//   }
//   String? icon;
//   String? value;
//   Creativity copyWith({  String? icon,
//     String? value,
//   }) => Creativity(  icon: icon ?? this.icon,
//     value: value ?? this.value,
//   );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['icon'] = icon;
//     map['value'] = value;
//     return map;
//   }
//
// }

/// icon : "Icons.favorite"
/// value : "women"

class InterestData {
  InterestData({
    this.icon,
    this.value,});

  InterestData.fromJson(dynamic json) {
    icon = json['icon'];
    value = json['value'];
  }
  String? icon;
  String? value;
  InterestData copyWith({  String? icon,
    String? value,
  }) => InterestData(  icon: icon ?? this.icon,
    value: value ?? this.value,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['value'] = value;
    return map;
  }

}