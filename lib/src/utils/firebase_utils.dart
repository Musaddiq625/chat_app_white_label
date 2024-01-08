import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/models/user.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:chat_app_white_label/src/utils/service/firebase_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseUtils {
  static FirebaseService firebaseService = getIt<FirebaseService>();

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
    try {
      final extension = p.extension(selectedImage!.path);
      UploadTask task = storage
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

      String downloadURL = await storage
          .ref("profile_picture/$fileName$extension")
          .getDownloadURL();
      print("downloadURL ${downloadURL}");

      return downloadURL;
    } catch (error) {
      print("Error during file upload or retrieval: $error");
    }
  }
}
