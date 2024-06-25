import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullImageView extends StatefulWidget {
  String url;
   FullImageView({super.key,required this.url});

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      bgColor: ColorConstants.black,
        appBar: AppBarComponent(""),
        widget: Container(
alignment: Alignment.center,
      child: Image.network(
        widget.url,
        fit: BoxFit.cover,
        width: double.infinity,
        // height:
      ),
    ));
  }
}
