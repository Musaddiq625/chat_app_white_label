import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/utils/firebase_notification_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../globals.dart';
import '../constants/color_constants.dart';
import '../constants/firebase_constants.dart';
import '../models/contacts_model.dart';
import '../models/usert_model.dart';

class AgoraGroupCalling extends StatefulWidget {
  const AgoraGroupCalling(
      {Key? key,
      required this.recipientUid,
      this.callerName,
      this.callerNumber,
      this.callId,
      this.groupImage,
      this.ownNumber})
      : super(key: key);
  final int recipientUid;
  final String? callerName;
  final String? callerNumber;
  final String? callId;
  final int? ownNumber;
  final String? groupImage;

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
  Map<int, AgoraVideoView> _remoteViews = {};
  Map<int, Map<String, dynamic>> _remoteUserNames = {};
  Map<int, String> _remoteUserImages = {};
  List<ContactModel> contactToDisplay = [];
  List<Contact> localContacts = [];
  UserModel? userData;
  Set<String> processedNumbers = {};
  int remoteUserCount = 0;

  @override
  void initState() {
    super.initState();

    print("call ids ${widget.callId}");
    initAgora();
    _callStartTime = DateTime.now();
    _listenForCallStatusChanges();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      localContacts = await ContactsService.getContacts(withThumbnails: false);
    });
  }

  void _listenForCallStatusChanges() {
    _callStatusSubscription = FirebaseUtils.firebaseService.firestore
        .collection(FirebaseConstants.calls)
        .doc(widget.callId!)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (mounted) {
        print("_remoteUserNames-count ${remoteUserCount}");
        print("user now remove from call");
        if (remoteUserCount < 1) {
          if (snapshot.exists && snapshot['is_call_active'] == false) {
            _callStatusSubscription
                ?.cancel(); // Check if the widget is still mounted
            _dispose();
          }
        }
      }
      // setState(() {
      //   remoteUserCount = _remoteUserNames.length;
      // });
    });
  }

  // void _listenForCallStatusChanges() {
  //   _callStatusSubscription = FirebaseUtils.firebaseService.firestore
  //       .collection(FirebaseConstants.calls)
  //       .doc(widget.callId!)
  //       .snapshots()
  //       .listen((DocumentSnapshot snapshot) {
  //     if (snapshot.exists && snapshot['is_call_active'] == false) {
  //       if (mounted) {
  //         _callStatusSubscription?.cancel(); // Check if the widget is still mounted
  //         _dispose();
  //       }
  //     } else if (snapshot.exists && snapshot['receiver_numbers'] != null) {
  //       List<String> receiverNumbers = List<String>.from(snapshot['receiver_numbers']);
  //       Map<int, String> contactNames = {};
  //       for (String number in receiverNumbers) {
  //         Contact? contact = getContactByPhoneNumber(number);
  //         String displayName = contact?.displayName ?? number;
  //         // Assuming the remote UID is the same as the index in the receiverNumbers list
  //         int remoteUid = receiverNumbers.indexOf(number);
  //         contactNames[remoteUid] = displayName;
  //       }
  //       setState(() {
  //         _remoteUserNames = contactNames;
  //       });
  //     }
  //   });
  // }

  Contact? getContactByPhoneNumber(String phoneNumber) {
    // Normalize the phone number to remove any non-numeric characters and leading '+'
    String normalizedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Find the contact in local contacts
    Contact? contact;
    try {
      contact = localContacts.firstWhere(
        (c) => c.phones!.any(
          (phone) =>
              phone.value?.replaceAll(RegExp(r'\D'), '') ==
              normalizedPhoneNumber,
        ),
      );
    } catch (e) {
      // Handle the case where no contact is found
      print("Contact not found for phone number: $phoneNumber");
    }
    return contact;
  }

  Future<void> initAgora() async {
    // int remoteUserCount = _remoteUserNames.length;
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
          FirebaseUtils.updateCallsOnReceiveOfUser(
              [FirebaseUtils.phoneNumber!], widget.callId!);
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) async {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });

          print("user join $_remoteUid");
          await FirebaseUtils.firebaseService.firestore
              .collection(FirebaseConstants.calls)
              .doc(widget.callId)
              .get()
              .then((DocumentSnapshot snapshot) async {
            if (snapshot.exists && snapshot['receiver_numbers'] != null) {
              List<String> receiverNumbers =
                  List<String>.from(snapshot['receiver_numbers']);
              print("receiverNumbers $receiverNumbers");

              // Filter out numbers that have already been processed
              List<String> unprocessedNumbers = receiverNumbers
                  .where((number) => !processedNumbers.contains(number))
                  .toList();

              // Process each unprocessed number
              for (String newNumber in unprocessedNumbers) {
                final newUserData = await FirebaseUtils.getChatUser(newNumber);
                UserModel userData =
                    UserModel.fromJson(newUserData.data() ?? {});
                String displayImage = userData?.image ?? "";
                print("displayImage $displayImage");
                print("newNumber $newNumber");

                // Look up the contact in local contacts
                Contact? contact = getContactByPhoneNumber(newNumber);
                print(" contact?.displayName ${contact?.displayName}");
                String displayName;
                if (newNumber == FirebaseUtils.user?.id) {
                  displayName = "You";
                } else {
                  displayName = contact?.displayName ?? newNumber;
                }
                print("displayName $displayName");

                // Update the _remoteUserNames map with the new contact name or number
                setState(() {
                  _remoteUserNames[int.parse(newNumber)] = {
                    'name': displayName,
                    'image': displayImage
                  };
                  remoteUserCount = _remoteUserNames.length;
                });

                // Mark the number as processed
                processedNumbers.add(newNumber);
              }
            }
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) async {
          //debugPrint("remote user $remoteUid left channel");
          // setState(() {
          //   _remoteUid = null;
          // });
          // _dispose();

          debugPrint("remote user $remoteUid left channel");
          print("remoteUserCount ${remoteUserCount}");
          setState(() {
            _remoteUserNames.remove(remoteUid);
            remoteUserCount--;
          });
          print("User names to left ${_remoteUserNames.toString()}");
          print(
              "user-left _remoteUserNames.length  ${_remoteUserNames.length} count ${remoteUserCount}");
          if (remoteUserCount <= 1) {
            await FirebaseUtils.firebaseService.firestore
                .collection(FirebaseConstants.calls)
                .doc(widget.callId)
                .get()
                .then((DocumentSnapshot snapshot) async {
              if (snapshot.exists && snapshot['users'] != null) {
                List<String> userNumbers = List<String>.from(snapshot['users']);
                print("receiverNumbers $userNumbers");
                List<int> remoteUserNumbers = _remoteUserNames.keys.toList();

                List<String> nonExistentUserNumbers = [];
                for (String userNumber in userNumbers) {
                  int number = int.parse(userNumber);
                  if (!remoteUserNumbers.contains(number)) {
                    nonExistentUserNumbers.add(userNumber);
                  }
                }
                if (nonExistentUserNumbers.isNotEmpty) {
                  for (String newNumber in nonExistentUserNumbers) {
                    final newUserData =
                        await FirebaseUtils.getChatUser(newNumber);

                    Map<String, dynamic> data = {
                      "messageType": "missed-group-call",
                      "callId": widget.callId,
                      "callerName": widget.callerName,
                      // "callerNumber": FirebaseUtils.user?.phoneNumber,
                    };

                    UserModel userData =
                        UserModel.fromJson(newUserData.data() ?? {});
                    final userFcmToken = userData.fcmToken;
                    FirebaseNotificationUtils.sendFCM(
                        userFcmToken!,
                        "Missed Group Call",
                        "You have a Group call request",
                        data);
                  }
                }
              }
            });

            _disposeEndCall();
          }
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
      uid: 0, //widget.ownNumber!,
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
    String formattedDuration =
        "${duration.inMinutes}:${duration.inSeconds % 60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration, false,
        widget.callId!, FirebaseUtils.getDateTimeNowAsId());

    if (mounted) {
      await _engine.leaveChannel();
      await _engine.release();
    }
    NavigationUtil.pop(context);
  }

  Future<void> _disposeEndCall() async {
    Duration duration = DateTime.now().difference(_callStartTime!);
    String formattedDuration =
        "${duration.inMinutes}:${duration.inSeconds % 60}";
    await FirebaseUtils.updateCallsDuration(formattedDuration, false,
        widget.callId!, FirebaseUtils.getDateTimeNowAsId());

    if (mounted) {
      await _engine.leaveChannel();
      await _engine.release();
    }
    NavigationUtil.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // remoteUserCount = _remoteUserNames.length;
    print("remoteruasercount $remoteUserCount");
    print("_remoteUserNames $_remoteUserNames");

    int crossAxisCount = remoteUserCount <= 2 ? 1 : 2;
    // _remoteUserNames[4] = {'name': 'displayName4', 'image': null};
    // _remoteUserNames[5] = {'name': 'displayName5', 'image': null};
    // _remoteUserNames[6] = {'name': 'displayName6', 'image': null};
    // _remoteUserNames[7] = {'name': 'displayName7', 'image': null};
    // _remoteUserNames[7] = {'name': 'displayName8', 'image': null};
    return Scaffold(
      // appBar: AppBar(
      //   title:  Text(widget.callerName ?? "Video Call"),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            // GridView.count(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   crossAxisCount: crossAxisCount,
            //   children: _remoteUserNames.entries.map((entry) {
            //     return Text(entry.value); // Display the user name
            //   }).toList(),
            // )
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              children: _remoteUserNames.entries.map((entry) {
                return Card(
                  // margin: EdgeInsets.all(8.0), // Space around the card
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Padding inside the card
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entry.value['name'], // Display the user name
                          style: TextStyle(fontSize: 16.0), // Style the text
                        ),
                        SizedBox(height: 18.0),
                        // Space between the image and the text
                        ProfileImageComponent(
                          url: entry.value['image'],
                          size: 80,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: SizedBox(
            //     width: 100,
            //     height: 150,
            //     child: Center(
            //       child: _localUserJoined
            //           ? Text(FirebaseUtils.user!.name!)
            //           : const CircularProgressIndicator(),
            //     ),
            //   ),
            // ),
            Align(
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

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Container(
        alignment: Alignment.bottomRight,
        child: Column(
          children: [
            // SizedBox(
            //   height: 100,
            // ),
            // Text(widget.callerName ?? "Unkown"),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(widget.callerNumber ?? "Group Call")
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            ProfileImageComponent(
              url: widget.groupImage,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.callerName ?? "Unkown-Group",
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Waiting for others...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      );
    }
  }
}
