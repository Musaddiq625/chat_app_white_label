import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/chat_input_icon_component.dart';
import 'package:chat_app_white_label/src/components/record_button_component.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputComponent extends StatefulWidget {
  final TextEditingController controller;
  final Function() onTextInputTap;
  final Function() onEmojiTap;
  final Function() onDocumentSelection;
  final Function() onImageSelection;
  final Function() onCameraSelection;
  final Function(String, int) onRecordingFinished;
  final Function() onSendButtonTap;
  const ChatInputComponent(
      {super.key,
      required this.controller,
      required this.onTextInputTap,
      required this.onEmojiTap,
      required this.onDocumentSelection,
      required this.onImageSelection,
      required this.onCameraSelection,
      required this.onRecordingFinished,
      required this.onSendButtonTap});

  @override
  State<ChatInputComponent> createState() => _ChatInputComponentState();
}

class _ChatInputComponentState extends State<ChatInputComponent> {
  late final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              color: themeCubit.darkBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  ChatInputIconComponent(
                      icon: Icons.emoji_emotions, onTap: widget.onEmojiTap),

                  Expanded(
                      child: TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: widget.onTextInputTap,
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  )),

                  //pick doc from storage button
                  ChatInputIconComponent(
                      icon: Icons.description_rounded,
                      onTap: widget.onDocumentSelection),

                  //pick image from gallery button
                  ChatInputIconComponent(
                      icon: Icons.image, onTap: widget.onImageSelection),

                  //take image from camera button
                  ChatInputIconComponent(
                      icon: Icons.camera_alt_rounded,
                      onTap: widget.onCameraSelection),

                  //voice message mutton
                  RecordButtonComponent(

                    onRecordingFinished: widget.onRecordingFinished,
                  ),

                  //adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          //send message
          MaterialButton(
            onPressed: widget.onSendButtonTap,
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: themeCubit.primaryColor,
            child: const Icon(Icons.send, color: Colors.black, size: 28),
          )
        ],
      ),
    );
  }
}
