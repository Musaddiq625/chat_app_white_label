import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/chat_input_component.dart';
import 'package:chat_app_white_label/src/components/message_card_component.dart';
import 'package:chat_app_white_label/src/components/message_uploading_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/color_constants.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel chatUser;
  final String? unreadCount;

  const ChatRoomScreen(
      {super.key, required this.chatUser, required this.unreadCount});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late ChatRoomCubit chatRoomCubit = BlocProvider.of<ChatRoomCubit>(context);
  int myUnreadCount = 0;
  int chatUserUnreadCount = -1;
  List<MessageModel> messagesList = [];
  final _textController = TextEditingController();

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  // bool _showEmoji = false;
  //   = false;

  String? replacedNumber;
  String? myReplacedNumber;

  @override
  void initState() {
    super.initState();
    replacedNumber = widget.chatUser.phoneNumber?.replaceAll('+', '');
    myReplacedNumber =  "923083306918";//FirebaseUtils.phoneNumber?.replaceAll('+', '');

    print("replacedNumber ${replacedNumber}");
    print("myReplacedNumber ${myReplacedNumber}");

    // SystemChannels.lifecycle.setMessageHandler((message) {
    //   LoggerUtil.logs('message ${message}');
    //   if (FirebaseUtils.user != null) {
    //     if (message.toString().contains('resume')) {
    //       FirebaseUtils.updateActiveStatus(true).then((value) => null);
    //     }
    //     if (message.toString().contains('pause')) {
    //       FirebaseUtils.updateActiveStatus(false);
    //     }
    //     if (message.toString().contains('detached')) {
    //       FirebaseUtils.updateActiveStatus(false);
    //     }
    //   }
    //   return Future.value(message);
    // });
  }
  late final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor:themeCubit.darkBackgroundColor),
    );
    LoggerUtil.logs('Chat Room Build');
    LoggerUtil.logs('Chat widget.chatUser.id ${widget.chatUser.toJson()}');
    return BlocConsumer<ChatRoomCubit, ChatRoomState>(
      listener: (context, state) async {
        if (state is MediaSelectedState) {
          chatRoomCubit.setUploading(true);
          await ChatUtils.sendMessage(
              chatUser: widget.chatUser,
              type: state.type,
              isFirstMessage: messagesList.isEmpty,
              filePath: state.filePath,
              thumbnailPath: state.thumbnailPath);
          chatRoomCubit.setUploading(false);
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
                if (chatRoomCubit.showEmoji) {
                  chatRoomCubit.setShowEmoji(!chatRoomCubit.showEmoji);
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: themeCubit.darkBackgroundColor,  statusBarIconBrightness: Brightness.dark,),
                  backgroundColor: themeCubit.darkBackgroundColor,//ColorConstants.greenMain,
                  automaticallyImplyLeading: true,
                  flexibleSpace: _appBar(),
                ),
                backgroundColor: themeCubit.backgroundColor,//const Color.fromARGB(255, 234, 248, 255),
                body: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseUtils.user?.isOnline == true
                            ? ChatUtils.getAllMessages(
                                ChatUtils.getConversationID(
                                  replacedNumber ?? ""
                                    // widget.chatUser.id ?? ''
                                ))
                                // ChatUtils.getConversationIDLocals(
                                //     replacedNumber ?? "", myReplacedNumber ?? ""
                                //     // widget.chatUser.id ?? ''
                                //     ))
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
                              // print(" FirebaseUtils.user?.id ${FirebaseUtils.user?.id}  messagesList[i].fromId ${messagesList.first.fromId} message ${messagesList.first.msg.toString()}");
                              // print("FirebaseUtils.user?.id == messagesList[i].fromId; ${FirebaseUtils.user?.id ==
                              //     messagesList.first.fromId}");
                              for (var i = 0; i < messagesList.length; i++) {

                                bool isFromMe = FirebaseUtils.user?.id ==
                                    messagesList[i].fromId;
                                if (isFromMe && messagesList[i].readAt == null) {
                                  print(" messagesList[i].readAt ${ messagesList[i].readAt} isFromMe $isFromMe ");
                                  print("0 chatUserUnreadCount $chatUserUnreadCount");
                                  chatUserUnreadCount = chatUserUnreadCount + 1;
                                  print("1 chatUserUnreadCount $chatUserUnreadCount");
                                } else if (messagesList[i].readAt == null) {
                                  // myUnreadCount = myUnreadCount + 1;
                                }
                              }

                              if (chatUserUnreadCount != -1 &&
                                  (data ?? []).isNotEmpty &&
                                  data?.last.id == messagesList.last.sentAt) {
                                LoggerUtil.logs(
                                    'chatUserUnreadCount $chatUserUnreadCount');
                                ChatUtils.updateUnreadCount(
                                    widget.chatUser.id ?? '',
                                    chatUserUnreadCount.toString(),
                                    false);
                              }
                              if (myUnreadCount != -1 &&
                                  (data ?? []).isNotEmpty &&
                                  data?.last.id == messagesList.last.sentAt) {
                                LoggerUtil.logs('myUnreadCount $myUnreadCount');
                                ChatUtils.updateUnreadCount(
                                    widget.chatUser.id ?? '', '0', true);
                              }
                              chatUserUnreadCount = 0;
                              myUnreadCount = -1;

                              if (messagesList.isNotEmpty) {
                                return ListView.builder(
                                    reverse: true,
                                    itemCount: messagesList.length,
                                    padding:
                                        EdgeInsets.only(top: mq.height * .01),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return MessageCard(
                                        key: Key('msg_$index'),
                                        message: messagesList[index],
                                        isRead:
                                            messagesList[index].readAt != null,
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: Text('Say Hii! 👋',
                                      style: TextStyle(fontSize: 20,color: ColorConstants.white)),
                                );
                              }
                          }
                        },
                      ),
                    ),

                    //progress indicator for showing uploading
                    if (state is UploadinState)
                      if (chatRoomCubit.isUploading)
                        const MessageUploadingComponent(),

                    //chat input filed
                    _chatInput(),

                    // show emojis on keyboard emoji button click & vice versa
                    if (state is ShowEmojiState)
                      if (chatRoomCubit.showEmoji)
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
          if (chatRoomCubit.showEmoji) {
            chatRoomCubit.setShowEmoji(!chatRoomCubit.showEmoji);
          }
        },
        onEmojiTap: () {
          FocusScope.of(context).unfocus();
          chatRoomCubit.setShowEmoji(!chatRoomCubit.showEmoji);
        },
        onDocumentSelection: () async {
          // Picking multiple documents
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
            chatRoomCubit.setUploading(true);
            await ChatUtils.sendMultipleMediaMessage(
                chatUser: widget.chatUser,
                messagesList: messagesList,
                selectedFiles: result.files,
                type: MessageType.document);
            chatRoomCubit.setUploading(false);
          }
        },
        onImageSelection: () async {
          // Picking multiple images/videos
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.media,
          );
          if (result != null) {
            // uploading & sending image/videos one by one
            chatRoomCubit.setUploading(true);
            await ChatUtils.sendMultipleMediaMessage(
                chatUser: widget.chatUser,
                messagesList: messagesList,
                selectedFiles: result.files);
            chatRoomCubit.setUploading(false);
            // chatRoomCubit.isUploading = false;
          }
        },
        onCameraSelection: () async {
          NavigationUtil.push(context, RouteConstants.cameraScreen,
              args: false);
        },
        onRecordingFinished: (path, duration) async {
          LoggerUtil.logs('Voice Path: $path');
          chatRoomCubit.setUploading(true);

          await ChatUtils.sendMessage(
              chatUser: widget.chatUser,
              type: MessageType.audio,
              isFirstMessage: messagesList.isEmpty,
              filePath: path,
              length: duration);
          chatRoomCubit.setUploading(false);
        },
        onSendButtonTap: () {
          if (_textController.text.isNotEmpty) {
            print(" widget.chatUser ${ widget.chatUser.toJson()}");
            print(" widget._textController.text ${ _textController.text}");
            print(" messagesList.isEmpty ${ messagesList.isEmpty}");
            // print(" Firebase ${ FirebaseUtils.user?.toJson()}");
            print("Firebase id ${FirebaseUtils.user?.id} chatuserId ${widget.chatUser.id}");
            ChatUtils.sendMessage(
              chatUser: widget.chatUser,
              msg: _textController.text,
              type: MessageType.text,
              isFirstMessage: messagesList.isEmpty,
            );
            _textController.clear();
          }
        });

  }

  Widget _appBar() {
    final replacedPhoneNumber =
        widget.chatUser.phoneNumber?.replaceAll('+', '');
    return StreamBuilder(
        stream: ChatUtils.getUserInfo(replacedPhoneNumber ?? ''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel chatUserData =
                UserModel.fromJson(snapshot.data?.data() ?? {});
            chatUserData.firstName =
                widget.chatUser.firstName == chatUserData.phoneNumber
                    ? chatUserData.firstName
                    : widget.chatUser.firstName;
            return InkWell(
              onTap: () => NavigationUtil.push(
                  context, RouteConstants.viewUserProfile,
                  args: chatUserData),
              child: Row(
                children: [
                  IconButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  //user profile picture
                  ProfileImageComponent(
                    url: chatUserData.image,
                    size: 45,
                  ),
                  const SizedBox(width: 10),
                  //user name & last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(widget.chatUser.firstName ?? '',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
                              fontSize: 12, color: Colors.white)),
                    ],
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}

// // bottom chat input field
// Widget _chatInput() {
//   return Padding(
//     padding: EdgeInsets.symmetric(
//         vertical: mq.height * .01, horizontal: mq.width * .025),
//     child: Row(
//       children: [
//         //input field & buttons
//         Expanded(
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15)),
//             child: Row(
//               children: [
//                 //emoji button
//                 ChatInputIconComponent(
//                     icon: Icons.emoji_emotions,
//                     onTap: () {
//                       FocusScope.of(context).unfocus();
//                       setState(() => _showEmoji = !_showEmoji);
//                     }),

//                 Expanded(
//                     child: TextField(
//                   controller: _textController,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: null,
//                   onTap: () {
//                     if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
//                   },
//                   decoration: const InputDecoration(
//                       hintText: 'Type Something...',
//                       hintStyle: TextStyle(color: Colors.blueAccent),
//                       border: InputBorder.none),
//                 )),

//                 //pick doc from storage button
//                 ChatInputIconComponent(
//                     icon: Icons.description_rounded,
//                     onTap: () async {
//                       // Picking multiple documents
//                       FilePickerResult? result =
//                           await FilePicker.platform.pickFiles(
//                         allowMultiple: true,
//                         type: FileType.custom,
//                         allowedExtensions: [
//                           'doc',
//                           'pdf',
//                         ],
//                       );

//                       if (result != null) {
//                         // uploading & sending document one by one
//                         setState(() => _isUploading = true);
//                         await ChatUtils.sendMultipleMediaMessage(
//                             chatUser: widget.chatUser,
//                             messagesList: messagesList,
//                             selectedFiles: result.files,
//                             type: MessageType.document);
//                         setState(() => _isUploading = false);
//                       }
//                     }),

//                 //pick image from gallery button
//                 ChatInputIconComponent(
//                     icon: Icons.image,
//                     onTap: () async {
//                       // Picking multiple images/videos
//                       FilePickerResult? result =
//                           await FilePicker.platform.pickFiles(
//                         allowMultiple: true,
//                         type: FileType.media,
//                       );
//                       if (result != null) {
//                         // uploading & sending image/videos one by one
//                         setState(() => _isUploading = true);
//                         await ChatUtils.sendMultipleMediaMessage(
//                             chatUser: widget.chatUser,
//                             messagesList: messagesList,
//                             selectedFiles: result.files
//                                 .map((e) => e.path ?? '')
//                                 .toList());
//                         setState(() => _isUploading = false);
//                       }
//                     }),

//                 //take image from camera button
//                 ChatInputIconComponent(
//                     icon: Icons.camera_alt_rounded,
//                     onTap: () async {
//                       NavigationUtil.push(
//                           context, RouteConstants.cameraScreen,
//                           args: false);
//                     }),

//                 //voice message mutton
//                 RecordButtonComponent(
//                   onRecordingFinished: (path, duration) async {
//                     LoggerUtil.logs('Voice Path: $path');
//                     setState(() => _isUploading = true);

//                     await ChatUtils.sendMessage(
//                         chatUser: widget.chatUser,
//                         type: MessageType.audio,
//                         isFirstMessage: messagesList.isEmpty,
//                         filePath: path,
//                         length: duration);
//                     setState(() => _isUploading = false);
//                   },
//                 ),

//                 //adding some space
//                 SizedBox(width: mq.width * .02),
//               ],
//             ),
//           ),
//         ),

//         //send message
//         MaterialButton(
//           onPressed: () {
//             if (_textController.text.isNotEmpty) {
//               ChatUtils.sendMessage(
//                 chatUser: widget.chatUser,
//                 msg: _textController.text,
//                 type: MessageType.text,
//                 isFirstMessage: messagesList.isEmpty,
//               );
//               _textController.clear();
//             }
//           },
//           minWidth: 0,
//           padding:
//               const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
//           shape: const CircleBorder(),
//           color: Colors.green,
//           child: const Icon(Icons.send, color: Colors.white, size: 28),
//         )
//       ],
//     ),
//   );
// }
