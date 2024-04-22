import 'dart:io';

import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageComponent extends StatefulWidget {
  final String image;
  final Function(XFile image) onImagePick;
  final bool isCurrentProfilePic;
  final bool showImageSelectionBottomSheet;

  const ChooseImageComponent(
      {super.key,
      required this.image,
      required this.onImagePick,
      this.isCurrentProfilePic = false,
      this.showImageSelectionBottomSheet = true});

  @override
  State<ChooseImageComponent> createState() => _ChooseImageComponentState();
}

class _ChooseImageComponentState extends State<ChooseImageComponent> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (widget.showImageSelectionBottomSheet) {
            BottomSheetComponent.showBottomSheet(context,
                isShowHeader: false,
                body: Column(
                  children: [
                    SizedBoxConstants.sizedBoxTwelveH(),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ButtonComponent(
                          bgcolor: ColorConstants.lightGray.withOpacity(0.2),
                          textColor: ColorConstants.white,
                          buttonText: StringConstants.addPhotoFromGallery,
                          onPressed: () async {
                            final XFile? pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pickedImage != null) {
                              widget.onImagePick(pickedImage);
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ButtonComponent(
                          bgcolor: ColorConstants.white,
                          textColor: ColorConstants.black,
                          buttonText: StringConstants.takeASelfie,
                          onPressed: () async {
                            List<File> files = [];
                            final XFile? pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (pickedImage != null) {
                              widget.onImagePick(pickedImage);
                            }
                            // if (cameraImage != null) {
                            //   // files.add(File(cameraImage.path));
                            //   setState(() {
                            //     tempEmptyImageData.add(File(cameraImage.path));
                            //   });
                            // }
                          }),
                    ),
                    SizedBoxConstants.sizedBoxTwelveH(),
                  ],
                ));
          } else {
            final XFile? pickedImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);

            if (pickedImage != null) {
              widget.onImagePick(pickedImage);
            }
          }
        },
        child: widget.image != ""
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: ColorConstants.lightGray.withOpacity(0.4),
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  // width: AppConstants.responsiveWidth(context, percentage: 20),
                  // height: 250,

                  child: widget.isCurrentProfilePic == true
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ImageComponent(
                              height: 250,
                              imgUrl: widget.image,
                              imgProviderCallback: (imgProvider) {
                                return Container(
                                  color: Colors.red,
                                );
                              },
                            ),
                            Positioned(
                              left: 5,
                              top: 150,
                              child: TagComponent(
                                backgroundColor: themeCubit.primaryColor,
                                customFontWeight: FontWeight.bold,
                                customIconText: StringConstants.main,
                                onTap: () {},
                              ),
                            ),
                          ],
                        )
                      : ImageComponent(
                          height: 250,
                          imgUrl: widget.image,
                          imgProviderCallback: (imgProvider) {
                            return Container(
                              color: Colors.red,
                            );
                          },
                        ),
                  // Stack(
                  //   fit: StackFit.expand,
                  //   children: [
                  //     ImageComponent(
                  //       height: 250,
                  //       imgUrl: widget.image,
                  //       imgProviderCallback: (imgProvider) {
                  //         return Container(
                  //           color: Colors.red,
                  //         );
                  //       },
                  //     ),
                  //     if (widget.isCurrentProfilePic == true)
                  //       Positioned(
                  //         left: 5,
                  //         top: 150,
                  //         child: TagComponent(
                  //           backgroundColor: themeCubit.primaryColor,
                  //           customFontWeight: FontWeight.bold,
                  //           customIconText: StringConstants.main,
                  //           onTap: () {},
                  //         ),
                  //       ),
                  //   ],
                  // ),
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
              ));
  }
}
