import 'message_model.dart';

class ChatModel {
  String? id;
  bool? isGroup;
  List<String>? users;
  GroupData? groupData;
  MessageModel? lastMessage;
  String? unreadCount;
  int? readCountGroup;
  int? messageCount;

  ChatModel(
      {required this.id,
      required this.isGroup,
      required this.users,
      this.groupData,
      this.lastMessage,
      this.unreadCount,
      this.readCountGroup,
      this.messageCount});

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
        users: json['users'] == null ? [] : json['users'].cast<String>(),
        // readCountGroup: json['read_count_group'] == null
        //     ? []
        //     : json['read_count_group'].cast<String>(),
        messageCount: json['message_count']);
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
    data['users'] = users;
    // if (readCountGroup != null) {
    //   data['read_count_group'] = readCountGroup;
    // }
    data['message_count'] = messageCount;
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
