import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileImageComponent(
                  url: null,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextComponent(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: themeCubit.textColor),
                    ),
                    TextComponent(
                      widget.subtitle,
                      style: const TextStyle(color: ColorConstants.lightGrey),
                    )
                  ],
                ),
                const Spacer(),
                Checkbox(
                  checkColor: ColorConstants.black,
                  shape: const CircleBorder(),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return ColorConstants.primaryColor;
                    }
                    return null;
                  }),
                  value: widget.isSelected,
                  onChanged: (bool? newValue) {
                    // setState(() {
                    //   checkBoxValue = newValue!;
                    // });
                  },
                )
              ],
            ),
            if(widget.showDivider)
            DividerCosntants.divider1
          ],
        ),
      ),
    );
  }
}


