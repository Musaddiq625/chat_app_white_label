import 'dart:developer';
import 'dart:io';
import 'package:chat_app_white_label/src/components/chat_input_icon_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/components/record_button_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/usert_model.dart';
import '../../models/message_model.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel chatUser;
  final String? unreadCount;

  const ChatRoomScreen(
      {super.key, required this.chatUser, required this.unreadCount});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  int unreadCount = -1;
  List<MessageModel> messagesList = [];
  final _textController = TextEditingController();
  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  bool _showEmoji = false, _isUploading = false;
  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((message) {
      LoggerUtil.logs('message ${message}');
      if (FirebaseUtils.user != null) {
        if (message.toString().contains('resume')) {
          FirebaseUtils.updateActiveStatus(true).then((value) => null);
        }
        if (message.toString().contains('pause')) {
          FirebaseUtils.updateActiveStatus(false);
        }
        if (message.toString().contains('detached')) {
          FirebaseUtils.updateActiveStatus(false);
        }
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatRoomCubit, ChatRoomState>(
      listener: (context, state) async {
        if (state is MediaSelectedState) {
          setState(() => _isUploading = true);
          await ChatUtils.sendMessage(
              chatUser: widget.chatUser,
              type: state.type,
              isFirstMessage: messagesList.isEmpty,
              filePath: state.filePath,
              thumbnailPath: state.thumbnailPath);
          setState(() => _isUploading = false);
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
                if (_showEmoji) {
                  setState(() => _showEmoji = !_showEmoji);
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
                        stream: FirebaseUtils.user?.isOnline == true
                            ? ChatUtils.getAllMessages(
                                ChatUtils.getConversationID(
                                    widget.chatUser.id ?? ''))
                            : null,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const SizedBox();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              messagesList = data
                                      ?.map((e) =>
                                          MessageModel.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              for (var i = 0; i < messagesList.length; i++) {
                                bool isFromMe = FirebaseUtils.user?.id ==
                                    messagesList[i].fromId;
                                if (isFromMe &&
                                    messagesList[i].readAt == null) {
                                  unreadCount = unreadCount + 1;
                                }
                              }
                              if (unreadCount != -1 &&
                                  (data ?? []).isNotEmpty &&
                                  data?.last.id == messagesList.last.sentAt) {
                                ChatUtils.updateUnreadCount(
                                    widget.chatUser.id ?? '',
                                    unreadCount.toString());
                              }
                              unreadCount = 0;

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
                                        // isRead:
                                        //     messagesList[index].readAt != null,
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
                      ),
                    ),

                    //progress indicator for showing uploading
                    if (_isUploading)
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorConstants.greenMain,
                              ))),

                    //chat input filed
                    _chatInput(),

                    // show emojis on keyboard emoji button click & vice versa
                    if (_showEmoji)
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
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  ChatInputIconComponent(
                      icon: Icons.emoji_emotions,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      }),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //pick doc from storage button
                  ChatInputIconComponent(
                      icon: Icons.description_rounded,
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            'doc',
                            'pdf',
                          ],
                        );

                        if (result != null) {
                          // uploading & sending document one by one
                          for (var i in result.files) {
                            log('Document Path: ${i.path}');
                            setState(() => _isUploading = true);

                            await ChatUtils.sendMessage(
                              chatUser: widget.chatUser,
                              type: MessageType.document,
                              isFirstMessage: messagesList.isEmpty,
                              filePath: i.path,
                            );
                            setState(() => _isUploading = false);
                          }
                        }
                      }),

                  //pick image from gallery button
                  ChatInputIconComponent(
                      icon: Icons.image,
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage();

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);

                          await ChatUtils.sendMessage(
                              chatUser: widget.chatUser,
                              type: MessageType.image,
                              isFirstMessage: messagesList.isEmpty,
                              filePath: i.path);
                          setState(() => _isUploading = false);
                        }
                      }),

                  //take image from camera button
                  ChatInputIconComponent(
                      icon: Icons.camera_alt_rounded,
                      onTap: () async {
                        NavigationUtil.push(
                            context, RouteConstants.cameraScreen);
                      }),

                  //voice message mutton
                  RecordButtonComponent(
                    onRecordingFinished: (path, duration) async {
                      LoggerUtil.logs('Voice Path: $path');
                      setState(() => _isUploading = true);

                      await ChatUtils.sendMessage(
                          chatUser: widget.chatUser,
                          type: MessageType.audio,
                          isFirstMessage: messagesList.isEmpty,
                          filePath: path,
                          length: duration);
                      setState(() => _isUploading = false);
                    },
                  ),

                  //adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          //send message
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                ChatUtils.sendMessage(
                  chatUser: widget.chatUser,
                  msg: _textController.text,
                  type: MessageType.text,
                  isFirstMessage: messagesList.isEmpty,
                );
                _textController.clear();
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: ChatUtils.getUserInfo(widget.chatUser.id ?? ''),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel chatUserData =
                    UserModel.fromJson(snapshot.data?.data() ?? {});
                return Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black54)),

                    //user profile picture
                    (chatUserData.image ?? '').isNotEmpty
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * .03),
                            child: CachedNetworkImage(
                              width: mq.height * .055,
                              height: mq.height * .055,
                              imageUrl: chatUserData.image ?? '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                      child: Icon(CupertinoIcons.person)),
                            ),
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.grey.shade500,
                          ),
                    const SizedBox(width: 10),
                    //user name & last seen time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //user name
                        Text(chatUserData.name ?? '',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),

                        const SizedBox(height: 2),
                        // last seen time of user
                        Text(
                            chatUserData.isOnline == true
                                ? 'Online'
                                : DateUtil.getLastActiveTime(
                                    context: context,
                                    lastActive: chatUserData.lastActive ?? ''),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54)),
                      ],
                    )
                  ],
                );
              }
              return Container();
            }));
  }
}
