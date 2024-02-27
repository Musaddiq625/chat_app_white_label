import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

//Used for Custom bottom data

class BottomSheetComponent {
  static Future<void> showBottomSheet(
    BuildContext context, {
    VoidCallback? leadingPressed,
    String? leadingTitle,
    IconData leadingIcon = Icons.home,
    required Widget body,
    Widget? header,
    bool isShowHeader = true,
    bool takeFullHeightWhenPossible = false,
    Function()? whenComplete,
  }) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: ColorConstants.white,
      barrierColor: ColorConstants.white.withOpacity(0.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: takeFullHeightWhenPossible ? 0.9 : null,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 90),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBoxConstants.sizedBoxSixH(),
                    if (isShowHeader)
                      header ??
                          ((leadingTitle != null)
                              ? _defaultBottomSheetHeader(
                                  leadingPressed: leadingPressed,
                                  leadingTitle: leadingTitle,
                                  leadingIcon: leadingIcon,
                                  context: context,
                                )
                              : const SizedBox.shrink()),
                    if (isShowHeader) const Divider(),
                    Flexible(child: body)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static Widget _defaultBottomSheetHeader({
    required VoidCallback? leadingPressed,
    required String leadingTitle,
    required IconData leadingIcon,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: leadingPressed ??
                () {
                  NavigationUtil.pop(
                    context,
                  );
                },
            child: Icon(leadingIcon),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            leadingTitle,
          )
        ],
      ),
    );
  }
}
