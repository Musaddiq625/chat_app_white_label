import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';
import '../constants/font_styles.dart';
import '../constants/size_box_constants.dart';
import 'image_component.dart';

class AboutEventComponent extends StatelessWidget {
  final String name;
  final String detail;
  final String icon;
  final bool divider;
  final List<String>? selectedImages;
  final List<EventRequest>? eventParticipants;
  final Function()? onShareTap;
  final Function()? onProfileTap;
  final bool showPersonIcon;

  const AboutEventComponent(
      {Key? key,
      required,
      this.onShareTap,
      this.divider = true,
      this.showPersonIcon = true,
      this.onProfileTap,
      required this.name,
      required this.detail,
      required this.icon,
      this.selectedImages,
      this.eventParticipants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 25;
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 0, right: 20),
          child: InkWell(
            onTap: onProfileTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileImageComponent(
                  svgImage: true,
                  url: icon,
                  size: 25,
                ),
                SizedBoxConstants.sizedBoxTwentyW(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        name,
                        style: FontStylesConstants.style16(
                            color: ColorConstants.white),
                        maxLines: 6,
                      ),
                      TextComponent(
                        detail,
                        style: FontStylesConstants.style14(
                            color: ColorConstants.lightGray),
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
                if (showPersonIcon)
                  if (selectedImages != null)
                    SizedBox(
                      width: radius * 3, //radius * images.length.toDouble(),
// Calculate the total width of images
                      height: radius,
// Set the height to match the image size
                      child: Stack(
                        children: [
// ?? images.length
                          for (int i = 0;
                              i <
                                  ((eventParticipants ?? []).isNotEmpty
                                      ? (eventParticipants ?? []).length
                                      : 0);
                              i++)
                            Positioned(
                              left: i * radius / 1.5,
// Adjust the left offset
                              child: ClipOval(
                                  child: ImageComponent(
                                imgUrl: (eventParticipants ?? []).isNotEmpty
                                    ? (eventParticipants ?? [])[i].image!
                                    : "",
                                width: radius,
                                height: radius,
                                imgProviderCallback:
                                    (ImageProvider<Object> imgProvider) {},
                              )
// Image(
//   image: images[i],
//   width: radius,
//   height: radius,
//   fit: BoxFit.cover,
// ),
                                  ),
                            ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
        if (divider == true) const Divider(thickness: 0.1),
      ],
    );
  }
}
