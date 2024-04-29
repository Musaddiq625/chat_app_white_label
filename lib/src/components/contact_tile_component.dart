import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactTileComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final bool showDivider;
  final Function() onTap;
  const ContactTileComponent(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isSelected,
      this.showDivider = true,
      required this.onTap});

  @override
  State<ContactTileComponent> createState() => _ContactTileComponentState();
}

class _ContactTileComponentState extends State<ContactTileComponent> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        // color: ColorConstants.red,
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: ColorConstants.red,
              padding: const EdgeInsets.only(
                left: 5,
                right: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width:
                          AppConstants.responsiveWidth(context, percentage: 80),
                      // color: ColorConstants.red,
                      child: ContactCard(
                        name: widget.title,
                        title: widget.subtitle,
                        url: "",
                        showShareIcon: false,
                        showDivider: false,
                        imageSize: 45,
                      )),
                  // ContactCard(
                  //   name:  widget.title,
                  //   title:  widget.title,
                  //   url: "",
                  // ),
                  // const ProfileImageComponent(
                  //   url: null,
                  //   size: 40,
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     TextComponent(
                  //       widget.title,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, color: themeCubit.textColor),
                  //     ),
                  //     TextComponent(
                  //       widget.subtitle,
                  //       style: const TextStyle(color: ColorConstants.lightGrey),
                  //     )
                  //   ],
                  // ),
                  const Spacer(),
                  Transform.scale(
                    scale: 1.2, // Adjust the scale factor as needed
                    child: Checkbox(
                      checkColor: ColorConstants.black,
                      shape: const CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return ColorConstants.primaryColor;
                        }
                        return ColorConstants.blackLight;
                      }),
                      value: widget.isSelected,
                      onChanged: (bool? newValue) {
                        // Your onChanged logic here
                      },
                    ),
                  )
                ],
              ),
            ),
            if (widget.showDivider) DividerCosntants.divider1,
            // SizedBoxConstants.sizedBoxThirtyH()
          ],
        ),
      ),
    );
  }
}
