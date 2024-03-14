import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:meta/meta.dart';

part 'locals_home_screen_state.dart';

class LocalsHomeScreenCubit extends Cubit<LocalsHomeScreenState> {
  LocalsHomeScreenCubit() : super(LocalsHomeScreenInitial());

  Future<void> createGroupChat(String gropuName, String groupAbout,
      List contacts, String? filePath) async {
    emit(LocalsHomeScreenLoadingState());
    try {
      String? groupImage;
      if (filePath != null) {
        groupImage =
            await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      }
      final groupData = await ChatUtils.createGroupChat(
          gropuName, groupAbout, groupImage, contacts);
      emit(LocalsHomeScreenSuccessState(groupData));
    } catch (e) {
      emit(LocalsHomeScreenFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}
