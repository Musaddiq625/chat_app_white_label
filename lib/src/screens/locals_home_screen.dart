import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/main_scaffold.dart';
import 'package:flutter/material.dart';

import '../components/bottom_nav_componenet.dart';
import '../components/custom_button.dart';

class LocalsHomeScreen extends StatefulWidget {
  const LocalsHomeScreen({super.key});

  @override
  State<LocalsHomeScreen> createState() => _LocalsHomeScreenState();
}

class _LocalsHomeScreenState extends State<LocalsHomeScreen> {
  final List<ImageProvider> images = [
    NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your image URL
    NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    NetworkImage(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    // Replace with your asset path
    // Add more image providers as needed
  ];
  double radius = 30;

  @override
  Widget build(BuildContext context) {

    return MainScaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _eventWidget(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _topData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Locals",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        const Spacer(),
        CustomIconWidget(
          iconData: Icons.notifications,
          borderColor: Colors.transparent,
          backgroundColor: Colors.black12,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        SizedBox(width: 10),
        CustomIconWidget(
          iconData: Icons.sort,
          borderColor: Colors.transparent,
          backgroundColor: Colors.black12,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        SizedBox(width: 10),
        CustomIconWidget(
          iconData: Icons.search_rounded,
          borderColor: Colors.transparent,
          backgroundColor: Colors.black12,
          iconColor: Colors.white,
          circleSize: 40,
        )
      ],
    );
  }

  Widget _eventWidget() {
    return Stack(children: [
      Positioned.fill(
        child: Image.network(
          "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topData(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Align children vertically
                  children: [
                    SizedBox(
                      width: radius * images.length.toDouble(),
                      // Calculate the total width of images
                      height: radius,
                      // Set the height to match the image size
                      child: Stack(
                        children: [
                          for (int i = 0; i < images.length; i++)
                            Positioned(
                              left: i * radius / 1.5,
                              // Adjust the left offset
                              child: ClipOval(
                                child: Image(
                                  // color: Colors.red,
                                  image: images[i],
                                  width: radius,
                                  height: radius,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      "+1456 Joined",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  "Property \nnetworking event",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "17 Feb . 11AM - 2PM . Manchester",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        buttonText: "View Event", onPressedFunction: () {}),
                    const Spacer(),
                    CustomIconWidget(
                      iconData: Icons.heart_broken,
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      circleSize: 40,
                    ),
                    SizedBox(width: 10),
                    CustomIconWidget(
                      iconData: Icons.share,
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      circleSize: 40,
                    ),
                    SizedBox(width: 10),
                    CustomIconWidget(
                      iconData: Icons.menu,
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      circleSize: 40,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
