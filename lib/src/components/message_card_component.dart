import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/api_utlils.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:chat_app_white_label/src/utils/dialogs.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_message_package/voice_message_package.dart';
// import 'package:gallery_saver/gallery_saver.dart';

import '../models/message_model.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.message,
  });
  final MessageModel message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  // late final chatRoomCubit = BlocProvider.of<ChatRoomCubit>(context);
  // AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseUtils.user?.id == widget.message.fromId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _greenMessage() : _blueMessage());
  }

  // sender or another user message
  Widget _blueMessage() {
    //update last read message if sender and receiver are different
    if (widget.message.readAt == null) {
      FirebaseUtils.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //message content
        SizedBox(
          width: mq.width * 0.95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: widget.message.type == MessageType.image
                      ? mq.width * 0.6
                      : null,
                  padding: EdgeInsets.only(
                      left: widget.message.type == MessageType.audio ? 0 : 10,
                      right: widget.message.type == MessageType.audio ? 0 : 10,
                      top: 10,
                      bottom: 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: mq.width * .04, vertical: mq.height * .01),
                  decoration: BoxDecoration(
                      color: ColorConstants.blueLight,
                      border: Border.all(color: Colors.lightBlue),
                      //making borders curved
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.message.type == MessageType.text
                          ?
                          //show text
                          Text(
                              widget.message.msg ?? '',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            )
                          : widget.message.type == MessageType.audio
                              // voice message
                              ? VoiceMessageView(
                                  backgroundColor: ColorConstants.blueLight,
                                  innerPadding: 0,
                                  circlesColor: ColorConstants.blackLight,
                                  counterTextStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.blackLight),
                                  activeSliderColor: Colors.grey,
                                  controller: VoiceController(
                                    audioSrc: widget.message.msg ?? '',
                                    maxDuration: Duration(
                                        seconds: widget.message.length ?? 0),
                                    isFile: false,
                                    onComplete: () {},
                                    onPause: () {},
                                    onPlaying: () {},
                                    // onError: (err) {},
                                  ),
                                )
                              :
                              //show image
                              SizedBox(
                                  width: mq.width * 0.6,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.message.msg ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.image, size: 70),
                                    ),
                                  ),
                                ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.message.type == MessageType.audio)
                            const SizedBox(width: 10),
                          Text(
                            DateUtil.getFormattedTime(
                                context, widget.message.sentAt ?? ''),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //message content
        // Spacer(),
        SizedBox(
          width: mq.width * 0.95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  width: widget.message.type == MessageType.image
                      ? mq.width * 0.6
                      : null,
                  padding: EdgeInsets.only(
                      left: widget.message.type == MessageType.audio ? 0 : 10,
                      right: widget.message.type == MessageType.audio ? 0 : 10,
                      top: 10,
                      bottom: 10),
                  margin: EdgeInsets.symmetric(
                      horizontal: mq.width * .04, vertical: mq.height * .01),
                  decoration: BoxDecoration(
                      color: ColorConstants.greenLight,
                      border: Border.all(color: Colors.lightGreen),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.message.type == MessageType.text
                          ?
                          //show text
                          Text(
                              widget.message.msg ?? '',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87),
                              softWrap: true,
                              maxLines: 100,
                            )
                          : widget.message.type == MessageType.audio
                              // voice message
                              ? VoiceMessageView(
                                  backgroundColor: ColorConstants.greenLight,
                                  innerPadding: 0,
                                  circlesColor: ColorConstants.blackLight,
                                  counterTextStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.blackLight),
                                  activeSliderColor: Colors.grey,
                                  controller: VoiceController(
                                    audioSrc: widget.message.msg ?? '',
                                    maxDuration: Duration(
                                        seconds: widget.message.length ?? 0),
                                    isFile: false,
                                    onComplete: () {},
                                    onPause: () {},
                                    onPlaying: () {},
                                    // onError: (err) {},
                                  ),
                                )
                              : //show image
                              SizedBox(
                                  width: mq.width * 0.6,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.message.msg ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.image, size: 70),
                                    ),
                                  ),
                                ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.done_all_rounded,
                              color: widget.message.readAt != null
                                  ? Colors.blue
                                  : Colors.grey,
                              size: 15),
                          const SizedBox(width: 2),
                          Text(
                            DateUtil.getFormattedTime(
                                context, widget.message.sentAt ?? ''),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                          ),
                          if (widget.message.type == MessageType.audio)
                            const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _audio({
  //   required String message,
  //   required bool isCurrentUser,
  //   required int index,
  //   required String time,
  //   required String duration,
  // }) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.5,
  //     padding: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       color: isCurrentUser
  //           ? ColorConstants.greenMain
  //           : ColorConstants.greenMain.withOpacity(0.18),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Row(
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             chatRoomCubit.onPressedPlayButton(index, message);
  //             // changeProg(duration: duration);
  //           },
  //           onSecondaryTap: () {
  //             audioPlayer.stop();
  //             //    chatRoomCubit.completedPercentage.value = 0.0;
  //           },
  //           child: (chatRoomCubit.isRecordPlaying &&
  //                   chatRoomCubit.currentId == index)
  //               ? Icon(
  //                   Icons.cancel,
  //                   color:
  //                       isCurrentUser ? Colors.white : ColorConstants.greenMain,
  //                 )
  //               : Icon(
  //                   Icons.play_arrow,
  //                   color:
  //                       isCurrentUser ? Colors.white : ColorConstants.greenMain,
  //                 ),
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 0),
  //             child: Stack(
  //               clipBehavior: Clip.none,
  //               alignment: Alignment.center,
  //               children: [
  //                 // Text( chatRoomCubit.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
  //                 LinearProgressIndicator(
  //                   minHeight: 5,
  //                   backgroundColor: Colors.grey,
  //                   valueColor: AlwaysStoppedAnimation<Color>(
  //                     isCurrentUser ? Colors.white : ColorConstants.greenMain,
  //                   ),
  //                   value: (chatRoomCubit.isRecordPlaying &&
  //                           chatRoomCubit.currentId == index)
  //                       ? chatRoomCubit.completedPercentage
  //                       : chatRoomCubit.totalDuration.toDouble(),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         Text(
  //           duration,
  //           style: TextStyle(
  //               fontSize: 12,
  //               color: isCurrentUser ? Colors.white : ColorConstants.greenMain),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // bottom sheet for modifying message details
  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              widget.message.type == MessageType.text
                  ?
                  //copy option
                  _OptionItem(
                      icon: const Icon(Icons.copy_all_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Copy Text',
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.msg ?? ''))
                            .then((value) {
                          //for hiding bottom sheet
                          Navigator.pop(context);

                          Dialogs.showSnackbar(context, 'Text Copied!');
                        });
                      })
                  :
                  //save option
                  _OptionItem(
                      icon: const Icon(Icons.download_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Save Image',
                      onTap: () async {
                        // try {
                        //   log('Image Url: ${widget.message.msg}');
                        //   await GallerySaver.saveImage(widget.message.msg,
                        //           albumName: 'We Chat')
                        //       .then((success) {
                        //     //for hiding bottom sheet
                        //     Navigator.pop(context);
                        //     if (success != null && success) {
                        //       Dialogs.showSnackbar(
                        //           context, 'Image Successfully Saved!');
                        //     }
                        //   });
                        // } catch (e) {
                        //   log('ErrorWhileSavingImg: $e');
                        // }
                      }),

              //separator or divider
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

              //edit option
              if (widget.message.type == MessageType.text && isMe)
                _OptionItem(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                    name: 'Edit Message',
                    onTap: () {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      _showMessageUpdateDialog();
                    }),

              //delete option
              if (isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      await APIs.deleteMessage(widget.message).then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      });
                    }),

              //separator or divider
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

              //sent time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                  name:
                      'Sent At: ${DateUtil.getMessageTime(context: context, time: widget.message.sentAt ?? '')}',
                  onTap: () {}),

              //read time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                  name: widget.message.readAt == null
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${DateUtil.getMessageTime(context: context, time: widget.message.readAt ?? '')}',
                  onTap: () {}),
            ],
          );
        });
  }

  //dialog for updating message content
  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg ?? '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(' Update Message')
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMsg,
                maxLines: null,
                onChanged: (value) => updatedMsg = value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )),

                //update button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                      APIs.updateMessage(widget.message, updatedMsg);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}
