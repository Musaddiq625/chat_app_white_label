import 'dart:io';

import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../constants/color_constants.dart';

class StatusGenerateScreen extends StatefulWidget {
  final File imageFile;

  StatusGenerateScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _StatusGenerateScreenState createState() => _StatusGenerateScreenState();
}

class _StatusGenerateScreenState extends State<StatusGenerateScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isUploading = false;

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    // Generate a unique file name for the image
    String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch}_${widget.imageFile.path.split('/').last}';
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("StatusImage/$fileName");
    UploadTask uploadTask = ref.putFile(widget.imageFile);
    try {
      // Get the download URL
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Save the image URL and comment to Firestore
      FirebaseFirestore.instance.collection('images').add({
        'url': imageUrl,
        'comment': _commentController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      await _uploadStoryData(context, imageUrl);

      // Close the screen after upload
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Handle errors, e.g., show an error message
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Future<void> _uploadingImage(BuildContext context, File imageFile) async {
  //   // Generate a unique file name for the image
  //   String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child(fileName);
  //   UploadTask uploadTask = ref.putFile(imageFile);
  //
  //   // Get the download URL
  //   final snapshot = await uploadTask.whenComplete(() => {});
  //   final imageUrl = await snapshot.ref.getDownloadURL();
  //
  //   // Proceed to upload the story data to Firestore
  //   _uploadStoryData(context, imageUrl);
  // }

  Future<void> _uploadStoryData(BuildContext context, String imageUrl) async {
    print("Image Url = $imageUrl");
    print("_commentController.text.trim() = ${_commentController.text.trim()}");
    // Get the current user's ID and other details
    var uuid = Uuid();
    String uniqueId = uuid.v4();
    String storyUniqueId = uuid.v1();
    String? userId = FirebaseUtils.user?.id; // Replace with the actual user ID
    String storyId = "storyId"; // Generate a unique story ID if necessary
    String? name = FirebaseUtils.user?.name;
    String id = "id";
    String? userImage =
        FirebaseUtils.user?.image; // Replace with the actual user's name

    // Map<String, dynamic> storiesData = {
    //   'storyImage': imageUrl,
    //   'storyid': storyUniqueId,
    //   'storyMsg': _commentController.text,
    //    'time': Timestamp.now(), // This will set the current time
    // };

    String storiesDataId = DateTime.now().millisecondsSinceEpoch.toString();

    DocumentReference docRef =
        FirebaseFirestore.instance.collection('story').doc(userId);
    DocumentReference docRefStories =
        FirebaseFirestore.instance.collection('stories').doc(storiesDataId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document snapshot
      DocumentSnapshot snapshot = await transaction.get(docRef);
      DocumentSnapshot snapshot2 = await transaction.get(docRefStories);

      if (!snapshot.exists) {
        // If the document does not exist, create it with the initial story data
        transaction.set(docRef, {
          'id': uniqueId,
          'user_id': userId,
          'name': name,
          'image': userImage, // This might be the user's profile image
          'stories': [storiesDataId],
        });
      } else {
        // If the document exists, append the new story to the 'stories' array
        transaction.update(docRef, {
          'stories': FieldValue.arrayUnion([storiesDataId]),
        });
      }

      if (!snapshot2.exists) {
       transaction.set(docRefStories, {
          'story_image': imageUrl,
          'user_id': userId,
          'story_id': storiesDataId,
          'story_msg': _commentController.text,
          'time': storiesDataId,//DateTime.now().millisecondsSinceEpoch.toString(),// This will set the current time
        });
      }
    }).then((_) {
      print("Story uploaded successfully");
      // Success
      // Navigator.pop(context); // Handle navigation outside of this method
    }).catchError((error) {
      print("Error uploading story $error");
      // Handle errors, e.g., show an error message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.file(
              widget.imageFile,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 45,
            // Adjust this value based on the width of your send button
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                // Allows the TextField to expand vertically
                expands: false,
                controller: _commentController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  labelText: 'Add a caption...',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                //if (!_isUploading) { // Check if the upload is not already in progress
                _uploadImage(); // Call the upload method
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
