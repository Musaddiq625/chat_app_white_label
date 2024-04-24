import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBottomSheetComponent extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  final String? btnText;
  Color? btnColor;
  final Color? btnTextColor;
  final bool isImageProfilePic;
  final bool isImageAsset;
  final Function()? onBtnTap;

  CommonBottomSheetComponent(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      this.isImageProfilePic = false,
      this.btnText,
      this.btnColor,
      this.isImageAsset = false,
      this.btnTextColor,
      this.onBtnTap});

  @override
  State<CommonBottomSheetComponent> createState() =>
      _CommonBottomSheetComponentState();
}

class _CommonBottomSheetComponentState
    extends State<CommonBottomSheetComponent> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(children: [
        SizedBoxConstants.sizedBoxTwelveH(),
        if (widget.isImageProfilePic)
          const ProfileImageComponent(
            url:
                'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png', //!REPLACE WITH IMAGE URL
          )
        else
          ImageComponent(
            imgUrl: widget.image,
            isAsset: widget.isImageAsset,
            height: 50, width: 50,
            imgProviderCallback:
                (imgProvider) {}, //todo you can fix this according to needs
          ),
        SizedBoxConstants.sizedBoxTwentyH(),
        TextComponent(
          widget.title,
          style: FontStylesConstants.style18(
              color: themeCubit.textColor, fontWeight: FontWeight.bold),
        ),
        TextComponent(
          widget.description,
          style: FontStylesConstants.style18(
              fontWeight: FontWeight.bold, color: themeCubit.primaryColor),
        ),
        SizedBoxConstants.sizedBoxTwentyH(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBoxConstants.sizedBoxEightW(),
            Container(
              // color: Colors.red,
              alignment: Alignment.center,
              width: 150,
              child: TextComponent('', listOfText: const [
                StringConstants.goBack
              ], listOfOnPressedFunction: [
                () => NavigationUtil.pop(context)
              ], listOfTextStyle: [
                FontStylesConstants.style16(
                  color: themeCubit.textColor,
                ),
              ]),
            ),
            // SizedBoxConstants.sizedBoxFourW(),
            ButtonComponent(
                giveDefaultPadding: false,
                btnHeight: 38,
                bgcolor: widget.btnColor ?? themeCubit.primaryColor,
                textColor: widget.btnTextColor ?? themeCubit.backgroundColor,
                // overrideTextColor: themeCubit.textColor,
                btnWidth: 150,
                isSmallBtn: true,
                onPressed: widget.onBtnTap,
                buttonText: widget.btnText ?? StringConstants.message),
            // SizedBoxConstants.sizedBoxFourW(),
          ],
        ),
        SizedBoxConstants.sizedBoxTwelveH(),
      ]),
    );
  }
}
