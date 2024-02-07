import 'dart:async';
import 'package:chat_app_white_label/src/components/custom_text_field.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';

class OTPScreen extends StatefulWidget {
  final OtpScreenArg otpScreenArg;

  const OTPScreen({
    super.key,
    required this.otpScreenArg,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();

  bool _isOtpValid = false;
  Timer? _timer;
  int _counter = 60;

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

  @override
  Widget build(BuildContext context) {
    late OTPCubit otpCubit;
    return BlocConsumer<OTPCubit, OTPState>(
      listener: (context, state) async {
        LoggerUtil.logs('login state: $state');
        if (state is OTPLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        } else if (state is OTPSuccessNewUserState) {
          if (state.fcmToken != null) {
            await FirebaseUtils.addFcmToken(state.phoneNumber, state.fcmToken!);
          }
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.push(context, RouteConstants.profileScreen,
              args: state.phoneNumber);
        } else if (state is OTPSuccessOldUserState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
        } else if (state is OTPFailureState) {
          LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.error.toString(), context: context);
        } else if (state is OTPCancleState) {
          LoadingDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        otpCubit = context.read<OTPCubit>();
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 50, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Verify ${widget.otpScreenArg.phoneNumber}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Waiting to automatically detect an SMS sent to  \n  ${widget.otpScreenArg.phoneNumber} ',
                          style: const TextStyle(
                              color: Colors.black), // Change the color here
                        ),
                        const TextSpan(
                          text: 'WrongNumber ?',
                          style: TextStyle(
                              color: Colors.blue), // Change the color here
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text('Enter 6-digit code',
                      style: TextStyle(fontSize: 14)),
                  const Text('You may request a new code in ',
                      style: TextStyle(fontSize: 14)),
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: CustomTextField(
                      hintText: 'Enter OTP',
                      onChanged: (String value) {
                        setState(() {
                          _isOtpValid =
                              value.length == 6 && value.trim().isNotEmpty;
                        });
                      },
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Didnt receive code?  ${_counter > 0 ? _counter : ""}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  _isOtpValid
                      ? ElevatedButton(
                          onPressed: () async {
                            if (otpController.text.isEmpty ||
                                otpController.text.length != 6) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid 6 digit OTP",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                            otpCubit.otpUser(
                              widget.otpScreenArg.verificationId,
                              otpController.text,
                              widget.otpScreenArg.phoneNumber,
                            );
                          },
                          child: const Text("Verify OTP"),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OtpScreenArg {
  final String verificationId;
  final String phoneNumber;
  final String phoneCode;

  OtpScreenArg(
    this.verificationId,
    this.phoneNumber,
    this.phoneCode,
  );
}
