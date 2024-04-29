import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'text_component.dart';

class DropDownBottomSheet extends StatefulWidget {
  final String? image;
  String? selectedVisibilityValue;
  String? selectedValue;
  final List<String> values;
  final Function(String?)? onValueSelected;
  DropDownBottomSheet({
    super.key,
    this.image,
    this.selectedVisibilityValue,
    this.selectedValue,
    required this.values,
    this.onValueSelected,
  });

  @override
  State<DropDownBottomSheet> createState() => _DropDownBottomSheetState();
}

class _DropDownBottomSheetState extends State<DropDownBottomSheet> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: themeCubit.darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBoxConstants.sizedBoxTwentyH(),
              if (widget.image != null)
                ImageComponent(
                  imgUrl: widget.image!,
                  imgProviderCallback: (imageProvider) {},
                  width: 40,
                  height: 40,
                ),
              if (widget.image != null) SizedBoxConstants.sizedBoxTwentyH(),
              TextComponent(
                StringConstants.visibility,
                style: TextStyle(
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 18),
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              ...widget.values.map((value) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTileComponent(
                      title: value,
                      titleSize: 14,
                      onTap: () {
                        setState(() {
                          widget.selectedValue =
                              value; // Update the selected value
                        });
                      },
                      backgroundColor: //themeCubit.darkBackgroundColor100,
                          widget.selectedValue == value
                              ? themeCubit.primaryColor
                              : themeCubit.darkBackgroundColor100,
                      titleColor: //ColorConstants.white,
                          widget.selectedValue == value
                              ? themeCubit.backgroundColor
                              : null,
                      trailingIcon: null,
                    ),
                  )),
              SizedBoxConstants.sizedBoxForthyH(),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                width: AppConstants.responsiveWidth(context),
                child: ButtonComponent(
                  textColor: themeCubit.backgroundColor,
                  bgcolor: themeCubit.primaryColor,
                  buttonText: StringConstants.save,
                  onPressed: () {
                    setState(() {
                      widget.onValueSelected!(widget
                          .selectedValue); // Invoke the callback with the selected value
                      widget.selectedVisibilityValue =
                          widget.selectedValue!.isNotEmpty
                              ? widget.selectedValue
                              : widget.values[0];
                    });
                    NavigationUtil.pop(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
