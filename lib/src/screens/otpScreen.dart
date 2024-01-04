import 'dart:async';

import 'package:chat_app_white_label/src/components/custom_text_field.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/screens/profile_screen.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';

import '../constants/route_constants.dart';
import '../utils/navigation_util.dart';
import 'chat_screen.dart';

class OTPScreen extends StatefulWidget {
  final String? verificationId;
  final String? phoneNumber;
  final String? phoneCode;

  OTPScreen({this.verificationId, this.phoneNumber, this.phoneCode});

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
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify ${widget.phoneNumber}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              // Text('Waiting to automatically detect an SMS sent to \n          ${widget.phoneNumber} WrongNumber ?',style: TextStyle(fontSize: 14)),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Waiting to automatically detect an SMS sent to  \n  ${widget.phoneNumber} ',
                      style: TextStyle(
                          color: Colors.black), // Change the color here
                    ),
                    TextSpan(
                      text: 'WrongNumber ?',
                      style: TextStyle(
                          color: Colors.blue), // Change the color here
                    ),
                  ],
                ),
              ),
              // Text('OTP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(
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
              SizedBox(
                height: 20,
              ),
              Text('Enter 6-digit code', style: TextStyle(fontSize: 14)),
              Text('You may request a new code in ',
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
              SizedBox(
                height: 20,
              ),
              Text('Didnt receive code?  ${_counter > 0 ? _counter : ""}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(
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
                        try {
                          auth.signInWithCredential(
                            PhoneAuthProvider.credential(
                              verificationId: widget.verificationId!,
                              smsCode: otpController.toString(),
                            ),
                          );
                          final usersCollection = firestore.collection(FirebaseConstants.users);
                          final userDocs = await usersCollection.get();

                          bool userExists = false;
                          for (var doc in userDocs.docs) {
                            if (doc.id == widget.phoneNumber?.replaceAll('+', '')) {
                              userExists = true;
                              break;
                            }
                          }

                          final user = auth.currentUser;
                          print("UserId = ${user?.uid}");
                          // final userDoc = await FirebaseFirestore.instance
                          //     .collection('users')
                          //     .doc(user?.uid)
                          //     .get();
                          if (userExists) {

                            // User exists, navigate to profile screen
                            // NavigationUtil.push(context, RouteConstants.chatScreen);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      phoneNumber: widget.phoneNumber?.replaceAll('+', ''),
                                    )));
                          } else {
                            print("UserIds = ${user?.uid}");
                            // User does not exist, create a new user document in Firestore
                            await firestore.collection('users').doc(widget.phoneNumber?.replaceAll('+', '')).set({
                              'id': widget.phoneNumber?.replaceAll('+', ''),
                              'phoneNumber': widget.phoneNumber,
                              'is_profile_complete': false,
                            });
                            // Navigate to chat screen
                          //  NavigationUtil.push(context, RouteConstants.profileScreen,args:widget.phoneNumber);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                        phoneNumber: widget.phoneNumber,
                                    )));
                          }
                        } catch (e) {
                          // Sign-in failed, handle the exception
                          print(e);
                        }
                      },
                      child: Text("Verify OTP"),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
