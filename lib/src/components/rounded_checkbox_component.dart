import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RoundedCheckboxComponent extends StatelessWidget {
  final bool isChecked;
  final Function onCheckPressed;

  const RoundedCheckboxComponent({
    this.isChecked = false,
    required this.onCheckPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

    return GestureDetector(
      onTap: () => onCheckPressed(),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: (isChecked
                ? themeCubit.primaryColor
                : themeCubit.darkBackgroundColor),
            shape: BoxShape.circle,
          ),
          child: !isChecked
              ? Container()
              : SvgPicture.asset(
                  AssetConstants.check,
                  fit: BoxFit.none,
                )),
    );
  }
}
