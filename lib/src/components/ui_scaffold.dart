import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/string_utils.dart';
import 'package:flutter/material.dart';
//scaffold use in whole application

class UIScaffold extends StatefulWidget {
  final Widget widget;
  final Widget? bottomSheet;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final bool removeSafeAreaPadding;
  final double appBarHeight;
  final Color? bgColor;
  final String? bgImage;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Widget? floatingActionButton;
  final double toolBarHeight;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? drawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const UIScaffold(
      {Key? key,
      required this.widget,
      this.bottomNavigationBar,
      this.removeSafeAreaPadding = false,
      this.appBarHeight = 60,
      this.bgColor,
      this.resizeToAvoidBottomInset = true,
      this.bgImage,
      this.floatingActionButton,
      this.appBar,
      this.toolBarHeight = kToolbarHeight,
      this.scaffoldKey,
      this.bottomSheet,
      this.drawer,
      this.floatingActionButtonLocation,
      this.extendBody = false})
      : super(key: key);

  @override
  State<UIScaffold> createState() => _UIScaffoldState();
}

class _UIScaffoldState extends State<UIScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: !widget.removeSafeAreaPadding,
      left: !widget.removeSafeAreaPadding,
      bottom: !widget.removeSafeAreaPadding,
      top: !widget.removeSafeAreaPadding,
      child: Container(
        decoration: widget.bgImage != null &&
                StringUtil.getLength(
                      widget.bgImage,
                      length: 8,
                      fromStart: true,
                    ) ==
                    AppConstants.httpsSlash
            ? BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    widget.bgImage!,
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : widget.bgImage == null
                ? BoxDecoration()
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        widget.bgImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
        child: Scaffold(
          drawer: widget.drawer,
          extendBody: widget.extendBody,
          backgroundColor: widget.bgImage == null
              ? widget.bgColor
              : ColorConstants.transparent,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          body: widget.widget,
          key: widget.scaffoldKey,
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          appBar: widget.appBar != null
              ? PreferredSize(
                  preferredSize: Size(
                    double.infinity,
                    widget.toolBarHeight,
                  ),
                  child: widget.appBar!,
                )
              : null,
          bottomSheet: widget.bottomSheet,
        ),
      ),
    );
  }
}
