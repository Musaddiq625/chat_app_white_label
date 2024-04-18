import 'package:chat_app_white_label/src/components/about_event_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/event_summary_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/asset_constants.dart';

class ViewYourEventScreen extends StatefulWidget {
  const ViewYourEventScreen({super.key});

  @override
  State<ViewYourEventScreen> createState() => _ViewYourEventScreenState();
}

class _ViewYourEventScreenState extends State<ViewYourEventScreen> {
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

  final String _fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  bool _showFullText = false;
  bool ticketRequired = true;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      // appBar: AppBarComponent(""),
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
            SizedBoxConstants.sizedBoxEightyH(),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextComponent("Property event",
                  style:
                      FontStylesConstants.style30(color: ColorConstants.white)),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextComponent("17 Feb . 11AM - 2PM . Manchester",
                  style:
                      FontStylesConstants.style16(color: ColorConstants.white)),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconComponent(
                    iconData: Icons.lock,
                    backgroundColor: ColorConstants.transparent,
                    iconColor: Colors.white,
                    customIconText: " Private",
                    circleSize: 60,
                    circleHeight: 35,
                    iconSize: 20,
                  ),
                  IconComponent(
                    iconData: Icons.edit,
                    backgroundColor: ColorConstants.lightGray,
                    iconColor: ColorConstants.primaryColor,
                    customIconText: " Edit",
                    circleSize: 60,
                    circleHeight: 35,
                    iconSize: 20,
                  ),
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxThirtyH(),
            EventSummary(
              eventTitle: "Current Stats",
              ticketsSold: 4,
              remainingTickets: 96,
              eventActive: true,
              currenStats: true,
              imagesUserInEvent: images,
              // imagesUserInEvent: [
              //   // Your list of ImageProvider objects
              // ],
            ),
            SizedBoxConstants.sizedBoxTenH(),
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
          padding: const EdgeInsets.all(0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(StringConstants.abouttheEvent,
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor)),
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
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            Container(
              // padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
              child: Column(
                children: [
                  AboutEventComponent(
                    name: "1456 ${StringConstants.participants}",
                    detail: "Elena, Ilsa and more",
                    icon: AssetConstants.happy,
                    showPersonIcon: true,
                    selectedImages: images,
                  ),
                  AboutEventComponent(
                    name: StringConstants.flexibleDate,
                    detail: StringConstants.dateWillbeDecidelater,
                    icon: AssetConstants.calendar,
                  ),
                  AboutEventComponent(
                    name: "Manchester",
                    detail: StringConstants.exactLocationAfterJoining,
                    icon: AssetConstants.marker,
                  ),
                  if (ticketRequired == true)
                    AboutEventComponent(
                      name: "SR 150",
                      detail: StringConstants.ticketrequired,
                      icon: AssetConstants.ticket,
                    ),
                  AboutEventComponent(
                    divider: false,
                    name: StringConstants.capacityOf,
                    detail: StringConstants.limitedGuests,
                    icon: AssetConstants.tag,
                  ),
                  SizedBoxConstants.sizedBoxTenH()
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
            SizedBoxConstants.sizedBoxThirtyH(),
            Row(
              children: [
              Container(

                  width: AppConstants.responsiveWidth(context,percentage: 70),
                  child: ContactCard(contact: contacts[1],showShareIcon: false,dividerValue: false,)),
              Container(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // color: themeCubit.darkBackgroundColor,
                ),
                child: TextComponent(StringConstants.creator,textAlign: TextAlign.right),
              ),
            ],),
            DividerCosntants.divider1,

            // ...List.generate(
            //     contacts.length,
            //     (index) => ContactCard(
            //         contact: contacts[index], showShareIcon: false)),
            SizedBoxConstants.sizedBoxSixtyH(),
          ],
        ),
      ),
    );
  }
}
