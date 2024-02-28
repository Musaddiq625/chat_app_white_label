import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/main_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../components/bottom_nav_componenet.dart';
import '../components/bottom_sheet_component.dart';
import '../components/contacts_card_component.dart';
import '../components/custom_button.dart';
import '../models/contact.dart';

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


  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    ContactModel('Jesse Ebert', 'Graphic Designer',""),
    // ... other contacts
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
        IconComponent(
          iconData: Icons.notifications,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        SizedBox(width: 10),
        IconComponent(
          iconData: Icons.sort,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        SizedBox(width: 10),
        IconComponent(
          iconData: Icons.search_rounded,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
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
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 80),
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonComponent(
                        buttonText: "View Event", onPressedFunction: () {}),
                    const Spacer(),
                    IconComponent(
                      iconData: Icons.heart_broken,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: Colors.white,
                      circleSize: 35,
                      iconSize: 20,
                      onTap: () {
                        BottomSheetComponent.showBottomSheet(context,
                            takeFullHeightWhenPossible: false,
                            isShowHeader: false,
                            body: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 12, bottom: 12),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconComponent(
                                        iconData: Icons.share,
                                        borderColor: Colors.transparent,
                                        backgroundColor: ColorConstants.iconBg,
                                        iconColor: Colors.indigo,
                                        circleSize: 35,
                                        iconSize: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Save Event",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 12, bottom: 12),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconComponent(
                                        iconData: Icons.thumb_down,
                                        borderColor: Colors.transparent,
                                        backgroundColor: ColorConstants.iconBg,
                                        iconColor: Colors.indigo,
                                        circleSize: 35,
                                        iconSize: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Save Event",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 12, bottom: 12),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconComponent(
                                        iconData: Icons.remove_circle,
                                        borderColor: Colors.transparent,
                                        backgroundColor: ColorConstants.iconBg,
                                        iconColor: Colors.red,
                                        circleSize: 35,
                                        iconSize: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Report event",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                    SizedBox(width: 10),
                    IconComponent(
                        iconData: Icons.share,
                        borderColor: Colors.transparent,
                        backgroundColor: ColorConstants.iconBg,
                        iconColor: Colors.white,
                        circleSize: 35,
                        iconSize: 20,
                        onTap: () {
                          BottomSheetComponent.showBottomSheet(context,
                              takeFullHeightWhenPossible: false,
                              isShowHeader: false,
                              body: Container(
                                constraints: const BoxConstraints(maxHeight:600),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 18.0,top: 18,bottom: 18),
                                          child: Text(
                                            "Share event",
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        InkWell(
                                          onTap:()=>Navigator.pop(context),
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20.0),
                                            child: IconComponent(
                                              iconData: Icons.cancel_outlined,
                                              borderColor: Colors.transparent,
                                              iconColor: Colors.black,
                                              circleSize: 50,
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconComponent(
                                          iconData: Icons.link,
                                          borderColor: Colors.transparent,
                                          backgroundColor: ColorConstants.yellow,
                                          iconColor: Colors.white,
                                          circleSize: 60,
                                          customText: "Copy Link",
                                        ),

                                        IconComponent(
                                          iconData: Icons.facebook,
                                          borderColor: Colors.transparent,
                                          backgroundColor: ColorConstants.blue,
                                          circleSize: 60,
                                          customText: "Facebook",
                                        ),

                                        IconComponent(
                                          iconData: Icons.install_desktop,
                                          borderColor: Colors.transparent,
                                          circleSize: 60,
                                          customText: "Instagram",
                                        ),

                                        IconComponent(
                                          iconData: Icons.share,
                                          borderColor: Colors.transparent,
                                          backgroundColor:  Color.fromARGB(
                                              255, 87, 64, 208),
                                          circleSize: 60,
                                          customText: "Share",
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Divider(
                                      thickness: 0.5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0,top: 10,bottom: 16),
                                      child: Text(
                                        "Your Connections",
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: contacts.length,
                                        itemBuilder: (context, index) {
                                          return ContactCard(contact: contacts[index]);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                    SizedBox(width: 10),
                    IconComponent(
                      iconData: Icons.menu,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: Colors.white,
                      circleSize: 35,
                      iconSize: 20,
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
