import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../components/profile_image_component.dart';
import '../constants/color_constants.dart';

  class AgoraGroupVideoCalling extends StatefulWidget {
  const AgoraGroupVideoCalling({Key? key, required this.recipientUid,  this.callerName,  this.callerNumber, this.callId, this.groupImage ,this.ownNumber}) : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;
  final String? callId;
  final int? ownNumber;
  final String? groupImage;


  @override
  State<AgoraGroupVideoCalling> createState() => _AgoraGroupVideoCallingState();
}

class _AgoraGroupVideoCallingState extends State<AgoraGroupVideoCalling> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  DateTime? _callStartTime;
  StreamSubscription<DocumentSnapshot>? _callStatusSubscription;
  Map<int, AgoraVideoView> _remoteViews = {};
  int remoteUserCount =0;

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

            _remoteViews[remoteUid] = AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: _engine,
                canvas: VideoCanvas(uid: remoteUid),
                connection: const RtcConnection(channelId: channel),
              ),
            );
            remoteUserCount = _remoteViews.length;
          });
        },

        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteViews.remove(remoteUid);
            remoteUserCount--;
          });
          print("user-left _remoteUserNames.length  ${_remoteViews.length } count ${remoteUserCount}");
          if(remoteUserCount < 1){
            _dispose();
          }
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
      uid: 0!,
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
      if (snapshot.exists && snapshot['is_call_active'] == false) {
        if (mounted) {
          _callStatusSubscription?.cancel();// Check if the widget is still mounted
          // _dispose();
        } // Leave the channel if is_call_active is false
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

    Duration duration = DateTime.now().difference(_callStartTime!);
    String formattedDuration = "${duration.inMinutes}:${duration.inSeconds %  60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration,false,widget.callId!,FirebaseUtils.getDateTimeNowAsId());
    if (mounted) {
      await _engine.leaveChannel();
      await _engine.release();
      NavigationUtil.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    int remoteUserCount = _remoteViews.length;

    // Determine the crossAxisCount based on the number of remote users
    int crossAxisCount = remoteUserCount <=  2 ?  1 :  2; // Adjust the number of columns as needed

    return Scaffold(
      // appBar: AppBar(
      //   title:  Text(widget.callerName ?? "Group Video Call"),
      // ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          if (remoteUserCount ==  1)
            Center(
              child: _remoteViews.values.first, // Display the first (and only) remote view
            ),
          if (remoteUserCount >  1)
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              children: _remoteViews.values.toList(),
            ),
          _remoteUid !=null ?
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0,right: 10),
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
          ) : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
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
            padding: const EdgeInsets.only(bottom: 20.0),
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

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      // return AgoraVideoView(
      //   controller: VideoViewController.remote(
      //     rtcEngine: _engine,
      //     canvas: VideoCanvas(uid: _remoteUid),
      //     connection: const RtcConnection(channelId: channel),
      //   ),
      // );
      return Container(
        alignment: Alignment.bottomRight,
        child: Column(
        ),
      );
    } else {
      return Container(
        color: null,
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
            _remoteUid == null ?
            Container(
              color: _localUserJoined? Colors.grey.withOpacity(0.5) : Colors.white,
              // Semi-transparent grey
            ): Container(
              // Semi-transparent grey
            ),
            // Add your text widget here
            Padding(
              padding: const EdgeInsets.only(top:80.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.callerName ?? "",
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size as needed
                    color: _localUserJoined ? Colors.white : Colors.black, // Change the color as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(top: 140.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Waiting for others...",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color:  _localUserJoined ? Colors.white70 : Colors.black54 ), // Change the color as needed
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
