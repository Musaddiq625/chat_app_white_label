
import 'message.dart';

class Chat {
  final String id;

  // final String name;
  // final String imageUrl;
  final Message? last_message;
  final int unreadCount;

  const Chat({
    required this.id,
    // required this.name,
    // required this.imageUrl,
    required this.last_message,
    required this.unreadCount,
  });

  // factory Chat.fromDocument(DocumentSnapshot doc) {
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      // name: doc['name'],
      // imageUrl: doc['imageUrl'],
      last_message: Message.fromJson(map['last_message']),
      unreadCount: map['unread_count'],
    );
  }
}