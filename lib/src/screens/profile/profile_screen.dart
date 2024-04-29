import 'dart:io';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
import '../../components/custom_text_field.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/service/firbase_service.dart';

class ProfileScreen extends StatefulWidget {
  final String? phoneNumber;
  final bool? isEdit;
  const ProfileScreen({super.key, this.phoneNumber, this.isEdit});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseService firebaseService = getIt<FirebaseService>();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  File? selectedImage;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      nameController.text = FirebaseUtils.user?.firstName ?? '';
      aboutController.text = FirebaseUtils.user?.about ?? '';
      imageUrl = FirebaseUtils.user?.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorConstants.greenMain,
          title: Text(
              widget.isEdit == true ? 'Update Profile' : ' Complete Profile',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => NavigationUtil.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
            ),
            color: ColorConstants.white,
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: (selectedImage != null
                              ? FileImage(selectedImage!)
                              : widget.isEdit == true && imageUrl != null
                                  ? NetworkImage(imageUrl ?? '')
                                  : const AssetImage(
                                      AssetConstants.profileDummy))
                          as ImageProvider,
                    ),
                    Positioned(
                        right: 5,
                        bottom: 5,
                        child: GestureDetector(
                          onTap: () async {
                            if (selectedImage == null) {
                              final XFile? image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  selectedImage = File(image.path);
                                });
                              }
                            } else {
                              setState(() {
                                selectedImage = null;
                              });
                            }
                          },
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 238, 238),
                              child: Icon(
                                selectedImage == null
                                    ? Icons.edit
                                    : Icons.cancel_outlined,
                                color: const Color.fromARGB(255, 139, 139, 139),
                                size: 16,
                              )),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (widget.isEdit == true)
                  Text(
                    '${widget.isEdit == true ? FirebaseUtils.user?.phoneNumber : widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
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
                    controller: nameController,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {},
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
                    controller: aboutController,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonComponent(
                    buttonText: widget.isEdit == true ? 'Update' : ' Complete',
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
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
                        if (selectedImage != null) {
                          imageUrl = await FirebaseUtils.uploadMedia(
                              selectedImage!.path, MediaType.profilePicture);
                        }
                        await FirebaseUtils.updateUser(
                                nameController.text,
                                aboutController.text,
                                imageUrl,
                                widget.isEdit == true
                                    ? FirebaseUtils.user?.phoneNumber ?? ''
                                    : widget.phoneNumber ?? '')
                            .then((value) => NavigationUtil.popAllAndPush(
                                context, RouteConstants.homeScreen));
                      } catch (error) {
                        LoggerUtil.logs(
                            "Errors $error"); // You might want to display a general error message to the user
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
