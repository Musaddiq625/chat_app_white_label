import 'dart:io';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/choose_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/user_detail_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/onboarding_cubit.dart';

class UploadPictureScreen extends StatefulWidget {
  const UploadPictureScreen({super.key});

  @override
  State<UploadPictureScreen> createState() => _UploadPictureScreenState();
}

class _UploadPictureScreenState extends State<UploadPictureScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  File? selectedImage;
  File? selectedCameraImage;
  bool imageUploded = false;
  String? imageUrl;
  List<String> selectedImages = [];
  UserDetailModel? userDetailModel;
  // List tempEmptyImageData = [];

  @override
  void initState() {
    super.initState();
    selectedImages.addAll(List.filled(2 - selectedImages.length, ""));
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(""),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }

  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          children: [
            TextComponent(
              StringConstants.letsPutAFace,
              style: FontStylesConstants.style22(color: ColorConstants.white),
            ),
            SizedBoxConstants.sizedBoxTwelveH(),
            TextComponent(
              StringConstants.requiredPictures,
              style:
                  FontStylesConstants.style14(color: ColorConstants.lightGray),
            ),
            const SizedBox(
              height: 40,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:

                  //  tempEmptyImageData.isEmpty
                  //     ? Row(
                  //         children: List.generate(
                  //           2,
                  //           (index) => Container(
                  //             // color: Colors.red,
                  //             height: 250,
                  //             width: AppConstants.responsiveWidth(context,
                  //                 percentage: 60),
                  // margin: const EdgeInsets.only(right: 20),
                  //             child: ChooseImageComponent(
                  //               image: "",
                  //               showImageSelectionBottomSheet: false,
                  //               onImagePick: (image) {
                  //                 setState(() {
                  //                   tempEmptyImageData.add(File(image.path));
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     :
                  Row(
                      children: selectedImages.map((e) {
                // if (tempEmptyImageData.length == 1) {
                //   return Row(
                //     children: [
                //       Container(
                //         // color: Colors.red,
                //         // height: 250,
                //         width: AppConstants.responsiveWidth(context,
                //             percentage: 60),
                //         margin: const EdgeInsets.only(right: 20),
                //         child: ChooseImageComponent(
                //           image: e.path,
                //           onImagePick: (image) {
                //             setState(() {
                //               tempEmptyImageData.add(File(image.path));
                //             });
                //           },
                //         ),
                //       ),
                //       Container(
                //         height: 250,
                //         width: AppConstants.responsiveWidth(context,
                //             percentage: 60),
                //         child: ChooseImageComponent(
                //           image: "",
                //           showImageSelectionBottomSheet: false,
                //           onImagePick: (image) {
                //             setState(() {
                //               tempEmptyImageData.add(File(image.path));
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   );
                // }

                return Container(
                  height: 250,
                  width: AppConstants.responsiveWidth(context, percentage: 60),
                  margin: const EdgeInsets.only(right: 20),
                  child: ChooseImageComponent(
                    image: e,
                    showImageSelectionBottomSheet: false,
                    onImagePick: (image) {
                      setState(() {
                        selectedImages.insert(0, image.path);
                        // selectedImages = tempEmptyImageData;

                        selectedImages.removeLast();
                      });
                    },
                  ),
                );
              }).toList()),
            ),
            // ChooseImageComponent(
            //   selectedImages: selectedImages,
            // )
          ],
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: ColorConstants.lightGray.withOpacity(0.2),
              textColor: ColorConstants.white,
              buttonText: StringConstants.addPhotoFromGallery,
              onPressed: () async {
                if (selectedImage == null) {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    // setState(() {
                    //   selectedImages.add(File(image.path));
                    // });
                    selectedImages.insert(0, image.path);
                    // selectedImages = tempEmptyImageData;

                    selectedImages.removeLast();
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
              bgcolor: selectedImages.any((element) => element.isNotEmpty)
                  ? ColorConstants.lightGray.withOpacity(0.2)
                  : ColorConstants.white,
              textColor: selectedImages.any((element) => element.isNotEmpty)
                  ? ColorConstants.white
                  : ColorConstants.black,
              buttonText: StringConstants.takeASelfie,
              onPressed: () async {
                List<File> files = [];
                final XFile? cameraImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (cameraImage != null) {
                  // files.add(File(cameraImage.path));
                  // setState(() {
                  //   selectedImages.add(File(cameraImage.path));
                  // });

                  selectedImages.insert(0, cameraImage.path);
                  // selectedImages = tempEmptyImageData;

                  selectedImages.removeLast();

                  setState(() {});
                }
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        if (selectedImages.every((element) => element.isNotEmpty))
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
              bgcolor: themeCubit.primaryColor,
              textColor: ColorConstants.black,
              buttonText: StringConstants.continues,
              onPressed: () {
                userDetailModel?.userPhotos = selectedImages.toList();
                NavigationUtil.push(context, RouteConstants.selectProfileScreen,
                    args: selectedImages);
              },
            ),
          ),

        // }))
      ],
    );
  }
}
