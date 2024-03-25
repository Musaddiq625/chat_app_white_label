import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/bottom_nav_componenet.dart';
import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/contacts_card_component.dart';
import '../../constants/font_constants.dart';
import '../../models/contact.dart';

class LocalsHomeScreen extends StatefulWidget {
  const LocalsHomeScreen({super.key});

  @override
  State<LocalsHomeScreen> createState() => _LocalsHomeScreenState();
}

class _LocalsHomeScreenState extends State<LocalsHomeScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
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
  double radius = 30;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      removeSafeAreaPadding: false,
      bgImage:
          "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
      widget: _eventWidget(),
      bottomNavigationBar: Container(
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(1.5),
          //       spreadRadius: 05,
          //       blurRadius: 10,
          //       offset: Offset(0, -3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: const BottomNavBar()),
    );
  }

  Widget _topData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          StringConstants.locals,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 47,
              color: Colors.white,
              fontFamily: FontConstants.fontProtestStrike),
        ),
        const Spacer(),
        IconComponent(
          iconData: Icons.notifications,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        const SizedBox(width: 10),
        IconComponent(
          iconData: Icons.sort,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
        ),
        const SizedBox(width: 10),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    "+1456 ${StringConstants.joined}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              const Text(
                "Property \nnetworking event",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "17 Feb . 11AM - 2PM . Manchester",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      textColor: themeCubit.backgroundColor,
                      buttonText: StringConstants.viewEvent,
                      onPressedFunction: () {
                        NavigationUtil.push(
                            context, RouteConstants.localsEventScreen);
                      }),
                  const Spacer(),
                  IconComponent(
                    iconData: Icons.favorite,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(width: 10),
                  IconComponent(
                      iconData: Icons.share,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: Colors.white,
                      circleSize: 35,
                      iconSize: 20,
                      onTap: _shareEventBottomSheet),
                  const SizedBox(width: 10),
                  IconComponent(
                    iconData: Icons.menu,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 35,
                    iconSize: 20,
                    onTap: _showMoreBottomSheet,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _showMoreBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        bgColor: themeCubit.darkBackgroundColor,
        isShowHeader: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
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
                    Text(StringConstants.saveEvent,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: themeCubit.textColor)),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
                child: Row(
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
                    Text(StringConstants.showLessLikeThis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: themeCubit.textColor)),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
                child: Row(
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
          ),
        ));
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
                    child: Text(
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
                    iconData: Icons.link,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.yellow,
                    iconColor: Colors.white,
                    circleSize: 60,
                    customText: StringConstants.copyLink,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 60,
                    customText: StringConstants.facebook,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    iconData: Icons.install_desktop,
                    borderColor: Colors.transparent,
                    circleSize: 60,
                    customText: StringConstants.instagram,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: const Color.fromARGB(255, 87, 64, 208),
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
                child: Text(
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
                    child: Text(
                      StringConstants.goBack,
                      style: TextStyle(color: themeCubit.textColor),
                    )),
                const SizedBox(width: 30),
                ButtonComponent(
                  bgcolor: themeCubit.primaryColor,
                  textColor: themeCubit.backgroundColor,
                  buttonText: "Yes, share it",
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
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.eventShared,
        image: AssetConstants.group,
      ),
    );
  }
}
