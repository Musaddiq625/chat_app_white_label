import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/contacts_card_component.dart';
import '../../components/icon_component.dart';
import '../../components/icons_button_component.dart';
import '../../components/info_sheet_component.dart';
import '../../components/profile_image_component.dart';
import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../models/contact.dart';

class LocalsEventScreen extends StatefulWidget {
  const LocalsEventScreen({super.key});

  @override
  State<LocalsEventScreen> createState() => _LocalsEventScreenState();
}

final String _fullText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
bool _showFullText = false;
bool ticketRequired = true;
final TextEditingController _controller = TextEditingController();

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
              buttonText: StringConstants.getTicket,
              onPressedFunction: () {},
              bgcolor: ColorConstants.yellow,
            ),
            ButtonWithIconComponent(
              btnText: '  ${StringConstants.join}',
              icon: Icons.add_circle,
              width: 120,
              onPressed: () {
                _showJoinBottomSheet();
              },
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
                onTap: () => Navigator.pop(context),
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
                    "+1456 ${StringConstants.joined}",
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
                                          StringConstants.shareEvent,
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
                                        customText: StringConstants.copyLink,
                                      ),
                                      IconComponent(
                                        iconData: Icons.facebook,
                                        borderColor: Colors.transparent,
                                        backgroundColor: ColorConstants.blue,
                                        circleSize: 60,
                                        customText: StringConstants.facebook,
                                      ),
                                      IconComponent(
                                        iconData: Icons.install_desktop,
                                        borderColor: Colors.transparent,
                                        circleSize: 60,
                                        customText: StringConstants.instagram,
                                      ),
                                      IconComponent(
                                        iconData: Icons.share,
                                        borderColor: Colors.transparent,
                                        backgroundColor: const Color.fromARGB(
                                            255, 87, 64, 208),
                                        circleSize: 60,
                                        customText: StringConstants.share,
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
                                      StringConstants.yourConnections,
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
                    onTap: _showMoreBottomSheet,
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
          padding: const EdgeInsets.all(18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              StringConstants.abouttheEvent,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorConstants.bgcolorbutton),
            ),
            SizedBox(
              height: 10,
            ),
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
                        text: _showFullText
                            ? ' ${StringConstants.showLess}'
                            : ' ...${StringConstants.readMore}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
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
                            "1456 ${StringConstants.participants}",
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
                            StringConstants.flexibleDate,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            StringConstants.dateWillbeDecidelater,
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
                            StringConstants.exactLocationAfterJoining,
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
                              StringConstants.ticketrequired,
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
                            StringConstants.freeToJoin,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            StringConstants.noCharityRequired,
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
                      const TextSpan(text: "${StringConstants.members}  "),
                      TextSpan(
                        text: contacts.length.toString(),
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
                  const Text(StringConstants.saveEvent,
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
                  const Text(StringConstants.saveEvent,
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
                  const Text(StringConstants.reportEvent,
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

  _showJoinBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConstants.join,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: IconComponent(
                      iconData: Icons.close,
                      borderColor: Colors.transparent,
                      iconColor: Colors.black,
                      circleSize: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Property \nnetworking event",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.black),
                  ),
                  Image.asset(
                    AssetConstants.group,
                    width: 100,
                    height: 80,
                  ),
                ],
              ),
              Text(StringConstants.freeToJoin),
              SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.5,
              ),
              _messageComponent(),
              const Divider(
                thickness: 0.5,
              ),
              Text(
                StringConstants.somethingToKnow,
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ProfileImageComponent(
                    url: "",
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "When you join, you're in the game!\n Chat's open and ready for you ",
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0.5,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ProfileImageComponent(
                    url: "",
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "When you join, you're in the game!\n Chat's open and ready for you ",
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonComponent(
                    buttonText: StringConstants.join,
                    onPressedFunction: () {
                      _sendMessage();
                      Navigator.pop(context);
                      BottomSheetComponent.showBottomSheet(
                        context,
                        isShowHeader: false,
                        body: InfoSheetComponent(
                          heading: StringConstants.requestSent,
                          body: StringConstants.requestStatus,
                          image: AssetConstants.group,
                        ),
                      );
                    },
                    horizontalLength: 120,
                    bgcolor: ColorConstants.yellow,
                  )
                ],
              )
            ],
          ),
        ));
  }

  _messageComponent() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ProfileImageComponent(
                url: "",
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Message for Raul",
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            StringConstants.doYouHaveQuestion,
          ),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: StringConstants.typeYourMessage,
              // suffixIcon: IconButton(
              //   icon: Icon(Icons.send),
              //   onPressed: _sendMessage,
              // ),
              hintStyle: TextStyle(
                  color: ColorConstants.lightGray.withOpacity(0.5),
                  fontSize: 14),
              border: InputBorder.none,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text;
        _controller.clear();
      });
    }
  }
}
