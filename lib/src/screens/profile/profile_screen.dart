import 'dart:io';
import 'package:chat_app_white_label/src/components/custom_button.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/app_cubit/app_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
import '../../components/custom_text_field.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/service/firbase_auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String phoneNumber;

  const ProfileScreen({super.key, required this.phoneNumber});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AppCubit appCubit = BlocProvider.of<AppCubit>(context);

  FirebaseService firebaseService = getIt<FirebaseService>();
  final _controller = TextEditingController();
  final _controllerAbout = TextEditingController();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
          child: Column(
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: (_selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage(AssetConstants.profile))
                      as ImageProvider,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Phone Number : ${widget.phoneNumber}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: 'Profile Name',
                  maxLength: 30,
                  keyboardType: TextInputType.name,
                  controller: _controller,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: 'About',
                  maxLength: 35,
                  keyboardType: TextInputType.name,
                  controller: _controllerAbout,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  buttonText: "Next",
                  onPressedFunction: () async {
                    if (_controller.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter the name",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    try {
                      try {
                        final imageUrl =
                            await FirebaseUtils.uploadMedia(_selectedImage);
                        // print("imageUrl ${imageUrl} ");
                        await firebaseService.firestore
                            .collection(FirebaseConstants.users)
                            .doc(widget.phoneNumber.replaceAll('+', ''))
                            .update({
                          'name': _controller.text,
                          'image': imageUrl,
                          'about': _controllerAbout.text,
                          'is_profile_complete': true,
                        });
                      } catch (error) {
                        print("Error during file upload or retrieval: $error");
                      }
                      final userData =
                          await FirebaseUtils.getUserData(widget.phoneNumber);
                      appCubit.setUser(userData!);
                      NavigationUtil.push(context, RouteConstants.chatScreen);
                    } catch (error) {
                      print(
                          error); // You might want to display a general error message to the user
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
