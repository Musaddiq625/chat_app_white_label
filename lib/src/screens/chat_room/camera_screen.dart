import 'dart:io';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/chat_room/cubit/chat_room_cubit.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_thumbnail;

class CameraScreen extends StatefulWidget {
  // final CameraDescription camera;

  const CameraScreen({
    Key? key,
    //  required this.camera
  }) : super(key: key);
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isCameraInitialized = false;
  bool isVideoEnabled = false;
  bool isRecording = false;
  FlashMode flashMode = FlashMode.auto;
  // double _currentZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Center(
          child: CircularProgressIndicator(
        color: ColorConstants.greenMain,
      ));
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Expanded(child: CameraPreview(controller!)),
              ],
            ),
            Positioned(
              top: 25,
              right: 20,
              child: InkWell(
                onTap: toggleFlash,
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  radius: 25,
                  child: Icon(
                    flashMode == FlashMode.auto
                        ? Icons.flash_auto
                        : flashMode == FlashMode.off
                            ? Icons.flash_off
                            : Icons.flash_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 20,
              child: InkWell(
                onTap: () => NavigationUtil.pop(context),
                child: const CircleAvatar(
                  backgroundColor: Colors.black45,
                  radius: 25,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            if (!isRecording)
              Positioned(
                bottom: 30,
                right: 20,
                child: InkWell(
                  onTap: () => setState(() {
                    isVideoEnabled = !isVideoEnabled;
                  }),
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    radius: 25,
                    child: Icon(
                      isVideoEnabled ? Icons.camera_alt : Icons.videocam,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: GestureDetector(
                  onTap: isVideoEnabled ? recordVideo : takePicture,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    radius: 40,
                    child: Icon(
                      isVideoEnabled
                          ? isRecording
                              ? Icons.stop
                              : Icons.videocam
                          : Icons.camera_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initCamera() async {
    controller = CameraController(
        context.read<AppSettingCubit>().firstCamera!, ResolutionPreset.high);

    // Initialize controller
    try {
      await controller?.initialize();
      await controller?.setFlashMode(FlashMode.auto);
      setState(() {
        isCameraInitialized = controller!.value.isInitialized;
      });
    } catch (e) {
      LoggerUtil.logs(e);
    }
  }

  Future<void> toggleFlash() async {
    if (flashMode == FlashMode.auto) {
      await controller?.setFlashMode(FlashMode.off);
      setState(() {
        flashMode = FlashMode.off;
      });
    } else if (flashMode == FlashMode.off) {
      await controller?.setFlashMode(FlashMode.always);
      setState(() {
        flashMode = FlashMode.always;
      });
    } else {
      setState(() {
        flashMode = FlashMode.auto;
      });
    }
  }

  Future<void> recordVideo() async {
    try {
      if (isRecording) {
        final videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MediaPreviewScreen(
                      file: videoFile,
                      type: MessageType.video,
                    )));
      } else {
        await controller?.prepareForVideoRecording();
        await controller?.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      LoggerUtil.logs(e);
    }
  }

  Future<void> takePicture() async {
    try {
      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await controller?.takePicture();

      // If the picture was taken, display it on a new screen.
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MediaPreviewScreen(
            file: image!,
            type: MessageType.image,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      LoggerUtil.logs(e);
    }
  }
}

class MediaPreviewScreen extends StatefulWidget {
  final XFile file;
  final MessageType type;

  const MediaPreviewScreen({super.key, required this.file, required this.type});

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  late ChatRoomCubit chatRoomCubit = BlocProvider.of<ChatRoomCubit>(context);
  VideoPlayerController? videoController;
  String? thumbnailPath;
  bool thumbnailLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.type == MessageType.video) {
        startVideoPlayer(widget.file);
      }
    });
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets safeArea = MediaQuery.of(context).padding;
    double aspectRatio = screenWidth / (screenHeight - safeArea.top);
    if (videoController == null && widget.type == MessageType.video ||
        thumbnailLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: ColorConstants.greenMain,
      ));
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: widget.type == MessageType.video
                  // video preview in loop
                  ? VideoPlayer(videoController!)
                  // image preview
                  : Column(
                      children: [
                        Expanded(
                            child: Image.file(
                          File(widget.file.path),
                          fit: BoxFit.cover,
                        ))
                      ],
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black45,
                        radius: 40,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (widget.type == MessageType.image) {
                          chatRoomCubit.onMediaSelected(
                              widget.file.path, widget.type);
                          NavigationUtil.pop(context);
                          NavigationUtil.pop(context);
                        } else {
                          thumbnailPath = await createThumbnail(widget.file);
                          if (thumbnailPath != null) {
                            chatRoomCubit.onMediaSelected(
                              widget.file.path,
                              widget.type,
                              thumbnailPath,
                            );
                            NavigationUtil.pop(context);
                            NavigationUtil.pop(context);
                          }
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.black45,
                        radius: 40,
                        child: Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startVideoPlayer(XFile videoFile) async {
    try {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/videos';
      await Directory(dirPath).create(recursive: true);
      final String filePath =
          '$dirPath/${DateTime.now().millisecondsSinceEpoch}.mp4';
      final File newVideo = await File(videoFile.path).copy(filePath);

      videoController = VideoPlayerController.file(newVideo)
        ..initialize().then((_) {
          setState(() {});
          videoController?.play();
          videoController?.setLooping(true);
        });
    } catch (e) {
      LoggerUtil.logs(e);
    }
  }

  Future<String?> createThumbnail(XFile videoFile) async {
    try {
      setState(() {
        thumbnailLoading = true;
      });
      final thumbnailPath = await video_thumbnail.VideoThumbnail.thumbnailFile(
        video: videoFile.path, imageFormat: video_thumbnail.ImageFormat.JPEG,
        // thumbnailPath: (await getTemporaryDirectory()).path,
        quality: 25,
      );
      setState(() {
        thumbnailLoading = false;
      });
      return thumbnailPath;
    } catch (e) {
      LoggerUtil.logs(e);
      return null;
    }
  }
}
