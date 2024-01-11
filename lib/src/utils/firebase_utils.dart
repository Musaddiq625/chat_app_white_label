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
  static Future<void> logOut(context) async {
    await firebaseService.auth.signOut();
    NavigationUtil.popAllAndPush(context, RouteConstants.loginScreen);
  }

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

  static String getConversationID(String chatUserPhoneNumber) =>
      phoneNumber.hashCode <= chatUserPhoneNumber.hashCode
          ? '${phoneNumber}_$chatUserPhoneNumber'
          : '${chatUserPhoneNumber}_$phoneNumber';

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
    if (selectedImage != null) {
      try {
        final extension = p.extension(selectedImage!.path);
        if (fileName != null && extension != null) {
          UploadTask task = firebaseService.storage
              .ref("profile_picture/$fileName$extension")
              .putFile(selectedImage!);
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
        } else {
          print("FileName or Extension is null");
        }
      } catch (error) {
        print("Error during file upload or retrieval: $error");
      }
    } else {
      print("No Image Selected");
    }
  }
}
