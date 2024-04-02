import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/contacts_card_component.dart';
import '../../components/icon_component.dart';
import '../../components/icons_button_component.dart';
import '../../components/info_sheet_component.dart';
import '../../components/profile_image_component.dart';
import '../../constants/color_constants.dart';
import '../../constants/route_constants.dart';
import '../../models/contact.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

final String _fullText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
bool _showFullText = false;
bool ticketRequired = true;
final TextEditingController _controller = TextEditingController();

class _EventScreenState extends State<EventScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

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
        // physics: BouncingScrollPhysics(),
        child: Container(
          color: themeCubit.backgroundColor,
          child: Column(
            children: [_eventWidget(), _members()],
          ),
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
              textColor: ColorConstants.black,
              bgcolor: ColorConstants.btnGradientColor,
            ),
            SizedBox(
              width: AppConstants.responsiveWidth(context, percentage: 30),
              child: ButtonWithIconComponent(
                btnText: '  ${StringConstants.join}',
                icon: Icons.add_circle,
                bgcolor: themeCubit.primaryColor,
                // btnTextColor: themeCubit.textColor,
                onPressed: () {
                  _showJoinBottomSheet();
                },
              ),
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
                iconData: Icons.arrow_back_ios_new_outlined,
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
                  const TextComponent(
                    "+1456 ${StringConstants.joined}",
                    style: TextStyle(fontSize: 16, color: ColorConstants.white),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextComponent(
                "Property \nnetworking event",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: FontConstants.fontProtestStrike,
                    color: ColorConstants.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextComponent(
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
                    backgroundColor:
                        ColorConstants.darkBackgrounddColor.withOpacity(0.9),
                    iconColor: Colors.red,
                    customIconText: " 22",
                    circleSize: 60,
                    circleHeight: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(width: 10),
                  IconComponent(
                      // iconData: Icons.share,
                      svgData: AssetConstants.share,
                      backgroundColor:
                          ColorConstants.darkBackgrounddColor.withOpacity(0.9),
                      circleSize: 35,
                      iconSize: 15,
                      onTap: () {
                        _shareEventBottomSheet();
                      }),
                  const SizedBox(width: 10),
                  IconComponent(
                    // iconData: Icons.menu,
                    svgData: AssetConstants.more,
                    backgroundColor:
                        ColorConstants.darkBackgrounddColor.withOpacity(0.9),
                    circleSize: 35,
                    iconSize: 6,
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
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextComponent(
              StringConstants.abouttheEvent,
              style: TextStyle(
                  fontFamily: FontConstants.fontProtestStrike,
                  fontSize: 18,
                  color: themeCubit.primaryColor),
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
                      style: TextStyle(color: themeCubit.textColor),
                    ),
                    if (_fullText.length > 150)
                      TextSpan(
                        text: _showFullText
                            ? ' ${StringConstants.showLess}'
                            : ' ...${StringConstants.readMore}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: themeCubit.textColor),
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
                      SvgPicture.asset(
                        height: 35,
                        AssetConstants.happy,
                      ),
                      // const ProfileImageComponent(url: AssetConstants.happy,assetImage: true,),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                            "1456 ${StringConstants.participants}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeCubit.textColor),
                          ),
                          TextComponent(
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
                  Row(
                    children: [
                      SvgPicture.asset(
                        height: 35,
                        AssetConstants.calendar,
                      ),
                      // ProfileImageComponent(url: ""),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                            StringConstants.flexibleDate,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeCubit.textColor),
                          ),
                          TextComponent(
                            StringConstants.dateWillbeDecidelater,
                            style: TextStyle(
                                fontSize: 14, color: ColorConstants.lightGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(thickness: 0.2),
                  Row(
                    children: [
                      SvgPicture.asset(
                        height: 35,
                        AssetConstants.marker,
                      ),
                      // ProfileImageComponent(url: ""),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                            "Manchester",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeCubit.textColor),
                          ),
                          TextComponent(
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
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.ticket,
                        ),
                        // ProfileImageComponent(url: ""),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextComponent(
                              "SR 150",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeCubit.textColor),
                            ),
                            TextComponent(
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
                      SvgPicture.asset(
                        height: 35,
                        AssetConstants.tag,
                      ),
                      // ProfileImageComponent(url: ""),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                            StringConstants.freeToJoin,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeCubit.textColor),
                          ),
                          TextComponent(
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
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 18),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 18,
                        color: themeCubit.primaryColor),
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
            SizedBoxConstants.sizedBoxSixtyH(),
          ],
        ),
      ),
    );
  }

  _shareEventBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                    child: TextComponent(
                      StringConstants.shareEvent,
                      style: TextStyle(
                          color: themeCubit.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: themeCubit.textColor,
                        circleSize: 50,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconComponent(
                    // iconData: Icons.link,
                    svgData: AssetConstants.copyLink,
                    borderColor: Colors.transparent,
                    backgroundColor: themeCubit.primaryColor,
                    iconColor: ColorConstants.black,
                    circleSize: 60,
                    customText: StringConstants.copyLink,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 60,
                    iconSize: 30,
                    customText: StringConstants.facebook,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    svgDataCheck: false,
                    svgData: AssetConstants.instagram,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    circleSize: 60,
                    customText: StringConstants.instagram,
                    customTextColor: themeCubit.textColor,
                    iconSize: 60,
                  ),
                  IconComponent(
                    svgData: AssetConstants.share,
                    iconColor: ColorConstants.black,
                    borderColor: Colors.transparent,
                    // backgroundColor:ColorConstants.transparent,
                    circleSize: 60,
                    customText: StringConstants.share,
                    customTextColor: themeCubit.textColor,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0.5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 16),
                child: TextComponent(
                  StringConstants.yourConnections,
                  style: TextStyle(
                      color: themeCubit.primaryColor,
                      fontFamily: FontConstants.fontProtestStrike,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (ctx, index) {
                    return ContactCard(
                      contact: contacts[index],
                      onShareTap: () {
                        Navigator.pop(context);
                        _shareWithConnectionBottomSheet(
                            StringConstants.fireWorks, contacts[index].name);
                      },
                      onProfileTap: () {
                        NavigationUtil.push(
                            context, RouteConstants.profileScreenLocal);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
  _shareWithConnectionBottomSheet(String eventName, String userName) {
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            const ProfileImageComponent(url: ''),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: FontConstants.fontProtestStrike,
                    height: 1.5),
                children: <TextSpan>[
                  TextSpan(text: StringConstants.areYouSureYouwantToShare),
                  TextSpan(
                    text: eventName,
                    style: TextStyle(color: themeCubit.primaryColor),
                  ),
                  TextSpan(text: " with \n"),
                  TextSpan(
                    text: "$userName?",
                    style: TextStyle(color: themeCubit.primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: TextComponent(
                      StringConstants.goBack,
                      style: TextStyle(color: themeCubit.textColor),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  bgcolor: themeCubit.primaryColor,
                  textColor: themeCubit.backgroundColor,
                  buttonText: StringConstants.yesShareIt,
                  onPressedFunction: () {
                    Navigator.pop(context);
                    _yesShareItBottomSheet();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _yesShareItBottomSheet() {
    _navigateToBack();
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.eventShared,
        image: AssetConstants.garland,
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
                    iconColor: themeCubit.primaryColor,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const TextComponent(StringConstants.saveEvent,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ColorConstants.white)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.1,
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
                    iconColor: themeCubit.primaryColor,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const TextComponent(StringConstants.showLessLikeThis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ColorConstants.white)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.1,
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
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            // color: themeCubit.darkBackgroundColor,
          ),
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(
                    StringConstants.join,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        color: themeCubit.primaryColor,
                        fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: IconComponent(
                      iconData: Icons.close,
                      borderColor: Colors.transparent,
                      iconColor: themeCubit.textColor,
                      circleSize: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(
                    "Property \nnetworking event",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: FontConstants.fontProtestStrike,
                        color: themeCubit.textColor),
                  ),
                  Image.asset(
                    AssetConstants.group,
                    width: 100,
                    height: 80,
                  ),
                ],
              ),
              TextComponent(
                StringConstants.freeToJoin,
                style: TextStyle(color: themeCubit.textColor),
              ),
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
              TextComponent(
                StringConstants.somethingToKnow,
                style: TextStyle(
                    color: themeCubit.primaryColor,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    height: 35,
                    AssetConstants.chatMsg,
                  ),
                  // ProfileImageComponent(
                  //   url: "",
                  //   size: 30,
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  TextComponent(
                    StringConstants.whenYouJoinYoureInTheGame,
                    style: TextStyle(color: themeCubit.textColor),
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
                  SvgPicture.asset(
                    height: 35,
                    AssetConstants.clock,
                  ),
                  // ProfileImageComponent(
                  //   url: "",
                  //   size: 30,
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  TextComponent(
                    StringConstants.whenYouJoinYoureInTheGame,
                    style: TextStyle(color: themeCubit.textColor),
                    maxLines: 4,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ButtonComponent(
                      buttonText: StringConstants.join,
                      textColor: themeCubit.backgroundColor,
                      onPressedFunction: () {
                        _sendMessage();
                        Navigator.pop(context);
                        _navigateToBack();
                        BottomSheetComponent.showBottomSheet(
                          context,
                          isShowHeader: false,
                          body: InfoSheetComponent(
                            heading: StringConstants.requestSent,
                            body: StringConstants.requestStatus,
                            image: AssetConstants.paperPlaneImage,
                            // svg: true,
                          ),
                          // whenComplete:_navigateToBack(),
                        );
                      },
                      bgcolor: themeCubit.primaryColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  _navigateToBack() async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
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
                width: 10,
              ),
              TextComponent(
                "Message for Raul",
                style: TextStyle(
                    color: themeCubit.primaryColor,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextComponent(
            StringConstants.doYouHaveQuestion,
            style: TextStyle(color: themeCubit.textColor),
            maxLines: 4,
          ),
          TextFieldComponent(
            _controller,
            hintText: StringConstants.typeYourMessage,
            fieldColor: ColorConstants.lightGray.withOpacity(0.5),
            maxLines: 4,
          ),
          // TextField(
          //   controller: _controller,
          //   maxLines: 4,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: themeCubit.darkBackgroundColor.withOpacity(0.5),
          //     hintText: StringConstants.typeYourMessage,
          //     // suffixIcon: IconButton(
          //     //   icon: Icon(Icons.send),
          //     //   onPressed: _sendMessage,
          //     // ),
          //     hintStyle: TextStyle(
          //         color: ColorConstants.lightGray.withOpacity(0.5),
          //         fontSize: 14),
          //     border: InputBorder.none,
          //   ),
          // ),
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
