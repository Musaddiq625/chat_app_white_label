import 'dart:io';

import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ChooseImageComponent extends StatelessWidget {
  final List<File>? selectedImages;

  const ChooseImageComponent({super.key, this.selectedImages});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return (selectedImages ?? []).isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (selectedImages ?? []).map((image) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.white,
                          borderRadius: BorderRadius.circular(10.0),
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
