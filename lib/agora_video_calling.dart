import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'globals.dart';

// class AgoraCalling extends StatefulWidget with WidgetsBindingObserver {
class AgoraVideoCalling extends StatefulWidget {
  const AgoraVideoCalling(
      {Key? key,
      required this.recipientUid,
      this.callerName,
      this.callerNumber,
      this.callId,
      this.contactUserFcm})
      : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;
  final String? callId;
  final String? contactUserFcm;

  @override
  State<AgoraVideoCalling> createState() => _AgoraVideoCallingState();
}

class _AgoraVideoCallingState extends State<AgoraVideoCalling> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  DateTime? _callStartTime;
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;

  @override
  void initState() {
    super.initState();
    _callStartTime = DateTime.now();
    initAgora();
    _listenForCallStatusChanges();
  }

  Future<void> initAgora() async {
    print("recipetent Uid ${widget.recipientUid}");
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
          _dispose();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: widget.recipientUid,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _listenForCallStatusChanges() {
    _callStatusSubscription = FirebaseUtils.firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(widget.callId!)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      try {
        if (snapshot.exists && snapshot['is_call_active'] != null) {
          if (snapshot.exists && snapshot['is_call_active'] == false) {
            if (mounted) {
              _callStatusSubscription
                  ?.cancel(); // Check if the widget is still mounted
              _dispose();
            } // Leave the channel if is_call_active is false
          }
        }
      } catch (e) {
        print("error _listenForCallStatusChanges $e");
      }
    });
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  Future<void> _dispose() async {
    try {
      Duration duration = DateTime.now().difference(_callStartTime!);
      String formattedDuration =
          "${duration.inMinutes}:${duration.inSeconds % 60}";
      await FirebaseUtils.updateCallsDuration(formattedDuration, false,
          widget.callId!, FirebaseUtils.getDateTimeNowAsId());

      if (mounted) {
        await _engine.leaveChannel();
        await _engine.release();
        NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
      }
    } catch (e) {
      print("Error on dispose $e");
    }
  }

  Future<void> _disposeEndCall() async {
    try {
      Duration duration = DateTime.now().difference(_callStartTime!);
      String formattedDuration =
          "${duration.inMinutes}:${duration.inSeconds % 60}";
      await FirebaseUtils.updateCallsDuration(formattedDuration, false,
          widget.callId!, FirebaseUtils.getDateTimeNowAsId());
      Map<String, dynamic> data = {
        "messageType": "missed-video-call",
        "callId": callId,
        "callerName": FirebaseUtils.user?.name,
        "callerNumber": FirebaseUtils.user?.phoneNumber,
      };
      if (_remoteUid == null) {
        FirebaseNotificationUtils.sendFCM(widget.contactUserFcm!,
            "Missed Video Call", "You have a Video call request", data);
      }
      if (mounted) {
        await _engine.leaveChannel();
        await _engine.release();
        NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
      }
    } catch (e) {
      print("Error on dispose $e");
    }
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.callerName ?? "Video Call"),
      // ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: IconButton(
                  onPressed: () => _dispose(),
                  icon: const Icon(
                    Icons.call_end,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.white,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted
                      ? ColorConstants.greenMain
                      : ColorConstants.greenMain,
                  padding: const EdgeInsets.all(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Stack(children: [
        AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: const RtcConnection(channelId: channel),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0, right: 15),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ]);
    } else {
      return Container(
        child: Stack(
          alignment: Alignment.center, // Aligns the children at the center
          children: [
            Center(
              child: _localUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
            // Add your text widget here
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.callerName ?? "",
                  style: TextStyle(
                    fontSize: 24,
                    // Adjust the font size as needed
                    color: _localUserJoined
                        ? Colors.white
                        : Colors.black, // Change the color as needed
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1040.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Ringing",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black54), // Change the color as needed
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
