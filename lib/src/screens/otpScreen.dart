import 'dart:async';

import 'package:chat_app_white_label/src/components/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../constants/route_constants.dart';
import '../utils/navigation_util.dart';

class OTPScreen extends StatefulWidget {
  final String? verificationId;
  final String? phoneNumber;


  OTPScreen({this.verificationId, this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _controller = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  final _auth = FirebaseAuth.instance;
  bool _isOtpValid = false;
  Timer? _timer;
  int _counter = 60;


  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 50,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Verify  ${widget.phoneNumber}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              // Text('Waiting to automatically detect an SMS sent to \n          ${widget.phoneNumber} WrongNumber ?',style: TextStyle(fontSize: 14)),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Waiting to automatically detect an SMS sent to  \n  ${widget.phoneNumber} ',
                  style: TextStyle(color: Colors.black), // Change the color here
                ),
                TextSpan(
                  text: 'WrongNumber ?',
                  style: TextStyle(color: Colors.blue), // Change the color here
                ),
              ],
            ),
          ),
              // Text('OTP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              Text('Enter 6-digit code',style: TextStyle(fontSize: 14)),
              Text('You may request a new code in ',style: TextStyle(fontSize: 14)),
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
              SizedBox(height: 20,),
              Text('Didnt receive code?  ${_counter > 0 ? _counter : ""}',style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold)),
              SizedBox(height: 30,),
              _isOtpValid?
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.isEmpty || _controller.text.length != 6) {
                    Fluttertoast.showToast(
                        msg: "Please enter a valid 6 digit OTP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    return;
                  }
                  try {
                  _auth.signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: widget.verificationId!,
                        smsCode: otpController.toString(),
                      ),
                    );
                    // If the previous line didn't throw an exception, sign-in was successful
                    NavigationUtil.push(context, RouteConstants.chatScreen);
                  } catch (e) {
                    // Sign-in failed, handle the exception
                    print(e);
                  }
                },
                child: Text("Verify OTP"),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }


}
