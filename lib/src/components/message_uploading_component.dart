import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MessageUploadingComponent extends StatelessWidget {
  const MessageUploadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                  color: ColorConstants.greenLight,
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: const Text(
                "Uploading...",
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ))),
    );
  }
}
