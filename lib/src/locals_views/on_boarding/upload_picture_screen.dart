import 'dart:io';

import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class UploadPictureScreen extends StatefulWidget {
  const UploadPictureScreen({super.key});

  @override
  State<UploadPictureScreen> createState() => _UploadPictureScreenState();
}

class _UploadPictureScreenState extends State<UploadPictureScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  File? selectedImage;
  File? selectedCameraImage;
  bool imageUploded = false;
  String? imageUrl;
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }

  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: enterName(),
    );
  }

  enterName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap:()=> NavigationUtil.pop(context),
              child: IconComponent(
                iconData: Icons.arrow_back_ios_new_outlined,
                borderColor: ColorConstants.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: ColorConstants.white,
                circleSize: 30,
                iconSize: 20,
              ),
            ),
            SizedBoxConstants.sizedBoxThirtyH(),
            TextComponent(
              StringConstants.letsPutAFace,
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            SizedBoxConstants.sizedBoxTwelveH(),
            const TextComponent(
              StringConstants.requiredPictures,
              style: TextStyle(
                fontSize: 12,
                color: ColorConstants.lightGray,
              ),
            ),
            // Stack(
            //   children: [
            //     CircleAvatar(
            //       radius: 65,
            //       backgroundImage: (selectedImage != null
            //           ? FileImage(selectedImage!)
            //           : imageUrl != null
            //           ? NetworkImage(imageUrl ?? '')
            //           : const AssetImage(AssetConstants.profile))
            //       as ImageProvider,
            //     ),
            //     // Positioned(
            //     //     right: 5,
            //     //     bottom: 5,
            //     //     child: GestureDetector(
            //     //       onTap: () async {
            //     //         if (selectedImage == null) {
            //     //           final XFile? image = await ImagePicker()
            //     //               .pickImage(source: ImageSource.gallery);
            //     //           if (image != null) {
            //     //             setState(() {
            //     //               selectedImage = File(image.path);
            //     //             });
            //     //           }
            //     //         } else {
            //     //           setState(() {
            //     //             selectedImage = null;
            //     //           });
            //     //         }
            //     //       },
            //     //       child: CircleAvatar(
            //     //           radius: 15,
            //     //           backgroundColor:
            //     //           const Color.fromARGB(255, 238, 238, 238),
            //     //           child: Icon(
            //     //             selectedImage == null
            //     //                 ? Icons.edit
            //     //                 : Icons.cancel_outlined,
            //     //             color: const Color.fromARGB(255, 139, 139, 139),
            //     //             size: 16,
            //     //           )),
            //     //     ))
            //   ],
            // ),
            const SizedBox(
              height: 40,
            ),

            selectedImages.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // This is just for demonstration. You can remove or change it as needed.
                      child: Row(
                        children: selectedImages.map((image) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants
                                        .white, // Ensure this is defined in your themeCubit
                                    borderRadius: BorderRadius.circular(
                                        10.0), // This gives the curved border radius
                                  ),
                                  width: AppConstants.responsiveWidth(context,
                                      percentage: 60),
                                  height: 250,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 250,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGray.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconComponent(
                            iconData: Icons.add_circle,
                            iconSize: 60,
                            iconColor: ColorConstants.white,
                            circleSize: 60,
                            backgroundColor: ColorConstants.transparent,
                          ),
                        ]),
                  )
          ],
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: ColorConstants.lightGray.withOpacity(0.2),
              textColor: ColorConstants.white,
              buttonText: StringConstants.addPhotoFromGallery,
              onPressedFunction: () async {
                if (selectedImage == null) {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      selectedImages.add(File(image.path));
                    });
                  }
                } else {
                  setState(() {
                    selectedImage = null;
                  });
                }
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: selectedImages.length >= 2
                  ? ColorConstants.lightGray.withOpacity(0.2)
                  : ColorConstants.white,
              textColor: selectedImages.length >= 2
                  ? ColorConstants.white
                  : ColorConstants.black,
              buttonText: StringConstants.takeASelfie,
              onPressedFunction: () async {
                List<File> files = [];
                final XFile? cameraImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (cameraImage != null) {
                  // files.add(File(cameraImage.path));
                  setState(() {
                    selectedImages.add(File(cameraImage.path));
                  });
                }
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        if (selectedImages.length >= 2)
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: themeCubit.primaryColor,
                textColor: ColorConstants.black,
                buttonText: StringConstants.continues,
                onPressedFunction: () {
                  NavigationUtil.push(
                      context, RouteConstants.selectProfileScreen);
                }),
          )
      ],
    );
  }
}
