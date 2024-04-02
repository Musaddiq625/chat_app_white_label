class MoreAboutMe {
  MoreAboutMe({
      this.diet, 
      this.workout, 
      this.height, 
      this.weight, 
      this.smoking, 
      this.drinking,});

  MoreAboutMe.fromJson(dynamic json) {
    diet = json['diet'];
    workout = json['workout'];
    height = json['height'];
    weight = json['weight'];
    smoking = json['smoking'];
    drinking = json['drinking'];
  }
  String? diet;
  String? workout;
  int? height;
  int? weight;
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