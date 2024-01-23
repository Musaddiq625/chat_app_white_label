import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static String? get phoneNumber =>
      firebaseService.auth.currentUser?.phoneNumber?.replaceAll('+', '');

  static CollectionReference<Map<String, dynamic>> get usersCollection =>
      firebaseService.firestore.collection(FirebaseConstants.users);

  static CollectionReference<Map<String, dynamic>> get chatsCollection =>
      firebaseService.firestore.collection(FirebaseConstants.chats);

  static CollectionReference<Map<String, dynamic>> get storyCollection =>
      firebaseService.firestore.collection(FirebaseConstants.story);

  static CollectionReference<Map<String, dynamic>> get storiesCollection =>
      firebaseService.firestore.collection(FirebaseConstants.stories);

  static UserModel? user;

  static Future<void> logOut(context) async {
    await firebaseService.auth.signOut();
    NavigationUtil.popAllAndPush(context, RouteConstants.loginScreen);
  }

  static String getConversationID(String chatUserPhoneNumber) =>
      phoneNumber.hashCode <= chatUserPhoneNumber.hashCode
          ? '${phoneNumber}_$chatUserPhoneNumber'
          : '${chatUserPhoneNumber}_$phoneNumber';

  static String getDateTimeNowId() =>
      DateTime.now().millisecondsSinceEpoch.toString();
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getStoryUser() {
    return storyCollection.snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getStories() {
    return storiesCollection.snapshots();
  }

  // User Data for chat room screen ChatTileComponent
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String chatUserId) {
    return usersCollection.doc(chatUserId).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    return chatsCollection.where('users', arrayContains: user?.id).snapshots();
  }

  static Future<void> deleteStory(String id, String storyUserId) async {
    try {
      print("id $id  userId $storyUserId ");
      await storiesCollection.doc(id).delete();
      await storyCollection.doc(storyUserId).update({
        'stories': FieldValue.arrayRemove([id])
      });
      print('Story deleted');
    } catch (e) {
      print('Failed to delete story: $e');
    }
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
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatImage, chatUser);
      } else if (type == MessageType.video) {
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatVideo, chatUser);
        thumbnail =
            await uploadMedia(thumbnailPath!, MediaType.chatImage, chatUser);
      } else if (type == MessageType.document) {
        sendingMessage = await uploadMedia(
          filePath!,
          MediaType.chatDocument,
          chatUser,
        );
      } else if (type == MessageType.audio) {
        sendingMessage =
            await uploadMedia(filePath!, MediaType.chatVoice, chatUser);
      }

      //message sending time (also used as id)
      final sendingTimeAsId = getDateTimeNowId();
      final chatId = getConversationID(chatUser.id ?? '');
      final chatDoc = chatsCollection.doc(chatId);

      final MessageModel message = MessageModel(
        toId: chatUser.id ?? '',
        msg: sendingMessage,
        readAt: null,
        type: type,
        fromId: user?.id ?? '',
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

  static Future<void> downloadDocument(
      String downloadUrl, String filePathToExternalStorage) async {
    // Download the PDF from Firebase Storage
    final file = File(filePathToExternalStorage);
    try {
      await firebaseService.storage.refFromURL(downloadUrl).writeToFile(file);
      // Success message
      LoggerUtil.logs('Downloaded PDF to $filePathToExternalStorage');
    } on FirebaseException catch (e) {
      // Handle error
      LoggerUtil.logs('Error downloading PDF: $e');
    }
  }

  static Future<String?> uploadMedia(
    String filePath,
    MediaType uploadType, [
    UserModel? chatUser,
  ]) async {
    final splittedPath = filePath.split('.');
    //getting image file extension and name
    // if document so make it unique with #weuno#
    String fileName = uploadType == MediaType.chatDocument
        ? '${getDateTimeNowId()}_we_uno_chat_${splittedPath[splittedPath.length - 2].split('/').last}'
        : getDateTimeNowId();
    final extension = splittedPath.last;

    LoggerUtil.logs(extension);
    LoggerUtil.logs(fileName);

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

        case MediaType.chatDocument:
          return firebaseService.storage.ref().child(
              'chats/${getConversationID(chatUser?.id ?? '')}/chat_document/$fileName.$extension');

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
                          : uploadType == MediaType.chatDocument
                              ? 'document/$extension'
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

  static Stream<List<Map<String, dynamic>>> getUserData() async* {
    await firebaseService.requestPermission();
    Iterable<Contact> localContacts = await firebaseService.getLocalContacts();
    CollectionReference usersRef =
        firebaseService.firestore.collection('users');

    await for (var snapshot in usersRef.snapshots()) {
      List<Map<String, dynamic>> userDataList = [];
      for (var doc in snapshot.docs) {
        if (doc.exists) {
          userDataList.add(doc.data() as Map<String, dynamic>);
        } else {
          throw Exception('User does not exist in the database');
        }
      }
      yield userDataList;
    }
  }

  static Map<String, dynamic> contactToMap(
      Contact contact, String firebaseUserName) {
    return {
      'name': contact.displayName,
      'phoneNumber': (contact.phones ?? [])
          .map((item) => item.value)
          .toList()
          .first
          ?.replaceAll(" ", "")
          .replaceAll("+", ""),
      'subName': firebaseUserName
      // Add other contact fields you want to include
    };
  }

  static String formatTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(date);
  }

  static Stream<List<Map<String, dynamic>>> getMatchingContacts() async* {
    try {
      await firebaseService.requestPermission();
      Iterable<Contact> localContacts =
          await firebaseService.getLocalContacts();
      await for (List<Map<String, dynamic>> firebaseUsers in getUserData()) {
        List<Map<String, dynamic>> matchedContacts = [];
        print("firebaseusers $firebaseUsers");
        // try {
        for (var user in firebaseUsers) {
          print("user $user");

          String? firebasePhoneNumber = user['phoneNumber'];
          String? firbaseUserName = user['name'];
          print(
              "firebasePhoneNumber $firebasePhoneNumber firbaseUserName $firbaseUserName");
          for (var contact in localContacts) {
            // print("contacts ${(contact.phones ?? [])
            //     .map((item) => item.value)
            //     .toList()}");
            print("contact phones ${contact.toMap()}");
            if (contact.phones != null) {
              var contactPhones = (contact.phones ?? [])
                  .map((item) => item.value)
                  .toList()
                  .firstWhere(
                      (phone) => phone != null && phone.trim().isNotEmpty,
                      orElse: () => null)
                  ?.replaceAll(" ", "");

              print("contactPhones $contactPhones");
              // try {
              if (contactPhones != null &&
                  firebasePhoneNumber != null &&
                  contactPhones.contains(firebasePhoneNumber)) {
                final contactMap = contactToMap(contact, firbaseUserName!);
                print("Adding contact to matchedContacts: $contactMap");
                matchedContacts.add(contactMap);
                // Removed break for demonstration; re-add if needed
              }
            }

            // }
            // catch (e) {
            //   print("An error occurred addding number : $e");
            // }
          }
        }
        print("Yielding matchedContacts: $matchedContacts");
        yield matchedContacts;
      }
    } catch (e) {
      print("Error 01 : $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getMatchingContactsOnce() async {
    try {
      await firebaseService.requestPermission();
      Iterable<Contact> localContacts =
          await firebaseService.getLocalContacts();
      List<Map<String, dynamic>> firebaseUsers = await getUserData().first;
      List<Map<String, dynamic>> matchedContacts = [];

      for (var user in firebaseUsers) {
        String? firebasePhoneNumber = user['phoneNumber'];
        String? firbaseUserName = user['name'];

        for (var contact in localContacts) {
          var contactPhones = (contact.phones ?? [])
              .map((item) => item.value)
              .toList()
              .firstWhere((phone) => phone != null && phone.trim().isNotEmpty,
                  orElse: () => null)
              ?.replaceAll(" ", "");

          if (contactPhones != null &&
              firebasePhoneNumber != null &&
              contactPhones.contains(firebasePhoneNumber)) {
            final contactMap = contactToMap(contact, firbaseUserName!);
            matchedContacts.add(contactMap);
          }
        }
      }

      return matchedContacts;
    } catch (e) {
      print("Error 01 : $e");
      return [];
    }
  }
}

enum MediaType { profilePicture, chatImage, chatVideo, chatVoice, chatDocument }
