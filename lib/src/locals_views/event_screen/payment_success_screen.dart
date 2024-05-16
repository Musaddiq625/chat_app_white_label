import 'dart:ui';

import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/color_constants.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final PaymentSuccessArg? paymentSuccessArg;
  const PaymentSuccessScreen({super.key,this.paymentSuccessArg});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      // appBar: AppBarComponent(""),
      removeSafeAreaPadding: false,
      bgColor: ColorConstants.backgroundColor,
      widget: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: ImageComponent(
              width: AppConstants.responsiveWidth(context),
              height: AppConstants.responsiveHeight(context),
                imgUrl:
                widget.paymentSuccessArg?.eventImage ?? "",
                imgProviderCallback: (imageProvider) {}),
          ),
          _eventWidget(),
        ],
      ),
    );
  }

  Widget _eventWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.blackLight.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            // color: themeCubit.darkBackgroundColor,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: IconComponent(
                          iconData: Icons.close,
                          borderColor: Colors.transparent,
                          iconColor: themeCubit.textColor,
                          circleSize: 50,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: ColorConstants.white,
                  child: QrImageView(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 150.0,
                  ),
                ),
                SizedBoxConstants.sizedBoxSixteenH(),
                TextComponent(
                  widget.paymentSuccessArg?.eventName ?? "",
                  style: FontStylesConstants.style18(color: ColorConstants.white),
                ),
                SizedBoxConstants.sizedBoxSixteenH(),
                TextComponent(
                  StringConstants.when,
                  style: FontStylesConstants.style14(
                      color: ColorConstants.grey1),
                ),
                SizedBoxConstants.sizedBoxSixteenH(),
                TextComponent(
                  "${DateFormat('d MMM \'at\' hh a').format(DateTime.parse(widget.paymentSuccessArg?.eventStartDate ?? ""))} - ${ DateFormat('d MMM \'at\' hh a').format(DateTime.parse(widget.paymentSuccessArg?.eventEndDate ?? ""))}  ",
                  style: FontStylesConstants.style14(color: ColorConstants.white),
                ),
                SizedBoxConstants.sizedBoxSixteenH(),
                TextComponent(
                  StringConstants.where,
                  style: FontStylesConstants.style14(
                      color: ColorConstants.grey1),
                ),
                SizedBoxConstants.sizedBoxSixteenH(),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: TextComponent(
                    "${ widget.paymentSuccessArg?.eventLocation ?? ""}",
                    style:
                        FontStylesConstants.style14(color: ColorConstants.white),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBoxConstants.sizedBoxEighteenH(),
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorConstants.iconBg.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: themeCubit.darkBackgroundColor,
                  ),
                  child: TextComponent(
                    StringConstants.viewInMap,
                    style: TextStyle(color: ColorConstants.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBoxConstants.sizedBoxSixtyH(),
                Container(
                  width: 250,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorConstants.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    // color: themeCubit.darkBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconComponent(
                        // iconData: Icons.facebook,
                        svgDataCheck: false,
                        svgData: AssetConstants.applePay,
                        // borderColor: Colors.red,
                        backgroundColor: ColorConstants.transparent,
                        iconSize: 100,
                        borderSize: 0,
                        // circleSize: 30,
                        // circleHeight: 30,
                      ),
                      // Icon(
                      //   Icons.apple,
                      //   color: ColorConstants.white,
                      // ),
                      SizedBoxConstants.sizedBoxTenW(),
                      TextComponent(
                        StringConstants.addToAppleWallet,
                        style: TextStyle(color: ColorConstants.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBoxConstants.sizedBoxEighteenH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentSuccessArg {
  final String eventName;
  final String eventStartDate;
  final String eventEndDate;
  final String eventLocation;
  final String eventImage;

  PaymentSuccessArg(this.eventName, this.eventStartDate, this.eventEndDate, this.eventLocation,this.eventImage);
}