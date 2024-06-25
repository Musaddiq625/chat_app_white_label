import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:meta/meta.dart';

part 'create_group_chat_state.dart';

class CreateGroupChatCubit extends Cubit<CreateGroupChatState> {
  CreateGroupChatCubit() : super(CreateGroupChatInitial());

  Future<void> createGroupChat(String gropuName, String groupAbout,
      List contacts, String? filePath) async {
    emit(CreateGroupChatLoadingState());
    try {
      // String? groupImage;
      // if (filePath != null) {
      //   groupImage =
      //       await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      // }
      final groupData = await ChatUtils.createGroupChat(
          gropuName, groupAbout, filePath, contacts);
      emit(CreateGroupChatSuccessState(groupData));
    } catch (e) {
      emit(CreateGroupChatFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }


  Future<void> createGroupChatLocals(String groupId,String gropuName, String groupAbout,
      List contacts, String? filePath) async {
    emit(CreateGroupChatLoadingState());
    try {
      // String? groupImage;
      // if (filePath != null) {
      //   groupImage =
      //       await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      // }
      final groupData = await ChatUtils.createGroupChatLocals(groupId,
          gropuName ,groupAbout, filePath, contacts);
      emit(CreateGroupChatSuccessState(groupData));
    } catch (e) {
      emit(CreateGroupChatFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}


