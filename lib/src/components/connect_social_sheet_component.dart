import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSheetComponent extends StatefulWidget {
  final String? heading;
  final String? textfieldHint;
  final String? image;
  final bool isSvg;

  const SocialSheetComponent(
      {super.key,
      this.heading,
      this.image,
      this.isSvg = false,
      this.textfieldHint});

  @override
  State<SocialSheetComponent> createState() => _SocialSheetComponentState();
}

class _SocialSheetComponentState extends State<SocialSheetComponent> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      child: Column(
        children: [
          // const SizedBox(
          //   height: 70,
          //   width: double.infinity,
          // ),
          if (widget.image != null)
            widget.isSvg
                ? SvgPicture.asset(
                    // height: 25.55,
                    widget.image!,
                    height: 50,
                  )
                : Image.asset(
                    // AssetConstants.group,
                    widget.image!,
                    width: 50,
                    height: 50,
                  ),
          SizedBoxConstants.sizedBoxTwentyH(),
          if (widget.heading != null)
            SizedBox(
              width: 300,
              child: TextComponent(
                widget.heading!,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: FontConstants.fontProtestStrike,
                    color: themeCubit.textColor),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),

          SizedBoxConstants.sizedBoxThirtyH(),
          TextFieldComponent(
            _textEditingController,
            filled: true,
            hintText: widget.textfieldHint ?? '',
          ),
          SizedBoxConstants.sizedBoxTenH(),
          ButtonComponent(
            buttonText: StringConstants.save,
            textColor: themeCubit.backgroundColor,
            bgcolor: themeCubit.primaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
