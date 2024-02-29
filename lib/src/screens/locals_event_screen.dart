import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icons_button_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:flutter/material.dart';

import '../components/bottom_sheet_component.dart';
import '../components/contacts_card_component.dart';
import '../components/icon_component.dart';
import '../components/profile_image_component.dart';
import '../constants/color_constants.dart';
import '../models/contact.dart';

class LocalsEventScreen extends StatefulWidget {
  const LocalsEventScreen({super.key});

  @override
  State<LocalsEventScreen> createState() => _LocalsEventScreenState();
}

final String _fullText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
bool _showFullText = false;
bool ticketRequired = true;

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
  ];
  final List<ImageProvider> images = [
    const NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    const NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const NetworkImage(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    // Replace with your asset path
    // Add more image providers as needed
  ];
  double radius = 30;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      removeSafeAreaPadding: false,
      bgColor: ColorConstants.backgroundColor,
      widget: SingleChildScrollView(
        child: Column(
          children: [_eventWidget(), _members()],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonComponent(
              buttonText: 'Get Ticket',
              onPressedFunction: () {},
              bgcolor: ColorConstants.yellow,
            ),
            ButtonWithIconComponent(
              btnText: '  Join',
              icon: Icons.add_circle,
              width: 120,
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _eventWidget() {
    return Stack(children: [
      Image.network(
        "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        fit: BoxFit.fill,
        width: double.infinity,
        height: 500,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                children: [
                  SizedBox(
                    width: radius * images.length.toDouble(),
                    height: radius,
                    child: Stack(
                      children: [
                        for (int i = 0; i < images.length; i++)
                          Positioned(
                            left: i * radius / 1.5,
                            child: ClipOval(
                              child: Image(
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
                  const Text(
                    "+1456 Joined",
                    style: TextStyle(fontSize: 16, color: ColorConstants.white),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Property \nnetworking event",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "17 Feb . 11AM - 2PM . Manchester",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  IconComponent(
                    iconData: Icons.favorite,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.red,
                    customIconText: " 22",
                    circleSize: 60,
                    circleHeight: 35,
                    iconSize: 20,
                    onTap: _showMoreBottomSheet,
                  ),
                  const SizedBox(width: 10),
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
                              constraints: const BoxConstraints(maxHeight: 600),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
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
                                        backgroundColor: const Color.fromARGB(
                                            255, 87, 64, 208),
                                        circleSize: 60,
                                        customText: "Share",
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
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
                                          contact: contacts[index],
                                          showShareIcon: false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                  const SizedBox(width: 10),
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
            // _members(),
          ],
        ),
      ),
    ]);
  }

  Widget _aboutTheEvent() {
    return Card(
        color: ColorConstants.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "About the event",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorConstants.bgcolorbutton),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 18),
              child:
                  // Text(
                  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //   ),
                  // ),
                  GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullText = !_showFullText;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: _showFullText
                            ? _fullText
                            : (_fullText.length > 150
                                    ? _fullText.substring(0, 150)
                                    : _fullText) ??
                                "No description available",
                        style: TextStyle(color: Colors.black),
                      ),
                      if (_fullText.length > 150)
                        TextSpan(
                          text: _showFullText ? ' Show less' : ' ...Read more',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                    ],
                  ),
                ),
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
                      const ProfileImageComponent(url: ""),
                      const SizedBox(width: 10),
                      const Column(
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
                      const Spacer(),
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
                  const Divider(thickness: 0.2),
                  const Row(
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
                  const Divider(thickness: 0.2),
                  const Row(
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
                  if (ticketRequired == true) Divider(thickness: 0.2),
                  if (ticketRequired == true)
                    Row(
                      children: [
                        ProfileImageComponent(url: ""),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SR 150",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Ticket required to attend event",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ColorConstants.lightGray),
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
          ]),
        ));
  }

  Widget _members() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: ColorConstants.white,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 18),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorConstants.bgcolorbutton),
                    children: <TextSpan>[
                      const TextSpan(text: "Members  "),
                      TextSpan(
                        text: "8",
                        style: TextStyle(
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            ...List.generate(
                contacts.length,
                (index) => ContactCard(
                    contact: contacts[index], showShareIcon: false)),
          ],
        ),
      ),
    );
  }

  _showMoreBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.indigo,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Save Event",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.thumb_down,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.indigo,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Save Event",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.remove_circle,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.red,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Report event",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red)),
                ],
              ),
            ),
          ],
        ));
  }
}
