import 'dart:async';

import 'package:chat_app_white_label/src/components/custom_text_field.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/screens/otp/cubit/otp_cubit.dart';
import 'package:chat_app_white_label/src/screens/profile_screen.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../constants/route_constants.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../utils/navigation_util.dart';
import '../chat_screen.dart';

class OTPScreen extends StatefulWidget {
  final OtpScreenArg otpScreenArg;

  const OTPScreen({
    super.key,
    required this.otpScreenArg,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _controller = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  // final _auth = FirebaseAuth.instance;
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
  Widget build(BuildContext context) {
    late OTPCubit otpCubit;
    return BlocConsumer<OTPCubit, OTPState>(
      listener: (context, state) async {
        LoggerUtil.logs('login state: $state');
        if (state is OTPLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        }
        else if (state is OTPSuccessNewUserState) {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    phoneNumber:state.phoneNumber,
                  )));
          // log("::::::::::::::::::::::test case ammar");
        }
        else if (state is OTPSuccessOldUserState) {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    phoneNumber: state.phoneNumber.replaceAll('+', ''),
                  )));
          // log("::::::::::::::::::::::test case ammar");
        }
        else if (state is OTPFailureState) {
          LoadingDialog.hideLoadingDialog(context);
          // if (state.error.contains('AuthorizationErrorCode.canceled')) {
          //   ToastComponent.showToast(
          //     context,
          //     'You have cancelled Apple Login',
          //   );
          // } else {
          //   ToastComponent.showToast(context, state.error);
          // }
        }
        else if (state is OTPCancleState) {
          LoadingDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        otpCubit = context.read<OTPCubit>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify ${widget.otpScreenArg.phoneNumber}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              // Text('Waiting to automatically detect an SMS sent to \n          ${widget.otpScreenArgphoneNumber} WrongNumber ?',style: TextStyle(fontSize: 14)),
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
              // Text('OTP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 20,
              ),
              // OTPTextField(
              //     controller: otpController,
              //     length: 6,
              //     width: MediaQuery.of(context).size.width,
              //     textFieldAlignment: MainAxisAlignment.spaceAround,
              //     fieldWidth: 45,
              //     fieldStyle: FieldStyle.box,
              //     outlineBorderRadius: 15,
              //     style: TextStyle(fontSize: 17),
              //     onChanged: (pin) {
              //       print("Changed: " + pin);
              //     },
              //     onCompleted: (pin) {
              //       print("Completed: " + pin);
              //     }),
              const SizedBox(
                height: 20,
              ),
              const Text('Enter 6-digit code', style: TextStyle(fontSize: 14)),
              const Text('You may request a new code in ',
                  style: TextStyle(fontSize: 14)),
              Container(
                width: 150,
                alignment: Alignment.center,
                // child: TextField(
                //   textAlign: TextAlign.center,
                //   controller: _controller,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "Enter OTP"),
                //   onChanged: (value) {
                //     setState(() {
                //       _isOtpValid = value.length == 6 && value.trim().isNotEmpty;
                //     });
                //   },
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(6), // Limit to 12 characters
                //     FilteringTextInputFormatter.digitsOnly, // Accept only digits
                //   ],
                // ),
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
                  controller: _controller,
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
                        if (_controller.text.isEmpty ||
                            _controller.text.length != 6) {
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
                        otpCubit.otpUser( widget.otpScreenArg.verificationId, otpController.toString(), widget.otpScreenArg.phoneNumber, false);
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
