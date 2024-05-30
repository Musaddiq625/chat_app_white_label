import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
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
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
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
    print("adding images");
    selectedImages.addAll(List.filled(6 - selectedImages.length, ""));
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     'SELECTEDIMAGES.MAP((E) => E.ISNOTEMPTY).TOLIST().LENGTH: ${selectedImages.where((e) => e.isNotEmpty).toList().length}');

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
    return BlocConsumer<OnboardingCubit, OnBoardingState>(
        listener: (context, state) {
          if(state is UploadImageLoadingState){
            LoadingDialog.showLoadingDialog(context);
          }
          else if(state is UploadImageSuccess){
            LoadingDialog.hideLoadingDialog(context);
            NavigationUtil.push(
                context, RouteConstants.selectProfileScreen,
                args: state.uplodedImages);
          }
          else if(state is UploadImageFailureState){
                LoadingDialog.hideLoadingDialog(context);
          }

      // if (state is OnBoardingLoadingState) {
      //   // LoadingDialog.showLoadingDialog(context);
      // } else if (state is OnBoardingUserNameImageSuccessState) {
      //   LoadingDialog.hideLoadingDialog(context);
      //
      //   NavigationUtil.push(context, RouteConstants.selectProfileScreen,
      //       args: selectedImages);
      // } else {
      //   LoadingDialog.hideLoadingDialog(context);
      //   // ToastComponent.showToast(state.toString(), context: context);
      // }
      // if (state is OnBoardingUserNameImageFailureState) {
      //   LoadingDialog.hideLoadingDialog(context);
      // }
    }, builder: (BuildContext context, OnBoardingState state) {
      // LoggerUtil.logs(onBoardingCubit.getUserName());
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
                style: FontStylesConstants.style14(
                    color: ColorConstants.lightGray),
              ),
              const SizedBox(
                height: 40,
              ),

              Container(
                height: 250,
                width: AppConstants.responsiveWidth(context),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if(selectedImages.length <6){
                      selectedImages
                          .addAll(List.filled(6 - selectedImages.length, ""));
                    }

                    print(
                        "selected Image ${selectedImages}  lenght ${selectedImages.length}");
                    return Container(
                      height: 250,
                      width:
                          AppConstants.responsiveWidth(context, percentage: 60),
                      margin: const EdgeInsets.only(right: 20),
                      child: ChooseImageComponent(
                        image: selectedImages[index],
                        showImageSelectionBottomSheet: false,
                        onImagePick: (image) {
                          setState(() {
                            insertImage(image, index: index);
                            // selectedImages.insert(0, image.path);
                            // selectedImages = tempEmptyImageData;

                            // selectedImages.removeLast();
                          });
                        },
                      ),
                    );
                  },
                  itemCount: selectedImages.length,
                ),
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
                bgcolor: ColorConstants.lightGray.withOpacity(0.5),
                textColor: ColorConstants.white,
                buttonText: StringConstants.addPhotoFromGallery,
                onPressed: () async {
                  if(selectedImages.where((e) => e.isNotEmpty).toList().length < 6){
                  if(selectedImages.length <6){
                    selectedImages
                        .addAll(List.filled(6 - selectedImages.length, ""));
                  }
                  // if (selectedImages.length < 6) {
                    if (selectedImage == null) {
                      final XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        // setState(() {
                        //   selectedImages.add(File(image.path));
                        // });
                        insertImage(image);
                        // selectedImages = tempEmptyImageData;

                        // selectedImages.removeLast();
                      }
                    } else {
                      selectedImage = null;
                    }
                  }

                  setState(() {});
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor:
                    selectedImages.where((e) => e.isNotEmpty).toList().length >=
                            2
                        ? ColorConstants.lightGray.withOpacity(0.5)
                        : ColorConstants.white,
                textColor:
                    selectedImages.where((e) => e.isNotEmpty).toList().length >=
                            2
                        ? ColorConstants.white
                        : const Color.fromRGBO(0, 0, 0, 1),
                buttonText: StringConstants.takeASelfie,
                onPressed: () async {
                  if(selectedImages.where((e) => e.isNotEmpty).toList().length < 6){


                  if(selectedImages.length <6){
                    selectedImages
                        .addAll(List.filled(6 - selectedImages.length, ""));
                  }
                  // if (selectedImages.length < 6) {
                    List<File> files = [];
                    final XFile? cameraImage = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.front);
                    if (cameraImage != null) {
                      // files.add(File(cameraImage.path));
                      // setState(() {
                      //   selectedImages.add(File(cameraImage.path));
                      // });

                      insertImage(cameraImage);

                      // selectedImages.insert(0, cameraImage.path);
                      // selectedImages = tempEmptyImageData;

                      // selectedImages.removeLast();

                      setState(() {});
                    }
                  }
                }),
          ),
          const SizedBox(
            height: 10,
          ),

          // if (selectedImages.every((element) => element.isNotEmpty))

          if (selectedImages.where((e) => e.isNotEmpty).toList().length >= 2)
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: ButtonComponent(
                bgcolor: themeCubit.primaryColor,
                textColor: ColorConstants.black,
                buttonText: StringConstants.continues,
                onPressed: () async {

                  // removeEmptyImages();
                  List<String> passImages = selectedImages;
                  passImages.removeWhere((element) => element.isEmpty);
                  // AwsS3.uploadFile(
                  //     accessKey: "OOFqyH9v2YBpon7C3m0pZSH0ruNxqGEVMeyRy0g5",
                  //     secretKey: "DQEJGSA2VP1KBQZ551NI",
                  //     file: File("path_to_file"),
                  //     bucket: "locals",
                  //     region: "se-sto-1",
                  //     domain: "linodeobjects.com", // optional - Default: amazonaws.com
                  //     metadata: {"test": "test"} // optional
                  // );
                  onBoardingCubit.uploadUserPhoto((selectedImages));
                  LoggerUtil.logs("uploadUserPhotos $selectedImages}");
                  // NavigationUtil.push(
                  //     context, RouteConstants.selectProfileScreen,
                  //     args: passImages);
                },
              ),
            ),

          // }))
        ],
      );
    });
  }

  void removeEmptyImages() {
    selectedImages.removeWhere((element) => element.isEmpty);
  }

  void insertImage(XFile image, {int? index}) {
    // var i = {selectedImages[selectedImages.indexOf("")]};

    // print('Iss: ${i}');

    bool isListEmpty = selectedImages.every((element) => element.isNotEmpty);
    if (index == null && isListEmpty) {
      print("5 replacing image $index");
      selectedImages.insert(0, image.path);
    }
    // if (index != null) {
    // if (isListEmpty) {
    //   print("List of image ${isListEmpty}");
    //   print("4 replacing image $index");
    //   // selectedImages.insert(0, image.path);
    //
    //   // selectedImages.firstWhere((element) => element == "");
    // }
    // else
      if (selectedImages.any((element) => element == '')) {
      print("0 replacing image $index");
      if (index != null) {
        print("1 replacing image $index");
        selectedImages[index] = image.path;
      } else {
        print("2 replacing image $index");
        if (selectedImages[selectedImages.indexOf("")] == "") {
          print("3 replacing image $index");
          selectedImages[selectedImages.indexOf("")] = image.path;
        }
      }
    } else if (index != null) {
      print("replacing image $index");
      selectedImages[index] = image.path;
    }
  }
// }
}
