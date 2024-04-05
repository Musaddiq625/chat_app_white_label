

import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import '../constants/firebase_constants.dart';

class EventUtils{
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static CollectionReference<Map<String, dynamic>> get eventCollection =>
      firebaseService.firestore.collection(FirebaseConstants.event);


}