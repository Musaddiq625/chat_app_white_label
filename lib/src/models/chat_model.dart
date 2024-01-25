import 'message_model.dart';

class ChatModel {
  String? id;
  bool? isGroup;
  List<String>? users;
  GroupData? groupData;
  MessageModel? lastMessage;
  String? unreadCount;
  List<String>? unreadMessages;
  // List<UnreadMessages>? unreadMessages;

  ChatModel(
      {required this.id,
      required this.isGroup,
      required this.users,
      this.groupData,
      this.lastMessage,
      this.unreadCount,
      this.unreadMessages});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      isGroup: json['is_group'],
      groupData: json['group_data'] != null
          ? GroupData.fromJson(json['group_data'])
          : null,
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'])
          : null,
      // unreadCount: json['unread_count'],
      users: json['users'] == null ? [] : json['users'].cast<String>(),
      unreadMessages: json['unread_messages'] == null
          ? []
          : json['unread_messages'].cast<String>(),
      // unreadMessages: json['unread_messages'] != null
      //     ? (json['unread_messages'] as List)
      //         .map<UnreadMessages>((item) => UnreadMessages.fromJson(item))
      //         .toList()
      //     : []
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_group'] = isGroup;
    if (groupData != null) {
      data['group_data'] = groupData?.toJson();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage?.toJson();
    }
    // data['unread_count'] = unreadCount;
    data['users'] = users;
    if (unreadMessages != null) {
      data['unread_messages'] = unreadMessages;
    }
    // data['unread_messages'] = unreadMessages;
    return data;
  }
}

class GroupData {
  GroupData({
    required this.adminId,
    required this.grougName,
    required this.groupImage,
  });
  String? adminId;
  String? grougName;
  String? groupImage;

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        adminId: json['admin_id'],
        grougName: json['groug_name'],
        groupImage: json['group_image'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['admin_id'] = adminId;
    data['groug_name'] = grougName;
    data['group_image'] = groupImage;

    return data;
  }
}
