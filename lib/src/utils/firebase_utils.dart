
import 'dart:io';

import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:chat_app_white_label/src/utils/service/firebase_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import '../constants/firebase_constants.dart';


class FirebaseUtils{



  static uploadMedia(File? _selectedImage)async{
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final extension = p.extension(_selectedImage!.path);
      UploadTask task = storage.ref("profile_picture/$fileName$extension").putFile(_selectedImage!);
      print("Image ${task} + extension ${ extension}");
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      }, onError: (e) {
        print(e);
      });

      await task.whenComplete(() => print('Upload completed'));

      String downloadURL = await storage.ref("profile_picture/$fileName$extension").getDownloadURL();
      print("downloadURL ${downloadURL}");

      return downloadURL;
    } catch (error) {
      print("Error during file upload or retrieval: $error");
    }
  }

}