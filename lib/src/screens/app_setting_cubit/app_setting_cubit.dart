import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/permission_utils.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(AppSettingInitial());
  FirebaseService firebaseService = getIt<FirebaseService>();
  SharedPreferencesUtil sharedPreferencesUtil = getIt<SharedPreferencesUtil>();

  String appName = 'WeUno Chat';
  String appLogo = 'assets/images/logo.jpg';
  String? userId ;

  void setFlavor(String packageName) async {
    if (packageName == 'com.example.chat_app_white_label') {
      appName = 'WeUno Chat Alpha';
      appLogo = 'assets/images/logo.jpg';
    } else if (packageName == 'com.example.chat_app_white_label_beta') {
      appName = 'WeUno Chat Beta';
      appLogo = 'assets/images/whatsapp.png';
    }
    emit(SetFlavorState());
  }


  setToken(String? token)async{
    await sharedPreferencesUtil.setString(SharedPreferenceConstants.apiAuthToken, token);
  }

  setUserModel(UserModel? userModel)async{
    await sharedPreferencesUtil.setUserModel(SharedPreferenceConstants.userModel, userModel);
  }

  List<CameraDescription> cameras = [];
  CameraDescription? firstCamera;
  void initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  bool isContactactsPermissionGranted = false;
  List<Contact> localContacts = [];
  List<ContactModel> contactToDisplay = [];

  Future<void> initGetLocalContacts(context) async {
    final status = await PermissionUtils.requestContactsPermission(context);
    if (status.isGranted) {
      localContacts = await ContactsService.getContacts(withThumbnails: false);

      final snapshot = await FirebaseUtils.usersCollection.get();

      if (snapshot.docs.isNotEmpty) {
        contactToDisplay.clear();
        for (var i = 0; i < localContacts.length; i++) {
          String? localNumber = (localContacts[i].phones ?? [])
              .map((item) => item.value)
              .toList()
              .firstWhere((phone) => phone != null && phone.trim().isNotEmpty,
                  orElse: () => null)
              ?.replaceAll(' ', '')
              .replaceAll('+', '');
          if ((localNumber ?? '').startsWith('0')) {
            localNumber = localNumber?.replaceFirst('0', '92');
          }
          bool contactExist = (snapshot.docs).any((firebaseUser) =>
              firebaseUser.id == localNumber &&
              firebaseUser.id != FirebaseUtils.phoneNumber);
          // .any for filtering in Firebase users
          if (contactExist) {
            contactToDisplay.add(ContactModel(
                localName: localContacts[i].displayName,
                phoneNumber: localNumber ?? ''));
          }
        }
      }

      for (var index = 0; index < contactToDisplay.length; index++) {
        final snapshot = await FirebaseUtils.getChatUser(
            contactToDisplay[index].phoneNumber ?? '');

        UserModel firebaseContactUser =
            UserModel.fromJson(snapshot.data() ?? {});
        contactToDisplay[index].firebaseData = firebaseContactUser;
      }
      isContactactsPermissionGranted = true;
      emit(ContactsPermissionGranted());
    }
  }
}
