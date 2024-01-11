class ContactModel {
  ContactModel({
    this.localName,
    this.phoneNumber,
    this.firebaseName,
    this.image,
  });
  String? localName;
  String? phoneNumber;
  String? firebaseName;
  String? image;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        localName: json['local_name'],
        phoneNumber: json['phone_number'],
        firebaseName: json['firebase_name'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['local_name'] = localName;
    data['phone_number'] = phoneNumber;
    data['firebase_name'] = firebaseName;
    data['image'] = image;
    return data;
  }
}
