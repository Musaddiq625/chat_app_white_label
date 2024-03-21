import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';
import 'icon_component.dart';

class CreateEventTileComponent extends StatelessWidget {
  final icon;
  final iconText;
  final subText;
  final Function()? onTap;
  const CreateEventTileComponent({super.key, this.icon, this.iconText, this.subText, this.onTap,});

  @override
  Widget build(BuildContext context) {
    late final themeCubit= BlocProvider.of<ThemeCubit>(context);
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: themeCubit.darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: IconComponent(
                      iconData: icon,
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.transparent,
                      circleSize: 25,
                      iconSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextComponent(
                      iconText,
                    style: TextStyle(fontSize: 15,color: themeCubit.textColor),
                  ),
                  Spacer(),
                  TextComponent(
                    subText,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold,color: themeCubit.textColor),
                  ),
                  IconComponent(
                    iconData: Icons.arrow_forward_ios,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    circleSize: 20,
                    iconSize: 20,
                    iconColor: ColorConstants.lightGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}



