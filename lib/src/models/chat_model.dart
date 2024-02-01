import 'message_model.dart';

class ChatModel {
  String? id;
  bool? isGroup;
  List<String>? users;
  GroupData? groupData;
  MessageModel? lastMessage;
  String? unreadCount;
  List? lastMessageReadBy;
  int? readCountGroup;
  int? messageCount;

  ChatModel(
      {required this.id,
      required this.isGroup,
      required this.users,
      this.groupData,
      this.lastMessage,
      this.unreadCount,
      this.lastMessageReadBy,
      this.readCountGroup,
      this.messageCount});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        isGroup: json['is_group'],
        users: json['users'] == null ? [] : json['users'].cast<String>(),
        groupData: json['group_data'] != null
            ? GroupData.fromJson(json['group_data'])
            : null,
        lastMessage: json['last_message'] != null
            ? MessageModel.fromJson(json['last_message'])
            : null,
        lastMessageReadBy: json['last_message_readBy'] == null
            ? []
            : json['last_message_readBy'].cast<String>(),
        messageCount: json['message_count']);
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_group'] = isGroup;
    data['users'] = users;
    if (groupData != null) {
      data['group_data'] = groupData?.toJson();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage?.toJson();
    }
    data['message_count'] = messageCount;
    return data;
  }
}

class GroupData {
  GroupData({
    required this.id,
    required this.adminId,
    required this.grougName,
    required this.groupAbout,
    required this.groupImage,
  });
  String? id;
  String? adminId;
  String? grougName;
  String? groupAbout;
  String? groupImage;

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        id: json['id'],
        adminId: json['admin_id'],
        grougName: json['groug_name'],
        groupAbout: json['group_about'],
        groupImage: json['group_image'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['admin_id'] = adminId;
    data['groug_name'] = grougName;
    data['group_about'] = groupAbout;
    data['group_image'] = groupImage;

    return data;
  }
}
