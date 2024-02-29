import 'dart:math';

import 'package:chat_app_white_label/src/models/StoriesNewModel.dart';
import 'package:chat_app_white_label/src/models/StoryNewModel.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../utils/firebase_utils.dart';

class StatusTileComponent extends StatefulWidget {
  const StatusTileComponent({super.key});

  @override
  _StatusTileComponentState createState() => _StatusTileComponentState();
}

class _StatusTileComponentState extends State<StatusTileComponent> {
  int currentIndex = 0;
  int currentInnerIndex = 0;

  //
  // void addUserToSeenList(String? storyDocumentId, String? storyId, String? userId) {
  //   // Reference to the story document in Firestore
  //   print("storyDocumentId $storyDocumentId  storyId $storyId  userId $userId");
  //
  //   DocumentReference storyDocRef = FirebaseFirestore.instance.collection('story').doc(storyDocumentId);
  //
  //   // Update the user_seen_List array within the stories map
  //
  //   storyDocRef.set({
  //     'stories.0.user_seen_List': FieldValue.arrayUnion([userId])
  //   },SetOptions(merge: true)).then((_) {
  //     print('User ID added to seen list');
  //   }).catchError((error) {
  //     print('Failed to add user ID to seen list: $error');
  //   });
  // }

  List<StoriesNewModel> _list = [];
  List<StoryNewModel> _storylist = [];

  @override
  void initState() {
    super.initState();
    fetchStories();
    fetchStoryData();
  }

  void addUserToSeenList(String? storyDocumentId, String? userId) {
    print("storyDocumentId $storyDocumentId  userId $userId");

    // Reference to the story document in Firestore
    DocumentReference storyDocRef =
        FirebaseFirestore.instance.collection('stories').doc(storyDocumentId);

    // Update the user_seen_list array directly within the story document
    storyDocRef.update({
      'user_seen_list': FieldValue.arrayUnion([userId])
    }).then((_) {
      print('User ID added to seen list in the specified story');
    }).catchError((error) {
      print('Failed to add user ID to seen list: $error');
    });
  }

  Future<void> fetchStories() async {
    // Listen to the stream of document snapshots from the 'stories' collection
    FirebaseUtils.getStories().listen((QuerySnapshot snapshot) {
      final data = snapshot.docs;

      try {
        setState(() {
          //    Map each document to a StoriesNewModel and add it to the list
          _list = data
              .map((e) {
                Map<String, dynamic> storyData =
                    e.data() as Map<String, dynamic>;
                DateTime storyTime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(storyData['time']));
                print("storyTime $storyTime");
                DateTime now = DateTime.now();
                Duration diff = now.difference(storyTime);

                // If the story is less than 24 hours old, add it to the list
                try {
                  if (diff.inHours <= 24) {
                    print("Story is not then 24 hour ${e.id}");
                    return StoriesNewModel.fromJson(storyData);
                  } else {
                    print("Story is older then 24 hour ${e.id}");
                    if (e.id.isNotEmpty) {
                      FirebaseUtils.deleteStory(
                          storyData['story_id'], storyData['user_id']);
                    }
                    // return StoriesNewModel.fromJson(storyData);

                    // If the story is older than 24 hours, don't return anything
                    return null;
                  }
                } catch (e) {
                  print('Error : ${e.toString()}');
                }
              })
              .whereType<StoriesNewModel>() // Filter out null values
              .toList();

          _list.forEach((story) {
            print('Story ID: ${story.storyId}');
          });
        });
      } catch (e) {
        print('An error occurred: $e');
      }

      // setState(() {
      //   // Map each document to a StoriesNewModel and add it to the list
      //   _list = data
      //       .map((e) =>
      //           StoriesNewModel.fromJson(e.data() as Map<String, dynamic>))
      //       .toList();
      // });
    });
  }

  // Future<void> fetchStoryData() async {
  //   // Listen to the stream of document snapshots from the 'stories' collection
  //   FirebaseUtils.getStoryUser().listen((QuerySnapshot snapshot) {
  //     final data = snapshot.docs;
  //
  //     setState(() {
  //       // Map each document to a StoriesNewModel and add it to the list
  //       _storylist = data
  //           .map(
  //               (e) => StoryNewModel.fromJson(e.data() as Map<String, dynamic>))
  //           .toList();
  //     });
  //   });
  // }

  Future<void> fetchStoryData() async {
    // Get the stream of matching contacts.
    Future<List<Map<String, dynamic>>> matchingContactsStream =
        FirebaseUtils.getMatchingContactsOnce();

    // Listen to the stream of document snapshots from the 'stories' collection.
    FirebaseUtils.getStoryUser().listen((QuerySnapshot storySnapshot) {
      final storyData = storySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Listen to the stream of matching contacts.
      matchingContactsStream
          .then((List<Map<String, dynamic>> matchingContacts) {
        print("contacts ${matchingContacts}");
        // Use the 'where' method to filter out stories based on matching contacts.
        final filteredStories = storyData.where((story) {
          // Check if the story's user ID is in the list of matching contacts.
          print("story_id ${story['user_id']} ");
          var containsContact = matchingContacts
              .any((contact) => contact['phoneNumber'] == story['user_id']);
          print("contain contacts ${containsContact}");
          return containsContact;
        }).toList();

        setState(() {
          // Map each filtered document to a StoriesNewModel and add it to the list.
          // _storylist =
          //     filteredStories.map((e) => StoryNewModel.fromJson(e)).toList();
          print("filterdstories ${filteredStories}");
          _storylist = filteredStories
              .where((e) => (e['stories'] as List)
                  .isNotEmpty) // Check if stories array is not empty
              .map((e) => StoryNewModel.fromJson(e))
              .toList();

          print("storyList ${_storylist}");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          currentInnerIndex = 0;
          return true;
        },
        child: Expanded(
            // child: StreamBuilder(
            //   stream: FirebaseUtils.getStories(),
            //   builder: (context, snapshot) {
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.waiting:
            //       case ConnectionState.none:
            //         return const SizedBox();
            //
            //       case ConnectionState.active:
            //       case ConnectionState.done:
            //         final data = snapshot.data?.docs;
            //         _list =
            //             data?.map((e) => StoriesNewModel.fromJson(e.data())).toList() ??
            //                 [];
            //         if (_list.isNotEmpty) {
            child: _storylist.isNotEmpty
                ? ListView.builder(
                    itemCount: _storylist.length,
                    itemBuilder: (context, index) {
                      int? seenValue = _storylist[index]
                          .stories
                          ?.where((story) => _list.any((item) =>
                              item.storyId == story &&
                              item.userSeenList!
                                  .contains(FirebaseUtils.user?.id)))
                          .length;

                      // String? storieTime = _storylist[index]
                      //     .stories
                      //     ?.where((story) => _list.any((item) => item.storyId == story))
                      //     .map((story) => _list.firstWhere((item) => item.storyId == story).time)
                      //     .firstWhere((time) => true, orElse: () => null);

                      _list.forEach((item) {
                        print("itemss ${item.storyId}");
                      });

                      String? storieTime =
                          _storylist[index].stories?.where((story) {
                        bool isInList =
                            _list.any((item) => item.storyId == story);
                        print('Is story $story in _list? $isInList');
                        return isInList;
                      }).map((story) {
                        StoriesNewModel? foundItem =
                            _list.firstWhere((item) => item.storyId == story);
                        print('Found item for story $story: $foundItem');
                        return foundItem.time;
                      }).firstWhere((time) => true, orElse: () {
                        print('No time found');
                        return null;
                      });

                      print("storieTimess ${storieTime}");

                      int timestamp = int.parse(storieTime ?? "0") ?? 0;

                      print("timeStamp ${timestamp}");

                      return InkWell(
                        onTap: () {
                          print(
                              '--Selected user ID: ${_storylist[index].userId}');
                          for (var story in _list) {
                            print('--Story user ID: ${story.storyId}');
                          }
                          final userStories = _list
                              .where((story) =>
                                  story.userId == _storylist[index].userId)
                              .toList();
                          print("userStories ${userStories}");
                          final List<StoryItem> storyItems =
                              userStories.map((story) {
                            if (story.storyImage != null &&
                                story.storyImage!.contains('mp4')) {
                              return StoryItem.pageVideo(
                                story.storyImage ?? '',
                                caption: story.storyMsg ?? '',
                                imageFit: BoxFit.fitHeight,
                                controller: StoryController(),
                              );
                            } else {
                              return StoryItem.pageImage(
                                url: story.storyImage ?? '',
                                caption: story.storyMsg ??
                                    '', // Replace with the correct property if different
                                controller:
                                    StoryController(), // You need to use the same controller for all items
                              );
                            }
                          }).toList();

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              body: StoryView(
                                storyItems: storyItems,
                                onComplete: () {
                                  currentInnerIndex = 0;
                                  NavigationUtil.pop(context);
                                },
                                onStoryShow: (s) {
                                  currentIndex = storyItems.indexOf(s);

                                  print("Stories Length ${userStories.length}");
                                  print("CurrentIndex-0 ${currentInnerIndex}");
                                  if (currentInnerIndex == userStories.length ||
                                      currentInnerIndex >= userStories.length) {
                                    // Reset currentInnerStoryIndex to zero
                                    currentInnerIndex = 0;
                                  }

                                  if (currentInnerIndex <= userStories.length) {
                                    print(
                                        'Current story id: ${userStories[currentIndex].storyId}');
                                    addUserToSeenList(
                                        userStories[currentIndex].storyId,
                                        FirebaseUtils.user?.id);
                                    currentInnerIndex++;
                                  }
                                  print("CurrentIndex-1 ${currentInnerIndex}");
                                },
                                controller: StoryController(),
                                // Provide the same controller used for the items
                                inline: false,
                                repeat: false,
                              ),
                            );
                          }));
                        },
                        child: ListTile(
                          leading: Transform.translate(
                            offset: Offset(-16, 0),
                            child: CustomPaint(
                              painter: StatusBorderPainter(
                                  statusNum: _storylist[index].stories?.length,
                                  seenValue: seenValue),
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  backgroundImage: NetworkImage(
                                    _storylist[index].image ??
                                        '', // Replace with the actual image URL
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Transform.translate(
                            offset: Offset(-30, 0),
                            child: Text(
                              '${_storylist[index].name}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          subtitle: Transform.translate(
                            offset: Offset(-30, 0),
                            child: Text(
                              FirebaseUtils.formatTimestamp(timestamp) ?? "",
                              // DateFormat('hh:mm a')
                              //     .format(latestStory),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                      //  }).toList(),
                      //  );
                    },
                  )
                : Center(
                    child: Text('No Story Available!',
                        style: TextStyle(fontSize: 14)),
                  )
            //  else {

            // }
            ));
  }
}

degreeToRad(double degree) {
  return degree * pi / 180;
}

class StatusBorderPainter extends CustomPainter {
  int? seenValue;
  int? statusNum;
  Set<int> viewedStatusNums = Set<int>();

  StatusBorderPainter({this.statusNum, this.seenValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0;

    if (statusNum != null) {
      if (viewedStatusNums.contains(statusNum)) {
        // Change the color for the viewed status
        paint.color = Colors.green; // Change this to the desired color
      } else {
        paint.color = Colors.grey;
      }
    } else {
      paint.color = Colors.green;
    }

    paint.style = PaintingStyle.stroke;
    drawArc(canvas, paint, size, statusNum, seenValue);

    if ((seenValue ?? 0) > 0 && statusNum != null) {
      viewedStatusNums.add(statusNum!);
      print("Viewed Status Numbers: $viewedStatusNums");
    }
  }

  void drawArc(
      Canvas canvas, Paint paint, Size size, int? count, int? seenValue) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double circleRadius =
        size.width < size.height ? size.width / 2 : size.height / 2;
    circleRadius *= 1.05;

    if (count == 1) {
      paint.color = seenValue! > 0 ? Colors.grey : Colors.green;

      double circleRadius =
          size.width < size.height ? size.width / 2 : size.height / 2;
      circleRadius *= 1.05; // Adjust the multiplier as needed

      canvas.drawCircle(Offset(centerX, centerY), circleRadius, paint);
    } else {
      double degree = -90;
      double arc = 360 / count!;
      for (int i = 0; i < count; i++) {
        if (i < seenValue!) {
          // Change the color for the seen parts
          paint.color = Colors.grey; // Change this to the desired color
        } else {
          // Reset the color for the remaining parts
          paint.color = Colors.green; // Change this to the original color
        }

        // Calculate the bounds for the arc based on the red circle's center and radius
        Rect arcBounds = Rect.fromCircle(
            center: Offset(centerX, centerY), radius: circleRadius);

        canvas.drawArc(arcBounds, degreeToRad(degree + 2), degreeToRad(arc - 5),
            false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
