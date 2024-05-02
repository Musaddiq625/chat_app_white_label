import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class ViewUserProfileScreen extends StatefulWidget {
  final UserModel user;
  const ViewUserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<ViewUserProfileScreen> createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
              backgroundColor: ColorConstants.greenMain,
              title: Text(widget.user.firstName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              leading: IconButton(
                onPressed: () => NavigationUtil.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
                color: ColorConstants.white,
              )),
          //body
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  //user profile picture
                  ProfileImageComponent(
                    url: widget.user.image,
                    size: 150,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Name: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.firstName ?? '',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16)),
                    ],
                  ),
                  // user phone number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Phone Number: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.phoneNumber ?? '',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 50),
                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.aboutMe ?? '',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (widget.user.isOnline == true)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Text('Online',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15)),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Last Seen: ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Text(
                            DateUtil.getLastMessageTime(
                                context: context,
                                time: widget.user.lastActive ?? '',
                                showYear: true),
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15)),
                      ],
                    )
                ],
              ),
            ),
          )),
    );
  }
}
