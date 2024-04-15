import 'dart:ui';

import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Color? bgColor = Colors.white,
    bool takeFullHeightWhenPossible = false,
    Function()? whenComplete,
  }) async {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: themeCubit.darkBackgroundColor,
      // barrierColor: ColorConstants.white.withOpacity(0.2),
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
              child: Stack(
                children: [
                  Positioned(
                      // top: 130,
                      // left: 220,
                      child: Container(
                    // width: 400,
                    // height: 800,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // gradient: LinearGradient(colors: [
                      //   Color(0xff7c7c7c),
                      //   Color(0xff1c1c1c),
                      //   // Color(0xff9b9b9b),
                      //   // Color(0xff9b9b9b),
                      //   // Color(0xff9b9b9b),
                      // ]),
                      color: ColorConstants.transparent,
                    ),
                  )),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          // constraints: const BoxConstraints(maxHeight:100),
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
                  ),
                ],
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
