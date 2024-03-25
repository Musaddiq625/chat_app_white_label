import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.maxLength = 12,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.center,
    this.inputFormatters = const [],
    this.onChanged,
    this.controller,
    this.hintStyle,
    this.style,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(); // Assign if not provided
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose only if created internally
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: widget.style,
        textAlign: widget.textAlign,
        controller: _controller,
        keyboardType: widget.keyboardType,
        cursorColor: ColorConstants.greenMain,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: InputBorder.none,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.transparent, width: 2),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.transparent, width: 2),
          ),
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
          ...widget.inputFormatters,
        ]);
  }
}
