import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/drop_down_bottom_sheet.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/question_component.dart';
import 'package:chat_app_white_label/src/components/success_share_bottom_sheet.dart';
import 'package:chat_app_white_label/src/components/switch_permission_component.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/info_sheet_component.dart';
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
  String? selectedVisibilityValue = "Public";
  String? selectedValue = "";
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  String _selectedQuestionRequired = 'Required';
  String _selectedQuestionPublic = 'Public';
  int? selectedIndexPrice;
  int? _draggingIndex;

  String selectedPriceValue = "Free"; // Initialize with a default value
  String capacityValue = "Unlimited"; // Initialize with a default value
  TextEditingController _inputPriceValuecontroller = TextEditingController();
  TextEditingController _inputCapacityValuecontroller = TextEditingController();
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final List<String> values = ['Public', 'Private'];
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "","00112233455"),
    ContactModel('Albert Ebert', 'Manager', "","45612378123"),
    ContactModel('Json Ebert', 'Tester', "","03323333333"),
    ContactModel('Mack', 'Intern', "","03312233445"),
    ContactModel('Julia', 'Developer', "","88552233644"),
    ContactModel('Rose', 'Human Resource', "","55366114532"),
    ContactModel('Frank', 'xyz', "","25651412344"),
    ContactModel('Taylor', 'Test', "","5511772266"),
  ];

  // final List<Map<String, dynamic>> contacts = [
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  // ];
  String eventName = 'xyz Event';
  String? selectedImagePath;
  String? startDate;
  String? endDate;
  List<String> questions = ['Question 1'];
  List<TextEditingController> _questionControllers =
      []; // Initialize with one question
  final TextEditingController _controllerQuestions = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionControllers =
        List.generate(questions.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    _questionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        bgColor: themeCubit.backgroundColor,
        appBar: AppBarComponent(
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
      onTap: () => {
        setStateBottomSheet(() => {
              selectedIndexPrice = containerIndex,
            }),
        setState(() {
          selectedPriceValue =
              ["Free", "£5", "£10", "£25", "£50", "£100"][containerIndex];
        }),
      },
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
                        imgUrl: selectedImagePath != null
                            ? selectedImagePath!
                            : "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
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
                            GestureDetector(
                              onTap: () async {
                                final XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    selectedImagePath = image
                                        .path; // Update the state with the selected image path
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  IconComponent(
                                    iconData: Icons.edit,
                                    borderColor: ColorConstants.transparent,
                                    circleSize: 35,
                                    backgroundColor: ColorConstants.lightGray
                                        .withOpacity(0.5),
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
                            ),
                            TextComponent(
                              eventName,
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
                                              if (endDate != null &&
                                                  selectedDate.isBefore(
                                                      DateTime.parse(
                                                          endDate!))) {
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
                                                    } else if (endDate !=
                                                            null &&
                                                        selectedDateTime.isAfter(
                                                            DateTime.parse(
                                                                endDate!))) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: TextComponent(
                                                              "Start Date-Time cannot be After end Date-Time."),
                                                        ),
                                                      );
                                                    } else {
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
                                              } else if (endDate != null &&
                                                  selectedDate.isAfter(
                                                      DateTime.parse(
                                                          endDate!))) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: TextComponent(
                                                        "Start date cannot be After end date."),
                                                  ),
                                                );
                                              } else {
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
                                                    } else if (endDate !=
                                                            null &&
                                                        selectedDateTime.isAfter(
                                                            DateTime.parse(
                                                                endDate!))) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: TextComponent(
                                                              "Start Date-Time cannot be After end Date-Time."),
                                                        ),
                                                      );
                                                    } else {
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
                                                print(
                                                    "selectedDate $selectedDate start Date $startDate");
                                                if (selectedDate.isBefore(
                                                    DateTime.parse(
                                                        startDate!))) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: TextComponent(
                                                          "End date cannot be select before start date."),
                                                    ),
                                                  );
                                                } else if (selectedDate
                                                        .isAfter(
                                                            DateTime.parse(
                                                                startDate!)) ||
                                                    selectedDate
                                                        .isAtSameMomentAs(
                                                            DateTime.parse(
                                                                startDate!))) {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  ).then((selectedTime) {
                                                    // Handle the selected date and time here.
                                                    if (selectedTime != null) {
                                                      DateTime
                                                          selectedDateTime =
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
                                                      } else if (selectedDateTime
                                                          .isBefore(
                                                              DateTime.parse(
                                                                  startDate!))) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "End date-time cannot be select before start date-time."),
                                                          ),
                                                        );
                                                      } else if (selectedDateTime
                                                          .isAfter(
                                                              DateTime.parse(
                                                                  startDate!))) {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                    }
                                                  });
                                                } else {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  ).then((selectedTime) {
                                                    if (selectedTime != null) {
                                                      DateTime
                                                          selectedDateTime =
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
                                                      } else if (selectedDateTime
                                                          .isBefore(
                                                              DateTime.parse(
                                                                  startDate!))) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "End date-time cannot be select before start date-time."),
                                                          ),
                                                        );
                                                      } else if (selectedDateTime
                                                          .isAfter(
                                                              DateTime.parse(
                                                                  startDate!))) {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }

                                                      print(formattedDateTime);
                                                      print(selectedDateTime);

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
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  leadingIconWidth: 25,
                  leadingIconHeight: 25,
                  leadingIcon: AssetConstants.ticket,
                  leadingText: StringConstants.price,
                  trailingText: selectedPriceValue,
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: _selectPrice,
                  subTextColor: themeCubit.textColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTileComponent(
                  isLeadingIconAsset: true,
                  leadingIconWidth: 18,
                  leadingIconHeight: 18,
                  leadingIcon: AssetConstants.scalability,
                  leadingText: StringConstants.capacity,
                  trailingText: capacityValue,
                  trailingIcon: Icons.arrow_forward_ios,
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
                  trailingIcon: Icons.arrow_forward_ios,
                  leadingIcon: AssetConstants.marker,
                  leadingText: StringConstants.visibility,
                  trailingText: selectedVisibilityValue,
                  onTap: visibility,
                  subTextColor: themeCubit.textColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                SwitchPermissionComponent(
                  name: StringConstants.requireGuestsApproval,
                  detail: StringConstants.requireGuestsApprovalBody,
                  switchValue: requireGuest,
                  editQuestions: false,
                  onSwitchChanged: (bool value) {
                    setState(() {
                      requireGuest = value;
                    });
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                SwitchPermissionComponent(
                  name: StringConstants.askQuestionWhenPeopleJoin,
                  detail: StringConstants.askQuestionWhenPeopleJoinBody,
                  switchValue: _questionControllers.isNotEmpty &&
                          _questionControllers.first.text.isNotEmpty
                      ? true
                      : false,
                  editQuestionsTap: () {
                    if (askQuestion == true) {
                      // _selectQuestion();
                      QuestionComponent.selectQuestion(
                        context,
                        _questionControllers,
                        questions,
                      );
                    }
                  },
                  editQuestions: _questionControllers.isNotEmpty &&
                          _questionControllers.first.text.isNotEmpty
                      ? true
                      : false,
                  onSwitchChanged: (bool value) {
                    // if(questions.length>=1){

                    // askQuestion = value;
                    askQuestion = value;
                    if (askQuestion == true) {
                      QuestionComponent.selectQuestion(
                          context, _questionControllers, questions);

                      // _selectQuestion();
                    } else if (askQuestion == false) {
                      questions.clear();
                      _questionControllers.clear();
                    }
                    // }
                    setState(() {});
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextComponent(
                        StringConstants.selectLocation,
                        style: TextStyle(
                            color: themeCubit.primaryColor,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 18),
                      ),
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
                  filledColor: ColorConstants.backgroundColor.withOpacity(0.3),
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
        body: SuccessShareBottomSheet(
            contacts: contacts,
            successTitle: StringConstants.eventCreatedSuccessfully));
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
        body: StatefulBuilder(builder: (context, setState2) {
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
                    _buildRow(0, setState2),
                    const SizedBox(height: 10),
                    _buildRow(1, setState2),
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
                      controller: _inputPriceValuecontroller,
                      onChanged: (value) {
                        setState(() {
                          selectedPriceValue =
                              "${"£" + _inputPriceValuecontroller.text}";
                        });
                      },
                      keyboardType: TextInputType.number,
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
                          NavigationUtil.pop(context);
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
                    controller: _inputCapacityValuecontroller,
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
                        setState(() {
                          capacityValue =
                              _inputCapacityValuecontroller.text.isNotEmpty
                                  ? _inputCapacityValuecontroller.text
                                  : "Unlimited";
                        });
                        NavigationUtil.pop(context);
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

  visibility() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: DropDownBottomSheet(
          image: AssetConstants.marker,
          values: values,
          selectedValue: selectedVisibilityValue,
          onValueSelected: (String? newValue) {
            setState(() {
              selectedVisibilityValue = newValue;
            });
          },
        ));
  }
}
