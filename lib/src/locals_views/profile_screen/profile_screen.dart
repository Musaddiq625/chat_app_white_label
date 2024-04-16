import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/back_button_component.dart';
import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/info_sheet_component.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  bool connectSend = false;
  int _currentPage = 0;
  late PageController _pageController;
  final List<ImageProvider> images = [
    const NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your image URL
    const NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
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
      body: const InfoSheetComponent(
        heading: StringConstants.requestSend + " XyZ",
        body: StringConstants.connectSendBody,
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
          child: Container(
        color: themeCubit.backgroundColor,
        child: Column(
          children: [
            _profileWidget(),
            SizedBoxConstants.sizedBoxTenH(),
            _aboutMe(),
            SizedBoxConstants.sizedBoxTenH(),
            _myInterest(),
            SizedBoxConstants.sizedBoxTenH(),
            _event(),
            SizedBoxConstants.sizedBoxTenH(),
            _clubs(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      )),
      floatingActionButton: connectSend
          ? ButtonComponent(
              bgcolor: themeCubit.primaryColor,
              buttonText: StringConstants.connectSent,
              textColor: themeCubit.backgroundColor,
              onPressed: () {
                _yesShareItBottomSheet();
                // NavigationUtil.push(
                //     context, RouteConstants.localsEventScreen);
              },
            )
          : ButtonComponent(
              bgcolor: themeCubit.primaryColor,
              buttonText: StringConstants.connect,
              textColor: themeCubit.backgroundColor,
              onPressed: () {
                setState(() {
                  connectSend = true;
                });
                // NavigationUtil.push(
                //     context, RouteConstants.localsEventScreen);
              },
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
          height: AppConstants.responsiveHeight(context,
              percentage: 98), // Adjust this value as needed
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
              // AppBarComponent(""),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: InkWell(
                  onTap: () => NavigationUtil.pop(context),
                  child: BackButtonComponent(
                      bgColor: ColorConstants.iconBg,
                      image: AssetConstants.backArrow,
                      //! pass your asset here
                      enableDark: false,
                      isImage: true,
                      isCircular: true,
                      onTap: () {}),
                ),
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
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Carousel indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(imgList.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
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
          SizedBoxConstants.sizedBoxTenH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                "NAME ",
                style: FontStylesConstants.style38(color: ColorConstants.white),
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.business_center_rounded,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "Founder, WeUno",
                    style: FontStylesConstants.style16(),
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.cake,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "31 yo",
                    style: FontStylesConstants.style16(),
                  ),
                  SizedBoxConstants.sizedBoxTwentyW(),
                  const Icon(
                    Icons.location_on_sharp,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "Manchester",
                    style: FontStylesConstants.style16(),
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.tag_faces_rounded,
                    color: ColorConstants.lightGray,
                    size: 14,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "2 mutual, connections",
                    style: FontStylesConstants.style16(),
                  ),
                  SizedBoxConstants.sizedBoxEightW(),
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
                  const SizedBox(width: 30),
                  IconComponent(
                    svgData: AssetConstants.share,
                    // iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 38,
                    iconSize: 15,
                  ),
                  const SizedBox(width: 10),
                  IconComponent(
                    // iconData: Icons.more,
                    svgData: AssetConstants.more,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 38,
                    iconSize: 6,
                    // onTap: _showMoreBottomSheet,
                  )
                ],
              ),
              const SizedBox(
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
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextComponent(
                    StringConstants.aboutMe,
                    style: FontStylesConstants.style18(
                        color: themeCubit.primaryColor),
                  )),
              SizedBoxConstants.sizedBoxTenH(),
              TextComponent(
                "New to the city, keen to explore with new minded people and build my own network",
                style: FontStylesConstants.style14(color: ColorConstants.white),
                maxLines: 6,
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Wrap(
                children: [
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 30,
                  ),
                  SizedBoxConstants.sizedBoxTenW(),
                  IconComponent(
                    // iconData: Icons.facebook,
                    svgDataCheck: false,
                    svgData: AssetConstants.instagram,
                    // borderColor: Colors.red,
                    backgroundColor: ColorConstants.transparent,
                    iconSize: 100,
                    borderSize: 0,
                    // circleSize: 30,
                    // circleHeight: 30,
                  ),
                  SizedBoxConstants.sizedBoxTenW(),
                  ...tagList
                      .map((tag) =>
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: TagComponent(
                                iconData: tag['iconData'],
                                customTextColor: themeCubit.textColor,
                                backgroundColor:
                                    ColorConstants.lightGray.withOpacity(0.3),
                                iconColor: themeCubit.primaryColor,
                                customIconText: tag['name'],
                                circleHeight: 35,
                                iconSize: 20,
                              ),
                            ),
                            SizedBoxConstants.sizedBoxTenW(),
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
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextComponent(
                      StringConstants.myInterests,
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor),
                    )),
                SizedBoxConstants.sizedBoxTenH(),
                Wrap(
                  children: [
                    ...interestTagList
                        .map((tag) =>
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: TagComponent(
                                  iconData: tag['iconData'],
                                  customTextColor: themeCubit.textColor,
                                  backgroundColor:
                                      ColorConstants.lightGray.withOpacity(0.3),
                                  iconColor: themeCubit.primaryColor,
                                  customIconText: tag['name'],
                                  circleHeight: 35,
                                  iconSize: 20,
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenW(),
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
                    style: FontStylesConstants.style20(
                        color: themeCubit.primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${StringConstants.events}  ",
                      ),
                      TextSpan(
                        text: "387",
                        style: FontStylesConstants.style20(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      "See all",
                      style: FontStylesConstants.style15(
                          color: ColorConstants.lightGray.withOpacity(0.8)),
                    ),
                    IconComponent(
                      iconData: Icons.arrow_forward_ios,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      iconSize: 18,
                      borderSize: 0,
                      circleSize: 20,
                      iconColor: ColorConstants.lightGray,
                    )
                  ],
                )),
          ],
        ),
        SizedBoxConstants.sizedBoxTenH(),
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
                        decoration: const BoxDecoration(
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
                                    TextComponent(
                                      "${event['joined']}${StringConstants.joined}",
                                      style: FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                      // style: const TextStyle(
                                      //     fontSize: 13,
                                      //     color: ColorConstants.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextComponent(
                                  event['eventName'],
                                  style: FontStylesConstants.style20(
                                      color: ColorConstants.white),
                                  maxLines: 6,
                                  // style: const TextStyle(
                                  //     fontSize: 20,
                                  //     fontFamily:
                                  //         FontConstants.fontProtestStrike,
                                  //     color: ColorConstants.white),
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenH(),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextComponent(
                                  event['dateTime'],
                                  style: FontStylesConstants.style13(
                                      color: ColorConstants.white),
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenH(),
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
                    style: FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${StringConstants.clubs}  ",
                      ),
                      TextSpan(
                        text: "387",
                        style: FontStylesConstants.style20(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Row(
                  children: [
                    TextComponent(
                      "See all",
                      style: FontStylesConstants.style15(
                          color: ColorConstants.lightGray.withOpacity(0.8)),
                    ),
                    IconComponent(
                      iconData: Icons.arrow_forward_ios,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      iconSize: 18,
                      borderSize: 0,
                      circleSize: 20,
                      iconColor: ColorConstants.lightGray,
                    )
                  ],
                )),
          ],
        ),
        SizedBoxConstants.sizedBoxTenH(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // This makes the list scrollable horizontally
          child: Row(
            children: [
              ...eventList
                  .map(
                    (tag) =>
                        Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        decoration: const BoxDecoration(
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
                                    TextComponent(
                                      "+1456 ${StringConstants.joined}",
                                      style: FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextComponent(
                                  "Property networking event",
                                  style: FontStylesConstants.style20(
                                      color: ColorConstants.white),
                                  maxLines: 6,
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenH(),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextComponent(
                                  "17 Feb . 11AM - 2PM ",
                                  style: FontStylesConstants.style13(
                                      color: ColorConstants.white),
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
