import 'message_model.dart';

class ChatModel {
  String? id;
  bool? isGroup;
  MessageModel? lastMessage;
  int? unreadCount;
  List<String>? users;
  List<UnreadMessages>? unreadMessages;

  ChatModel(
      {this.id,
      this.isGroup,
      this.lastMessage,
      this.unreadCount,
      this.users,
      this.unreadMessages});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        isGroup: json['is_group'],
        lastMessage: json['last_message'] != null
            ? MessageModel.fromJson(json['last_message'])
            : null,
        unreadCount: json['unread_count'],
        users: json['users'] == null ? [] : json['users'].cast<String>(),
        unreadMessages: json['unread_messages'] == null
            ? []
            : json['unread_messages'].cast<UnreadMessages>());
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_group'] = isGroup;
    if (lastMessage != null) {
      data['last_message'] = lastMessage?.toJson();
    }
    data['unread_count'] = unreadCount;
    data['users'] = users;
    if (unreadMessages != null) {
      data['unread_messages'] = unreadMessages?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class UnreadMessages {
  UnreadMessages({
    this.userId,
    this.count,
  });
  String? userId;
  int? count;

  factory UnreadMessages.fromJson(Map<String, dynamic> json) => UnreadMessages(
        userId: json['user_id'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['count'] = count;
    return data;
  }
}
