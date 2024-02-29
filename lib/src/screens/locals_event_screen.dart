import 'package:flutter/material.dart';

import '../components/bottom_sheet_component.dart';
import '../components/contacts_card_component.dart';
import '../components/icon_component.dart';
import '../components/main_scaffold.dart';
import '../components/profile_image_component.dart';
import '../constants/color_constants.dart';
import '../models/contact.dart';

class LocalsEventScreen extends StatefulWidget {
  const LocalsEventScreen({super.key});

  @override
  State<LocalsEventScreen> createState() => _LocalsEventScreenState();
}

class _LocalsEventScreenState extends State<LocalsEventScreen> {
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    // ... other contacts
  ];
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.bgcolorbutton,
        foregroundColor: ColorConstants.white,
        onPressed: () {
          // Respond to button press
        },
        label: Row(
          children: [
            Text('Join'),
            // Text displayed before the icon
            SizedBox(width: 30),
            Icon(Icons.add_circle),
            // Adjust the space between text and icon as needed
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Adjust the border radius as needed
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, bottom: 80),
                child: IconComponent(
                  iconData: Icons.arrow_back_ios_new,
                  borderColor: Colors.transparent,
                  backgroundColor: ColorConstants.iconBg,
                  iconColor: ColorConstants.white,
                  iconSize: 20,
                  circleSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
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
                      style:
                          TextStyle(fontSize: 16, color: ColorConstants.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Property \nnetworking event",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "17 Feb . 11AM - 2PM . Manchester",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    IconComponent(
                      iconData: Icons.heart_broken,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: Colors.red,
                      customIconText: " 22",
                      circleSize: 48,
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
                        borderColor: ColorConstants.transparent,
                        backgroundColor: ColorConstants.iconBg,
                        iconColor: ColorConstants.white,
                        circleSize: 35,
                        iconSize: 20,
                        onTap: () {
                          BottomSheetComponent.showBottomSheet(context,
                              takeFullHeightWhenPossible: false,
                              isShowHeader: false,
                              body: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 600),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 18, bottom: 18),
                                          child: Text(
                                            "Share event",
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: IconComponent(
                                              iconData: Icons.cancel_outlined,
                                              borderColor: Colors.transparent,
                                              iconColor: Colors.black,
                                              circleSize: 50,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                          backgroundColor:
                                              ColorConstants.yellow,
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
                                          backgroundColor:
                                              Color.fromARGB(255, 87, 64, 208),
                                          circleSize: 60,
                                          customText: "Share",
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 10, bottom: 16),
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
                                          return ContactCard(
                                              contact: contacts[index]);
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
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: ColorConstants.white,
                      circleSize: 35,
                      iconSize: 20,
                    )
                  ],
                ),
              ),
              _aboutTheEvent(),
              _members(),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _aboutTheEvent() {
    return Card(
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 18),
            child: Text(
              "About the event",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorConstants.bgcolorbutton),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileImageComponent(url: ""),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1456 Participants",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Elena, Ilsa and more",
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.lightGray),
                        ),
                      ],
                    ),
                    Spacer(),
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
                  ],
                ),
                Divider(thickness: 0.2),
                Row(
                  children: [
                    ProfileImageComponent(url: ""),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Flexible Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Date will be decide later",
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.lightGray),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 0.2),
                Row(
                  children: [
                    ProfileImageComponent(url: ""),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manchester",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Exact location after joining",
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.lightGray),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 0.2),
                Row(
                  children: [
                    ProfileImageComponent(url: ""),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Free to join",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "No charity support required",
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.lightGray),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _members() {
    return Card(
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 18),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: ColorConstants.bgcolorbutton),
                  children: <TextSpan>[
                    TextSpan(text: "Members  "),
                    TextSpan(
                      text: "8",
                      style: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.5)),
                    ),
                  ],
                ),
              )),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const BouncingScrollPhysics(),
          //   itemCount: contacts.length,
          //   itemBuilder: (context, index) {
          //     return ContactCard(contact: contacts[index]);
          //   },
          // ),
          SizedBox(height: 20,),
          ...List.generate(contacts.length, (index) => ContactCard(contact: contacts[index])),
        ],
      ),
    );
  }
}
