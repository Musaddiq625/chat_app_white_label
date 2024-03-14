import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:meta/meta.dart';

part 'locals_event_screen_state.dart';

class LocalsEventScreenCubit extends Cubit<LocalsEventScreenState> {
  LocalsEventScreenCubit() : super(LocalsEventScreenInitial());

  Future<void> createGroupChat(String gropuName, String groupAbout,
      List contacts, String? filePath) async {
    emit(LocalsEventScreenLoadingState());
    try {
      String? groupImage;
      if (filePath != null) {
        groupImage =
            await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      }
      final groupData = await ChatUtils.createGroupChat(
          gropuName, groupAbout, groupImage, contacts);
      emit(LocalsEventScreenSuccessState(groupData));
    } catch (e) {
      emit(LocalsEventScreenFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}
