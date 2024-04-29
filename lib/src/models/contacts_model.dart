import 'package:chat_app_white_label/src/models/user_model.dart';

class ContactModel {
  ContactModel({
    this.localName,
    this.phoneNumber,
    this.firebaseData,
  });
  String? localName;
  String? phoneNumber;
  UserModel? firebaseData;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
      localName: json['local_name'],
      phoneNumber: json['phone_number'],
      firebaseData: json['firebase_data'] != null
          ? UserModel.fromJson(json['firebase_data'])
          : null);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['local_name'] = localName;
    data['phone_number'] = phoneNumber;
    data['firebase_data'] = firebaseData;

    return data;
  }
}
