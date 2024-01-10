import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedFunction;

  const CustomButton(
      {super.key, required this.buttonText, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await onPressedFunction();
      },
      child: Text(buttonText),
    );
  }
}
