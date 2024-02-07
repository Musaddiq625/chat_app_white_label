import 'dart:io';

import 'package:chat_app_white_label/src/components/status_tiles_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/screens/status_generate_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/StoryModel.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with AutomaticKeepAliveClientMixin {
  // Move the methods and variables that need to maintain state here

  List<StoryModel> stories = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchStories(String? userId) async {
    // Reference to the document
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('story').doc(userId);

    // Getting the document snapshot
    DocumentSnapshot docSnapshot = await docRef.get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Convert the document snapshot to a Map
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      // Access the 'stories' array from the Map
      List<dynamic>? stories = data?['stories'];

      // Use the 'stories' array as needed
      if (stories != null) {
        for (var story in stories) {
          print("story $story"); // Do something with each story
        }
      }
    } else {
      print("Document does not exist.");
    }
  }

  Future<List<StoryModel>> fetchAllStories() async {
    // Reference to the collection
    CollectionReference storyCollection =
        FirebaseFirestore.instance.collection('story');

    // Get all documents in the collection
    QuerySnapshot querySnapshot = await storyCollection.get();

    // Initialize an empty list to store the stories

    // Loop through each document in the collection
    for (var doc in querySnapshot.docs) {
      // Convert the document snapshot to a StoryModel object
      StoryModel story = StoryModel.fromJson(doc);

      // Add the story to the list
      stories.add(story);
    }

    print("Stories ${stories.toList()}");

    // Return the list of stories
    return stories;
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: const Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/woman.png',
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 30,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.green,
                          radius: 10,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'My Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                    'tap to add status update',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    showImageSourceDialog(context);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Recent Updates',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Expanded(
              //     child: StreamBuilder(
              //   stream: FirebaseUtils.getStoryUser(),
              //   builder: (context, snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.waiting:
              //       case ConnectionState.none:
              //         return const SizedBox();
              //
              //       case ConnectionState.active:
              //       case ConnectionState.done:
              //         final data = snapshot.data?.docs;
              //         _list = data
              //                 ?.map((e) => StoryModel.fromJson(e.data()))
              //                 .toList() ??
              //             [];
              //         print("StoryList $_list");
              //         if (_list.isNotEmpty) {
              //           return ListView.builder(
              //               reverse: true,
              //               itemCount: _list.length,
              //               padding: EdgeInsets.only(top: mq.height * .01),
              //               physics: const BouncingScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 // return MessageCard(message: _list[index]);
              //                 // return MessageCard(message: _list[index]);
              //                 return  StatusTileComponent();
              //               });
              //         }
              //         else {
              //           return const Center(
              //             child: Text('No Story Available !',
              //                 style: TextStyle(fontSize: 14)),
              //           );
              //         }
              //     }
              //   },
              // )),
              const StatusTileComponent(),
              // OthersStatus(
              //   name: stories[0].name,
              //   seenvalue: 0,
              //   statusNum: 3,
              //   imageName: stories[0].image,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              StatusGenerateScreen(imageFile: File(image.path)),
        ),
      );
      // Use the image file as needed
    }
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
