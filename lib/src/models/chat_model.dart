import 'message_model.dart';

class ChatModel {
  String? id;
  bool? isGroup;
  MessageModel? lastMessage;
  int? unreadCount;
  List<String>? users;

  ChatModel(
      {this.id, this.isGroup, this.lastMessage, this.unreadCount, this.users});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        isGroup: json['is_group'],
        lastMessage: json['last_message'] != null
            ? MessageModel.fromJson(json['last_message'])
            : null,
        unreadCount: json['unread_count'],
        users: json['users'] == null ? [] : json['users'].cast<String>());
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_group'] = isGroup;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage?.toJson();
    }
    data['unread_count'] = unreadCount;
    data['users'] = users;

    return data;
  }
}
