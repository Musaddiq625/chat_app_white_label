import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:flutter/material.dart';
import '../constants/route_constants.dart';
import '../utils/navigation_util.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
          child: Column(
            children: [
              Text(
                "Welcome to WeUno",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(AssetConstants.logo),
              SizedBox(
                height: 100,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Read our ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15), // Change the color here
                    ),
                    TextSpan(
                      text: 'Privacy Policy. ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15), // Change the color here
                    ),
                    TextSpan(
                      text: 'Tap "Agree and continue" to \n accept the ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15), // Change the color here
                    ),
                    TextSpan(
                      text: 'Terms of Service.',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15), // Change the color here
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // If the previous line didn't throw an exception, sign-in was successful
                    NavigationUtil.push(context, RouteConstants.loginScreen);
                  } catch (e) {
                    // Sign-in failed, handle the exception
                    print(e);
                  }
                },
                child: Text("AGREE AND CONTINUE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
