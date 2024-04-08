

import 'package:chat_app_white_label/src/models/event_data_model.dart';
import 'package:chat_app_white_label/src/models/event_request_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import '../constants/firebase_constants.dart';
import 'logger_util.dart';

class EventUtils{
  static FirebaseService firebaseService = getIt<FirebaseService>();

  static CollectionReference<Map<String, dynamic>> get eventCollection =>
      firebaseService.firestore.collection(FirebaseConstants.event);


  static Future<void> createEvent(EventDataModel eventDataModel) async {
    // final replacedPhoneNumber = phoneNumber.replaceAll('+', '');

    final docId = FirebaseUtils.getDateTimeNowAsId();
    eventDataModel.id=docId;
    await eventCollection.doc(docId).set(eventDataModel.toJson());
    LoggerUtil.logs('Event Created');
  }


  static Future<void> joinRequestEvent(EventRequestModel eventRequestModel) async {
    // final replacedPhoneNumber = phoneNumber.replaceAll('+', '');

    final docId = FirebaseUtils.phoneNumber;

    await eventCollection.doc(docId).set(eventRequestModel.toJson());
    LoggerUtil.logs('Event Created');
  }




}