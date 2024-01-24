import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:meta/meta.dart';

part 'create_group_chat_state.dart';

class CreateGroupChatCubit extends Cubit<CreateGroupChatState> {
  CreateGroupChatCubit() : super(CreateGroupChatInitial());

  Future<void> createGroupChat(
      String gropuName, List<String> contacts, String filePath) async {
    emit(CreateGroupChatLoadingState());
    try {
      final gropuImage =
          await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      ChatUtils.createGroupChat(gropuName, gropuImage, contacts);
      emit(CreateGroupChatSuccessState());
    } catch (e) {
      emit(CreateGroupChatFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}
