import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/social_link_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../models/more_about_me_model.dart';

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static UserModel? user;

  static String? get phoneNumber =>
      firebaseService.auth.currentUser?.phoneNumber?.replaceAll('+', '');

  static CollectionReference<Map<String, dynamic>> get usersCollection =>
      firebaseService.firestore.collection(FirebaseConstants.users);

  static CollectionReference<Map<String, dynamic>> get callsCollection =>
      firebaseService.firestore.collection(FirebaseConstants.calls);

  static CollectionReference<Map<String, dynamic>> get storyCollection =>
      firebaseService.firestore.collection(FirebaseConstants.story);

  static CollectionReference<Map<String, dynamic>> get storiesCollection =>
      firebaseService.firestore.collection(FirebaseConstants.stories);

  // for getting milliSecondsSinceEpoch as Id
  static String getDateTimeNowAsId() =>
      DateTime.now().millisecondsSinceEpoch.toString();

  static String getNameFromLocalContact(
      String phoneNumber, BuildContext context) {
    String formatPhoneNumber(String phoneNumber) {
      if (phoneNumber.startsWith('0')) {
        phoneNumber = phoneNumber.replaceFirst('0', '');
      }
      return phoneNumber.replaceAll(' ', '').replaceAll('+', '');
    }

    Contact matchedContact;

    matchedContact = context.read<AppSettingCubit>().localContacts.firstWhere(
          (contact) =>
              contact.phones?.any((phone) =>
                  formatPhoneNumber(phone.value ?? '') == phoneNumber) ??
              false,
          orElse: () => Contact(),
        );

    return matchedContact.displayName ?? '+$phoneNumber';
  }

  static Future<void> logOut(context) async {
    await firebaseService.auth.signOut();
    FirebaseUtils.updateActiveStatus(false);
    FirebaseUtils.deleteFcmToken(FirebaseUtils.user!.phoneNumber!);
    user = null;

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


  static Future<void> updateUserStepOne(String? firstName,String? lastName,List<String>? userImages, String? profileImage) async {
    final replacedPhoneNumber = phoneNumber?.replaceAll('+', '');
    await usersCollection.doc(replacedPhoneNumber).set({
      'first_name': firstName,
      'last_name': lastName,
      'user_images':userImages,
      'profile_image':profileImage,
    },SetOptions(merge: true));
    LoggerUtil.logs('Updated User Step 1');
  }


  static Future<void> updateUserStepTwo(String? dob,String? aboutMe,String? gender,String? bio,MoreAboutMe? moreAboutMe,SocialLinkModel? socialLinkModel,List<String>?  hobbies,List<String>? creativity) async {
    final replacedPhoneNumber = phoneNumber?.replaceAll('+', '');
    await usersCollection.doc(replacedPhoneNumber).set({
      'date_of_birth': dob ,
      'about_me': aboutMe,
      'gender': gender,
      'bio': bio,
      'social_links': socialLinkModel?.toJson(),
      'more_about_me': moreAboutMe?.toJson(),
      'hobbies':hobbies,
      'creativity':creativity,
    },SetOptions(merge: true));
    LoggerUtil.logs('Updated User Step 2');
  }


  static Future<void> createCalls(String callId, String callerNumber,
      List<String> receiverNumber, String type) async {
    await callsCollection.doc(callId).set({
      'id': callId,
      'caller_number': callerNumber,
      'time': getDateTimeNowAsId(),
      'type': type,
      'users': receiverNumber
    });
    // await callsCollection.doc(callId).set({
    //   'id': callId,
    //   'caller_number': callerNumber,
    //   'receiver_number': receiverNumber,
    //   'time': getDateTimeNowAsId(),
    //   'type': type,
    //   'users': receiverNumber
    // });
    LoggerUtil.logs('Created Call');
  }

  static Future<void> createGroupCalls(
      String callId,
      String groupId,
      String callerNumber,
      List<String> receiverNumber,
      String type,
      String name) async {
    await callsCollection.doc(callId).set({
      'id': callId,
      "group_id": groupId,
      'caller_number': callerNumber,
      'time': getDateTimeNowAsId(),
      'type': type,
      'users': receiverNumber
    });

    // "name":name,

    // await callsCollection.doc(callId).set({
    //   'id': callId,
    //   'caller_number': callerNumber,
    //   'receiver_number': receiverNumber,
    //   'time': getDateTimeNowAsId(),
    //   'type': type,
    //   'users': receiverNumber
    // });
    LoggerUtil.logs('Created Call');
  }

  static Future<void> updateCallsOnReceiveOfUser(
      List<String> receiverNumbers, String callId) async {
    await firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(callId)
        .set({
      'receiver_numbers': FieldValue.arrayUnion(receiverNumbers),
    }, SetOptions(merge: true));
    LoggerUtil.logs('Updated the CallsOnReceiveOrReject');
  }

  static Future<void> updateCallsOnReceiveOrReject(
      bool isCallActive, String callId) async {
    await firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(callId)
        .set({
      'is_call_active': isCallActive,
    }, SetOptions(merge: true));
    LoggerUtil.logs('Updated the CallsOnReceiveOrReject');
  }

  static Future<void> updateCallsDuration(
      String duration, bool isCallActive, String callId, String endTime) async {
    await firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(callId)
        .set({
      'is_call_active': isCallActive,
      'duration': duration,
      'end_time': endTime
    }, SetOptions(merge: true));
  }

  static Future<void> updateUserCallList(
      String phoneNumber, String callId) async {
    await firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(phoneNumber.replaceAll('+', ''))
        .set({
      'calls': FieldValue.arrayUnion([callId])
    }, SetOptions(merge: true));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCalls() {
    return callsCollection
        .where('users', arrayContains: FirebaseUtils.user?.id)
        .orderBy('end_time', descending: true)
        .snapshots();
  }

  static Future<void> updateUser(
      String name, String about, String? imageUrl, String phoneNumber) async {
    await firebaseService.firestore
        .collection(FirebaseConstants.users)
        .doc(phoneNumber.replaceAll('+', ''))
        .update({
      'name': name,
      'image': imageUrl,
      'about': about,
      'is_profile_complete': true,
    });
    user?.name = name;
    user?.image = imageUrl;
    user?.about = about;
    user?.isProfileComplete = true;
    LoggerUtil.logs('Update User');
  }

  static Future<void> addFcmToken(String phoneNumber, String fcmToken) async {
    final replacedPhoneNumber = phoneNumber.replaceAll('+', '');
    await usersCollection.doc(replacedPhoneNumber).set({
      'fcm_token': fcmToken,
    }, SetOptions(merge: true));
    LoggerUtil.logs('FCM Token $fcmToken');
  }

  static Future<void> deleteFcmToken(String phoneNumber) async {
    final replacedPhoneNumber = phoneNumber.replaceAll('+', '');
    await usersCollection.doc(replacedPhoneNumber).update({
      'fcm_token': FieldValue.delete(),
    });
    LoggerUtil.logs('FCM Token deleted for phone number $replacedPhoneNumber');
  }

  static Future<UserModel?> getCurrentUser() async {
    final userData = await usersCollection.doc(phoneNumber).get();
    if (userData.exists) {
      user = UserModel.fromJson(userData.data()!);
      FirebaseUtils.updateActiveStatus(true);
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getStoryUser() {
    return storyCollection.snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCallsUser() {
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

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

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

  static Future<void> updateActiveStatus(bool isOnline) async {
    LoggerUtil.logs('isOnline $isOnline');
    user?.isOnline = isOnline;
    await usersCollection.doc(user?.id ?? '').update({
      'is_online': isOnline,
      'last_active': getDateTimeNowAsId(),
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

  static Future<String?> createThumbnail(String videoFilepath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoFilepath, imageFormat: ImageFormat.JPEG,
        // thumbnailPath: (await getTemporaryDirectory()).path,
        quality: 25,
      );
      return thumbnailPath;
    } catch (e) {
      LoggerUtil.logs(e);
      return null;
    }
  }

  static Future<String?> uploadMedia(
    String filePath,
    MediaType uploadType, [
    String? chatId,
  ]) async {
    final splittedPath = filePath.split('.');
    //getting image file extension and name
    // if document so make it unique with #weuno#
    String fileName = uploadType == MediaType.chatDocument
        ? '${getDateTimeNowAsId()}_we_uno_chat_${splittedPath[splittedPath.length - 2].split('/').last}'
        : getDateTimeNowAsId();
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
          return firebaseService.storage
              .ref()
              .child('chats/$chatId/chat_image/$fileName.$extension');

        case MediaType.chatVideo:
          return firebaseService.storage
              .ref()
              .child('chats/$chatId/chat_video/$fileName.$extension');

        case MediaType.chatVoice:
          return firebaseService.storage
              .ref()
              .child('chats/$chatId/chat_voice/$fileName.$extension');

        case MediaType.chatDocument:
          return firebaseService.storage
              .ref()
              .child('chats/$chatId/chat_document/$fileName.$extension');

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

      LoggerUtil.logs("DownloadURL $mediaUrl");

      return mediaUrl;
    } catch (error) {
      LoggerUtil.logs("Error during file upload or retrieval: $error");
      return null;
    }
  }

  static Stream<List<Map<String, dynamic>>> getUserData() async* {
    await firebaseService.requestContactsPermission();
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
      await firebaseService.requestContactsPermission();
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
      await firebaseService.requestContactsPermission();
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
