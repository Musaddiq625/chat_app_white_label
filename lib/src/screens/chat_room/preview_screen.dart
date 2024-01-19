import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatefulWidget {
  final bool isVideo;
  final String mediaUrl;

  const PreviewScreen({Key? key, required this.isVideo, required this.mediaUrl})
      : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.mediaUrl))
        ..initialize().then((_) {
          setState(() {});
        })
        ..addListener(_videoListener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
  }

  void _videoListener() {
    if (_controller != null && _controller!.value.isInitialized) {
      // Check if the video has ended
      if (_controller!.value.position == _controller!.value.duration) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    EdgeInsets safeArea = MediaQuery.of(context).padding;
    double aspectRatio = screenWidth / (screenHeight - safeArea.top);
    if ((!_controller!.value.isInitialized || _controller == null) &&
        widget.isVideo) {
      return const Center(
          child: CircularProgressIndicator(
        color: ColorConstants.greenMain,
      ));
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Display full-screen media
            AspectRatio(
              aspectRatio: aspectRatio,
              child: widget.isVideo && _controller != null
                  ? VideoPlayer(_controller!)
                  : Column(
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: widget.mediaUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorConstants.greenMain,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image, size: 70),
                          ),
                        ),
                      ],
                    ),
            ),
            if (widget.isVideo && _controller != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: VideoProgressIndicator(
                    _controller!,
                    colors:
                        const VideoProgressColors(playedColor: Colors.white),
                    allowScrubbing: true,
                  ),
                ),
              ),
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => NavigationUtil.pop(context),
              ),
            ),
            // Play/Pause button for videos
            if (widget.isVideo && _controller != null)
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause
                        // : _controller!.value.isCompleted
                        //     ? Icons.replay
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _controller!.value.isPlaying
                        ? await _controller?.pause()
                        : _controller!.value.isCompleted
                            ? [
                                await _controller!.seekTo(Duration.zero).then(
                                    (value) async => await _controller?.play()),
                              ]
                            : await _controller?.play();
                    setState(() {});
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
