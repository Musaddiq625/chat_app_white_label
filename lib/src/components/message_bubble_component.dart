import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MessageBubbleComponent extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubbleComponent(
      {super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth:
                      AppConstants.responsiveWidth(context, percentage: 70)),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  color: isMe ? ColorConstants.greenLight : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                message,
                softWrap: true,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
