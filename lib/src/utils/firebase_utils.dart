import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static String? get phoneNumber =>
      firebaseService.auth.currentUser?.phoneNumber?.replaceAll('+', '');

  static CollectionReference<Map<String, dynamic>> get usersCollection =>
      firebaseService.firestore.collection(FirebaseConstants.users);

  static CollectionReference<Map<String, dynamic>> get chatsCollection =>
      firebaseService.firestore.collection(FirebaseConstants.chats);

  static UserModel? user;

  static Future<void> logOut(context) async {
    await firebaseService.auth.signOut();
    NavigationUtil.popAllAndPush(context, RouteConstants.loginScreen);
  }

  static String getConversationID(String chatUserPhoneNumber) =>
      phoneNumber.hashCode <= chatUserPhoneNumber.hashCode
          ? '${phoneNumber}_$chatUserPhoneNumber'
          : '${chatUserPhoneNumber}_$phoneNumber';

  static Future<void> createUser(String phoneNumber) async {
    final replacedPhoneNumber = phoneNumber.replaceAll('+', '');
    await usersCollection.doc(replacedPhoneNumber).set({
      'id': replacedPhoneNumber,
      'phoneNumber': phoneNumber,
      'is_profile_complete': false,
    });
    LoggerUtil.logs('Created User');
  }

  static Future<UserModel?> getCurrentUser() async {
    final userData = await usersCollection.doc(phoneNumber).get();
    if (userData.exists) {
      user = UserModel.fromJson(userData.data()!);
    }
    LoggerUtil.logs('getUser ${user?.toJson()}');
    FirebaseUtils.updateActiveStatus(true);
    return user;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return usersCollection.get();
  }

  // User Data for chat screen ChatTileComponent
  static Future<DocumentSnapshot<Map<String, dynamic>>> getChatUser(
      String chatUserId) {
    return usersCollection.doc(chatUserId).get();
  }

  // User Data for chat room screen ChatTileComponent
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String chatUserId) {
    return usersCollection.doc(chatUserId).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    return chatsCollection.where('users', arrayContains: user?.id).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserModel user) {
    return chatsCollection
        .doc(getConversationID(user.id ?? ''))
        .collection(FirebaseConstants.messages)
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  static Future<void> createChat(UserModel chatUser) async {
    final chatId = getConversationID(chatUser.id ?? '');

    await chatsCollection.doc(chatId).set(ChatModel(
        id: '${user?.id}_${chatUser.id ?? ''}',
        isGroup: false,
        lastMessage: null,
        users: [user?.id ?? '', chatUser.id ?? '']).toJson());

    await usersCollection.doc(user?.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));

    await usersCollection.doc(chatUser.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));
  }

  // for sending message
  static Future<void> sendMessage(
      {required UserModel chatUser,
      required MessageType type,
      required bool isFirstMessage,
      String? msg,
      String? filePath,
      int? length,
      String? thumbnailPath}) async {
    try {
      // if message type is text
      String? sendingMessage = msg;
      String? thumbnail;
      if (isFirstMessage) {
        await createChat(chatUser);
      }
      if (type == MessageType.image) {
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatImage, chatUser);
      } else if (type == MessageType.video) {
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatVideo, chatUser);
        thumbnail =
            await uploadMedia(thumbnailPath!, MediaType.chatImage, chatUser);
      } else if (type == MessageType.audio) {
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatVoice, chatUser);
      }

      //message sending time (also used as id)
      final sendingTime = DateTime.now().millisecondsSinceEpoch.toString();
      final chatId = getConversationID(chatUser.id ?? '');
      final chatDoc = chatsCollection.doc(chatId);

      final MessageModel message = MessageModel(
          toId: chatUser.id ?? '',
          msg: sendingMessage,
          readAt: null,
          type: type,
          fromId: user?.id ?? '',
          sentAt: sendingTime,
          length: length,
          thumbnail: thumbnail);

      await chatDoc
          .collection(FirebaseConstants.messages)
          .doc(sendingTime)
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

  static Future<void> updateUnreadCount(String chatUserId, String count) async {
    await chatsCollection
        .doc(getConversationID(chatUserId))
        .update({'${chatUserId}_unread_count': count});
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    LoggerUtil.logs('isOnline $isOnline');
    await usersCollection.doc(user?.id ?? '').update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  static Future<String?> uploadMedia(String filePath, MediaType uploadType,
      [UserModel? chatUser]) async {
    //getting image file extension and name
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final extension = filePath.split('.').last;

    //  getUpload Refrence to its type
    Reference getUploadRef(uploadType) {
      switch (uploadType) {
        case MediaType.profilePicture:
          return firebaseService.storage
              .ref()
              .child('profile_picture/$fileName.$extension');

        case MediaType.chatImage:
          return firebaseService.storage.ref().child(
              'chats/${getConversationID(chatUser?.id ?? '')}/chat_image/$fileName.$extension');

        case MediaType.chatVideo:
          return firebaseService.storage.ref().child(
              'chats/${getConversationID(chatUser?.id ?? '')}/chat_video/$fileName.$extension');

        case MediaType.chatVoice:
          return firebaseService.storage.ref().child(
              'chats/${getConversationID(chatUser?.id ?? '')}/chat_voice/$fileName.$extension');

        default:
          return firebaseService.storage
              .ref()
              .child("profile_picture/$fileName.$extension");
      }
    }

    //  upload and return media path from storage
    try {
      final ref = getUploadRef(uploadType);
      await ref
          .putFile(
              File(filePath),
              SettableMetadata(
                  contentType: uploadType == MediaType.chatImage
                      ? 'image/$extension'
                      : uploadType == MediaType.chatVideo
                          ? 'video/$extension'
                          : 'audio/$extension'))
          .then((p0) => LoggerUtil.logs(
              'Data Transferred: ${p0.bytesTransferred / 1000} kb'));

      final mediaUrl = await ref.getDownloadURL();

      LoggerUtil.logs("downloadURL $mediaUrl");

      return mediaUrl;
    } catch (error) {
      LoggerUtil.logs("Error during file upload or retrieval: $error");
      return null;
    }
  }
}

enum MediaType { profilePicture, chatImage, chatVideo, chatVoice }
