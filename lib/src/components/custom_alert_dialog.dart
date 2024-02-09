import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

//Used for Warning when logout .delete account,block User

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String? title;
  final String? message;
  final String? note;
  final String btnTextRight;
  final Function() btnTapRight;
  final double circularBorderRadius;
  final TextStyle? textStyleRight;
  final TextStyle? textStyleLeft;
  final bool hideCancel;
  final String? btnTextLeft;
  final Function()? btnTapLeft;
  final bool makeHeadingCenter;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.circularBorderRadius = 6,
    this.bgColor = Colors.white,
    required this.btnTextRight,
    required this.btnTapRight,
    this.textStyleRight,
    this.textStyleLeft,
    this.note,
    this.hideCancel = false,
    this.btnTextLeft,
    this.btnTapLeft,
    this.makeHeadingCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
            )
          : null,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: ColorConstants.greenMain),
      content: message != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: makeHeadingCenter
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                if (note != null && note != null)
                  const SizedBox(
                    height: 15,
                  )
                else
                  const SizedBox(),
                if (note != null && note != '')
                  Text(
                    note!,
                    textAlign: TextAlign.center,
                  ),
              ],
            )
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!hideCancel)
              GestureDetector(
                onTap: btnTapLeft ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    btnTextLeft ?? 'Cancel',
                    style: textStyleRight ??
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (!hideCancel) const SizedBox(width: 60),
            GestureDetector(
              onTap: btnTapRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  btnTextRight,
                  style: textStyleLeft ??
                      const TextStyle(
                        color: ColorConstants.greenMain,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
