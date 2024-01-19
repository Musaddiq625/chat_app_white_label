import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  void onMediaSelected(
    String file,
    MessageType type, [
    String? thumbnailFile,
  ]) {
    emit(MediaSelectedState(file, thumbnailFile, type));
  }
}
