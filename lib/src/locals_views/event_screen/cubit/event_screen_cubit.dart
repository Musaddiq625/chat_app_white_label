import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';


import 'event_screen_state.dart';



class EventScreenCubit extends Cubit<EventScreenState> {
  EventScreenCubit() : super(EventScreenInitial());

  Future<void> createGroupChat(String gropuName, String groupAbout,
      List contacts, String? filePath) async {
    emit(EventScreenLoadingState());
    try {
      String? groupImage;
      if (filePath != null) {
        groupImage =
            await FirebaseUtils.uploadMedia(filePath, MediaType.profilePicture);
      }
      final groupData = await ChatUtils.createGroupChat(
          gropuName, groupAbout, groupImage, contacts);
      emit(EventScreenSuccessState(groupData));
    } catch (e) {
      emit(EventScreenFailureState(e.toString()));
      LoggerUtil.logs(e.toString());
    }
  }
}
