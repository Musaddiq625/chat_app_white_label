import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static String? get phoneNumber =>
      firebaseService.auth.currentUser?.phoneNumber?.replaceAll('+', '');

  static CollectionReference<Map<String, dynamic>> get usersCollection =>
      firebaseService.firestore.collection(FirebaseConstants.users);

  static CollectionReference<Map<String, dynamic>> get chatsCollection =>
      firebaseService.firestore.collection(FirebaseConstants.chats);

  static UserModel? user;

  static Future<void> createUser(String phoneNumber) async {
    final replacedPhoneNumber = phoneNumber.replaceAll('+', '');
    await firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(replacedPhoneNumber)
        .set({
      'id': replacedPhoneNumber,
      'phoneNumber': phoneNumber,
      'is_profile_complete': false,
    });
    LoggerUtil.logs('Created User');
  }

  static Future<UserModel?> getCurrentUser() async {
    final userData = await firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(phoneNumber)
        .get();
    if (userData.exists) {
      user = UserModel.fromJson(userData.data()!);
    }
    LoggerUtil.logs('getUser ${user?.toJson()}');
    return user;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getChatUser(
      String chatUserId) {
    return firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(chatUserId)
        .get();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String chatUserId) {
    return firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(chatUserId)
        .snapshots();
  }

  static String getConversationID(String chatUserPhoneNumber) =>
      phoneNumber.hashCode <= chatUserPhoneNumber.hashCode
          ? '${phoneNumber}_$chatUserPhoneNumber'
          : '${chatUserPhoneNumber}_$phoneNumber';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    return firebaseService.firestore
        .collection(FirebaseConstants.chats)
        .where('users', arrayContains: user?.id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserModel user) {
    return firebaseService.firestore
        .collection(
            '${FirebaseConstants.chats}/${getConversationID(user.id ?? '')}/${FirebaseConstants.messages}/')
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  static Future<void> sendFirstMessage(
      UserModel chatUser, String msg, Type type) async {
    final chatId = getConversationID(chatUser.id ?? '');

    await chatsCollection.doc(chatId).set(ChatModel(
        id: '${user?.id}_${chatUser.id ?? ''}',
        isGroup: false,
        lastMessage: null,
        unreadCount: 1,
        users: [user?.id ?? '', chatUser.id ?? '']).toJson());

    await usersCollection.doc(user?.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));

    await usersCollection.doc(chatUser.id ?? '').set({
      'chats': FieldValue.arrayUnion([chatId])
    }, SetOptions(merge: true));

    sendMessage(chatUser, msg, type);
  }

  // for sending message
  static Future<void> sendMessage(
      UserModel chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final sendingTime = DateTime.now().millisecondsSinceEpoch.toString();
    final chatId = getConversationID(chatUser.id ?? '');
    final chatDoc = chatsCollection.doc(chatId);

    final MessageModel message = MessageModel(
        toId: chatUser.id ?? '',
        msg: msg,
        readAt: '',
        type: type,
        fromId: user?.id ?? '',
        sentAt: sendingTime);

    await chatDoc
        .collection(FirebaseConstants.messages)
        .doc(sendingTime)
        .set(message.toJson())
        .then((value) =>
                //adding last message
                chatDoc.set(
                    {'last_message': message.toJson()}, SetOptions(merge: true))
            // )
            // .then((value) =>
            // sendPushNotification(chatUser, type == Type.text ? msg : 'image')
            );
  }

  static uploadMedia(File? selectedImage) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final extension = p.extension(selectedImage!.path);
      UploadTask task = firebaseService.storage
          .ref("profile_picture/$fileName$extension")
          .putFile(selectedImage);
      print("Image ${task} + extension ${extension}");
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      }, onError: (e) {
        print(e);
      });

      await task.whenComplete(() => print('Upload completed'));

      String downloadURL = await firebaseService.storage
          .ref("profile_picture/$fileName$extension")
          .getDownloadURL();
      print("downloadURL ${downloadURL}");

      return downloadURL;
    } catch (error) {
      print("Error during file upload or retrieval: $error");
    }
  }
}
