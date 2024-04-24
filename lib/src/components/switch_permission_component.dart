import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwitchPermissionComponent extends StatelessWidget {
  final String name;
  final String detail;
  final bool editQuestions ;
  final bool switchValue ;
  final Function()? editQuestionsTap;
  final ValueChanged<bool> onSwitchChanged;

  const SwitchPermissionComponent({super.key, required this.name, required this.detail,this.editQuestions=false,this.switchValue=false,  required this.onSwitchChanged,this.editQuestionsTap});

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Container(
      width: AppConstants.responsiveWidth(context),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SvgPicture.asset(
                    height: 25,
                    AssetConstants.ticket,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          name,
                          maxLines: 13,
                          style: TextStyle(
                              fontSize: 15,
                              color: themeCubit.textColor),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child:  TextComponent(
                             detail,
                              maxLines: 15,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: ColorConstants.lightGray),
                              textAlign: TextAlign.start),
                        ),
                        if (editQuestions == true)
                          GestureDetector(
                            onTap: editQuestionsTap,
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  TextComponent(
                                    StringConstants.editQuestions,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: themeCubit.textColor),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconComponent(
                                    iconData: Icons.edit,
                                    borderColor:
                                    ColorConstants.transparent,
                                    backgroundColor:
                                    ColorConstants.transparent,
                                    iconColor: ColorConstants.lightGray
                                        .withOpacity(0.5),
                                    iconSize: 16,
                                    circleSize: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  // This bool value toggles the switch.
                  value: switchValue,
                  activeColor: ColorConstants.white,
                  activeTrackColor: themeCubit.primaryColor,
                  onChanged: onSwitchChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
