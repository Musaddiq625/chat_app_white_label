import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/components/image_widgets.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageComponent extends StatelessWidget {
  final String imgUrl;
  final String imgError;
  final String imgPlaceHolder;
  final double width;
  final double height;
  final bool isNetwork;
  final Function(ImageProvider<Object> imgProvider) imgProviderCallback;

  const ImageComponent(
      {Key? key,
      required this.imgUrl,
      required this.imgProviderCallback,
      this.imgPlaceHolder = AssetConstants.logo,
      this.height = 20,
      this.width = 20,
      this.imgError = AssetConstants.logo,
      this.isNetwork = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return SizedBox(
        height: height,
        width: width,
        child: imgUrl.split('.').last == 'svg'
            ? ImageWidgets.svgComponent(
                imgUrl,
                height: height,
                width: width,
                isNetwork: isNetwork,
              )
            : isNetwork == true
                ? CachedNetworkImage(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    imageUrl: imgUrl,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: themeCubit.primaryColor,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child:
                              SvgPicture.asset(imgError, fit: BoxFit.contain),
                        )),
                    imageBuilder: (context, imageProvider) =>
                        imgProviderCallback(imageProvider))
                : Image.asset(
                    imgUrl,
                    height: height,
                    width: width,
                    alignment: Alignment.center,
                  ));
  }
}
