import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/info_sheet_component.dart';
import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class LocalsProfileScreen extends StatefulWidget {
  const LocalsProfileScreen({super.key});

  @override
  State<LocalsProfileScreen> createState() => _LocalsProfileScreenState();
}

class _LocalsProfileScreenState extends State<LocalsProfileScreen> {

  bool connectSend = false;
  int _currentPage = 0;
  late PageController _pageController;
  final List<ImageProvider> images = [
    const NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your image URL
    const NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const NetworkImage(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    // Replace with your asset path
    // Add more image providers as needed
  ];
  double radius = 22;

  double radius2 = 20;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<Map<String, dynamic>> tagList = [
    {
      'iconData': Icons.favorite,
      'name': "Women",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "Active",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Dog(s)",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Regularly",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Socially",
    },
    {
      'iconData': Icons.height,
      'name': "5'7(170cm)",
    },
    // Add more tag data items as required
  ];

  List<Map<String, dynamic>> interestTagList = [
    {
      'iconData': Icons.favorite,
      'name': "Cinema",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "City Event",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Foods & restaurants",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Networking",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Workout",
    },
    {
      'iconData': Icons.height,
      'name': "Dancing",
    },
    // Add more tag data items as required
  ];

  List<Map<String, dynamic>> eventList = [
    {
      'joined': "+1456",
      'eventName': "Property networking event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1226",
      'eventName': "Drum Code London",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1134",
      'eventName': "Property test event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1146",
      'eventName': "Networking event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _yesShareItBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.requestSend+" XyZ",
        body:StringConstants.connectSendBody,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // return MainScaffold(
    //   // bgImage: "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
    //   // removeSafeAreaPadding: false,
    //   // removeBgImage: false,
    //   bgImage: true,
    //   overrideBackgroundImage: "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
    //   body: _profileWidget(),
    // );
    return UIScaffold(
      removeSafeAreaPadding: false,
      bgColor: ColorConstants.backgroundColor,
      widget: SingleChildScrollView(
          child: Column(
        children: [
          _profileWidget(),
          const SizedBox(
            height: 10,
          ),
          _aboutMe(),
          const SizedBox(
            height: 10,
          ),
          _myInterest(),
          const SizedBox(
            height: 10,
          ),
          _event(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          _clubs(),
          const SizedBox(
            height: 100,
          ),
        ],
      )),
      floatingActionButton: SizedBox(
        width: 350,
        child: connectSend?ButtonComponent(
          bgcolor:ColorConstants.yellow ,
          buttonText: StringConstants.connectSent,
          onPressedFunction: () {
            _yesShareItBottomSheet();
            // NavigationUtil.push(
            //     context, RouteConstants.localsEventScreen);
          },
        ):ButtonComponent(
          buttonText: StringConstants.connect,
          onPressedFunction: () {
            setState(() {
              connectSend=true;
            });
            // NavigationUtil.push(
            //     context, RouteConstants.localsEventScreen);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _profileWidget() {
    return Column(
      children: [
        // Use a Container with a specific height or Flexible with FlexFit.loose
        // Here, I'm using a Container with a specific height as an example
        Container(
          height: 750, // Adjust this value as needed
          child: Stack(
            children: [
              Column(
                children: [

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: imgList.length,
                      itemBuilder: (context, index) {
                        final file = imgList[index];
                        return Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                file,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              _infoWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Carousel indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(imgList.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 4,
                width: 15,
                decoration: BoxDecoration(
                    color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            }),
          ),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "NAME ",
                style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontFamily: "Protest Strike"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Founder, WeUno",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.cake,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "31 yo",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.location_on,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Manchester",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.face,
                    color: ColorConstants.lightGray,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "2 mutual, connections",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
                  SizedBox(width: 10),
                  IconComponent(
                    iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 38,
                    iconSize: 20,
                  ),
                  const SizedBox(width: 10),
                  IconComponent(
                    iconData: Icons.menu,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 38,
                    iconSize: 20,
                    // onTap: _showMoreBottomSheet,
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _aboutMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: ColorConstants.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    StringConstants.aboutMe,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorConstants.bgcolorbutton,
                        fontFamily: FontConstants.fontProtestStrike),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "New to the city, keen to explore with new minded people and build my own network",
                style: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 30,
                    circleHeight: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ...tagList
                      .map((tag) =>
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            IconComponent(
                              iconData: tag['iconData'],
                              borderColor: ColorConstants.tagBgColor,
                              backgroundColor: ColorConstants.tagBgColor,
                              customIconText: tag['name'],
                              circleHeight: 35,
                              // circleSize: (tag['name'].length * 14.0) + 25,
                              iconSize: 20,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ]))
                      .toList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myInterest() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: ColorConstants.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      StringConstants.myInterests,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConstants.bgcolorbutton,
                          fontFamily: FontConstants.fontProtestStrike),
                    )),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    ...interestTagList
                        .map((tag) =>
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              IconComponent(
                                iconData: tag['iconData'],
                                borderColor: ColorConstants.tagBgColor,
                                backgroundColor: ColorConstants.tagBgColor,
                                customIconText: tag['name'],
                                circleHeight: 35,
                                // circleSize: (tag['name'].length * 13.0) + 20,
                                iconSize: 20,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ]))
                        .toList(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _event() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 20, color: ColorConstants.bgcolorbutton),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "${StringConstants.events}  ",
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.bgcolorbutton,
                            fontFamily: FontConstants.fontProtestStrike),
                      ),
                      TextSpan(
                        text: "387",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 10, right: 30),
                child: Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.8),
                          fontSize: 15),
                    ),
                    IconComponent(
                      iconData: Icons.arrow_forward_ios,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      circleSize: 10,
                      iconSize: 18,
                      iconColor: ColorConstants.lightGray,
                    )
                  ],
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // This makes the list scrollable horizontally
          child: Row(
            children: [
              ...eventList
                  .map(
                    (event) => Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 186,
                        height: 308,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: radius2 * images.length.toDouble(),
                                      height: radius2,
                                      child: Stack(
                                        children: [
                                          for (int i = 0;
                                              i < images.length;
                                              i++)
                                            Positioned(
                                              left: i * radius2 / 1.5,
                                              child: ClipOval(
                                                child: Image(
                                                  image: images[i],
                                                  width: radius2,
                                                  height: radius2,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                     Text(
                                      "${event['joined']}${StringConstants.joined}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: ColorConstants.white),
                                    ),
                                  ],
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  event['eventName'] ,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily:
                                          FontConstants.fontProtestStrike,
                                      color: ColorConstants.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  event['dateTime'],
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        )
      ],
    );
  }

  Widget _clubs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 20, color: ColorConstants.bgcolorbutton),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "${StringConstants.clubs}  ",
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.bgcolorbutton,
                            fontFamily: FontConstants.fontProtestStrike),
                      ),
                      TextSpan(
                        text: "387",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 10, right: 30),
                child: Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.8),
                          fontSize: 15),
                    ),
                    IconComponent(
                      iconData: Icons.arrow_forward_ios,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      circleSize: 10,
                      iconSize: 18,
                      iconColor: ColorConstants.lightGray,
                    )
                  ],
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // This makes the list scrollable horizontally
          child: Row(
            children: [
              ...eventList
                  .map(
                    (tag) => Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 186,
                        height: 308,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: radius2 * images.length.toDouble(),
                                      height: radius2,
                                      child: Stack(
                                        children: [
                                          for (int i = 0;
                                              i < images.length;
                                              i++)
                                            Positioned(
                                              left: i * radius2 / 1.5,
                                              child: ClipOval(
                                                child: Image(
                                                  image: images[i],
                                                  width: radius2,
                                                  height: radius2,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "+1456 ${StringConstants.joined}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: ColorConstants.white),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Property networking event",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily:
                                          FontConstants.fontProtestStrike,
                                      color: ColorConstants.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "17 Feb . 11AM - 2PM ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        )
      ],
    );
  }
}
