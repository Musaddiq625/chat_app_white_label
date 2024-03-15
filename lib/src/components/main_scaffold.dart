import 'package:chat_app_white_label/src/components/ui_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_constants.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final bool extendBody;
  final Widget? appBar;
  final double? overrideTopPadding;
  final String? overrideBackgroundImage;
  final double? overrideBottomPadding;
  final Widget? drawerWidget;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool removeSafeAreaPadding;
  final bool removeBgImage;
  final Color? bgColor;
  final Color? overrideStatusBarColor;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const MainScaffold({
    Key? key,
    required this.body,
    this.extendBody = true,
    this.drawerWidget,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.removeSafeAreaPadding = false,
    this.resizeToAvoidBottomInset = true,
    this.bgColor,
    this.removeBgImage = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBar,
    this.overrideStatusBarColor,
    this.overrideTopPadding,
    this.overrideBottomPadding,
    this.overrideBackgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: UIDirection.getDirection(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        // Use [SystemUiOverlayStyle.light] for white status bar
        // or [Super(key: key);
        //
        //   @override
        //   Widget build(BuildContext context) {
        //     return AnnotatedRegion<SystemUiOverlayStyle>(
        //       // Use [SystemUiOverlayStyle.light] for white status bar
        //       // or [SystemUiOverlayStyle.dark] for black status bar
        //       // https://stackoverflow.com/a/58132007/1321917
        //       value: SystemUiOverlayStyle.light,
        //       child: SafeArea(
        //         bottom: false,
        //         top: false,
        //         child: Container(ystemUiOverlayStyle.dark] for black status bar
        // https://stackoverflow.com/a/58132007/1321917
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          bottom: false,
          top: false,
          child: Container(
            padding: EdgeInsets.only(
              top: overrideTopPadding ?? MediaQuery.of(context).padding.top,
              bottom: overrideBottomPadding ??
                  MediaQuery.of(context).viewPadding.bottom,
            ),
            decoration:
                const BoxDecoration(color: ColorConstants.backgroundColor),
            child: Scaffold(
              extendBody: extendBody,
              key: key,
              backgroundColor: ColorConstants.transparent,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              drawer: drawerWidget,
              bottomSheet: bottomSheet,
              body: body,
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              appBar: appBar != null
                  ? PreferredSize(
                      preferredSize: const Size(
                        double.infinity,
                        kToolbarHeight,
                      ),
                      child: appBar!,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
