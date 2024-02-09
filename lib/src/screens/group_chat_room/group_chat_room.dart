import 'dart:convert';
import 'dart:io';
import 'package:chat_app_white_label/src/components/chat_input_component.dart';
import 'package:chat_app_white_label/src/components/message_uploading_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/screens/group_chat_room/cubit/group_chat_room_cubit.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/message_model.dart';
import '../../models/usert_model.dart';
import '../../utils/firebase_utils.dart';
import '../agora_calling.dart';
import 'package:http/http.dart' as http;

import '../agora_group_calling.dart';
import '../agora_group_video_calling.dart';

// ignore: must_be_immutable
class GroupChatRoomScreen extends StatefulWidget {
  ChatModel groupChat;
  GroupChatRoomScreen({super.key, required this.groupChat});

  @override
  State<GroupChatRoomScreen> createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  late GroupChatRoomCubit groupChatRoomCubit =
      BlocProvider.of<GroupChatRoomCubit>(context);

  final _textController = TextEditingController();
  List<MessageModel> messagesList = [];
  List<String> userNumber = [];
  @override
  Widget build(BuildContext context) {
    LoggerUtil.logs('Group Chat Room Build');
    return BlocConsumer<GroupChatRoomCubit, GroupChatRoomState>(
      listener: (context, state) async {
        if (state is MediaSelectedState) {
          groupChatRoomCubit.setUploading(true);
          await ChatUtils.sendGropuMessage(
              groupChatId: widget.groupChat.id ?? '',
              type: state.type,
              filePath: state.filePath,
              thumbnailPath: state.thumbnailPath);
          groupChatRoomCubit.setUploading(false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: WillPopScope(
              //if emojis are shown & back button is pressed then hide emojis
              //or else simple close current screen on back button click
              onWillPop: () {
                if (groupChatRoomCubit.showEmoji) {
                  groupChatRoomCubit
                      .setShowEmoji(!groupChatRoomCubit.showEmoji);
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: _appBar(),
                ),
                backgroundColor: const Color.fromARGB(255, 234, 248, 255),
                body: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder(
                      stream:
                          ChatUtils.getAllMessages(widget.groupChat.id ?? ''),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            messagesList = data
                                    ?.map(
                                        (e) => MessageModel.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (messagesList.length >
                                (widget.groupChat.readCountGroup ?? 0)) {
                              int difference = messagesList.length -
                                  (widget.groupChat.readCountGroup ?? 0);
                              for (var i = 0; i < difference; i++) {
                                widget.groupChat.readCountGroup =
                                    (widget.groupChat.readCountGroup ?? 0) + 1;
                                ChatUtils.updateGroupReadCount(
                                    widget.groupChat.id ?? '');
                              }
                            }
                            if (messagesList.isNotEmpty) {
                              return ListView.builder(
                                  reverse: true,
                                  itemCount: messagesList.length,
                                  padding:
                                      EdgeInsets.only(top: mq.height * .01),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                      message: messagesList[index],
                                      isRead:
                                          messagesList[index].readBy?.length ==
                                              ((widget.groupChat.users ?? [])
                                                      .length -
                                                  1),
                                      isGroupMessage: true,
                                      updateGroupChatReadStatus: () => ChatUtils
                                          .updateGroupMessageReadStatus(
                                              widget.groupChat.id ?? '',
                                              messagesList[index],
                                              data?.last.id ==
                                                  messagesList.last.sentAt),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text('Say Hii! 👋',
                                    style: TextStyle(fontSize: 20)),
                              );
                            }
                        }
                      },
                    )),

                    //progress indicator for showing uploading
                    if (state is UploadingState)
                      if (groupChatRoomCubit.isUploading)
                        const MessageUploadingComponent(),

                    //chat input filed
                    _chatInput(),

                    // show emojis on keyboard emoji button click & vice versa
                    if (state is ShowEmojiState)
                      if (groupChatRoomCubit.showEmoji)
                        SizedBox(
                          height: mq.height * .35,
                          child: EmojiPicker(
                            textEditingController: _textController,
                            config: Config(
                              bgColor: const Color.fromARGB(255, 234, 248, 255),
                              columns: 8,
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                            ),
                          ),
                        )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // bottom chat input field
  Widget _chatInput() {
    return ChatInputComponent(
        controller: _textController,
        onTextInputTap: () {
          if (groupChatRoomCubit.showEmoji) {
            groupChatRoomCubit.setShowEmoji(!groupChatRoomCubit.showEmoji);
          }
        },
        onEmojiTap: () {
          FocusScope.of(context).unfocus();
          groupChatRoomCubit.setShowEmoji(!groupChatRoomCubit.showEmoji);
        },
        onDocumentSelection: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: [
              'doc',
              'pdf',
            ],
          );

          if (result != null) {
            // uploading & sending document one by one
            groupChatRoomCubit.setUploading(true);
            await ChatUtils.sendGroupMultipleMediaMessage(
                groupChatId: widget.groupChat.id ?? '',
                selectedFiles: result.files,
                type: MessageType.document);
            groupChatRoomCubit.setUploading(false);
          }
        },
        onImageSelection: () async {
          // Picking multiple images/videos
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.media,
            // allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'avi'],
          );
          if (result != null) {
            // uploading & sending image/videos one by one
            groupChatRoomCubit.setUploading(true);
            await ChatUtils.sendGroupMultipleMediaMessage(
                groupChatId: widget.groupChat.id ?? '',
                selectedFiles: result.files);
            groupChatRoomCubit.setUploading(false);
          }
        },
        onCameraSelection: () async {
          NavigationUtil.push(context, RouteConstants.cameraScreen, args: true);
        },
        onRecordingFinished: (path, duration) async {
          LoggerUtil.logs('Voice Path: $path');

          groupChatRoomCubit.setUploading(true);
          await ChatUtils.sendGropuMessage(
              groupChatId: widget.groupChat.id ?? '',
              type: MessageType.audio,
              filePath: path,
              length: duration);
          groupChatRoomCubit.setUploading(false);
        },
        onSendButtonTap: () {
          if (_textController.text.isNotEmpty) {
            ChatUtils.sendGropuMessage(
              groupChatId: widget.groupChat.id ?? '',
              msg: _textController.text,
              type: MessageType.text,
            );
            _textController.clear();
          }
        });
  }

  Widget _appBar() {
    return InkWell(
      onTap: () => NavigationUtil.push(context, RouteConstants.viewGroupProfile,
          args: widget.groupChat),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black54)),
          //user profile picture
          ProfileImageComponent(
            url: widget.groupChat.groupData?.groupImage,
            size: 45,
            isGroup: true,
          ),
          const SizedBox(width: 10),
          //user name & last seen time
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //user name
              Text(widget.groupChat.groupData?.grougName ?? '',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),

              const SizedBox(height: 2),
            ],
          ),
          Expanded(child: Container()), // This will take up all available space
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  onPressed: () => callTap(),
                  icon: const Icon(
                    Icons.call,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  onPressed: ()=>videoTap(),
                  icon: const Icon(
                    Icons.video_call,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendFCM(String fcmToken, String title, String body,
      Map<String, dynamic> data) async {
    Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'
    };

    final payload = {
      "to": fcmToken,
      "notification": {
        "title": title,
        "body": body,
      },
      "data": data
    };

    final response = await http.post(postUrl,
        body: json.encode(payload),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification ${response.statusCode}');
    }
  }

  Future<void> callTap() async {
    userNumber = (widget.groupChat.users) ?? [];
    String? senderName = FirebaseUtils.user?.name;
    String? senderContactNumber = FirebaseUtils.user?.phoneNumber;

    //
    // print("firebaseContactUser.fcmToken ${firebaseContactUser.fcmToken}");
    // print("recipientUid $recipientUid");
    // print("contactToDisplay[index].phoneNumber ${contactToDisplay[index].phoneNumber}");

    //
    //
    // Uri postUrl = Uri.parse(
    //     'https://fcm.googleapis.com/fcm/send');
    // final data = {
    //   "to": firebaseContactUser.fcmToken,
    //   "notification": {
    //     "title": 'New Call Request',
    //     "body": 'You have a new call request',
    //   },
    //   "data": {
    //     "messageType" : "call",
    //     "callerName": senderName,
    //     "callerNumber": senderContactNumber,
    //   }
    // };
    //
    // final headers = {
    //   'content-type': 'application/json',
    //   'Authorization':
    //       'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'
    // };
    //
    // final response = await http.post(postUrl,
    //     body: json.encode(data),
    //     encoding: Encoding.getByName('utf-8'),
    //     headers: headers);
    //
    // if (response.statusCode == 200) {
    //   print("response ${response.body}");
    //   print('Notification sent successfully');
    // } else {
    //   print(
    //       'Failed to send notification ${response.statusCode}');
    // }

    final callId = "${senderContactNumber!.replaceAll('+', "")}_${FirebaseUtils.getDateTimeNowAsId()}";
    await FirebaseUtils.createCalls(callId,senderContactNumber,userNumber,"group_call" );
    Map<String, dynamic> data = {
      "messageType": "group_call",
      "callId": callId,
      "callerName": widget.groupChat.groupData?.grougName,
      "callerNumber": senderContactNumber,
    };
    userNumber =
        userNumber.where((number) => number != FirebaseUtils.user!.id).toList();

    for (String userNumbers in userNumber) {
      final getUserData = await FirebaseUtils.getChatUser(userNumbers);
      UserModel chatUser = UserModel.fromJson(getUserData.data() ?? {});
      await sendFCM(chatUser.fcmToken!, 'New Group Call Request',
          'You have a new Group call request', data);
      FirebaseUtils.updateUserCallList(chatUser.phoneNumber!, callId);
    }


    // await sendFCM(
    //     firebaseContactUser.fcmToken!,
    //     'New Call Request',
    //     'You have a new call request',
    //     data);
    // await FirebaseUtils.createCalls(callId,senderContactNumber,firebaseContactUser.phoneNumber!,"call" );
    // await FirebaseUtils.updateUserCallList(FirebaseUtils.user!.id!,callId);
    // await FirebaseUtils.updateUserCallList(firebaseContactUser.phoneNumber!,callId);

    await FirebaseUtils.updateUserCallList(FirebaseUtils.user!.id!,callId);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AgoraGroupCalling(
            recipientUid: int.parse(FirebaseUtils.getDateTimeNowAsId()),
            callerName: widget.groupChat.groupData?.grougName,
            callId:callId,
          )),
    );
  }

  Future<void> videoTap() async {
    userNumber = (widget.groupChat.users) ?? [];
    String? senderName = FirebaseUtils.user?.name;
    String? senderContactNumber =
        FirebaseUtils.user?.phoneNumber;


    //
    // print("firebaseContactUser.fcmToken ${firebaseContactUser.fcmToken}");
    // print("recipientUid $recipientUid");
    // print("contactToDisplay[index].phoneNumber ${contactToDisplay[index].phoneNumber}");

    //
    //
    // Uri postUrl = Uri.parse(
    //     'https://fcm.googleapis.com/fcm/send');
    // final data = {
    //   "to": firebaseContactUser.fcmToken,
    //   "notification": {
    //     "title": 'New Call Request',
    //     "body": 'You have a new call request',
    //   },
    //   "data": {
    //     "messageType" : "call",
    //     "callerName": senderName,
    //     "callerNumber": senderContactNumber,
    //   }
    // };
    //
    // final headers = {
    //   'content-type': 'application/json',
    //   'Authorization':
    //       'Bearer AAAAOIYrwGU:APA91bFOw0B8_2FY2USTdpTwg72djuxfiqf-vJ2ZcMts8g5TsXa5oeVEumc1-qZ-n7ei5pnPzVb7SKDFKo2mCF7XU4572rJJnH99Uge7PdORc6gGVDKHdA2vdZfzU10jlG7Hl5iIYCZK'
    // };
    //
    // final response = await http.post(postUrl,
    //     body: json.encode(data),
    //     encoding: Encoding.getByName('utf-8'),
    //     headers: headers);
    //
    // if (response.statusCode == 200) {
    //   print("response ${response.body}");
    //   print('Notification sent successfully');
    // } else {
    //   print(
    //       'Failed to send notification ${response.statusCode}');
    // }

    final callId = "${senderContactNumber!.replaceAll('+', "")}_${FirebaseUtils.getDateTimeNowAsId()}";
    await FirebaseUtils.createCalls(callId,senderContactNumber,userNumber,"group_call" );
    Map<String, dynamic> data = {
      "messageType": "group_video_call",
      "callId":callId,
      "callerName": widget.groupChat.groupData?.grougName,
      "callerNumber": senderContactNumber,
    };
    userNumber = userNumber.where((number) => number != FirebaseUtils.user!.id).toList();

    for (String userNumbers in userNumber) {
      final getUserData = await FirebaseUtils.getChatUser(userNumbers);
      UserModel chatUser = UserModel.fromJson(getUserData.data() ?? {});
      await sendFCM(chatUser.fcmToken!,
          'New Group Call Request',
          'You have a new Group call request',
          data);
      FirebaseUtils.updateUserCallList(chatUser.phoneNumber!, callId);
    }


    // await sendFCM(
    //     firebaseContactUser.fcmToken!,
    //     'New Call Request',
    //     'You have a new call request',
    //     data);
    // await FirebaseUtils.createCalls(callId,senderContactNumber,firebaseContactUser.phoneNumber!,"call" );
    // await FirebaseUtils.updateUserCallList(FirebaseUtils.user!.id!,callId);
    // await FirebaseUtils.updateUserCallList(firebaseContactUser.phoneNumber!,callId);

    await FirebaseUtils.updateUserCallList(FirebaseUtils.user!.id!,callId);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AgoraGroupVideoCalling(
            recipientUid: int.parse(FirebaseUtils.getDateTimeNowAsId()),
            callerName: widget.groupChat.groupData?.grougName,
            callId:callId,
          )),
    );
  }
}
