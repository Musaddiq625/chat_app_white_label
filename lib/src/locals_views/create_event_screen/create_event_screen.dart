import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/event_data_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/contacts_card_component.dart';
import '../../components/icons_button_component.dart';
import '../../components/info_sheet_component.dart';
import '../../components/profile_image_component.dart';
import '../../components/search_text_field_component.dart';
import '../../models/contact.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  EventDataModel? _eventDataModel;
  final TextEditingController _controller = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchControllerConnections = TextEditingController();
  bool requireGuest = true;
  bool askQuestion = false;
  bool editQuestion = false;
  bool locationVisible = true;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  String _selectedQuestionRequired = 'Required';
  String _selectedQuestionPublic = 'Public';
  int? selectedIndexPrice;
  int? _draggingIndex;
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
    // ... other contacts
  ];

  String? startDate;
  String? endDate;
  List<String> questions = ['Question 1'];
  List<TextEditingController> _questionControllers =
      []; // Initialize with one question
  final TextEditingController _controllerQuestions = TextEditingController();

  //
  // void _addQuestion() {
  //   setState(() {
  //     questions.add('Question ${questions.length + 1}'); // Add a new question
  //   });
  // }
  //
  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     if (newIndex > oldIndex) {
  //       newIndex -= 1;
  //     }
  //     final String item = questions.removeAt(oldIndex);
  //     questions.insert(newIndex, item);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each question
    _questionControllers =
        List.generate(questions.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _questionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        bgColor: themeCubit.backgroundColor,
        // removeSafeAreaPadding: true,
        // appBar:_appBar(),
        appBar: const AppBarComponent(
          StringConstants.createEvent,
          centerTitle: false,
          isBackBtnCircular: false,
        ),
        widget: _createEvent());
  }

  toggleTaped() {
    print("Tapped ${themeCubit.isDarkMode}");
    themeCubit.toggleTheme();
  }

  Widget _buildContainer(
      int rowIndex, int index, StateSetter setStateBottomSheet) {
    int containerIndex =
        rowIndex * 3 + index; // Calculate the index for each container
    return GestureDetector(
      onTap: () =>
          setStateBottomSheet(() => selectedIndexPrice = containerIndex),
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
        decoration: BoxDecoration(
          color: selectedIndexPrice == containerIndex
              ? themeCubit.primaryColor
              : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: TextComponent(
          ["Free", "£5", "£10", "£25", "£50", "£100"][containerIndex],
          style: TextStyle(
              fontSize: 15,
              color: selectedIndexPrice == containerIndex
                  ? ColorConstants.black
                  : ColorConstants.white),
        ),
      ),
    );
  }

  Widget _createEvent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBoxConstants.sizedBoxTenH(),

          // Padding(
          //   padding: const EdgeInsets.only(top: 20.0, left: 5),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //           child: GestureDetector(
          //         onTap: _goBackBottomSheet,
          //         child: IconComponent(
          //           iconData: Icons.arrow_back_ios_new,
          //           iconSize: 20,
          //           circleHeight: 30,
          //           backgroundColor: ColorConstants.transparent,
          //           borderColor: ColorConstants.transparent,
          //           iconColor: ColorConstants.lightGray,
          //         ),
          //       )),
          //       const SizedBox(
          //         width: 20,
          //       ),
          //       TextComponent(
          //         StringConstants.createEvent,
          //         style: TextStyle(
          //             fontFamily: FontConstants.fontProtestStrike,
          //             fontSize: 20,
          //             color: themeCubit.primaryColor),
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      child: ImageComponent(
                        imgUrl:
                            "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                        width: AppConstants.responsiveWidth(context),
                        height: AppConstants.responsiveHeight(context,
                            percentage: 85),
                        imgProviderCallback: (imgProvider) {},
                      ),
                    ),
                    Positioned(
                      top: AppConstants.responsiveHeight(context,
                          percentage: 60),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconComponent(
                                  iconData: Icons.edit,
                                  borderColor: ColorConstants.transparent,
                                  circleSize: 35,
                                  backgroundColor:
                                      ColorConstants.lightGray.withOpacity(0.5),
                                  iconColor: ColorConstants.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const TextComponent(
                                  StringConstants.editCover,
                                  style: TextStyle(
                                      color: ColorConstants.white,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            const TextComponent(
                              "xyz Event",
                              style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: FontConstants.fontProtestStrike,
                                  color: ColorConstants.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Container(
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                //   image: DecorationImage(
                //     image: CachedNetworkImageProvider(
                //       "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                //     ),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // width: AppConstants.responsiveWidth(context),
                // height:
                //     AppConstants.responsiveHeight(context, percentage: 85),
                //   child: Padding(
                //     padding: const EdgeInsets.all(20.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Row(
                //           children: [
                //             IconComponent(
                //               iconData: Icons.edit,
                //               borderColor: ColorConstants.transparent,
                //               circleSize: 38,
                //               backgroundColor:
                //                   ColorConstants.lightGray.withOpacity(0.5),
                //               iconColor: ColorConstants.white,
                //             ),
                //             const SizedBox(
                //               width: 10,
                //             ),
                //             const TextComponent(
                //               StringConstants.editCover,
                //               style: TextStyle(
                //                   color: ColorConstants.white, fontSize: 15),
                //             )
                //           ],
                //         ),
                //         const Padding(
                //           padding: EdgeInsets.only(left: 20),
                //           child: TextComponent(
                //             "xyz Event",
                //             style: TextStyle(
                //                 fontSize: 38,
                //                 fontFamily: FontConstants.fontProtestStrike,
                //                 color: ColorConstants.white),
                //           ),
                //         ),
                //         SizedBoxConstants.sizedBoxSixtyH()
                //       ],
                //     ),
                //   ),
                // ),
                SizedBoxConstants.sizedBoxTwentyH(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextComponent(
                    StringConstants.eventDetail,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 20,
                        color: themeCubit.primaryColor),
                  ),
                ),
                SizedBoxConstants.sizedBoxTwelveH(),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  width: AppConstants.responsiveWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: themeCubit.darkBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ImageComponent(
                                imgUrl: AssetConstants.calendar,
                                width: 20,
                                imgProviderCallback: (imgProvider) {},
                              ),
                              SizedBoxConstants.sizedBoxSixH(),
                              Column(
                                children: List.generate(6, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 0, bottom: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstants.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: 3,
                                      width: 3,
                                    ),
                                  );
                                }),
                              ),
                              SizedBoxConstants.sizedBoxSixH(),
                              SvgPicture.asset(
                                height: 20,
                                AssetConstants.end,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: AppConstants.responsiveWidth(context,
                                      percentage: 70),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextComponent(
                                        StringConstants.start,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeCubit.textColor),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          ).then((selectedDate) {
                                            // After selecting the date, display the time picker.
                                            if (selectedDate != null) {
                                              if (endDate != null && selectedDate.isBefore(DateTime.parse(endDate!))) {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((selectedTime) {
                                                  // Handle the selected date and time here.
                                                  if (selectedTime != null) {
                                                    DateTime selectedDateTime =
                                                        DateTime(
                                                      selectedDate.year,
                                                      selectedDate.month,
                                                      selectedDate.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute,
                                                    );

                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'd MMM \'at\' hh a')
                                                            .format(
                                                                selectedDateTime);

                                                    if (startDate == null) {
                                                      setState(() {
                                                        startDate =
                                                            selectedDateTime
                                                                .toString();
                                                        // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      });
                                                    }
                                                    else if(endDate != null && selectedDateTime.isAfter(DateTime.parse(endDate!))){
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: TextComponent(
                                                              "Start Date-Time cannot be After end Date-Time."),
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      setState(() {
                                                        startDate =
                                                            selectedDateTime
                                                                .toString();
                                                        // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      });
                                                    }
                                                    print(formattedDateTime);
                                                    print(
                                                        selectedDateTime); // print should display as 11 feb at 11 am
                                                  }
                                                });
                                              }
                                              else if (endDate != null && selectedDate.isAfter(DateTime.parse(endDate!))) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: TextComponent(
                                                        "Start date cannot be After end date."),
                                                  ),
                                                );
                                              }
                                              else {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((selectedTime) {
                                                  // Handle the selected date and time here.
                                                  if (selectedTime != null) {
                                                    DateTime selectedDateTime =
                                                        DateTime(
                                                      selectedDate.year,
                                                      selectedDate.month,
                                                      selectedDate.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute,
                                                    );

                                                    String formattedDateTime =
                                                        DateFormat(
                                                                'd MMM \'at\' hh a')
                                                            .format(
                                                                selectedDateTime);

                                                    if (startDate == null) {
                                                      setState(() {
                                                        startDate =
                                                            selectedDateTime
                                                                .toString();
                                                        // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      });
                                                    }
                                                    else if(endDate != null && selectedDateTime.isAfter(DateTime.parse(endDate!))){
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: TextComponent(
                                                              "Start Date-Time cannot be After end Date-Time."),
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      setState(() {
                                                        startDate =
                                                            selectedDateTime
                                                                .toString();
                                                        // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      });
                                                    }
                                                    print(formattedDateTime);
                                                    print(
                                                        selectedDateTime); // print should display as 11 feb at 11 am
                                                  }
                                                });
                                              }
                                            }
                                          });
                                        },
                                        child: TextComponent(
                                          startDate != null
                                              ? DateFormat('d MMM \'at\' hh a')
                                                  .format(DateTime.parse(
                                                      startDate!))
                                              : "Select Date & Time",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: themeCubit.textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: AppConstants.responsiveWidth(context,
                                      percentage: 76),
                                  child: Column(
                                    children: [DividerCosntants.divider1],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  width: AppConstants.responsiveWidth(context,
                                      percentage: 70),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextComponent(
                                        StringConstants.end,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeCubit.textColor),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (startDate != null) {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101),
                                            ).then((selectedDate) {
                                              // After selecting the date, display the time picker.
                                              if (selectedDate != null) {
                                                print("selectedDate $selectedDate start Date $startDate");
                                                if(selectedDate.isBefore(DateTime.parse(startDate!)) ){
                                                  ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: TextComponent(
                                                          "End date cannot be select before start date."),
                                                    ),
                                                  );
                                                }
                                                else if(selectedDate.isAfter(DateTime.parse(startDate!))|| selectedDate.isAtSameMomentAs(DateTime.parse(startDate!))){
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.now(),
                                                  ).then((selectedTime) {
                                                    // Handle the selected date and time here.
                                                    if (selectedTime != null) {
                                                      DateTime selectedDateTime =
                                                      DateTime(
                                                        selectedDate.year,
                                                        selectedDate.month,
                                                        selectedDate.day,
                                                        selectedTime.hour,
                                                        selectedTime.minute,
                                                      );

                                                      String formattedDateTime =
                                                      DateFormat(
                                                          'd MMM \'at\' hh a')
                                                          .format(
                                                          selectedDateTime);

                                                      if (endDate == null) {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      else if(selectedDateTime.isBefore(DateTime.parse(startDate!))){
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "End date-time cannot be select before start date-time."),
                                                          ),
                                                        );

                                                      }else if(selectedDateTime.isAfter(DateTime.parse(startDate!))){
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      else{
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }

                                                      print(formattedDateTime);
                                                      print(selectedDateTime);
                                                      //
                                                      // else {
                                                      //        // Optionally, show an error message or ignore the selection
                                                      //        ScaffoldMessenger.of(
                                                      //                context)
                                                      //            .showSnackBar(
                                                      //          SnackBar(
                                                      //            content: TextComponent(
                                                      //                "End date cannot be select before start date."),
                                                      //          ),
                                                      //        );
                                                      //      }
                                                      print(formattedDateTime);
                                                      // print(selectedDateTime); // print should display as 11 feb at 11 am
                                                    }
                                                  });
                                              }
                                                else{
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.now(),
                                                  ).then((selectedTime) {
                                                    // Handle the selected date and time here.
                                                    if (selectedTime != null) {
                                                      DateTime selectedDateTime =
                                                      DateTime(
                                                        selectedDate.year,
                                                        selectedDate.month,
                                                        selectedDate.day,
                                                        selectedTime.hour,
                                                        selectedTime.minute,
                                                      );

                                                      String formattedDateTime =
                                                      DateFormat(
                                                          'd MMM \'at\' hh a')
                                                          .format(
                                                          selectedDateTime);

                                                      if (endDate == null) {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      else if(selectedDateTime.isBefore(DateTime.parse(startDate!))){
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "End date-time cannot be select before start date-time."),
                                                          ),
                                                        );

                                                      }else if(selectedDateTime.isAfter(DateTime.parse(startDate!))){
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      else{
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }

                                                      print(formattedDateTime);
                                                      print(selectedDateTime);
                                                      //
                                                      // else {
                                                      //        // Optionally, show an error message or ignore the selection
                                                      //        ScaffoldMessenger.of(
                                                      //                context)
                                                      //            .showSnackBar(
                                                      //          SnackBar(
                                                      //            content: TextComponent(
                                                      //                "End date cannot be select before start date."),
                                                      //          ),
                                                      //        );
                                                      //      }
                                                      print(formattedDateTime);
                                                      // print(selectedDateTime); // print should display as 11 feb at 11 am
                                                    }
                                                  });
                                                }

                                              }
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: TextComponent(
                                                    "First Select start date."),
                                              ),
                                            );
                                          }
                                        },
                                        child: TextComponent(
                                          endDate != null
                                              ? DateFormat('d MMM \'at\' hh a')
                                                  .format(
                                                      DateTime.parse(endDate!))
                                              : "Select Date & Time",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: themeCubit.textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  leadingIconWidth: 25,
                  leadingIconHeight: 25,
                  leadingIcon: AssetConstants.marker,
                  leadingText: StringConstants.location,
                  trailingText: "Manchester",
                  onTap: _selectLocation,
                  subTextColor: themeCubit.textColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  leadingIconWidth: 25,
                  leadingIconHeight: 25,
                  leadingIcon: AssetConstants.ticket,
                  leadingText: StringConstants.price,
                  trailingText: "Free",
                  onTap: _selectPrice,
                  subTextColor: themeCubit.textColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  leadingIconWidth: 25,
                  leadingIconHeight: 25,
                  leadingIcon: AssetConstants.happy,
                  leadingText: StringConstants.capacity,
                  trailingText: "60",
                  onTap: _selectCapacity,
                  subTextColor: themeCubit.textColor,
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextComponent(
                    StringConstants.eventDescription,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 20,
                        color: themeCubit.primaryColor),
                  ),
                ),
                SizedBoxConstants.sizedBoxTenH(),
                TextField(
                  controller: _controllerQuestions,
                  maxLines: 4,
                  style: TextStyle(color: themeCubit.textColor),
                  decoration: InputDecoration(
                    hintText: StringConstants.typeYourDescription,
                    filled: true,
                    fillColor: themeCubit.darkBackgroundColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: ColorConstants.transparent,
                        )),
                    hintStyle: const TextStyle(
                        color: ColorConstants.lightGray, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: ColorConstants.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: const BorderSide(
                            color: ColorConstants.transparent)),
                    // suffixIcon: IconButton(
                    //   icon: Icon(Icons.send),
                    //   onPressed: _sendMessage,
                    // ),
                  ),
                ),
                SizedBoxConstants.sizedBoxTwentyH(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextComponent(
                    StringConstants.otherOptions,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 20,
                        color: themeCubit.primaryColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  leadingIconWidth: 25,
                  leadingIconHeight: 25,
                  leadingIcon: AssetConstants.marker,
                  leadingText: StringConstants.visibility,
                  trailingText: "Public",
                  onTap: () {},
                  subTextColor: themeCubit.textColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: AppConstants.responsiveWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: themeCubit.darkBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:10.0,left:15,right: 15,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: ImageComponent(
                            imgUrl: AssetConstants.ticket,
                            height: 25,
                            width: 25,
                            imgProviderCallback:
                                (ImageProvider<Object> imgProvider) {},
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent(
                                    StringConstants.requireGuestsApproval,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: themeCubit.textColor)),
                                SizedBoxConstants.sizedBoxSixH(),
                                Container(
                                  child: const TextComponent(
                                      StringConstants
                                          .requireGuestsApprovalBody,
                                      maxLines: 6,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: ColorConstants.lightGray),
                                      textAlign: TextAlign.start),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Switch(
                          // This bool value toggles the switch.
                          value: requireGuest,
                          activeColor: ColorConstants.white,
                          activeTrackColor: themeCubit.primaryColor,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              requireGuest = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: AppConstants.responsiveWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: themeCubit.darkBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:10.0,left:15,right: 15,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: SvgPicture.asset(
                                height: 25,
                                AssetConstants.ticket,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextComponent(
                                      StringConstants.askQuestionWhenPeopleJoin,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: themeCubit.textColor),
                                    ),
                                    Container(
                                      child: const TextComponent(
                                          StringConstants
                                              .askQuestionWhenPeopleJoinBody,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.lightGray),
                                          textAlign: TextAlign.start),
                                    ),
                                    if (editQuestion != false)
                                      Row(
                                        children: [
                                          TextComponent(
                                            StringConstants.editQuestions,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: themeCubit.textColor),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          IconComponent(
                                            iconData: Icons.edit,
                                            borderColor:
                                                ColorConstants.transparent,
                                            backgroundColor:
                                                ColorConstants.transparent,
                                            iconColor: ColorConstants.lightGray
                                                .withOpacity(0.5),
                                            iconSize: 20,
                                            circleSize: 15,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              // This bool value toggles the switch.
                              value: askQuestion,
                              activeColor: ColorConstants.white,
                              activeTrackColor: themeCubit.primaryColor,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  askQuestion = value;
                                });
                                if (askQuestion == true) {
                                  _selectQuestion();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8,right: 8),
                  child: ButtonComponent(
                    bgcolor: themeCubit.primaryColor,
                    buttonText: StringConstants.createEvent,
                    textColor: themeCubit.backgroundColor,
                    onPressed: () {
                      // EventUtils.createEvent(_eventDataModel!);
                      _createBottomSheet();
                      // NavigationUtil.push(
                      //     context, RouteConstants.localsEventScreen);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _createBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: const InfoSheetComponent(
        heading: StringConstants.eventCreatedSuccessfully,
        image: AssetConstants.confetti,
      ),
    );
    Future.delayed(const Duration(milliseconds: 1000), () async {
      NavigationUtil.pop(context);
      _createEventBottomSheet();
    });
  }

  _selectLocation() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: themeCubit.darkBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      StringConstants.selectLocation,
                      style: TextStyle(
                          color: themeCubit.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: themeCubit.textColor,
                        circleSize: 20,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchTextField(
                  title: "Search",
                  hintText: "Search name, postcode..",
                  onSearch: (text) {
                    // widget.viewModel.onSearchStories(text);
                  },
                  textEditingController: searchController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextComponent(
                        StringConstants.exactLocationApproval,
                        style: TextStyle(
                            fontSize: 15, color: themeCubit.textColor),
                        maxLines: 4,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      // This bool value toggles the switch.
                      value: locationVisible,
                      activeColor: ColorConstants.white,
                      activeTrackColor: themeCubit.primaryColor,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          locationVisible = value;
                        });
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
    }));
  }

  _createEventBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: themeCubit.darkBackgroundColor,
          ),
          constraints: const BoxConstraints(maxHeight: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0, top: 15),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: themeCubit.textColor,
                        circleSize: 10,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Image.asset(
                    AssetConstants.confetti,
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextComponent(
                      StringConstants.eventCreatedSuccessfully,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: FontConstants.fontProtestStrike,
                          color: themeCubit.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextComponent(
                      StringConstants.inviteYourFriend,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
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
                height: 5,
              ),
              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 5),
                child: TextComponent(
                  StringConstants.yourConnections,
                  style: TextStyle(
                      color: themeCubit.primaryColor,
                      fontFamily: FontConstants.fontProtestStrike,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, top: 10, bottom: 16, right: 18),
                child: SearchTextField(
                  title: "Search",
                  hintText: "Search name, postcode..",
                  onSearch: (text) {
                    // widget.viewModel.onSearchStories(text);
                  },
                  textEditingController: searchControllerConnections,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (ctx, index) {
                    return ContactCard(
                      name: contacts[index].name,
                      title: contacts[index].title,
                      url: contacts[index].url,
                      // contact: contacts[index],
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorConstants.black,
                    height: 1.5),
                children: <TextSpan>[
                  const TextSpan(
                      text: StringConstants.areYouSureYouwantToShare),
                  TextSpan(
                    text: eventName,
                    style: const TextStyle(color: Colors.indigo),
                  ),
                  const TextSpan(text: "with \n"),
                  TextSpan(
                    text: "$userName?",
                    style: const TextStyle(color: Colors.indigo),
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
                    child: const TextComponent(StringConstants.goBack)),
                const SizedBox(width: 30),
                ButtonComponent(
                  buttonText: "Yes, share it",
                  onPressed: () {
                    Navigator.pop(context);
                    _yesShareItBottomSheet();
                  },
                  bgcolor: ColorConstants.yellow,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _goBackBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(
              AssetConstants.warning,
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 20),
            const TextComponent(StringConstants.areYouSureYouwantToExit,
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontFamily: FontConstants.fontProtestStrike)),
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
                  bgcolor: ColorConstants.red,
                  textColor: themeCubit.textColor,
                  buttonText: StringConstants.yesExit,
                  isSmallBtn: true,
                  onPressed: () {
                    NavigationUtil.popAllAndPush(
                        context, RouteConstants.mainScreen);
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
      body: const InfoSheetComponent(
        heading: StringConstants.eventShared,
        image: AssetConstants.group,
      ),
    );
  }

  Widget _buildRow(int rowIndex, StateSetter setStateBottomSheet) {
    return Container(
      child: Row(
        children: List.generate(3,
            (index) => _buildContainer(rowIndex, index, setStateBottomSheet)),
      ),
    );
  }

  _selectPrice() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: themeCubit.darkBackgroundColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          StringConstants.pricing,
                          style: TextStyle(
                              color: themeCubit.primaryColor,
                              fontFamily: FontConstants.fontProtestStrike,
                              fontSize: 18),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: IconComponent(
                            iconData: Icons.close,
                            borderColor: Colors.transparent,
                            iconColor: themeCubit.textColor,
                            circleSize: 20,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTwentyH(),
                    _buildRow(0, setState),
                    const SizedBox(height: 10),
                    _buildRow(1, setState),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent("Free",
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: themeCubit.textColor)),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent("£5",
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: themeCubit.textColor)),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent("£10",
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: themeCubit.textColor)),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent("£25",
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: themeCubit.textColor)),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent("£50",
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: themeCubit.textColor)),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Flexible(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstants.backgroundColor
                    //                 .withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 25, bottom: 25, left: 30, right: 30),
                    //             child: TextComponent(
                    //               "£100",
                    //               style: TextStyle(
                    //                   fontSize: 15, color: themeCubit.textColor),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextComponent(
                      StringConstants.setOtherAmount,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: ColorConstants.white,
                      ),
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        hintText: "£",
                        filled: true,
                        fillColor:
                            ColorConstants.backgroundColor.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: ColorConstants.transparent,
                            )),
                        hintStyle: const TextStyle(
                            color: ColorConstants.lightGray, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: ColorConstants.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: ColorConstants.transparent)),
                        // suffixIcon: IconButton(
                        //   icon: Icon(Icons.send),
                        //   onPressed: _sendMessage,
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: AppConstants.responsiveWidth(context),
                      child: ButtonComponent(
                        bgcolor: themeCubit.primaryColor,
                        textColor: ColorConstants.black,
                        buttonText: StringConstants.done,
                        onPressed: () {
                          // _yesShareItBottomSheet();
                          // NavigationUtil.push(
                          //     context, RouteConstants.localsEventScreen);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    }));
  }

  _selectCapacity() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: themeCubit.darkBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(
                        StringConstants.capacity,
                        style: TextStyle(
                            color: themeCubit.primaryColor,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: IconComponent(
                          iconData: Icons.close,
                          borderColor: Colors.transparent,
                          iconColor: themeCubit.textColor,
                          circleSize: 20,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextComponent(
                    StringConstants.limitNumberOfParticipants,
                    style: TextStyle(color: themeCubit.textColor),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextComponent(
                    StringConstants.participants,
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: const TextStyle(
                      color: ColorConstants.white,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      hintText: "Unlimited",
                      filled: true,
                      fillColor:
                          ColorConstants.backgroundColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: const TextStyle(
                          color: ColorConstants.lightGray, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              color: ColorConstants.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              color: ColorConstants.transparent)),
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.send),
                      //   onPressed: _sendMessage,
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: AppConstants.responsiveWidth(context),
                    child: ButtonComponent(
                      textColor: themeCubit.backgroundColor,
                      bgcolor: themeCubit.primaryColor,
                      buttonText: StringConstants.done,
                      onPressed: () {
                        // _yesShareItBottomSheet();
                        // NavigationUtil.push(
                        //     context, RouteConstants.localsEventScreen);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }

  _selectQuestion() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextComponent(
                      StringConstants.questions,
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: Colors.white,
                        circleSize: 20,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextComponent(
                  StringConstants.choseToAskQuestion,
                  maxLines: 2,
                  style: TextStyle(color: themeCubit.textColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                question(setState),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWithIconComponent(
                      btnText: '  ${StringConstants.addQuestion}',
                      icon: Icons.add_circle,
                      btnTextStyle: const TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        setState(() =>
                            questions.add('Question ${questions.length + 1}'));
                        TextEditingController newController =
                            TextEditingController();
                        // Add the new controller to the _questionControllers list
                        _questionControllers.add(newController);
                      },
                    ),
                    ButtonComponent(
                      isSmallBtn: true,
                      bgcolor: ColorConstants.primaryColor,
                      textColor: ColorConstants.black,
                      buttonText: StringConstants.done,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ));
    }));
  }

  question(StateSetter setStateBottomSheet) {
    return ReorderableListView(
      shrinkWrap: true,
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        // Apply your custom decoration here
        return Container(
          color: Colors.transparent, // Change this to your desired color
          child: child,
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setStateBottomSheet(() {
          print('Reordering: $oldIndex -> $newIndex');
          print("item  ${questions}");
          final String item = questions.removeAt(oldIndex);
          questions.insert(newIndex, item);

          final TextEditingController controller =
              _questionControllers.removeAt(oldIndex);
          _questionControllers.insert(newIndex, controller);
          print('Reordering After reordering: $questions');
        });
      },
      children: List<Widget>.generate(questions.length, (int index) {
        return Container(
          key: ValueKey(questions[index]), // Assign a unique key to each child
          child: Column(children: [
            Row(
              children: [
                TextComponent(
                  questions[index],
                  style: TextStyle(color: themeCubit.textColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    setStateBottomSheet(() {
                      _questionControllers[index].dispose();
                      _questionControllers.removeAt(index);
                      questions.removeAt(index); // Remove the question
                    })
                  },
                  child: IconComponent(
                    iconData: Icons.delete,
                    borderColor: ColorConstants.red,
                    backgroundColor: ColorConstants.red,
                    iconColor: ColorConstants.white,
                    iconSize: 15,
                    circleSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.lightGray.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: Material(
                      color: ColorConstants.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextField(
                        controller: _questionControllers[index],
                        style: TextStyle(color: themeCubit.textColor),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          hintText: StringConstants.typeYourQuestion,
                          filled: true,
                          fillColor: ColorConstants.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: ColorConstants.transparent),
                          ),
                          hintStyle: const TextStyle(
                              color: ColorConstants.lightGray, fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: ColorConstants.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: ColorConstants.transparent)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setStateBottomSheet(() {
                        _draggingIndex = index;
                      });
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconComponent(
                          iconData: Icons.menu,
                          borderColor: ColorConstants.transparent,
                          backgroundColor: ColorConstants.transparent,
                          iconColor: ColorConstants.lightGray.withOpacity(0.4),
                          iconSize: 25,
                          circleSize: 25,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconComponent(
                  iconData: Icons.arrow_downward_outlined,
                  borderColor: ColorConstants.transparent,
                  backgroundColor: ColorConstants.transparent,
                  iconColor: ColorConstants.lightGray,
                  iconSize: 25,
                  circleSize: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MenuAnchor(
                      style: MenuStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            themeCubit.backgroundColor),
                      ),
                      childFocusNode: _buttonFocusNode,
                      menuChildren: <Widget>[
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedQuestionRequired == 'Required',
                              onChanged: (bool? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedQuestionRequired = 'Required';
                                  });
                                }
                              },
                              shape: const CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            TextComponent(
                              "Required",
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 0.1,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedQuestionRequired == 'Optional',
                              onChanged: (bool? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedQuestionRequired = 'Optional';
                                  });
                                }
                              },
                              shape: const CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            TextComponent(
                              "Optional",
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ],
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return TextButton(
                          focusNode: _buttonFocusNode,
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: TextComponent(
                            _selectedQuestionRequired,
                            style: const TextStyle(
                                color: ColorConstants.lightGray),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                IconComponent(
                  iconData: Icons.arrow_downward_outlined,
                  borderColor: ColorConstants.transparent,
                  backgroundColor: ColorConstants.transparent,
                  iconColor: ColorConstants.lightGray,
                  iconSize: 25,
                  circleSize: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MenuAnchor(
                      alignmentOffset: const Offset(-250, 0),
                      style: MenuStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            themeCubit.backgroundColor),
                      ),
                      childFocusNode: _buttonFocusNode,
                      menuChildren: <Widget>[
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedQuestionPublic == 'Public',
                              onChanged: (bool? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedQuestionPublic = 'Public';
                                  });
                                }
                              },
                              shape: const CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent(
                                  'Public',
                                  style: TextStyle(color: themeCubit.textColor),
                                ),
                                TextComponent(
                                  'Responses can be seen by everyone',
                                  style: TextStyle(color: themeCubit.textColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 0.1,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedQuestionPublic == 'Private',
                              onChanged: (bool? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedQuestionPublic = 'Private';
                                  });
                                }
                              },
                              shape: const CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent(
                                  'Private',
                                  style: TextStyle(color: themeCubit.textColor),
                                ),
                                TextComponent(
                                  'Only host can see the responses',
                                  style: TextStyle(color: themeCubit.textColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        )
                      ],
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return TextButton(
                          focusNode: _buttonFocusNode,
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: Column(
                            children: [
                              TextComponent(
                                _selectedQuestionPublic,
                                style: const TextStyle(
                                    color: ColorConstants.lightGray),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ]),
        );
      }),
    );
  }
}

// return ListView.builder(
//     shrinkWrap: true,
//     itemCount: questions.length,
//     itemBuilder: (context, index) {
//       return Container(
//         child: Column(children: [
//           Row(
//             children: [
//               TextComponent(
//                 questions[index],
//                 style: TextStyle(color: themeCubit.textColor),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               GestureDetector(
//                 onTap: () => {
//                   setStateBottomSheet(() {
//                     questions.removeAt(index); // Remove the question
//                   })
//                 },
//                 child: IconComponent(
//                   iconData: Icons.delete,
//                   borderColor: ColorConstants.red,
//                   backgroundColor: ColorConstants.red,
//                   iconColor: ColorConstants.white,
//                   iconSize: 15,
//                   circleSize: 20,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
//               hintText: StringConstants.typeYourQuestion,
//               filled: true,
//               fillColor: ColorConstants.lightGray.withOpacity(0.3),
//               suffixIcon: GestureDetector(
//                 child: Padding(
//                     padding: EdgeInsets.only(right: 20, top: 8),
//                     child: IconComponent(
//                       iconData: Icons.menu,
//                       borderColor: ColorConstants.transparent,
//                       backgroundColor: ColorConstants.transparent,
//                       iconColor: ColorConstants.lightGray.withOpacity(0.4),
//                       iconSize: 25,
//                       circleSize: 25,
//                     )),
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   borderSide: BorderSide(
//                     color: ColorConstants.transparent,
//                   )),
//               hintStyle:
//                   TextStyle(color: ColorConstants.lightGray, fontSize: 14),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   borderSide:
//                       BorderSide(color: ColorConstants.transparent)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   borderSide:
//                       BorderSide(color: ColorConstants.transparent)),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconComponent(
//                 iconData: Icons.arrow_downward_outlined,
//                 borderColor: ColorConstants.transparent,
//                 backgroundColor: ColorConstants.transparent,
//                 iconColor: ColorConstants.lightGray,
//                 iconSize: 25,
//                 circleSize: 25,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MenuAnchor(
//                     style: MenuStyle(
//                       backgroundColor: MaterialStatePropertyAll<Color>(
//                           themeCubit.backgroundColor),
//                     ),
//                     childFocusNode: _buttonFocusNode,
//                     menuChildren: <Widget>[
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _selectedQuestionRequired == 'Required',
//                             onChanged: (bool? value) {
//                               if (value != null) {
//                                 setState(() {
//                                   _selectedQuestionRequired = 'Required';
//                                 });
//                               }
//                             },
//                             shape: CircleBorder(),
//                             // Makes the checkbox circular
//                             activeColor: ColorConstants.primaryColor,
//                             // Sets the color of the checkbox when selected
//                             checkColor: Colors.black,
//                           ),
//                           TextComponent(
//                             "Required",
//                             style: TextStyle(color: themeCubit.textColor),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           )
//                         ],
//                       ),
//                       Divider(
//                         thickness: 0.1,
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _selectedQuestionRequired == 'Optional',
//                             onChanged: (bool? value) {
//                               if (value != null) {
//                                 setState(() {
//                                   _selectedQuestionRequired = 'Optional';
//                                 });
//                               }
//                             },
//                             shape: CircleBorder(),
//                             // Makes the checkbox circular
//                             activeColor: ColorConstants.primaryColor,
//                             // Sets the color of the checkbox when selected
//                             checkColor: Colors.black,
//                           ),
//                           TextComponent(
//                             "Optional",
//                             style: TextStyle(color: themeCubit.textColor),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           )
//                         ],
//                       ),
//                     ],
//                     builder: (BuildContext context,
//                         MenuController controller, Widget? child) {
//                       return TextButton(
//                         focusNode: _buttonFocusNode,
//                         onPressed: () {
//                           if (controller.isOpen) {
//                             controller.close();
//                           } else {
//                             controller.open();
//                           }
//                         },
//                         child: TextComponent(
//                           _selectedQuestionRequired,
//                           style: TextStyle(color: ColorConstants.lightGray),
//                         ), // Use the selected option as the label
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               IconComponent(
//                 iconData: Icons.arrow_downward_outlined,
//                 borderColor: ColorConstants.transparent,
//                 backgroundColor: ColorConstants.transparent,
//                 iconColor: ColorConstants.lightGray,
//                 iconSize: 25,
//                 circleSize: 25,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MenuAnchor(
//                     alignmentOffset: Offset(-250, 0),
//                     style: MenuStyle(
//                       backgroundColor: MaterialStatePropertyAll<Color>(
//                           themeCubit.backgroundColor),
//                     ),
//                     childFocusNode: _buttonFocusNode,
//                     menuChildren: <Widget>[
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _selectedQuestionPublic == 'Public',
//                             onChanged: (bool? value) {
//                               if (value != null) {
//                                 setState(() {
//                                   _selectedQuestionPublic = 'Public';
//                                 });
//                               }
//                             },
//                             shape: CircleBorder(),
//                             // Makes the checkbox circular
//                             activeColor: ColorConstants.primaryColor,
//                             // Sets the color of the checkbox when selected
//                             checkColor: Colors.black,
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextComponent(
//                                 'Public',
//                                 style:
//                                     TextStyle(color: themeCubit.textColor),
//                               ),
//                               TextComponent(
//                                 'Responses can be seen by everyone',
//                                 style:
//                                     TextStyle(color: themeCubit.textColor),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 20,
//                           )
//                         ],
//                       ),
//                       Divider(
//                         thickness: 0.1,
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _selectedQuestionPublic == 'Private',
//                             onChanged: (bool? value) {
//                               if (value != null) {
//                                 setState(() {
//                                   _selectedQuestionPublic = 'Private';
//                                 });
//                               }
//                             },
//                             shape: CircleBorder(),
//                             // Makes the checkbox circular
//                             activeColor: ColorConstants.primaryColor,
//                             // Sets the color of the checkbox when selected
//                             checkColor: Colors.black,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextComponent(
//                                 'Private',
//                                 style:
//                                     TextStyle(color: themeCubit.textColor),
//                               ),
//                               TextComponent(
//                                 'Only host can see the responses',
//                                 style:
//                                     TextStyle(color: themeCubit.textColor),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 20,
//                           )
//                         ],
//                       )
//                     ],
//                     builder: (BuildContext context,
//                         MenuController controller, Widget? child) {
//                       return TextButton(
//                         focusNode: _buttonFocusNode,
//                         onPressed: () {
//                           if (controller.isOpen) {
//                             controller.close();
//                           } else {
//                             controller.open();
//                           }
//                         },
//                         child: Column(
//                           children: [
//                             TextComponent(
//                               _selectedQuestionPublic,
//                               style: TextStyle(
//                                   color: ColorConstants.lightGray),
//                             ),
//                           ],
//                         ), // Use the selected option as the label
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ]),
//       );
//     });
