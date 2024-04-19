import 'package:cached_network_image/cached_network_image.dart';
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

import '../../components/member_respsonse_component.dart';
import '../../constants/asset_constants.dart';

class ViewYourEventScreen extends StatefulWidget {
  const ViewYourEventScreen({super.key});

  @override
  State<ViewYourEventScreen> createState() => _ViewYourEventScreenState();
}

class _ViewYourEventScreenState extends State<ViewYourEventScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  final List<Map<String, dynamic>> contacts = [
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
  ];

  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  // ];
  final List<ImageProvider> images = [
    const CachedNetworkImageProvider(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    const CachedNetworkImageProvider(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const CachedNetworkImageProvider(
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

  List<ContactModel> contact = [
    ContactModel('Jesse E bert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    // Add more contacts as needed
  ];

// Dummy data for member response details
//   List<Map<String, dynamic>> memberResponseDetail = [
//     {
//       'contact': contact[0],
//       'messageValue': 'This is a message from John Doe.',
//       'questionsAndAnswers': [
//         {
//           'question': 'Question 1 from John Doe',
//           'answer': 'Answer 1 from John Doe',
//         },
//         {
//           'question': 'Question 2 from John Doe',
//           'answer': 'Answer 2 from John Doe',
//         },
//       ],
//     },
//     {
//       'contact': contact[1],
//       'messageValue': 'This is a message from Jane Smith.',
//       'questionsAndAnswers': [
//         {
//           'question': 'Question 1 from Jane Smith',
//           'answer': 'Answer 1 from Jane Smith',
//         },
//         {
//           'question': 'Question 2 from Jane Smith',
//           'answer': 'Answer 2 from Jane Smith',
//         },
//       ],
//     },
//   ];

  late final List<Map<String, dynamic>>? memberResponseDetail;

  void initState() {
    super.initState();
    memberResponseDetail = [
      {
        'name': "hello",
        'url': "",
        'title': "Graphic Designer",
        'messageValue': 'This is a message from Jesse Ebert.',
        'questionsAndAnswers': [
          {
            'question': 'Question 1 from Jesse Ebert',
            'answer': 'Answer 1 from Jesse Ebert',
          },
          {
            'question': 'Question 2 from Jesse Ebert',
            'answer': 'Answer 2 from Jesse Ebert',
          },
        ],
      },
      {
        'name': "hello",
        'url': "",
        'title': "Graphic Designer",
        'messageValue': 'This is a message from Jesse Ebert.',
        'questionsAndAnswers': [
          {
            'question': 'Question 1 from Jesse Ebert',
            'answer': 'Answer 1 from Jesse Ebert',
          },
          {
            'question': 'Question 2 from Jesse Ebert',
            'answer': 'Answer 2 from Jesse Ebert',
          },
        ],
      },
      {
        'name': "hello",
        'url': "",
        'title': "Graphic Designer",
        'messageValue': 'This is a message from Jesse Ebert.',
        'questionsAndAnswers': [
          {
            'question': 'Question 1 from Jesse Ebert',
            'answer': 'Answer 1 from Jesse Ebert',
          },
          {
            'question': 'Question 2 from Jesse Ebert',
            'answer': 'Answer 2 from Jesse Ebert',
          },
        ],
      },
      {
        'name': "hello",
        'url': "",
        'title': "Graphic Designer",
        'messageValue': 'This is a message from Jesse Ebert.',
        'questionsAndAnswers': [
          {
            'question': 'Question 1 from Jesse Ebert',
            'answer': 'Answer 1 from Jesse Ebert',
          },
          {
            'question': 'Question 2 from Jesse Ebert',
            'answer': 'Answer 2 from Jesse Ebert',
          },
        ],
      },
    ];
  }

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  ]));
  }

  Widget _members() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: themeCubit.darkBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
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
                  margin: EdgeInsets.only(left: 5),
                    width:
                        AppConstants.responsiveWidth(context, percentage: 66),
                    child: const ContactCard(
                      name: "Jesse",
                      url: "",
                      title: "Graphic Designer",
                      showShareIcon: false,
                      dividerValue: false,
                      imageSize: 40,
                    )),
                Container(

                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: themeCubit.darkBackgroundColor,
                  ),
                  child: TextComponent(StringConstants.creator,
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            DividerCosntants.divider1,

            ...memberResponseDetail!.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> details = entry.value;
              bool isLast = index == memberResponseDetail!.length - 1;
              return Container(

                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: MemberResponseComponent(
                        name: details['name'],
                        url: details['url'],
                        title: details['title'],
                        // contact: details['title'],
                        messageValue: details['messageValue'],
                        questionsAndAnswers: details['questionsAndAnswers'],
                        // [
                        //   {
                        //     'question': 'Question 1 asasd asdasd ',
                        //     'answer': 'Answer 1 asdasd asdasd asdasd',
                        //   },
                        //   {
                        //     'question': 'Question 2 asdasd asdasd asdasd',
                        //     'answer':
                        //         'Answer 2 asdasddasasd asdasdasdasd asdasdasd asdasd',
                        //   },
                        //   {
                        //     'question': 'Question 3 asdasd asdasd asdasd',
                        //     'answer':
                        //         'Answer 3 asdasddasasd asdasdasdasd asdasdasd asdasd',
                        //   },
                        // ]
                      ),
                    ),
                    if (!isLast) DividerCosntants.divider1,
                  ],
                ),
              );
            }),

            SizedBoxConstants.sizedBoxSixtyH(),

            // ContactCard(
            //   contact: contacts[1],
            //   showShareIcon: false,
            //   dividerValue: false,
            // ),
            // Container(
            //   margin: EdgeInsets.only(right: 20),
            //   alignment: Alignment.centerRight,
            //   width: AppConstants.responsiveWidth(context, percentage: 70),
            //   //MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
            //   decoration: BoxDecoration(
            //
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //   ),
            //   child: Column(
            //     children: [
            //       Container(
            //         width: AppConstants.responsiveWidth(
            //             context, percentage: 65),
            //
            //         // alignment: Alignment.centerRight,
            //         decoration: BoxDecoration(
            //           color: ColorConstants.blackLight,
            //           borderRadius: BorderRadius.all(Radius.circular(20)),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 10.0, left: 20, right: 20, bottom: 10),
            //               child: Column(
            //                 children: [
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.grey.withOpacity(
            //                             0.8)), maxLines: 10,),
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.white),
            //                     maxLines: 10,),
            //                 ],
            //               ),
            //             ),
            //
            //           ],
            //         ),
            //       ),
            //       SizedBoxConstants.sizedBoxTenH(),
            //       Container(
            //         width: AppConstants.responsiveWidth(
            //             context, percentage: 65),
            //
            //         // alignment: Alignment.centerRight,
            //         decoration: BoxDecoration(
            //           color: ColorConstants.blackLight,
            //           borderRadius: BorderRadius.all(Radius.circular(20)),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 10.0, left: 20, right: 20, bottom: 10),
            //               child: Column(
            //                 children: [
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.grey.withOpacity(
            //                             0.8)), maxLines: 10,),
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.white),
            //                     maxLines: 10,),
            //                 ],
            //               ),
            //             ),
            //             DividerCosntants.divider1,
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 10.0, left: 20, right: 20, bottom: 10),
            //               child: Column(
            //                 children: [
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.grey.withOpacity(
            //                             0.8)), maxLines: 10,),
            //                   TextComponent(
            //                     "helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd",
            //                     style: FontStylesConstants.style14(
            //                         color: ColorConstants.white),
            //                     maxLines: 10,),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            //
            // ),
            // SizedBoxConstants.sizedBoxTenH(),
            // DividerCosntants.divider1,

            // ...List.generate(
            //     contacts.length,
            //     (index) => ContactCard(
            //         contact: contacts[index], showShareIcon: false)),
          ],
        ),
      ),
    );
  }
}
