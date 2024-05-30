import 'package:chat_app_white_label/src/components/about_event_component.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/event_summary_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/dark_theme_color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/edit_event_screen/cubit/edit_event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/cubit/group_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_event_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/member_respsonse_component.dart';
import '../../constants/asset_constants.dart';
import '../../models/event_model.dart';
import 'cubit/view_your_event_screen_cubit.dart';

class ViewYourGroupScreen extends StatefulWidget {
  String? eventId;

  ViewYourGroupScreen({super.key, this.eventId});

  @override
  State<ViewYourGroupScreen> createState() => _ViewYourGroupScreenState();
}

class _ViewYourGroupScreenState extends State<ViewYourGroupScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final viewYourGroupCubit =
      BlocProvider.of<ViewYourGroupScreenCubit>(context);
  String? totalAcceptedMembers;
  String? totalRequestedMembers;
  final List<Map<String, dynamic>> contacts = [
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
    {'name': 'Jesse E bert', "title": 'Graphic Designer', "url": ""},
  ];
  final TextEditingController _queryController = TextEditingController();

  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  //   ContactModel('Jesse Ebert', 'Graphic Designer', ""),
  // ];
  final List<String> images = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",

    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",

    "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
    // Replace with your asset path
    // Add more image providers as needed
  ];
  double radius = 30;

  final String _fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  bool _showFullText = false;
  bool ticketRequired = true;
  final TextEditingController _controller = TextEditingController();

  final List<ContactModel> contact = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "", "00112233455"),
    ContactModel('Albert Ebert', 'Manager', "", "45612378123"),
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
  List<EventRequest>? acceptedRequests;
  List<String?>? imagesUserInEvent;
  List<EventRequest>? pendingRequests;
  late final List<Map<String, dynamic>>? memberResponseDetail;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      viewYourGroupCubit.eventModel = EventModel();
      await viewYourGroupCubit.viewOwnEventDataById(
          widget.eventId ?? ""); //6644a7791d98d12f648b0467
      // if (eventCubit.eventModel.pricing?.price != "0" &&
      //     (eventCubit.eventModel.pricing?.price ?? "").isNotEmpty) {
      //   _price = int.parse(eventCubit.eventModel.pricing?.price ?? "");
      // }
      // _price = 50;
    });
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
    return BlocConsumer<ViewYourGroupScreenCubit, ViewYourGroupScreenState>(
      listener: (context, state) {
        if (state is ViewYourGroupScreenLoadingState) {
        } else if (state is ViewYourGroupScreenSuccessState) {
          viewYourGroupCubit.initializeEventData(state.eventModel!);
          totalAcceptedMembers = viewYourGroupCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .length
              .toString();
          totalRequestedMembers = viewYourGroupCubit.eventModel.eventRequest
              ?.where((eventRequest) => eventRequest.requestStatus == "Pending")
              .length
              .toString();

          print("totalRequestedMembers ${totalRequestedMembers}");
          acceptedRequests = viewYourGroupCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .toList();
      imagesUserInEvent = acceptedRequests?.map((e) => e.image).where((image) => image!= null).toList(); // Filter out null values.toList();
          pendingRequests = viewYourGroupCubit.eventModel.eventRequest
              ?.where((eventRequest) => eventRequest.requestStatus == "Pending")
              .toList();
          print("totalAcceptedMembers $totalAcceptedMembers");
          print("totalRequestedMembers $totalRequestedMembers");
        } else if (state is SendGroupRequestQueryAndStatusSuccessState) {
          viewYourGroupCubit.initializeEventData(state.eventModel!);
          totalAcceptedMembers = viewYourGroupCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .length
              .toString();
          totalRequestedMembers = viewYourGroupCubit.eventModel.eventRequest
              ?.where((eventRequest) => eventRequest.requestStatus == "Pending")
              .length
              .toString();
          acceptedRequests = viewYourGroupCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .toList();
          pendingRequests = viewYourGroupCubit.eventModel.eventRequest
              ?.where((eventRequest) => eventRequest.requestStatus == "Pending")
              .toList();
        } else if (state is ViewYourGroupScreenFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is SendGroupRequestQueryAndStatusFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return BlocConsumer<GroupCubit, GroupState>(
          listener: (context, state) {
            // if (state is EditEventSuccessState) {
            //   viewYourGroupCubit.initializeEventData(state.eventModel!);
            // }
          },
          builder: (context, state) {
            return UIScaffold(
              // appBar: AppBarComponent(""),
              removeSafeAreaPadding: false,
              bgColor: ColorConstants.backgroundColor,
              widget: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Container(
                  color: themeCubit.backgroundColor,
                  child: Column(
                    children: [
                      _eventWidget(),
                      ((totalRequestedMembers ?? "").isNotEmpty &&
                              totalRequestedMembers != null &&
                              totalRequestedMembers != "0")
                          ? _requestedMembers()
                          : Container(),
                      ((totalAcceptedMembers ?? "").isNotEmpty &&
                              totalAcceptedMembers != null)
                          ? _members()
                          : Container(
                              color: ColorConstants.black,
                              height: 300,
                            ),

                      SizedBoxConstants.sizedBoxEightyH()
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _eventWidget() {


// Calculate the difference
    return Stack(children: [
      (viewYourGroupCubit.eventModel.images ?? []).isNotEmpty
          ? Image.network(
        viewYourGroupCubit.eventModel.images?.first ?? "",
              // "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
              fit: BoxFit.fill,
              width: double.infinity,
              height: 500,
            )
          : Container(
              color: ColorConstants.black,
              height: 500,
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              "",
              iconBgColor: ColorConstants.iconBg,
            ),
            SizedBoxConstants.sizedBoxEightyH(),
            viewYourGroupCubit.eventModel.title != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextComponent(
                            viewYourGroupCubit.eventModel.title ?? "",
                            style: FontStylesConstants.style30(
                                color: ColorConstants.white)),
                      ),
                      SizedBoxConstants.sizedBoxTenH(),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child:
                            // TextComponent("17 Feb . 11AM - 2PM . Manchester",
                            //     style:
                            //     FontStylesConstants.style16(color: ColorConstants.white)),
                        viewYourGroupCubit.eventModel.venues != null &&
                                    (viewYourGroupCubit.eventModel.venues ?? [])
                                        .isNotEmpty
                                ? TextComponent(
                                    "",
                                    listOfText: [
                                      DateFormat('d MMM \'at\' hh a').format(
                                          DateTime.parse((viewYourGroupCubit
                                                          .eventModel.venues ??
                                                      [])
                                                  .first
                                                  .startDatetime ??
                                              "")),
                                      //    DateFormat('d MMM \'at\' hh a').format(DateTime.parse(eventCubit.eventModelList[index].venues?.first.endDatetime ?? "")),
                                      "-",
                                      DateFormat('d MMM \'at\' hh a').format(
                                          DateTime.parse((viewYourGroupCubit
                                                          .eventModel.venues ??
                                                      [])
                                                  .first
                                                  .endDatetime ??
                                              "")),
                                      "-",
                                      viewYourGroupCubit.eventModel.venues
                                              ?.first.location ??
                                          "asdasddas"
                                    ],
                                    listOfTextStyle: [
                                      FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                      FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                      FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                      FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                      FontStylesConstants.style14(
                                          color: ColorConstants.white),
                                    ],
                                    style: FontStylesConstants.style14(
                                        color: ColorConstants.white),
                                  )
                                : TextComponent(""),
                      ),
                      SizedBoxConstants.sizedBoxTenH(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconComponent(
                              iconData:
                                  (viewYourGroupCubit.eventModel.isPublic ??
                                          true)
                                      ? Icons.lock_open_rounded
                                      : Icons.lock,
                              backgroundColor: ColorConstants.transparent,
                              iconColor: Colors.white,
                              customIconText:
                                  (viewYourGroupCubit.eventModel.isPublic ??
                                          true)
                                      ? " Public"
                                      : " Private",
                              circleSize: 60,
                              circleHeight: 35,
                              iconSize: 20,
                            ),
                            IconComponent(
                              iconData: Icons.edit,
                              backgroundColor: ColorConstants.lightGray,
                              iconColor: ColorConstants.primaryColor,
                              customIconText: "Edit",
                              circleSize: 60,
                              circleHeight: 35,
                              iconSize: 20,
                              onTap: () {
                                NavigationUtil.push(
                                    context, RouteConstants.editGroupScreen,
                                    args: viewYourGroupCubit.eventModel);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : _shimmerTopData(),
            SizedBoxConstants.sizedBoxThirtyH(),
            Container(
              width: AppConstants.responsiveWidth(context, percentage: 100),
              //MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
              decoration: BoxDecoration(
                color: ColorConstants.darkBackgrounddColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ContactCard(
                  name: viewYourGroupCubit.eventModel.userName ?? "",
                  //"Jesse",
                  url: viewYourGroupCubit.eventModel.userImages ?? "",
                  //"",
                  title: "Group Creator",
                  showShareIcon: false,
                  showDivider: false,
                  imageSize: 40,
                ),
              ),
            ),
            viewYourGroupCubit.eventModel.title != null
                ? _aboutTheEvent()
                : _shimmerAboutTheEvent(),
            SizedBoxConstants.sizedBoxTenH(),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: AppConstants.responsiveWidth(context, percentage: 90),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.btnGradientColor,
                    const Color.fromARGB(255, 220, 210, 210)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ButtonComponent(
                  bgcolor: ColorConstants.transparent,
                  textColor: ColorConstants.black,
                  buttonText: StringConstants.inviteFriends,
                  onPressed: () {}),
            ),
            // _members(),
          ],
        ),
      ),
    ]);
  }

  Widget _shimmerTopData() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, top: 15),
              height: 15,
              width: AppConstants.responsiveWidth(context, percentage: 40),
              color: ColorConstants.white,
            ),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 15),
                height: 10,
                width: AppConstants.responsiveWidth(context, percentage: 30),
                color: ColorConstants.white,
              )),
          SizedBoxConstants.sizedBoxTenH(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 15),
                  height: 8,
                  width: AppConstants.responsiveWidth(context, percentage: 20),
                  color: ColorConstants.white,
                ),
                Container(
                  // margin: const EdgeInsets.only( ),
                  height: 30,
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: AppConstants.responsiveWidth(context, percentage: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerAboutTheEvent() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Shimmer.fromColors(
          baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: 15,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 80),
                    color: ColorConstants.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 30,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 80),
                    color: ColorConstants.white,
                  ),
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  SizedBoxConstants.sizedBoxSixH(),
                  DividerCosntants.divider1,
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  SizedBoxConstants.sizedBoxSixH(),
                  DividerCosntants.divider1,
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    height: 10,
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    color: ColorConstants.white,
                  ),
                  SizedBoxConstants.sizedBoxTenH()
                ],
              ),
            ),
          ]),
        ));
  }

  Widget _aboutTheEvent() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Container(
          width: AppConstants.responsiveWidth(context),
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
                  if (viewYourGroupCubit.eventModel.description != null &&
                      (viewYourGroupCubit.eventModel.description ?? "")
                          .isNotEmpty)
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
                                  ? viewYourGroupCubit.eventModel.description
                                  : ((viewYourGroupCubit.eventModel.description ??
                                                      "")
                                                  .length >
                                              150
                                          ? (viewYourGroupCubit
                                                      .eventModel.description ??
                                                  "")
                                              .substring(0, 150)
                                          : viewYourGroupCubit
                                              .eventModel.description) ??
                                      "No description available",
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                            if ((viewYourGroupCubit.eventModel.description ?? "")
                                    .length >
                                150)
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
          ]),
        ));
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
                        text: totalAcceptedMembers ?? "0",
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
                    child: ContactCard(
                      name: (viewYourGroupCubit.eventModel.userName ?? ""),
                      url: (viewYourGroupCubit.eventModel.userImages ?? ""),
                      title: (viewYourGroupCubit.eventModel.userAboutMe ?? ""),
                      showShareIcon: false,
                      showDivider: false,
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
            if ((acceptedRequests ?? []).isNotEmpty) DividerCosntants.divider1,
            // ...memberResponseDetail!.asMap().entries.map((entry) {
            ...?acceptedRequests?.asMap().entries.map((entry) {
              int index = entry.key;
              EventRequest details = entry.value;
              bool isLast = index == acceptedRequests!.length - 1;
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: MemberResponseComponent(
                        name: details.name ?? "",
                        url: details.image ?? "",
                        //details['url'],
                        title: details.aboutMe ?? "",
                        //details['title'],
                        // contact: details['title'],
                        messageValue: details.query?.question ?? "",
                        //details['messageValue'],
                        questionsAndAnswers: details.eventQuestions,
                        questions: viewYourGroupCubit.eventModel.question,
                      ),
                    ),
                    if (!isLast) DividerCosntants.divider1,
                  ],
                ),
              );
            }),
            SizedBoxConstants.sizedBoxThirtyH(),
          ],
        ),
      ),
    );
  }

  Widget _requestedMembers() {
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
                      const TextSpan(
                          text: "${StringConstants.requestedMembers}  "),
                      TextSpan(
                        text: totalRequestedMembers ?? "0",
                        style: TextStyle(
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            // SizedBoxConstants.sizedBoxThirtyH(),
            // Row(
            //   children: [
            //     Container(
            //         margin: EdgeInsets.only(left: 5),
            //         width:
            //         AppConstants.responsiveWidth(context, percentage: 66),
            //         child:  ContactCard(
            //           name: (viewYourEventCubit.eventModel.userName ?? ""),
            //           url: (viewYourEventCubit.eventModel.userImages ?? ""),
            //           title: (viewYourEventCubit.eventModel.description ?? ""),
            //           showShareIcon: false,
            //           showDivider: false,
            //           imageSize: 40,
            //         )),
            //     Container(
            //       padding: const EdgeInsets.only(
            //           left: 16, right: 16, top: 3, bottom: 3),
            //       decoration: BoxDecoration(
            //         color: ColorConstants.primaryColor,
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //         // color: themeCubit.darkBackgroundColor,
            //       ),
            //       child: TextComponent(StringConstants.creator,
            //           textAlign: TextAlign.right),
            //     ),
            //   ],
            // ),
            // DividerCosntants.divider1,
            SizedBoxConstants.sizedBoxTwentyH(),
            /////////////////////////////
            // ...memberResponseDetail!.asMap().entries.map((entry) {
            ...?pendingRequests?.asMap().entries.map((entry) {
              int index = entry.key;
              EventRequest details = entry.value;
              bool isLast = index == pendingRequests!.length - 1;
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: MemberResponseComponent(
                        name: details.name ?? "",
                        url: details.image ?? "",
                        isPending: true,
                        title: details.aboutMe ?? "",
                        messageValue: details.query?.question ?? "",
                        questionsAndAnswers: details.eventQuestions,
                        questions: viewYourGroupCubit.eventModel.question,
                        onTapPending: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    DarkTheme.darkBackgroundColor100,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextComponent(
                                      "Reply to Query",
                                      style: TextStyle(
                                          color: ColorConstants.white),
                                    ),
                                    InkWell(
                                      onTap: () => {
                                        _queryController.clear(),
                                        Navigator.pop(context)
                                      },
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
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextComponent(details.query?.question ?? "",
                                        style: TextStyle(
                                            color: ColorConstants.white)),
                                    SizedBoxConstants.sizedBoxTenH(),
                                    TextFieldComponent(_queryController,
                                        hintText: "",
                                        maxLines: 3,
                                        minLines: 3,
                                        autoFocus: true,
                                        filled: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textColor: themeCubit.textColor,
                                        onChanged: (value) {
                                      Query queryReply = Query(
                                          question:
                                              details.query?.question ?? "",
                                          answer: _queryController.value.text);
                                      viewYourGroupCubit.addQuery(queryReply);
                                    })
                                  ],
                                ),
                                actions: <Widget>[
                                  SizedBoxConstants.sizedBoxTenH(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonComponent(
                                          isSmallBtn: true,
                                          buttonText: "Reject",
                                          bgcolor: ColorConstants.blackLight,
                                          textColor: ColorConstants.white,
                                          onPressed: () {
                                            _queryController.clear();
                                            viewYourGroupCubit.replyQueryById(
                                                viewYourGroupCubit
                                                        .eventModel.id ??
                                                    "",
                                                details.id ?? "",
                                                "Rejected",
                                                viewYourGroupCubit
                                                        .eventRequest.query ??
                                                    Query());
                                            NavigationUtil.pop(context);
                                          }),
                                      ButtonComponent(
                                          isSmallBtn: true,
                                          buttonText: "Accept",
                                          bgcolor: ColorConstants.primaryColor,
                                          textColor: ColorConstants.black,
                                          onPressed: () {
                                            _queryController.clear();
                                            viewYourGroupCubit.replyQueryById(
                                                viewYourGroupCubit
                                                        .eventModel.id ??
                                                    "",
                                                details.id ?? "",
                                                "Accepted",
                                                viewYourGroupCubit
                                                        .eventRequest.query ??
                                                    Query());
                                            NavigationUtil.pop(context);
                                          }),
                                    ],
                                  ),
                                  SizedBoxConstants.sizedBoxTenH(),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      //onTapPending show dailog where detail query pass show in text field and text input field to reply that query and give button of accept and reject
                    ),
                    if (!isLast) DividerCosntants.divider1,
                  ],
                ),
              );
            }),
            SizedBoxConstants.sizedBoxThirtyH(),
          ],
        ),
      ),
    );
  }
}
