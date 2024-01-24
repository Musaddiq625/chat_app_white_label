part of 'group_chat_room_cubit.dart';

@immutable
sealed class GroupChatRoomState {}

final class GroupChatRoomInitial extends GroupChatRoomState {}

final class GroupChatRoomLoading extends GroupChatRoomState {}

final class GroupChatRoomFailure extends GroupChatRoomState {}

final class MediaSelectedState extends GroupChatRoomState {
  final String filePath;
  final String? thumbnailPath;
  final MessageType type;
  MediaSelectedState(this.filePath, this.thumbnailPath, this.type);
}
