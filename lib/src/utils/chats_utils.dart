import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static CollectionReference<Map<String, dynamic>> get chatsCollection =>
      firebaseService.firestore.collection(FirebaseConstants.chats);

  static String getConversationID(String chatUserPhoneNumber) =>
      FirebaseUtils.phoneNumber.hashCode <= chatUserPhoneNumber.hashCode
          ? '${FirebaseUtils.phoneNumber}_$chatUserPhoneNumber'
          : '${chatUserPhoneNumber}_${FirebaseUtils.phoneNumber}';

  static String createGroupChatId(String chatName) =>
      '${chatName}_${FirebaseUtils.getDateTimeNowAsId()}';

  // User Data for chat room screen ChatTileComponent
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String chatUserId) {
    return FirebaseUtils.usersCollection.doc(chatUserId).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    return chatsCollection
        .where('users', arrayContains: FirebaseUtils.user?.id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String chatId) {
    return chatsCollection
        .doc(chatId)
        .collection(FirebaseConstants.messages)
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  // for creating one to one chat
  static Future<void> createChat(UserModel chatUser) async {
    final chatId = getConversationID(chatUser.id ?? '');

    await chatsCollection.doc(chatId).set(ChatModel(
        id: '${FirebaseUtils.user?.id}_${chatUser.id ?? ''}',
        isGroup: false,
        users: [FirebaseUtils.user?.id ?? '', chatUser.id ?? '']).toJson());

    await FirebaseUtils.usersCollection.doc(FirebaseUtils.user?.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));

    await FirebaseUtils.usersCollection.doc(chatUser.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));
  }

  // for sending message
  static Future<void> sendMessage({
    required UserModel chatUser,
    required MessageType type,
    required bool isFirstMessage,
    String? msg,
    String? filePath,
    int? length,
    String? thumbnailPath,
  }) async {
    try {
      // if message type is text
      String? sendingMessage = msg;
      String? thumbnail;
      if (isFirstMessage) {
        await createChat(chatUser);
      }
      if (type == MessageType.image) {
        sendingMessage = await FirebaseUtils.uploadMedia(filePath!,
            MediaType.chatImage, getConversationID(chatUser.id ?? ''));
      } else if (type == MessageType.video) {
        sendingMessage = await FirebaseUtils.uploadMedia(filePath!,
            MediaType.chatVideo, getConversationID(chatUser.id ?? ''));
        thumbnail = await FirebaseUtils.uploadMedia(thumbnailPath!,
            MediaType.chatImage, getConversationID(chatUser.id ?? ''));
      } else if (type == MessageType.document) {
        sendingMessage = await FirebaseUtils.uploadMedia(
          filePath!,
          MediaType.chatDocument,
          getConversationID(chatUser.id ?? ''),
        );
      } else if (type == MessageType.audio) {
        sendingMessage = await FirebaseUtils.uploadMedia(filePath!,
            MediaType.chatVoice, getConversationID(chatUser.id ?? ''));
      }

      //message sending time (also used as id)
      final sendingTimeAsId = FirebaseUtils.getDateTimeNowAsId();
      final chatId = getConversationID(chatUser.id ?? '');
      final chatDoc = chatsCollection.doc(chatId);

      final MessageModel message = MessageModel(
        toId: chatUser.id ?? '',
        msg: sendingMessage,
        readAt: null,
        type: type,
        fromId: FirebaseUtils.user?.id ?? '',
        sentAt: sendingTimeAsId,
        length: length,
        thumbnail: thumbnail,
      );

      await chatDoc
          .collection(FirebaseConstants.messages)
          .doc(sendingTimeAsId)
          .set(message.toJson())
          .then((value) async =>
                  //adding last message
                  await chatDoc.set({'last_message': message.toJson()},
                      SetOptions(merge: true))
              // )
              // .then((value) =>
              // sendPushNotification(chatUser, type == Type.text ? msg : 'image')
              );
    } catch (e) {
      LoggerUtil.logs(e.toString());
    }
  }

  static Future<void> updateMessageReadStatus(MessageModel message) async {
    final sendingTime = DateTime.now().millisecondsSinceEpoch.toString();
    final chatId = getConversationID(message.fromId ?? '');
    final chatDoc = chatsCollection.doc(chatId);

    await chatDoc
        .collection(FirebaseConstants.messages)
        .doc(message.sentAt)
        .update({'readAt': DateTime.now().millisecondsSinceEpoch.toString()});
    await chatDoc.update({'last_message.readAt': sendingTime});
  }

  static Future<void> updateUnreadCount(
      String chatUserId, String count, bool isUpdatingMe) async {
    await chatsCollection.doc(getConversationID(chatUserId)).update({
      '${isUpdatingMe ? FirebaseUtils.user?.id : chatUserId}_unread_count':
          count
    });
  }

  // for creating group chat
  static Future<void> createGroupChat(
    String groupName,
    String? groupImage,
    List contacts,
  ) async {
    final groupChatId =
        createGroupChatId(groupName.toLowerCase().trim().replaceAll(' ', '_'));

    await chatsCollection.doc(groupChatId).set(ChatModel(
        id: groupChatId,
        isGroup: true,
        groupData: GroupData(
            adminId: FirebaseUtils.user?.id,
            grougName: groupName,
            groupImage: groupImage),
        lastMessage: null,
        users: [FirebaseUtils.user?.id ?? '', ...contacts]).toJson());

    await FirebaseUtils.usersCollection.doc(FirebaseUtils.user?.id ?? '').set({
      'chats': FieldValue.arrayUnion([groupChatId])
    }, SetOptions(merge: true));

    for (var i = 0; i < contacts.length; i++) {
      await FirebaseUtils.usersCollection.doc(contacts[i]).set({
        'chats': FieldValue.arrayUnion([groupChatId])
      }, SetOptions(merge: true));
    }
  }

  // for sending group message
  static Future<void> sendGropuMessage({
    required String groupChatId,
    required MessageType type,
    String? msg,
    String? filePath,
    int? length,
    String? thumbnailPath,
  }) async {
    try {
      // if message type is text
      String? sendingMessage = msg;
      String? thumbnail;
      if (type == MessageType.image) {
        sendingMessage = await FirebaseUtils.uploadMedia(
            filePath!, MediaType.chatImage, groupChatId);
      } else if (type == MessageType.video) {
        sendingMessage = await FirebaseUtils.uploadMedia(
            filePath!, MediaType.chatVideo, groupChatId);
        thumbnail = await FirebaseUtils.uploadMedia(
            thumbnailPath!, MediaType.chatImage, groupChatId);
      } else if (type == MessageType.document) {
        sendingMessage = await FirebaseUtils.uploadMedia(
          filePath!,
          MediaType.chatDocument,
          groupChatId,
        );
      } else if (type == MessageType.audio) {
        sendingMessage = await FirebaseUtils.uploadMedia(
            filePath!, MediaType.chatVoice, groupChatId);
      }

      //message sending time (also used as id)
      final sendingTimeAsId = FirebaseUtils.getDateTimeNowAsId();
      final chatId = groupChatId;
      final chatDoc = chatsCollection.doc(chatId);

      final MessageModel message = MessageModel(
        toId: null,
        msg: sendingMessage,
        readAt: null,
        type: type,
        fromId: FirebaseUtils.user?.id ?? '',
        sentAt: sendingTimeAsId,
        length: length,
        thumbnail: thumbnail,
      );

      await chatDoc
          .collection(FirebaseConstants.messages)
          .doc(sendingTimeAsId)
          .set(message.toJson())
          .then((value) async =>
                  //adding last message
                  await chatDoc.set({'last_message': message.toJson()},
                      SetOptions(merge: true))
              // )
              // .then((value) =>
              // sendPushNotification(chatUser, type == Type.text ? msg : 'image')
              );
    } catch (e) {
      LoggerUtil.logs(e.toString());
    }
  }

  static Future<void> updateGroupMessageReadStatus(
      String groupChatId, MessageModel message, UserModel chatuser) async {
    final chatDoc = chatsCollection.doc(groupChatId);

    await chatDoc
        .collection(FirebaseConstants.messages)
        .doc(message.sentAt)
        .set({
      'readBy': FieldValue.arrayUnion([chatuser.id])
    });
    await chatDoc.set({
      'last_message.readBy': FieldValue.arrayUnion([chatuser.id])
    });
  }
}
