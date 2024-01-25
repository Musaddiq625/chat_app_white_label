part of 'create_group_chat_cubit.dart';

@immutable
sealed class CreateGroupChatState {}

class CreateGroupChatInitial extends CreateGroupChatState {}

class CreateGroupChatLoadingState extends CreateGroupChatState {}

class CreateGroupChatSuccessState extends CreateGroupChatState {}

class CreateGroupChatFailureState extends CreateGroupChatState {
  final String error;

  CreateGroupChatFailureState(this.error);
}
