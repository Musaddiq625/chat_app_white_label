import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/asset_constants.dart';
import '../utils/theme_cubit/theme_cubit.dart';

class InfoSheetComponent extends StatefulWidget {
  final heading;
  final body;
  final image;
  final bool svg;

  const InfoSheetComponent(
      {super.key, this.heading, this.body, this.image, this.svg = false});

  @override
  State<InfoSheetComponent> createState() => _InfoSheetComponentState();
}

class _InfoSheetComponentState extends State<InfoSheetComponent> {
  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Container(
      width: AppConstants.responsiveWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: themeCubit.darkBackgroundColor,
      ),
      child: Column(
        children: [
          SizedBoxConstants.sizedBoxThirtyH(),
          if (widget.image != null)
            widget.svg
                ? SvgPicture.asset(
                    // height: 25.55,
                    widget.image,
                    height: 100,
                  )
                : Image.asset(
                    // AssetConstants.group,
                    widget.image!,
                    width: 100,
                    height: 100,
                  ),
          SizedBoxConstants.sizedBoxTwentyH(),
          Container(
            width: AppConstants.responsiveWidth(context, percentage: 70),
            child: TextComponent(
              widget.heading,
              style: FontStylesConstants.style24(color: CupertinoColors.white),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          if (widget.body != null) SizedBoxConstants.sizedBoxTwentyH(),
          Container(
            width: 300,
            child: TextComponent(
              widget.body ?? "",
              style: TextStyle(fontSize: 15, color: themeCubit.textColor),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          SizedBoxConstants.sizedBoxThirtyH()
        ],
      ),
    );
  }
}
