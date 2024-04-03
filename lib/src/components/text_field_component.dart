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
  final bool? hidePassword;
  final Widget? suffixIcon;
  Color fieldColor;
  final bool disableField;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int maxLines;
  final int errorMaxLines;
  final int minLines;
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
    this.fieldColor = ColorConstants.lightGrey,
    this.disableField = false,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.errorMaxLines = 2,
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
    this.digitsOnly = false,
    this.prefixWidget,
    this.changeDirection = false,
    this.textDirection,
    this.textColor = ColorConstants.white,
  }) : super(key: key);
  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool? hidePassword;
  List<TextInputFormatter> inputFormatters = [];
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  void initState() {
    hidePassword = widget.hidePassword;
    widget.fieldColor = ColorConstants.blackLight.withOpacity(0.6);
    if (widget.capitalizeText) {
      inputFormatters.add(_UpperCaseTextFormatter());
    }
    if (widget.digitsOnly) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          controller: widget.textEditingController,
          obscureText: hidePassword ?? false,
          validator: widget.validator,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: (_) =>
              widget.onChanged == null ? () {} : widget.onChanged!(_),
          style: const TextStyle(
              color: ColorConstants.white,
              fontFamily: FontConstants.fontProtestStrike,
              fontSize: 30),
          inputFormatters: inputFormatters,
          cursorColor: themeCubit.primaryColor,

          decoration: InputDecoration(
            border: InputBorder.none,
            errorMaxLines: widget.errorMaxLines,
            hintText: widget.hintText,
            counter: const Offstage(),
            hintStyle: const TextStyle(
                color: ColorConstants.lightGray,
                fontFamily: FontConstants.fontProtestStrike,
                fontSize: 30),
          ),
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
          //   filled: true,
          //   fillColor: widget.fieldColor.withOpacity(0.5),
          //   enabled: !widget.disableField,
          //   hintText: _showHintText(
          //     text: widget.hintText,
          //     showAsterisk: widget.isMandatory,
          //   ),
          //   labelStyle: TextStyle(color: ColorConstants.lightGrey),
          //   hintStyle: TextStyle(color: ColorConstants.lightGrey.withOpacity(0.3), fontSize: 14),
          //   border: _outLineBorder(),
          //   errorBorder: _outLineBorder(),
          //   enabledBorder: _outLineBorder(),
          //   focusedBorder: _outLineBorder(),
          //   disabledBorder: _outLineBorder(),
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

  OutlineInputBorder _outLineBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.fieldColor,
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
  Widget _iconWidget() => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          hidePassword! ? Icons.visibility_off : Icons.visibility,
          color: ColorConstants.grey,
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
