class MessageModel {
  MessageModel(
      {required this.fromId,
      required this.toId,
      required this.msg,
      required this.readAt,
      required this.type,
      required this.sentAt,
      this.length,
      this.thumbnail,
      this.fileName,
      this.readBy});
  String? fromId;
  String? toId;
  String? msg;
  MessageType? type;
  String? readAt;
  String? sentAt;
  int? length;
  String? thumbnail;
  String? fileName;
  List<String>? readBy;

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
                    : json['type'] == MessageType.document.name
                        ? MessageType.document
                        : MessageType.text,
        readAt: json['readAt'],
        sentAt: json['sentAt'],
        length: json['length'],
        thumbnail: json['thumbnail'],
        fileName: json['fileName'],
        readBy: json['readBy'] == null ? [] : json['readBy'].cast<String>(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['sentAt'] = sentAt;
    data['msg'] = msg;
    data['type'] = type?.name;
    if (readAt != null) {
      data['readAt'] = readAt;
    }
    if (toId != null) {
      data['toId'] = toId;
    }
    if (length != null) {
      data['length'] = length;
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail;
    }
    if (fileName != null) {
      data['fileName'] = fileName;
    }
    if (readBy != null) {
      data['readBy'] = readBy;
    }
    return data;
  }
}

enum MessageType { text, image, audio, video, document }
