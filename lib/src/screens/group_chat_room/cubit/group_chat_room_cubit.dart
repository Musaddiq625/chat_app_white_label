import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:meta/meta.dart';

part 'group_chat_room_state.dart';

class GroupChatRoomCubit extends Cubit<GroupChatRoomState> {
  GroupChatRoomCubit() : super(GroupChatRoomInitial());

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  setUploading(bool value) {
    emit(UploadingState());
    _isUploading = value;
    LoggerUtil.logs('isUploading $_isUploading');
  }

  bool _showEmoji = false;
  bool get showEmoji => _showEmoji;
  setShowEmoji(bool value) {
    emit(ShowEmojiState());
    _showEmoji = value;
    LoggerUtil.logs('showEmoji $_showEmoji');
  }

  void onMediaSelected(
    String file,
    MessageType type, [
    String? thumbnailFile,
  ]) {
    emit(MediaSelectedState(file, thumbnailFile, type));
  }
}
