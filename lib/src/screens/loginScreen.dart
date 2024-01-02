import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/route_constants.dart';
import '../utils/navigation_util.dart';
import 'otpScreen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String selectedCountryCode = '';

  LoginScreen({super.key});

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
                'Enter Your Phone Number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Whatsapp will need to verify your account',
                  style: TextStyle(fontSize: 14)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        _countryCodeController.text =
                            '+${countryCode.dialCode!}';
                        print("country code ${countryCode.dialCode}");
                      },
                      initialSelection: 'pk',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        // Limit to 12 characters
                        FilteringTextInputFormatter.digitsOnly,
                        // Accept only digits
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('International carrier charges may apply',
                  style: TextStyle(fontSize: 14)),
              // SizedBox(height: 50,),
              // TextField(
              //   controller: _controller,
              //   keyboardType: TextInputType.phone,
              //   decoration: const InputDecoration(labelText: "Phone Number"),
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.isEmpty ||
                      _controller.text.length < 10) {
                    Fluttertoast.showToast(
                        msg: "Please enter a valid phone number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  try {
                    await _auth.verifyPhoneNumber(
                      phoneNumber:
                          "${_countryCodeController.text}${_controller.text}",
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        // Sign in with the credential
                        await _auth.signInWithCredential(credential);
                        // Navigate to the home screen (or desired screen)
                        NavigationUtil.push(context, RouteConstants.chatScreen);
                      },
                      verificationFailed: (FirebaseAuthException error) {
                        // Handle error
                        print(
                            "Verification Error ${error}"); // You might want to display an error message to the user
                      },
                      codeSent:
                          (String verificationId, int? forceResendingToken) {
                        // Store verification ID for later use in OTP screen
                        // (Assuming you'll pass it to the OTP screen)
                        // NavigationUtil.push(
                        //     context, RouteConstants.otpScreen,args: verificationId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                      verificationId: verificationId,
                                      phoneNumber:
                                          "${_countryCodeController.text}${_controller.text}",
                                    )));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // Handle timeout
                      },
                    );
                  } catch (error) {
                    // Handle general errors
                    print(
                        error); // You might want to display a general error message to the user
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
