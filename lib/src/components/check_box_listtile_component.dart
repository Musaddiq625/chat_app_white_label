import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'rounded_checkbox_component.dart';

class CheckboxListTileComponent extends StatelessWidget {
  final bool isChecked;
  final String title;
  final String subTitle;
  final Function onPressed;
  final bool withBgColor;
  final bool enablePadding;

  const CheckboxListTileComponent(this.title,
      {this.isChecked = false,
      this.subTitle = '',
      required this.onPressed,
      this.withBgColor = true,
      Key? key,
      this.enablePadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: enablePadding
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      title,
                      style: TextStyle(
                          fontSize: 30,
                          color: themeCubit.textColor,
                          fontFamily: FontConstants.fontProtestStrike),
                    ),
                    subTitle == '' ? Container() : Text(subTitle),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            RoundedCheckboxComponent(
              isChecked: isChecked,
              onCheckPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
