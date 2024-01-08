import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import 'navigation_util.dart';
class LoadingDialog {
  static Future showLoadingDialog(BuildContext context) async {
    bool _forceFullyBackEnable = kDebugMode;
    await showDialog(
      context: context,
      barrierDismissible: _forceFullyBackEnable,
      builder: (_) => WillPopScope(
        onWillPop: () async => _forceFullyBackEnable,
        child: GestureDetector(
          onTap: () {
            if (_forceFullyBackEnable) {
              NavigationUtil.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.grey.withOpacity(.7),
            // backgroundColor: Colors.transparent,
            // backgroundColor: ColorConstants.white.withOpacity(ColorConstants.btnOpacity2),
            body: Center(
              child: SizedBox(
                  width: 180,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Image.asset(AssetConstants.logo)
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange))
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
        ),
      );

  static somethingWentWrongWidget() =>
      const TextComponent(StringConstants.errSomethingWentWrong);

}
