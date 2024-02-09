import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../constants/firebase_constants.dart';

  class AgoraGroupCalling extends StatefulWidget {
  const AgoraGroupCalling({Key? key, required this.recipientUid, this.callerName, this.callerNumber,this.callId}) : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;
  final String? callId;

  @override
  State<AgoraGroupCalling> createState() => _AgoraGroupCallingState();
}

class _AgoraGroupCallingState extends State<AgoraGroupCalling> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  bool speaker = false;
  DateTime? _callStartTime;
  late Duration callDuration;
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;


  @override
  void initState() {
    super.initState();
    initAgora();
    _callStartTime = DateTime.now();
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
          _callStatusSubscription?.cancel();// Check if the widget is still mounted
          _dispose();
        }
      }
    });
  }

  Future<void> initAgora() async {

    print("recipetent Uid ${widget.recipientUid}");
    await [Permission.microphone, Permission.camera].request();

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

    Duration duration = DateTime.now().difference(_callStartTime!);
    String formattedDuration = "${duration.inMinutes}:${duration.inSeconds %  60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration,false,widget.callId!,FirebaseUtils.getDateTimeNowAsId());

    if(mounted){
      await _engine.leaveChannel();
      await _engine.release();
      NavigationUtil.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.callerName ?? "Video Call"),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
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
          Align(alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                  onPressed: () => _dispose(),
                  icon: const Icon(
                    Icons.call_end,
                    size: 20,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RawMaterialButton(
              onPressed: _onToggleSpeaker,
              child: Icon(
                speaker ? Icons.music_note : Icons.music_off,
                color: speaker ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: speaker ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text(widget.callerName ?? "Unkown"),
            SizedBox(height: 20,),
            Text(widget.callerNumber ?? "Group Call")
          ],
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
