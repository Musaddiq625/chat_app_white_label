import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonComponent extends StatelessWidget {
  final String? image;
  final Function()? onTap;
  final Color bgColor;
  final bool isImage;
  final bool isIcon;
  final IconData icon;
  final bool enableDark;
  final double? overrideSize;
  final bool? isCircular;

  const BackButtonComponent({
    Key? key,
    this.bgColor = ColorConstants.blackLight,
    this.image,
    this.isCircular = false,
    this.onTap,
    this.isImage = false,
    this.isIcon = false,
    this.icon = Icons.add,
    this.enableDark = false,
    this.overrideSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = overrideSize ?? 30;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorConstants.transparent,
        child: AbsorbPointer(
          child: Padding(
            padding: EdgeInsets.only(left: 4, right: 10),
            child: isCircular == true
                ? Container(
                    height: size,
                    width: size,
                    // padding: const EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: enableDark
                          ? ThemeCubit().darkBackgroundColor
                          : bgColor,
                    ),
                    child: isIcon
                        ? Icon(
                            icon,
                            size: 50,
                            color: enableDark
                                ? bgColor
                                : ThemeCubit().secondaryColor,
                          )
                        : isImage
                            ? ClipRRect(child: Image.asset(image!))
                            : SvgPicture.asset(
                                image!,
                                color: enableDark
                                    ? bgColor
                                    : ColorConstants.primaryColor,
                              ),
                  )
                : isIcon
                    ? Icon(
                        icon,
                        size: 50,
                      )
                    : isImage
                        ? Image.asset(image!)
                        : SvgPicture.asset(
                            image!,
                          ),
          ),
        ),
      ),
    );
  }
}
