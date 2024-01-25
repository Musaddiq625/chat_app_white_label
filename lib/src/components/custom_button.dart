import 'package:chat_app_white_label/src/constants/color_constants.dart';
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
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: ColorConstants.greenMain,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
            )),
        child: Text(buttonText));
  }
}
