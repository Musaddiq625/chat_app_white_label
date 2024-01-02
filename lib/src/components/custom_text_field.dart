import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final TextAlign textAlign;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.maxLength = 12,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.center,
    this.inputFormatters = const [],
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(); // Assign if not provided
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose only if created internally
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: widget.textAlign,
      controller: _controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(hintText: widget.hintText),
      onChanged: (value) {
        widget.onChanged(value);
      },
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
    );
  }
}