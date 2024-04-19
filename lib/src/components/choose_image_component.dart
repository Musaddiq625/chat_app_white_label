import 'dart:io';

import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:flutter/material.dart';

class ChooseImageComponent extends StatefulWidget {
  final String? selectedImages;

  const ChooseImageComponent({
    super.key,
    this.selectedImages,
  });

  @override
  State<ChooseImageComponent> createState() => _ChooseImageComponentState();
}

class _ChooseImageComponentState extends State<ChooseImageComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return widget.selectedImages != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              // width: AppConstants.responsiveWidth(context, percentage: 20),
              height: 250,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ImageComponent(
                    imgUrl: widget.selectedImages!,
                    imgProviderCallback: (imgProvider) {
                      return Container(
                        color: Colors.red,
                      );
                    },
                  )
                  // Image.file(
                  //   image,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
          )
        : Container(
            width: MediaQuery.sizeOf(context).width * 0.6,
            height: 250,
            decoration: BoxDecoration(
              color: ColorConstants.lightGray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconComponent(
                iconData: Icons.add_circle,
                iconSize: 60,
                iconColor: ColorConstants.white,
                circleSize: 60,
                backgroundColor: ColorConstants.transparent,
              ),
            ]),
          );
  }
}
