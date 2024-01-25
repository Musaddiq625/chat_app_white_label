import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:meta/meta.dart';

part 'group_chat_room_state.dart';

class GroupChatRoomCubit extends Cubit<GroupChatRoomState> {
  GroupChatRoomCubit() : super(GroupChatRoomInitial());
  void onMediaSelected(
    String file,
    MessageType type, [
    String? thumbnailFile,
  ]) {
    emit(MediaSelectedState(file, thumbnailFile, type));
  }
}
