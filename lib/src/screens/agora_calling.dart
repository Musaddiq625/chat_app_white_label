import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';

// class AgoraCalling extends StatefulWidget with WidgetsBindingObserver {
  class AgoraCalling extends StatefulWidget {
  const AgoraCalling({Key? key, required this.recipientUid, this.callerName, this.callerNumber}) : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;

  @override
  State<AgoraCalling> createState() => _AgoraCallingState();
}

// class _AgoraCallingState extends State<AgoraCalling>  with WidgetsBindingObserver {
//
//   // final int recipientUid;
//   bool muted = false;
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//     print("widget.recipientUid - 0  ${widget.recipientUid}");
//   }
//
//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera,Permission.audio].request();
//
//     //create the engine
//     _engine = createAgoraRtcEngine();
//     try {
//       await _engine.initialize(const RtcEngineContext(
//         appId: appId,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//       ));
//     } catch (e) {
//       print('Error initializing engine: $e');
//     }
//
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           print("onJoinChannelSuccess called");
//           print("local user ${connection.localUid} joined");
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           print("remote user $remoteUid joined");
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           print("remote user $remoteUid left channel");
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );
//
//     print("widget.recipientUid - 1  ${widget.recipientUid}");
//
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     // await _engine.setEnableSpeakerphone(true);
//     await _engine.enableLocalAudio(true);
//     await _engine.enableAudio();
//     await _engine.enableVideo();
//     // await _engine.disableVideo();
//
//     await _engine.startPreview();
//
//     await _engine.joinChannel(
//       token: token,
//       channelId: channel,
//       uid: widget.recipientUid,
//       options: ChannelMediaOptions(),
//     );
//     print("widget.recipientUid - 2  ${widget.recipientUid}");
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     switch (state) {
//       case AppLifecycleState.resumed:
//         _engine.joinChannel(
//           token: token,
//           channelId: channel,
//           uid: widget.recipientUid,
//           options: ChannelMediaOptions(),
//         );
//         break;
//       case AppLifecycleState.paused:
//         _engine.leaveChannel();
//         break;
//       default:
//       // Handle other events as needed
//         break;
//     // Other cases can be handled as needed
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     _dispose();
//   }
//
//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }
//
//
//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//
//           // Center(
//           //   child: const Text('Voice call in progress...'),
//           // ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SizedBox(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? AgoraVideoView(
//                   controller: VideoViewController(
//                     rtcEngine: _engine,
//                     canvas:  VideoCanvas(uid:0),
//                   ),
//                 )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//           ),
//           Align(
//
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: _endCall,
//                 child: const Text('End Call'),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: RawMaterialButton(
//               onPressed: _onToggleMute,
//               child: Icon(
//                 muted ? Icons.mic_off : Icons.mic,
//                 color: muted ? Colors.white : Colors.blueAccent,
//                 size: 20.0,
//               ),
//               shape: CircleBorder(),
//               elevation: 2.0,
//               fillColor: muted ? Colors.blueAccent : Colors.white,
//               padding: const EdgeInsets.all(12.0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _endCall() async {
//     // Implement the logic to end the call
//     await _engine.leaveChannel();
//     setState(() {
//       _localUserJoined = false;
//       _remoteUid = null;
//     });
//     NavigationUtil.pop(context);
//   }
//
//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: const RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }

class _AgoraCallingState extends State<AgoraCalling> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  bool speaker = false;

  @override
  void initState() {
    super.initState();
    initAgora();
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
        // onStreamMessage: (RtcConnection connection, int remoteUid, int streamId, Uint8List data, int length, int sentTs) {
        //   String message = String.fromCharCodes(data); // Convert Uint8List to String
        //   if (message == "callEnded") {
        //     _dispose();
        //   }
        // },
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
    // await _engine.enableVideo();
    await _engine.disableVideo();
    // await _engine.enableAudio();
    // await _engine.disableAudio();
    await _engine.setDefaultAudioRouteToSpeakerphone(false);
    // await _engine.startPreview();

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

    // _dispose();
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
    // await _engine.sendStreamMessage(
    //   streamId: widget.recipientUid,
    //   data: Uint8List.fromList('callEnded'.codeUnits),
    //   length: 0,
    // );
    await _engine.leaveChannel();
    await _engine.release();
    NavigationUtil.pop(context);
  }

  // Create UI with local view and remote view
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

  // Display remote user's video
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
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text(widget.callerName ?? "Unkown"),
            SizedBox(height: 20,),
            Text(widget.callerNumber ?? "xxxxxxxxx")
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
