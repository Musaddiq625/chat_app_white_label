class MessageModel {
  MessageModel(
      {required this.fromId,
      required this.toId,
      required this.msg,
      required this.readAt,
      required this.type,
      required this.sentAt,
      this.length,
      this.thumbnail});
  String? fromId;
  String? toId;
  String? msg;
  MessageType? type;
  String? readAt;
  String? sentAt;
  int? length;
  String? thumbnail;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      fromId: json['fromId'],
      toId: json['toId'],
      msg: json['msg'],
      type: json['type'] == MessageType.image.name
          ? MessageType.image
          : json['type'] == MessageType.audio.name
              ? MessageType.audio
              : json['type'] == MessageType.video.name
                  ? MessageType.video
                  : MessageType.text,
      readAt: json['readAt'],
      sentAt: json['sentAt'],
      length: json['length'],
      thumbnail: json['thumbnail']);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['toId'] = toId;
    data['msg'] = msg;
    data['type'] = type?.name;
    data['readAt'] = readAt;
    data['sentAt'] = sentAt;
    data['length'] = length;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

enum MessageType { text, image, audio, video }


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