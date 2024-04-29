import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../globals.dart';
import '../constants/firebase_constants.dart';
import '../constants/route_constants.dart';

class AgoraCalling extends StatefulWidget {
  const AgoraCalling(
      {Key? key,
      required this.recipientUid,
      this.callerName,
      this.callerNumber,
      this.callId,
      this.callerImage,
      this.contactUserFcm})
      : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;
  final String? callId;
  final String? callerImage;
  final String? contactUserFcm;

  @override
  State<AgoraCalling> createState() => _AgoraCallingState();
}

class _AgoraCallingState extends State<AgoraCalling> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  bool speaker = false;
  DateTime? _callStartTime;
  Timer? _timer;
  Duration? callDuration;
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;
  String image = "";

  @override
  void initState() {
    super.initState();
    initAgora();
    _listenForCallStatusChanges();
  }

  void _listenForCallStatusChanges() {
    _callStatusSubscription = FirebaseUtils.firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(widget.callId!)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists && snapshot['is_call_active'] == false) {
        if (mounted) {
          _callStatusSubscription
              ?.cancel(); // Check if the widget is still mounted
          _dispose();
        } // Leave the channel if is_call_active is false
      }
    });
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
            if (_remoteUid != null && _timer == null) {
              _callStartTime =
                  DateTime.now(); // Start the timer when the remote user joins
              _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
                setState(() {
                  callDuration = DateTime.now().difference(_callStartTime!);
                });
              });
            }
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
    await _engine.disableVideo();
    await _engine.setDefaultAudioRouteToSpeakerphone(false);

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
    _timer?.cancel();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onToggleSpeaker() {
    setState(() {
      speaker = !speaker;
    });
    _engine.setEnableSpeakerphone(speaker);
  }

  Future<void> _dispose() async {
    Duration duration =
        DateTime.now().difference(_callStartTime ?? DateTime.now());
    String formattedDuration =
        "${duration.inMinutes}:${duration.inSeconds % 60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration, false,
        widget.callId!, FirebaseUtils.getDateTimeNowAsId());
    Map<String, dynamic> data = {
      "messageType": "missed-call",
      "callId": callId,
      "callerName": FirebaseUtils.user?.firstName,
      "callerNumber": FirebaseUtils.user?.phoneNumber,
    };

    if (mounted) {
      await _engine.leaveChannel();
      await _engine.release();
      NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
    }
  }

  Future<void> _disposeEndCall() async {
    Duration duration =
        DateTime.now().difference(_callStartTime ?? DateTime.now());
    String formattedDuration =
        "${duration.inMinutes}:${duration.inSeconds % 60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration, false,
        widget.callId!, FirebaseUtils.getDateTimeNowAsId());
    Map<String, dynamic> data = {
      "messageType": "missed-call",
      "callId": callId,
      "callerName": FirebaseUtils.user?.firstName,
      "callerNumber": FirebaseUtils.user?.phoneNumber,
    };
    if (_remoteUid == null) {
      FirebaseNotificationUtils.sendFCM(widget.contactUserFcm!, "Missed Call",
          "You have a call request", data);
    }

    if (mounted) {
      await _engine.leaveChannel();
      await _engine.release();
      NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: IconButton(
                  onPressed: () => _disposeEndCall(),
                  icon: const Icon(
                    Icons.call_end,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: RawMaterialButton(
                  onPressed: _onToggleSpeaker,
                  child: Icon(
                    speaker ? Icons.volume_up : Icons.volume_down,
                    color: speaker ? Colors.white : Colors.white,
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
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              widget.callerName ?? widget.callerNumber!,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatDuration(callDuration ?? Duration.zero),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              height: 70,
            ),
            ProfileImageComponent(
              url: widget.callerImage,
              size: 150,
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 40,
          ),
          ProfileImageComponent(
            url: widget.callerImage,
            size: 150,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            widget.callerName ?? widget.callerNumber!,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Ringing',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }
}
