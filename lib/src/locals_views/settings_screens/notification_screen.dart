import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  bool requireNotification = true;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.termsOfuse,
          centerTitle: false,
          isBackBtnCircular: false,
        ),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent(
                StringConstants.pushNotifications,
                style: FontStylesConstants.style18(
                    color: ColorConstants.white,
                    fontFamily: FontConstants.inter),
              ),
              Switch(
                // This bool value toggles the switch.
                value: requireNotification,
                activeColor: ColorConstants.white,
                activeTrackColor: themeCubit.primaryColor,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    requireNotification = value;
                  });
                },
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }
}
