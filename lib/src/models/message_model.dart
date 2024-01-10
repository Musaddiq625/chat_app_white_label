class MessageModel {
  MessageModel({
    required this.fromId,
    required this.toId,
    required this.msg,
    required this.readAt,
    required this.type,
    required this.sentAt,
  });
  String? fromId;
  String? toId;
  String? msg;
  Type? type;
  String? readAt;
  String? sentAt;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      fromId: json['fromId'],
      toId: json['toId'],
      msg: json['msg'],
      type: json['type'] == Type.image.name ? Type.image : Type.text,
      readAt: json['readAt'],
      sentAt: json['sentAt']);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['toId'] = toId;
    data['msg'] = msg;
    data['type'] = type?.name;
    data['readAt'] = readAt;
    data['sentAt'] = sentAt;
    return data;
  }
}

enum Type { text, image }


// import 'package:cloud_firestore/cloud_firestore.dart';

// class Message {
//   final String? message;
//   final String? msgType;
//   final String? name;
//   final bool? received;
//   final bool? seen;
//   final Timestamp? time;

//   const Message({
//     required this.message,
//     required this.msgType,
//     required this.name,
//     required this.received,
//     required this.seen,
//     required this.time,
//   });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       message: json['message'],
//       msgType: json['msgType'],
//       name: json['name'],
//       received: json['received'],
//       seen: json['seen'],
//       time: json['time'] as Timestamp,
//     );
//   }
// }