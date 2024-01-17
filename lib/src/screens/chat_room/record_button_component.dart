import 'dart:async';
import 'dart:io';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

typedef RecordCallback = void Function(String);

class RecordButtonComponent extends StatefulWidget {
  final Function(String, int) onRecordingFinished;

  const RecordButtonComponent({Key? key, required this.onRecordingFinished})
      : super(key: key);

  @override
  State<RecordButtonComponent> createState() => _RecordButtonComponentState();
}

class _RecordButtonComponentState extends State<RecordButtonComponent> {
  bool _isRecording = false;
  // final _audioRecorder = AudioRecorder();
  // final audioPlayer = AudioPlayer();

  // Future<void> _startRecording() async {
  //   try {
  //     if (await _audioRecorder.hasPermission()) {
  //       await _audioRecorder.start(const RecordConfig(),
  //           path:
  //               '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.aac');
  //       setState(() => _isRecording = true);
  //     }
  //   } catch (e) {
  //     LoggerUtil.logs('errrr$e');
  //   }
  // }

  // Future<void> _stopRecording() async {
  //   try {
  //     final path = await _audioRecorder.stop();
  //     setState(() => _isRecording = false);
  //     if (path != null) {
  //       LoggerUtil.logs('path $path');
  //       final fileDuration = await getDuration(path);
  //       LoggerUtil.logs('fileDuration $fileDuration');
  //       widget.onRecordingFinished(path);
  //     }
  //   } catch (e) {
  //     LoggerUtil.logs('err222$e');
  //   }
  // }

  // Function to get the duration of the audio file
  // Future<Duration> getDuration(String path) async {
  //   try {
  //     await audioPlayer.setSourceDeviceFile(path); // Load the audio file
  //     final duration = await audioPlayer.getDuration(); // Get the duration
  //     LoggerUtil.logs('durr $duration');
  //     return duration ?? const Duration(milliseconds: 0);
  //   } catch (e) {
  //     LoggerUtil.logs('asdas$e');
  //     return Duration(milliseconds: 0);
  //   }
  // }

  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  String? _path;
  Duration _duration = const Duration();

  Future<void> startAudioRecord() async {
    try {
      await _requestPermissions();
      _path =
          '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
      setState(() => _isRecording = true);
      await _audioRecorder.openAudioSession();
      await _audioRecorder.startRecorder(
        toFile: _path!,
        codec: Codec.aacMP4,
      );
      await _audioRecorder.setSubscriptionDuration(const Duration(seconds: 1));
      _audioRecorder.onProgress?.listen((e) {
        _duration = e.duration;
      });
    } catch (e) {
      LoggerUtil.logs(e);
    }
  }

  Future<void> stopAudioRecord() async {
    try {
      await _audioRecorder.stopRecorder();
      await _audioRecorder.closeAudioSession();

      setState(() => _isRecording = false);

      LoggerUtil.logs('_path $_path');
      LoggerUtil.logs('_duration.inSeconds ${_duration.inSeconds}');
      widget.onRecordingFinished(_path!, _duration.inSeconds);
    } catch (e) {
      LoggerUtil.logs(e);
    }
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isRecording ? stopAudioRecord : startAudioRecord,
      child: Icon(
        _isRecording ? Icons.stop : Icons.mic,
        color: _isRecording ? Colors.red : ColorConstants.blueAccent,
      ),
    );
  }
}
