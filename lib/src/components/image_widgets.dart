import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidgets {
  static SvgPicture svgComponent(String svgImage,
      {bool removeColor = false,
      double height = 25,
      double width = 25,
      Color? color,
      bool isNetwork = false}) {
    return isNetwork
        ? SvgPicture.network(
            svgImage,
            height: height,
            width: width,
          )
        : SvgPicture.asset(
            svgImage,
            height: height,
            width: width,
          );
  }

  static Image imageAssetComponent(
    String image, {
    Color? color,
    double height = 25,
    double? width,
  }) {
    return Image.asset(
      image,
      height: height,
      width: width,
    );
  }
}
