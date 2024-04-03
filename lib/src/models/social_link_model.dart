class SocialLinkModel {
  SocialLinkModel({
      this.linkedin, 
      this.instagram,});

  SocialLinkModel.fromJson(dynamic json) {
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