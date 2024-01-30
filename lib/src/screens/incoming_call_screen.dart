import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

import '../../main.dart';
import 'agora_calling.dart';

class IncomingCallScreen extends StatefulWidget {
   IncomingCallScreen({super.key,required this.callerName,required this.callerNumber, required this.currentUid});
  String callerName;
  String callerNumber;
  String currentUid;

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the user from leaving the screen by pressing the back button
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_in_talk,
                color: Colors.green,
                size: 120,
              ),
              SizedBox(height: 20),
              Text(
                widget.callerName,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                widget.callerNumber,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) =>
                              AgoraCalling(recipientUid: int.parse(widget.callerNumber,))));
                      // Accept the call
                      // Navigate to the call screen
                    },
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await FlutterCallkitIncoming.endCall(widget.currentUid);
                      NavigationUtil.pop(context);
                      // Decline the call
                      // End the call
                    },
                    child: Text('Decline'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}