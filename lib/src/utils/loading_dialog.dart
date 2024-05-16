import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/string_constants.dart';
import 'navigation_util.dart';

class LoadingDialog {
  static Future showLoadingDialog(BuildContext context) async {
    bool forceFullyBackEnable = kDebugMode;
    await showDialog(
      context: context,
      barrierDismissible: forceFullyBackEnable,
      builder: (_) => WillPopScope(
        onWillPop: () async => forceFullyBackEnable,
        child: GestureDetector(
          onTap: () {
            if (forceFullyBackEnable) {
              NavigationUtil.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.grey.withOpacity(.3),
            // backgroundColor: Colors.transparent,
            // backgroundColor: ColorConstants.white.withOpacity(ColorConstants.btnOpacity2),
            body: const Center(
              child: SizedBox(
                  width: 180,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(AssetConstants.logo)
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.blackLight))
                      // Shimmer.fromColors(
                      //   child: Image.asset(AssetConstants.logo),
                      //   baseColor: ColorConstants.niceBlue,
                      //   highlightColor: ColorConstants.red,
                      // ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
  static Future showProgressLoadingDialog(BuildContext context) async {
    bool forceFullyBackEnable = kDebugMode;
    await showDialog(
      context: context,
      barrierDismissible: forceFullyBackEnable,
      builder: (_) => WillPopScope(
        onWillPop: () async => forceFullyBackEnable,
        child: GestureDetector(
          onTap: () {
            if (forceFullyBackEnable) {
              NavigationUtil.pop(context);
            }
          },
          child: Scaffold(

            // backgroundColor: Colors.grey.withOpacity(.3),
            backgroundColor: Colors.transparent,
            // backgroundColor: ColorConstants.white.withOpacity(ColorConstants.btnOpacity2),
            body: const Center(
              child: SizedBox(
                  width: 180,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(AssetConstants.logo)
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.blackLight))
                      // Shimmer.fromColors(
                      //   child: Image.asset(AssetConstants.logo),
                      //   baseColor: ColorConstants.niceBlue,
                      //   highlightColor: ColorConstants.red,
                      // ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  static hideLoadingDialog(BuildContext context) => Navigator.of(context).pop();

  static circularProgressLoader() => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.grey1),
        ),
      );


  static somethingWentWrongWidget() =>
      const TextComponent(StringConstants.errSomethingWentWrong);
}
