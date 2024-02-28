import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ShowBottomSheetComponent {
  void showBottomSheet({
    required Widget content, //column or list
    required BuildContext context,
    bool removeHeight = false,
    bool isControlled = false,
    bool removePadding = false,
    bool isDismissible = true,
    Widget? bottomNavButton,
    Color? overrideBackgroundColor,
  }) {
    showModalBottomSheet(
      barrierColor: Colors.grey.shade900.withOpacity(0.8),
      isScrollControlled: isControlled,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      context: context,
      builder: (c) {
        return FractionallySizedBox(
          heightFactor: removeHeight ? null : 0.9,
          // widthFactor: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Stack(
              alignment: bottomNavButton!=null? Alignment.bottomCenter:Alignment.topCenter,
              children: [
                Container(
                  decoration:  BoxDecoration(
                    color: overrideBackgroundColor??ColorConstants.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          removePadding ? EdgeInsets.zero : const EdgeInsets.all(15),
                      child: content,
                    ),
                  ),
                ),
                if(bottomNavButton!=null)
                  bottomNavButton
              ],
            ),
          ),
        );
      },
    );
  }
}
