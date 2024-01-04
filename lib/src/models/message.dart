
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? message;
  final String? msgType;
  final String? name;
  final bool? received;
  final bool? seen;
  final Timestamp? time;

  const Message({
    required this.message,
    required this.msgType,
    required this.name,
    required this.received,
    required this.seen,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      msgType: json['msgType'],
      name: json['name'],
      received: json['received'],
      seen: json['seen'],
      time: json['time'] as Timestamp,
    );
  }
}
