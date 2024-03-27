import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/asset_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';

class InfoSheetComponent extends StatefulWidget {
  final heading;
  final body;
  final image;

  const InfoSheetComponent({super.key, this.heading, this.body, this.image});

  @override
  State<InfoSheetComponent> createState() => _InfoSheetComponentState();
}

class _InfoSheetComponentState extends State<InfoSheetComponent> {
  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
            width: double.infinity,
          ),
          if (widget.image != null)
            Image.asset(
              // AssetConstants.group,
              widget.image,
              width: 150,
              height: 150,
            ),
          Container(
            width: 300,
            child: TextComponent(
              widget.heading,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: FontConstants.fontProtestStrike,
                  color: themeCubit.textColor),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            child: TextComponent(
              widget.body ?? "",
              style: TextStyle(fontSize: 15, color: themeCubit.textColor),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
