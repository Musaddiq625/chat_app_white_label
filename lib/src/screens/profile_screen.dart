import 'dart:io';

import 'package:chat_app_white_label/src/components/custom_button.dart';
import 'package:chat_app_white_label/src/constants/firebase_constants.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:chat_app_white_label/src/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../components/custom_text_field.dart';
import '../constants/route_constants.dart';
import '../utils/firebase_utils.dart';
import '../utils/navigation_util.dart';
import '../utils/service/firbase_auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String? phoneNumber;

  const ProfileScreen({super.key, this.phoneNumber});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = TextEditingController();
  final _controllerAbout = TextEditingController();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
          child: Column(
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: (_selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage(AssetConstants.profile))
                      as ImageProvider,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Phone Number : ${widget.phoneNumber}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: CustomTextField(
                    hintText: 'Profile Name',
                    maxLength: 30,
                    keyboardType: TextInputType.name,
                    controller: _controller,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      setState(() {});
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: CustomTextField(
                    hintText: 'About',
                    maxLength: 35,
                    keyboardType: TextInputType.name,
                    controller: _controllerAbout,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      setState(() {});
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  buttonText: "Next",
                  onPressedFunction: () async {
                    if (_controller.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter the name",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    try {
                      final usersCollection =
                          firestore.collection(FirebaseConstants.users);
                      final userDocs = await usersCollection.get();

                      bool userExists = false;
                      for (var doc in userDocs.docs) {
                        print("docid ${doc.id}");
                        if (doc.id == widget.phoneNumber?.replaceAll('+', '')) {
                          userExists = true;
                          break;
                        }
                      }
                      // final user = auth.currentUser;
                      // final userDoc = await FirebaseFirestore.instance
                      //     .collection(FirebaseConstants.users)
                      //     .doc(user?.uid)
                      //     .get();
                      //   print("User ${user?.uid}");
                      //   print("User doc ${userDoc.id}");
                      if (userExists) {
                        try {
                          // final extension = p.extension(_selectedImage!.path);
                          // UploadTask task = storage.ref("profile_picture/$fileName$extension").putFile(_selectedImage!);
                          // print("Image ${task} + extension ${ extension}");
                          // task.snapshotEvents.listen((TaskSnapshot snapshot) {
                          //   print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
                          // }, onError: (e) {
                          //   print(e);
                          // });
                          //
                          // await task.whenComplete(() => print('Upload completed'));
                          //
                          // String downloadURL = await storage.ref("profile_picture/$fileName$extension").getDownloadURL();

                          final imageUrl = await FirebaseUtils.uploadMedia(_selectedImage);
                          print("imageUrl ${imageUrl} ");
                          await firestore
                              .collection(FirebaseConstants.users)
                              .doc(widget.phoneNumber?.replaceAll('+', ''))
                              .update({
                            'name': _controller.text,
                            'image': imageUrl,
                            'about': _controllerAbout.text,
                          });
                          // ... rest of your code
                        } catch (error) {
                          print(
                              "Error during file upload or retrieval: $error");
                        }

                        // NavigationUtil.push(context, RouteConstants.chatScreen);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  phoneNumber: widget.phoneNumber?.replaceAll('+', ''),
                                )));
                      }
                    } catch (error) {
                      print(
                          error); // You might want to display a general error message to the user
                    }
                  }),
              // ElevatedButton(
              //   onPressed: () async {
              //     if (_controller.text.isEmpty) {
              //       Fluttertoast.showToast(
              //           msg: "Please enter the name",
              //           toastLength: Toast.LENGTH_SHORT,
              //           gravity: ToastGravity.BOTTOM,
              //           timeInSecForIosWeb: 1,
              //           backgroundColor: Colors.red,
              //           textColor: Colors.white,
              //           fontSize: 16.0);
              //       return;
              //     }
              //     try {
              //       final usersCollection =
              //           firestore.collection(FirebaseConstants.users);
              //       final userDocs = await usersCollection.get();
              //
              //       bool userExists = false;
              //       for (var doc in userDocs.docs) {
              //         print("docid ${doc.id}");
              //         if (doc.id == widget.phoneNumber?.replaceAll('+', '')) {
              //           userExists = true;
              //           break;
              //         }
              //       }
              //       // final user = auth.currentUser;
              //       // final userDoc = await FirebaseFirestore.instance
              //       //     .collection(FirebaseConstants.users)
              //       //     .doc(user?.uid)
              //       //     .get();
              //       //   print("User ${user?.uid}");
              //       //   print("User doc ${userDoc.id}");
              //       if (userExists) {
              //         try {
              //           // final extension = p.extension(_selectedImage!.path);
              //           // UploadTask task = storage.ref("profile_picture/$fileName$extension").putFile(_selectedImage!);
              //           // print("Image ${task} + extension ${ extension}");
              //           // task.snapshotEvents.listen((TaskSnapshot snapshot) {
              //           //   print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
              //           // }, onError: (e) {
              //           //   print(e);
              //           // });
              //           //
              //           // await task.whenComplete(() => print('Upload completed'));
              //           //
              //           // String downloadURL = await storage.ref("profile_picture/$fileName$extension").getDownloadURL();
              //
              //           final imageUrl =
              //               FirebaseUtils.uploadMedia(_selectedImage);
              //
              //           await firestore
              //               .collection(FirebaseConstants.users)
              //               .doc(widget.phoneNumber?.replaceAll('+', ''))
              //               .update({
              //             'name': _controller.text,
              //             'image': imageUrl,
              //             'about': _controllerAbout.text,
              //           });
              //           // ... rest of your code
              //         } catch (error) {
              //           print("Error during file upload or retrieval: $error");
              //         }
              //
              //         NavigationUtil.push(context, RouteConstants.chatScreen);
              //       }
              //     } catch (error) {
              //       print(
              //           error); // You might want to display a general error message to the user
              //     }
              //   },
              //   child: Text('Next'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
