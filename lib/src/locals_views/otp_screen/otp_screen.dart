import 'dart:async';

import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/locals_views/otp_screen/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/custom_text_field.dart';
import '../../components/toast_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class OtpScreen extends StatefulWidget {
  final OtpArg? otpArg;

  const OtpScreen({super.key, this.otpArg});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  bool _isOtpValid = false;
  Timer? _timer;
  int _counter = 15;

  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OTPCubit, OTPState>(listener: (context, state) async {
      LoggerUtil.logs('login state: $state');
      if (state is OTPLoadingState) {
        LoadingDialog.showLoadingDialog(context);
      } else if (state is OTPSuccessNewUserState) {
        if (state.fcmToken != null) {
          await FirebaseUtils.addFcmToken(state.phoneNumber, state.fcmToken!);
        }
        LoadingDialog.hideLoadingDialog(context);
        NavigationUtil.push(context, RouteConstants.signUpEmail,
            args: state.phoneNumber);
      } else if (state is OtpSuccessResendState) {
        LoadingDialog.hideLoadingDialog(context);
        setState(() {
          _counter = 15; // Reset the counter
          startTimer(); // Restart the timer
        });
      } else if (state is OTPSuccessOldUserState) {
        NavigationUtil.popAllAndPush(context, RouteConstants.homeScreenLocal);
      } else if (state is OTPFailureState) {
        LoadingDialog.hideLoadingDialog(context);
        // ToastComponent.showToast(state.error.toString(), context: context);
        ToastComponent.showToast("Invalid Otp", context: context);
      } else if (state is OTPCancleState) {
        LoadingDialog.hideLoadingDialog(context);
      }
    }, builder: (context, state) {
      return UIScaffold(
          appBar: const AppBarComponent(""),
          removeSafeAreaPadding: false,
          bgColor: themeCubit.backgroundColor,
          widget: enterOtp());
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Widget enterOtp() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //   onTap:()=> NavigationUtil.pop(context),
              //   child: IconComponent(
              //     iconData: Icons.arrow_back_ios_new_outlined,
              //     borderColor: Colors.transparent,
              //     backgroundColor: ColorConstants.iconBg,
              //     iconColor: Colors.white,
              //     circleSize: 30,
              //     iconSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              TextComponent(
                StringConstants.enterTheVerificationCode,
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 120,
                    alignment: Alignment.center,
                    child: CustomTextField(
                      hintText: '000000',
                      hintStyle: const TextStyle(
                          color: ColorConstants.lightGray,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 30),
                      onChanged: (String value) {
                        setState(() {
                          _isOtpValid =
                              value.length == 6 && value.trim().isNotEmpty;
                        });
                      },
                      style: const TextStyle(
                          color: ColorConstants.white,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 30),
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (_counter > 0)
                TextComponent(
                    '${StringConstants.didntReciveCode} ${_counter > 0 ? StringUtil.getFormattedTime(_counter.toString()) : ""}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.lightGray)),
              if (_counter <= 0)
                TextComponent(StringConstants.resendCode,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: themeCubit.primaryColor,
                        decorationThickness: 3,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeCubit.primaryColor)),

              const SizedBox(
                height: 20,
              ),
              // Spacer(),
            ],
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: _isOtpValid
                    ? themeCubit.primaryColor
                    : ColorConstants.lightGray.withOpacity(0.2),
                textColor: _isOtpValid
                    ? themeCubit.backgroundColor
                    : ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressedFunction: () {
                  if (widget.otpArg?.type == "number") {
                    NavigationUtil.push(context, RouteConstants.signUpEmail,
                        args: "number");
                  } else if (widget.otpArg?.type == "email") {
                    NavigationUtil.push(context, RouteConstants.signUpNumber);
                  } else if (widget.otpArg?.type == "afterEmail") {
                    NavigationUtil.push(context, RouteConstants.nameScreen,
                        args: "OnBoarding");
                  } else if (widget.otpArg?.type == "setPasswordBeforeNumber") {
                    NavigationUtil.push(context, RouteConstants.passwordScreen,
                        args: "phoneNumber");
                  } else if (widget.otpArg?.type == "setPasswordAfterNumber") {
                    NavigationUtil.push(context, RouteConstants.passwordScreen,
                        args: "OnBoarding");
                  }
                }),
          )
        ],
      ),
    );
  }
}

class OtpArg {
  final String verificationId;
  final String phoneNumber;
  final String phoneCode;
  final String type;

  OtpArg(this.verificationId, this.phoneNumber, this.phoneCode, this.type);
}
