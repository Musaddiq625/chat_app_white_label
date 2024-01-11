
import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/models/chatMessage.dart';
import 'package:chat_app_white_label/src/models/user.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:chat_app_white_label/src/utils/service/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static User get user => firebaseService.auth.currentUser!;

  static Future<UserMoodel?> getUserData(String phoneNumber) async {
    final replacedPhoneNumber = phoneNumber.replaceAll('+', '');
    UserMoodel? user;
    final userData = await firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(replacedPhoneNumber)
        .get();
    if (userData.exists) {
      user = UserMoodel.fromMap(userData.data()!);
    }
    return user;
  }

  static uploadMedia(File? selectedImage) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    if(selectedImage != null) {
      try {
        final extension = p.extension(selectedImage!.path);
        if (fileName != null && extension != null) {
          UploadTask task = storage.ref("profile_picture/$fileName$extension")
              .putFile(selectedImage!);
          print("Image ${task} + extension ${ extension}");
          task.snapshotEvents.listen((TaskSnapshot snapshot) {
            print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) *
                100}%');
          }, onError: (e) {
            print(e);
          });

          await task.whenComplete(() => print('Upload completed'));

          String downloadURL = await storage.ref(
              "profile_picture/$fileName$extension").getDownloadURL();
          print("downloadURL ${downloadURL}");

          return downloadURL;
        } else {
          print("FileName or Extension is null");
        }
      } catch (error) {
        print("Error during file upload or retrieval: $error");
      }
    }
    else{
      print("No Image Selected");
    }
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserMoodel user) {
    return firebaseService.firestore
        .collection('chats/${getConversationID(user.id!)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }
  // for sending message
  static Future<void> sendMessage(
      UserMoodel chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final ChatMessage message = ChatMessage(
        toId: chatUser.id!,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firebaseService.firestore
        .collection('chats/${getConversationID(chatUser.id!)}/messages/');
    // await ref.doc(time).set(message.toJson()).then((value) =>
    //     sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
    await ref.doc(time).set(message.toJson());
  }



}