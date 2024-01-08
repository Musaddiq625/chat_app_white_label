import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  static showToast(
    String? message, {
    bool makeToastPositionTop = false,
    required BuildContext context,
    int? duration,
  }) {
    var fToast = FToast();
    fToast.init(context);
    Widget toast = Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
        bottom: makeToastPositionTop ? 12 : 34,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              ColorConstants.green,
              ColorConstants.green,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.decal,
          ),
        ),
        // width: MediaQuery.of(context).size.width * .9,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                // Icon(Icons.info,color: ColorConstants.white,),
                SizedBox(width: 6),
              ],
            ),
            Flexible(
              child: Text(
                message ?? '',
                style: const TextStyle(
                  color: ColorConstants.white,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: makeToastPositionTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
      toastDuration: Duration(milliseconds: duration ?? 1500),
    );
  }
}
