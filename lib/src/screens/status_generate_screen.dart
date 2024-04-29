import 'dart:io';

import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../constants/color_constants.dart';

class StatusGenerateScreen extends StatefulWidget {
  // final File imageFile;
  final List<File> imageFiles;

  StatusGenerateScreen({Key? key, required this.imageFiles}) : super(key: key);

  @override
  _StatusGenerateScreenState createState() => _StatusGenerateScreenState();
}

class _StatusGenerateScreenState extends State<StatusGenerateScreen> {
  final TextEditingController _commentController = TextEditingController();
  late List<TextEditingController> _captionControllers;
  late LoadingDialog _customLoadingDialog;
  Map<String, VideoPlayerController> _videoPlayers = {};
  bool _isUploading = false;
  late VideoPlayerController _controller;
  late Map<String, Duration> _videoPositions = {};

  @override
  void initState() {
    super.initState();
    _captionControllers = List.generate(
      widget.imageFiles.length,
      (index) => TextEditingController(),
    );
    for (final file in widget.imageFiles) {
      if (!isImage(file)) {
        _videoPlayers[file.path] = _initializeVideoPlayer(file);
      }
    }
    // _customLoadingDialog = LoadingDialog(context);
  }

  @override
  void dispose() {
    // Dispose all video players when the widget is disposed
    _videoPlayers.values.forEach((player) => player.dispose());
    super.dispose();
  }

  Future<void> _uploadImages() async {
    setState(() {
      _isUploading = true;
    });

    print("widget.imageFiles ${widget.imageFiles.length}");
    LoadingDialog.showLoadingDialog(context);
    // for (var imageFile in widget.imageFiles)
    for (int index = 0; index < widget.imageFiles.length; index++) {
      String fileName =
          'images/${DateTime.now().millisecondsSinceEpoch}_${widget.imageFiles[index].path.split('/').last}';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("StatusImage/$fileName");
      UploadTask uploadTask = ref.putFile(widget.imageFiles[index]);

      try {
        String caption = _captionControllers[index].text.trim();
        final snapshot = await uploadTask.whenComplete(() => {});
        final imageUrl = await snapshot.ref.getDownloadURL();
        print("imageUrl - ${imageUrl}");
        print("snapshot - ${snapshot}");
        print("caption - ${caption}");
        // imageUrls.add(imageUrl);
        FirebaseFirestore.instance.collection('images').add({
          'urls': imageUrl,
          'comment': caption,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Assuming _uploadStoryData now takes a list of image URLs
        await _uploadStoryData(context, imageUrl, caption);
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
    LoadingDialog.hideLoadingDialog(context);
    setState(() {
      _isUploading = false;
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _uploadStoryData(
      BuildContext context, String imageUrl, String caption) async {
    print("Image Url = $imageUrl");
    print("_commentController.text.trim() = ${_commentController.text.trim()}");
    print("_captionControllers[index], ${_captionControllers[0]}");
    var uuid = Uuid();
    String uniqueId = uuid.v4();
    String storyUniqueId = uuid.v1();
    String? userId = FirebaseUtils.user?.id;
    String storyId = "storyId";
    String? name = FirebaseUtils.user?.firstName;
    String id = "id";
    String? userImage = FirebaseUtils.user?.image;

    String storiesDataId = DateTime.now().millisecondsSinceEpoch.toString();

    DocumentReference docRef =
        FirebaseFirestore.instance.collection('story').doc(userId);
    DocumentReference docRefStories =
        FirebaseFirestore.instance.collection('stories').doc(storiesDataId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      DocumentSnapshot snapshot2 = await transaction.get(docRefStories);

      if (!snapshot.exists) {
        transaction.set(docRef, {
          'id': uniqueId,
          'user_id': userId,
          'name': name,
          'image': userImage,
          'stories': [storiesDataId],
        });
      } else {
        transaction.update(docRef, {
          'stories': FieldValue.arrayUnion([storiesDataId]),
        });
      }

      if (!snapshot2.exists) {
        transaction.set(docRefStories, {
          'story_image': imageUrl,
          'user_id': userId,
          'story_id': storiesDataId,
          'story_msg': caption, // _commentController.text,
          'time':
              storiesDataId, //DateTime.now().millisecondsSinceEpoch.toString(),// This will set the current time
        });
      }
    }).then((_) {
      print("Story uploaded successfully");
    }).catchError((error) {
      print("Error uploading story $error");
    });
  }

  VideoPlayerController _initializeVideoPlayer(File file) {
    VideoPlayerController controller = VideoPlayerController.file(file);
    controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      controller.setLooping(
          true); // Set looping to true so the video continues to play
      // controller.play(); // Play the video
    });
    return controller;
  }

  bool isImage(File file) {
    return file.path.endsWith('.jpg') ||
        file.path.endsWith('.jpeg') ||
        file.path.endsWith('.png');
  }

  void _playVideo(String videoPath) async {
    // if (_videoPlayers[videoPath] != null && !_videoPlayers[videoPath]!.value.isPlaying) {
    //   _videoPlayers[videoPath]!.play();
    // }
    if (_videoPlayers.containsKey(videoPath)) {
      // Check if there is a stored position for this video
      if (_videoPositions.containsKey(videoPath)) {
        _videoPlayers[videoPath]!.seekTo(_videoPositions[videoPath]!);
      }
      await _videoPlayers[videoPath]!.play();

      setState(() {});
    }
  }

  void _pauseVideo(String videoPath) async {
    if (_videoPlayers[videoPath] != null &&
        _videoPlayers[videoPath]!.value.isPlaying) {
      _videoPositions[videoPath] =
          _videoPlayers[videoPath]!.value.position; // Store current position
      await _videoPlayers[videoPath]!.pause();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   child: Image.file(
          //     widget.imageFile,
          //     fit: BoxFit.cover,
          //     height: double.infinity,
          //     width: double.infinity,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 45,
          //   // Adjust this value based on the width of your send button
          //   child: Container(
          //     padding: EdgeInsets.all(8.0),
          //     child: TextField(
          //       maxLines: null,
          //       expands: false,
          //       controller: _commentController,
          //       decoration: InputDecoration(
          //         prefixIcon: Icon(
          //           Icons.image,
          //           color: Colors.white,
          //         ),
          //         labelText: 'Add a caption...',
          //         labelStyle: TextStyle(color: Colors.white),
          //         fillColor: Colors.grey.shade800,
          //         filled: true,
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
          PageView.builder(
            itemCount: widget.imageFiles.length,
            itemBuilder: (context, index) {
              final file = widget.imageFiles[index];
              String type = widget.imageFiles[index].toString();
              bool isImageFile = isImage(file);
              if (!isImageFile && !_videoPlayers.containsKey(file.path)) {
                _videoPlayers[file.path] = _initializeVideoPlayer(file);
              }
              return Column(
                children: [
                  Expanded(
                    child: isImageFile
                        ? Image.file(
                            file,
                            fit: BoxFit.cover,
                          )
                        : FutureBuilder(
                            future: _videoPlayers[file.path]!.initialize(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AspectRatio(
                                  aspectRatio: _videoPlayers[file.path]!
                                      .value
                                      .aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      VideoPlayer(_videoPlayers[file.path]!),
                                      VideoProgressIndicator(
                                          _videoPlayers[file.path]!,
                                          allowScrubbing: true),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                  ),
                  if (type.contains('mp4'))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(_videoPlayers[file.path]!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () {
                            if (_videoPlayers[file.path]!.value.isPlaying) {
                              _pauseVideo(file.path);
                            } else {
                              _playVideo(file.path);
                            }
                          },
                        ),
                        // Add any other buttons or controls you need here
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _captionControllers[index],
                      decoration: InputDecoration(
                        hintText: 'Add a caption...',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                _uploadImages(); // Call the upload method
                // }
              },
              child: CircleAvatar(
                backgroundColor: ColorConstants.green,
                radius: 20,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
