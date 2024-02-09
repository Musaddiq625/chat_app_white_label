part of 'chat_room_cubit.dart';

@immutable
sealed class ChatRoomState {}

final class ChatRoomInitial extends ChatRoomState {}

final class MediaSelectedState extends ChatRoomState {
  final String filePath;
  final String? thumbnailPath;
  final MessageType type;
  MediaSelectedState(this.filePath, this.thumbnailPath, this.type);
}

final class UploadinState extends ChatRoomState {}

final class ShowEmojiState extends ChatRoomState {}
