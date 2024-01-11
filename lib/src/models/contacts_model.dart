class ContactModel {
  ContactModel({
    this.localName,
    this.phoneNumber,
  });
  String? localName;
  String? phoneNumber;
  String? firebaseName;
  String? image;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        localName: json['local_name'],
        phoneNumber: json['phone_number'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['local_name'] = localName;
    data['phone_number'] = phoneNumber;

    return data;
  }
}
