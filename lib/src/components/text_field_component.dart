import 'dart:ui' as dart_ui;

import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldComponent extends StatefulWidget {
  final Function()? onTap;
  final String? title;
  final bool isMandatory;
  final TextEditingController textEditingController;
  final String hintText;
  final bool hideAsterisk;
  final bool autoFocus;
  final AutovalidateMode autovalidateMode;
  final bool? hidePassword;
  final Widget? suffixIcon;
  final Color? fieldColor;
  final bool disableField;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int maxLines;
  final int errorMaxLines;
  final int minLines;
  double textFieldFontSize;
  final bool? enabled;
  final Function(String _)? onChanged;
  final Function(String _)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? trailingImage;
  final Function()? onTrailingPressed;
  final FocusNode? focusNode;
  final bool capitalizeText;
  final bool digitsOnly;
  final bool filled;
  final Color textColor;
  final Widget? prefixWidget;

  final dart_ui.TextDirection? textDirection;
  final bool? changeDirection;

  TextFieldComponent(
    this.textEditingController, {
    Key? key,
    this.onTap,
    this.title,
    this.isMandatory = false,
    this.hintText = '',
    this.hideAsterisk = false,
    this.hidePassword,
    this.suffixIcon,
    this.fieldColor,
    this.disableField = false,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.errorMaxLines = 3,
    this.minLines = 1,
    this.enabled,
    this.onChanged(String _)?,
    this.onFieldSubmitted(String _)?,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.trailingImage,
    this.onTrailingPressed,
    this.focusNode,
    this.capitalizeText = false,
    this.filled = false,
    this.digitsOnly = false,
    this.prefixWidget,
    this.changeDirection = false,
    this.textDirection,
    this.textColor = ColorConstants.white,
    this.textFieldFontSize = 30,
    this.autoFocus = false,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool hidePassword = false;

  // List<TextInputFormatter> inputFormatters = [];

  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  void initState() {
    hidePassword = widget.hidePassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filled) {
      widget.textFieldFontSize = 15;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                TextComponent(
                  widget.title!,
                  style: TextStyle(color: widget.textColor),
                ),
                TextComponent(
                  widget.isMandatory ? '*' : '',
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                ),
              ],
            ),
          ),
        TextFormField(
          textDirection: widget.textDirection,

          onTap: widget.onTap,
          textInputAction: widget.textInputAction,
          key: widget.key,
          autofocus: widget.autoFocus,

          controller: widget.textEditingController,
          obscureText: hidePassword ?? false,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: (_) =>
              widget.onChanged == null ? () {} : widget.onChanged!(_),
          style: widget.filled
              ? TextStyle(
                  color: ColorConstants.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: FontConstants.inter,
                  decorationThickness: 0.0,
                  decoration: TextDecoration.none,
                  fontSize: widget.textFieldFontSize)
              : TextStyle(
                  color: ColorConstants.white,
                  decorationThickness: 0.0,
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: widget.textFieldFontSize),

          inputFormatters: widget.capitalizeText
              ? [_UpperCaseTextFormatter()]
              : widget.digitsOnly
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
          cursorColor: themeCubit.primaryColor,

          decoration: widget.filled
              ? filledInputDecoration()
              : unFilledInputDecoration(),
          //    decoration: InputDecoration(
          //   hintText: widget.hintText,
          //    hintStyle: const TextStyle(
          //                         color: ColorConstants.lightGray,
          //                         fontFamily: FontConstants.fontProtestStrike,
          //                         fontSize: 30),
          //   border: InputBorder.none,
          //   focusedBorder: const UnderlineInputBorder(
          //     borderSide: BorderSide(color: ColorConstants.transparent, width: 2),
          //   ),
          //   enabledBorder: const UnderlineInputBorder(
          //     borderSide: BorderSide(color: ColorConstants.transparent, width: 2),
          //   ),
          // ),
          // decoration: InputDecoration(
          //   counterText: '',

          //   enabled: !widget.disableField,
          //   hintText: _showHintText(
          //     text: widget.hintText,
          //     showAsterisk: widget.isMandatory,
          //   ),
          //   labelStyle: TextStyle(color: ColorConstants.lightGrey),
          //   hintStyle: TextStyle(color: ColorConstants.lightGrey.withOpacity(0.3), fontSize: 14),
          //   border: _outLineBorder(),
          // errorBorder: _outLineBorder(),
          // enabledBorder: _outLineBorder(),
          // focusedBorder: _outLineBorder(),
          // disabledBorder: _outLineBorder(),
          //   errorMaxLines: 2,
          //   prefixIcon: widget.prefixWidget != null
          //       ? Padding(
          //           padding: EdgeInsets.only(left: 15, bottom: 1),
          //           child: SizedBox(
          //             width: 35,
          //             child: widget.prefixWidget,
          //           ),
          //         )
          //       : null,
          //   prefixIconConstraints: _boxConstraints(),
          //   suffixIconConstraints: _boxConstraints(),
          //   contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 16),
          //   suffixIcon: hidePassword != null
          //       ? GestureDetector(
          //           child: _iconWidget(),
          //           onTap: () {
          //             setState(() => hidePassword = !hidePassword!);
          //           },
          //         )
          //       : widget.suffixIcon,
          // ),
        ),
      ],
    );
  }

  InputDecoration filledInputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      isDense: true,
      border: _outLineBorder(),
      errorBorder: _outLineBorder(),
      enabledBorder: _outLineBorder(),
      focusedBorder: _outLineBorder(),
      disabledBorder: _outLineBorder(),
      filled: widget.filled,
      fillColor: widget.filled
          ? (widget.fieldColor ?? ColorConstants.blackLight.withOpacity(0.6))
          : null,
      errorMaxLines: widget.errorMaxLines,
      hintText: widget.hintText,
      counter: const Offstage(),
      hintStyle: widget.filled
          ? TextStyle(
              color: ColorConstants.lightGray,
              fontWeight: FontWeight.normal,
              fontFamily: FontConstants.inter,
              decorationThickness: 0.0,
              decoration: TextDecoration.none,
              fontSize: widget.textFieldFontSize)
          : TextStyle(
              color: ColorConstants.lightGray,
              fontFamily: FontConstants.fontProtestStrike,
              fontSize: widget.textFieldFontSize),
    );
  }

  InputDecoration unFilledInputDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      // contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 6),
      errorMaxLines: widget.errorMaxLines,
      hintText: widget.hintText,
      counter: const Offstage(),
      hintStyle: TextStyle(
          color: ColorConstants.lightGray,
          fontFamily: FontConstants.fontProtestStrike,
          fontSize: widget.textFieldFontSize),
    );
  }

  OutlineInputBorder _outLineBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color:
              widget.fieldColor ?? ColorConstants.blackLight.withOpacity(0.6),
        ),
      );

  String _showHintText({
    required String text,
    required bool showAsterisk,
  }) {
    if (text != '') {
      return text + (showAsterisk ? '*' : '');
    } else {
      return text;
    }
  }

  BoxConstraints _boxConstraints() => const BoxConstraints();

  Widget _iconWidget() => GestureDetector(
        onTap: () {
          hidePassword = !hidePassword;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            hidePassword == true ? Icons.visibility_off : Icons.visibility,
            color: ColorConstants.grey,
          ),
        ),
      );
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
