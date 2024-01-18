import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(AppSettingInitial());

  String appName = 'WeUno Chat';
  String appLogo = 'assets/images/logo.jpg';

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

  List<CameraDescription> cameras = [];
  CameraDescription? firstCamera;
  void initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }
}
