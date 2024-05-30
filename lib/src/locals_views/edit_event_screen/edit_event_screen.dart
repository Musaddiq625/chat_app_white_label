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
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/edit_event_screen/cubit/edit_event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/view_your_event_screen/cubit/view_your_event_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
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
import '../../components/text_field_component.dart';
import '../../components/toast_component.dart';
import '../../models/contact.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';

class EditEventScreen extends StatefulWidget {
  EventModel? eventModel;

  EditEventScreen({super.key, this.eventModel});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  // EventDataModel? _eventDataModel;
  final TextEditingController _controller = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchControllerConnections = TextEditingController();
  bool requireGuest = true;
  bool askQuestion = false;
  bool editQuestion = false;
  bool locationVisible = true;
  bool editEventName = false;
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
    ContactModel('Jesse Ebert', 'Graphic Designer', "", "00112233455"),
    ContactModel('Albert Ebert', 'Manager', "", "45612378123"),
    ContactModel('Json Ebert', 'Tester', "", "03323333333"),
    ContactModel('Mack', 'Intern', "", "03312233445"),
    ContactModel('Julia', 'Developer', "", "88552233644"),
    ContactModel('Rose', 'Human Resource', "", "55366114532"),
    ContactModel('Frank', 'xyz', "", "25651412344"),
    ContactModel('Taylor', 'Test', "", "5511772266"),
  ];

  // final List<Map<String, dynamic>> contacts = [
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  //   {'name': 'Jesse Ebert', 'title': 'Graphic Designer', 'url': ''},
  //   {'name': 'John Doe', 'title': 'Developer', 'url': ''},
  // ];

  String intialEventName = 'Create Event Name';
  String? eventName;
  String? selectedImagePath;
  String? startDate;
  String? endDate;
  String? selectedLocation;
  List<String> questions = ['Question 1'];
  late FocusNode myFocusNode;
  List<TextEditingController> _questionControllers =
      []; // Initialize with one question

  Map<int, String> selectedQuestionPublic = {};
  Map<int, String> selectedQuestionRequired = {};
  Map<int, String> questionId = {};
  final TextEditingController _controllerQuestions = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  late EditEventCubit editEventCubit = BlocProvider.of<EditEventCubit>(context);
  late ViewYourEventScreenCubit viewYourEventScreenCubit = BlocProvider.of<ViewYourEventScreenCubit>(context);
  late OnboardingCubit onBoardingCubit =
      BlocProvider.of<OnboardingCubit>(context);

  @override
  void initState() {
    super.initState();
    _questionControllers =
        List.generate(questions.length, (index) => TextEditingController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      editEventCubit.eventModel = EventModel();
      editEventCubit.eventModel = EventModel();
      editEventCubit.eventModel = EventModel.fromJson(widget.eventModel?.toJson() ?? {});
      editEventCubit.initializeEventData(editEventCubit.eventModel);
      setState(() {
        selectedImagePath = widget.eventModel?.images?.first;
        eventNameController.value =
            TextEditingValue(text: editEventCubit.eventModel.title ?? '');
        eventName = editEventCubit.eventModel.title ?? '';
        _controllerDescription.value =
            TextEditingValue(text: editEventCubit.eventModel.description ?? '');
        startDate = editEventCubit.eventModel.venues?.first.startDatetime;
        endDate = editEventCubit.eventModel.venues?.first.endDatetime;
        endDate = editEventCubit.eventModel.venues?.first.endDatetime;
        capacityValue = editEventCubit.eventModel.venues?.first.capacity ?? "";
        selectedVisibilityValue =
        (editEventCubit.eventModel.isPublic ?? true) ? "Public" : "Private";
        requireGuest = editEventCubit.eventModel.isApprovalRequired ?? true;
        if (editEventCubit.eventModel.pricing?.price != "0" &&
            editEventCubit.eventModel.pricing?.price != null) {
          selectedPriceValue = editEventCubit.eventModel.pricing?.price ?? "0";
        } else {
          selectedPriceValue = "Free";
        }

        LoggerUtil.logs(
            "editEventCubit.eventModel.question? ${editEventCubit.eventModel.question?.map((e) => e.question)}");
        for (int i = 0;
        i < ((editEventCubit.eventModel.question?.length) ?? 0);
        i++) {
          if(questions.length <= i) {
            questions.add("Question ${i+1}");
          }
          // Dynamically add controllers to the list if they don't exist yet
          if (_questionControllers.length <= i) {
            _questionControllers.add(TextEditingController());
          }
          LoggerUtil.logs(
              "questionControllers ${(editEventCubit.eventModel.question?[i].question)}  ${selectedQuestionPublic[i]}   ${selectedQuestionRequired[i]}");
          _questionControllers[i].text =
              editEventCubit.eventModel.question?[i].question ?? "";

          if (editEventCubit.eventModel.question?[i].isRequired == true) {
            selectedQuestionRequired[i] = "Required";
          } else {
            selectedQuestionRequired[i] = "Optional";
          }

          if (editEventCubit.eventModel.question?[i].isPublic == true) {
            selectedQuestionPublic[i] = "Public";
          } else {
            selectedQuestionPublic[i] = "Private";
          }
          questionId[i] = editEventCubit.eventModel.question?[i].questionId ?? "";
        }
      });
    });
    print("widget.eventModel?.images?.first; ${widget.eventModel?.toJson()}");
    print(
        "eventCubit.eventModel.pricing?.price ${eventCubit.eventModel.pricing?.price}");



    LoggerUtil.logs("QuestionController values ${_questionControllers.map((e) => e.text)} ");
    LoggerUtil.logs("required values ${selectedQuestionRequired.values} ");
    LoggerUtil.logs("public values ${selectedQuestionPublic.values} ");
    LoggerUtil.logs("questionId ${questionId.values} ");

    LoggerUtil.logs("UserId-- ${AppConstants.userId}");
    myFocusNode = FocusNode();

    setState(() {
    });
  }

  @override
  void dispose() {
    _questionControllers.forEach((controller) => controller.dispose());
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoggerUtil.logs("Build UserId-- ${AppConstants.userId}");
    LoggerUtil.logs(
        "Build onBoardingCubit UserId-- ${onBoardingCubit.userModel.id}");
    return BlocConsumer<EditEventCubit, EditEventState>(
      listener: (context, state) {
        if (state is EditEventLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        } else if (state is EditEventSuccessState) {
          LoadingDialog.hideLoadingDialog(context);
          // viewYourEventScreenCubit.initializeEventData(state.eventModel!);
          setState(() {
            viewYourEventScreenCubit.eventModel = state.eventModel!;
          });
          NavigationUtil.pop(context);
        } else if (state is EditEventFailureState) {
          LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
            bgColor: themeCubit.backgroundColor,
            appBar: AppBarComponent(
              StringConstants.editEvent,
              centerTitle: false,
              isBackBtnCircular: false,
            ),
            widget: _createEvent());
      },
    );
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
          editEventCubit.addPrice(
              selectedPriceValue == "Free" ? "0" : selectedPriceValue);
        }),
      },
      child: Container(
        width: AppConstants.responsiveWidth(context, percentage: 25),
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
                        padding: const EdgeInsets.only(left: 32.0, right: 32),
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
                                    // eventCubit.addImage(selectedImagePath);
                                    // editEventCubit.addImage(
                                    //     "https://i.dawn.com/large/2015/12/567d1ca45aabe.jpg");
                                  });
                                  var uploadImage = await AppConstants.uploadImage(selectedImagePath?? "","event");
                                  print("uploadingImage $uploadImage");
                                  await editEventCubit.addImage(uploadImage);
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
                            Container(
                              width: AppConstants.responsiveWidth(context,
                                  percentage: 100),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // editEventName ?
                                  Container(
                                    // color: ColorConstants.blue,
                                    child: SizedBox(
                                      width: AppConstants.responsiveWidth(
                                          context,
                                          percentage: 55),
                                      child: AbsorbPointer(
                                        absorbing: editEventName,
                                        child: TextFieldComponent(
                                          eventNameController,
                                          keyboardType: TextInputType.name,
                                          focusNode: myFocusNode,
                                          hintTextColor: ColorConstants.white,
                                          hintText: "Edit Event",
                                          maxLines: 2,
                                          onChanged: (_) {
                                            eventName =
                                                eventNameController.text;
                                            editEventCubit.addTitle(
                                                eventNameController.text);
                                          },
                                          onFieldSubmitted: (_) {
                                            setState(() {
                                              editEventName = true;
                                              eventName =
                                                  eventNameController.text;
                                              print("eventName ${eventName}");
                                              editEventCubit.eventModel
                                                  .copyWith(title: eventName);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  //:
                                  // Container(
                                  //   width: AppConstants.responsiveWidth(context,percentage: 55),
                                  //   child: TextComponent(
                                  //     eventName ?? intialEventName,
                                  //     maxLines: 3,
                                  //     style: TextStyle(
                                  //         fontSize: 38,
                                  //         fontFamily: FontConstants.fontProtestStrike,
                                  //         color: ColorConstants.white),
                                  //   ),
                                  // ),
                                  Container(
                                    // color: ColorConstants.red,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          myFocusNode.requestFocus();
                                          editEventName = false;
                                          print("setState ${editEventName}");
                                        });
                                      },
                                      child: IconComponent(
                                        iconData: Icons.edit,
                                        borderColor: ColorConstants.transparent,
                                        circleSize: 40,
                                        backgroundColor:
                                            ColorConstants.transparent,
                                        iconColor: ColorConstants.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                children: List.generate(4, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 0, bottom: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstants.blackLight,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: 2,
                                      width: 2,
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
                          SizedBoxConstants.sizedBoxSixW(),
                          Container(
                            margin: EdgeInsets.only(left: 10),
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
                                          DateTime  selectedStartDate = DateFormat("yyyy-MM-dd").parse(startDate.toString());
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: selectedStartDate, //DateTime(2000),
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
                                            DateTime  selectedStartDate = DateFormat("yyyy-MM-dd").parse(startDate.toString());
                                            DateTime  selectedEndDate = DateFormat("yyyy-MM-dd").parse(endDate.toString());
                                            showDatePicker(
                                              context: context,
                                              initialDate: selectedEndDate,//DateTime.now(),
                                              firstDate: selectedStartDate,//DateTime(2000),
                                              lastDate: DateTime(2101),
                                            ).then((selectedDate) {
                                              // After selecting the date, display the time picker.
                                              if (selectedDate != null) {
                                                print(
                                                    "selectedDate $selectedDate start Date $startDate");
                                                DateTime  startDateFormat = DateFormat("yyyy-MM-dd").parse(startDate!);
                                                DateTime  startDateFullFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(startDate!);
                                                DateTime  selectedOnlyDate = DateFormat("yyyy-MM-dd").parse(selectedDate.toString());
                                                // if(selectedOnlyDate.)

                                                if (selectedOnlyDate.isBefore(startDateFormat
                                                  // DateTime.parse(
                                                  //     startDate!)
                                                )) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: TextComponent(
                                                          "End date cannot be select before start date."),
                                                    ),
                                                  );
                                                }
                                                else if (selectedDate
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

                                                      if (selectedDateTime.isBefore(DateTime.parse(startDate!)) && selectedDateTime.difference(startDateFullFormat).inHours < 1 && selectedDateTime.difference(startDateFullFormat).inMinutes < 60){
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
                                                        print("0 seleted end date ${selectedDateTime} startdate ${startDate}");

                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      // else if (endDate == null) {
                                                      //   setState(() {
                                                      //     endDate =
                                                      //         selectedDateTime
                                                      //             .toString();
                                                      //     // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      //   });
                                                      // }
                                                      else {
                                                        print("1 seleted end date ${selectedDateTime} startdate ${startDate}");
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                    }
                                                  });
                                                }
                                                else {
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
                                                      print("--- selected end date ${selectedDateTime} startdate ${startDate}");

                                                      // if (endDate == null) {
                                                      //   print("22 seleted end date ${selectedDateTime} startdate ${startDate}");
                                                      //   setState(() {
                                                      //     endDate =
                                                      //         selectedDateTime
                                                      //             .toString();
                                                      //     // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                      //   });
                                                      // }
                                                      // else
                                                      if (selectedDateTime.isBefore(DateTime.parse(startDate!)))
                                                      {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "End date-time cannot be select before start date-time."),
                                                          ),
                                                        );
                                                      }
                                                      else if( selectedDateTime == startDateFullFormat || selectedDateTime.difference(startDateFullFormat).inMinutes < 60 ){
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextComponent(
                                                                "Event should be minimum 1 hour"),
                                                          ),
                                                        );
                                                      }
                                                      else if (selectedDateTime
                                                          .isAfter(
                                                          DateTime.parse(
                                                              startDate!))) {
                                                        // print(" 00 seleted end date ${selectedDateTime} startdate ${startDate}");
                                                        setState(() {
                                                          endDate =
                                                              selectedDateTime
                                                                  .toString();
                                                          // DateFormat('d MMM \'at\' hh a').format(selectedDateTime);
                                                        });
                                                      }
                                                      else {
                                                        print(" 11 seleted end date ${selectedDateTime} startdate ${startDate}");
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
                  isLeadingIconAsset: true,
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
                  isLeadingIconAsset: true,
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
                  leadingText: " ${StringConstants.capacity}",
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
                  controller: _controllerDescription,
                  onChanged: (_) {
                    editEventCubit
                        .addDescription(_controllerDescription.value.text);
                  },
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
                      editEventCubit.addRequiredGuestApproval(requireGuest);
                    });
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                SwitchPermissionComponent(
                  name: StringConstants.askQuestionWhenPeopleJoin,
                  detail: StringConstants.askQuestionWhenPeopleJoinBody,
                  switchValue: _questionControllers.isNotEmpty
                      // && _questionControllers.first.text.isNotEmpty
                      ? true
                      : false,
                  editQuestionsTap: () {
                    if (_questionControllers.isNotEmpty || askQuestion == true) {
                      // _selectQuestion();
                      print("_questionControllers.length ${_questionControllers.map((e) => e.text)}");
                      QuestionComponent.selectQuestion(
                          context,
                          _questionControllers,
                          questions,
                          selectedQuestionRequired,
                          selectedQuestionPublic,
                          (List<Question> questionsList) {
                        // List<Question> questionsList = eventCubit.eventModel.question?? [];
                        // for(int i = 0; i < _questionControllers.length; i++){
                        //   LoggerUtil.logs("questionControllers ${_questionControllers[i].value.text}  ${selectedQuestionPublic[i]}   ${selectedQuestionRequired[i]}");
                        //   Question newQuestion = Question(
                        //     questionId: FirebaseUtils.getDateTimeNowAsId(), // Assuming you have a mechanism to generate unique IDs
                        //     question: _questionControllers[i].value.text, // Pass the entire list of controllers
                        //     isPublic: selectedQuestionPublic[i]=="Public"?true:false ,
                        //     isRequired: selectedQuestionRequired[i]=="Required"?true:false ,
                        //   );
                        //   questionsList.add(newQuestion);
                        // }

                        // NavigationUtil.pop(context);
                            editEventCubit.addQuestions(questionsList);
                        LoggerUtil.logs(
                            "eventCubit.eventModel.questions ${eventCubit.eventModel.question}");
                        LoggerUtil.logs(
                            "eventCubit.eventModel.tojson ${eventCubit.eventModel.toJson()}");
                      }, questionId: questionId);
                    }
                  },
                  editQuestions: _questionControllers.isNotEmpty
                      // && _questionControllers.first.text.isNotEmpty
                      ? true
                      : false,
                  onSwitchChanged: (bool value) {
                    // if(questions.length>=1){

                    // askQuestion = value;
                    askQuestion = value;
                    if (_questionControllers.isNotEmpty ||
                        askQuestion == true) {
                      QuestionComponent.selectQuestion(
                          context,
                          _questionControllers,
                          questions,
                          selectedQuestionRequired,
                          selectedQuestionPublic,
                          (List<Question> questionsList) {
                            editEventCubit.addQuestions(questionsList);
                        // List<Question> questionsList = eventCubit.eventModel.question?? [];
                        // for(int i = 0; i < _questionControllers.length; i++){
                        //   LoggerUtil.logs("questionControllers ${_questionControllers[i].value.text}  ${selectedQuestionPublic[i]}   ${selectedQuestionRequired[i]}");
                        //   Question newQuestion = Question(
                        //     questionId: "auto", // Assuming you have a mechanism to generate unique IDs
                        //     question: _questionControllers[i].value.text, // Pass the entire list of controllers
                        //     isPublic: selectedQuestionPublic[i]=="Public"?true:false ,
                        //     isRequired: selectedQuestionRequired[i]=="Required"?true:false ,
                        //   );
                        //   questionsList.add(newQuestion);
                        // }
                        // eventCubit.eventModel.copyWith(question: questionsList);
                        // NavigationUtil.pop(context);

                        LoggerUtil.logs(
                            "eventCubit.eventModel.questions ${eventCubit.eventModel.question}");
                        LoggerUtil.logs(
                            "eventCubit.eventModel.tojson ${eventCubit.eventModel.toJson()}");
                      },
                          questionId: questionId);

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
                    bgcolor: startDate != null &&
                            endDate != null &&
                            eventName != null &&
                            selectedImagePath != null &&
                            selectedPriceValue.isNotEmpty &&
                            capacityValue.isNotEmpty
                        ? themeCubit.primaryColor
                        : themeCubit.darkBackgroundColor,
                    buttonText: StringConstants.updateEvent,
                    textColor: startDate != null &&
                            endDate != null &&
                            eventName != null &&
                            selectedImagePath != null &&
                            selectedPriceValue.isNotEmpty &&
                            capacityValue.isNotEmpty
                        ? themeCubit.backgroundColor
                        : ColorConstants.grey1,
                    onPressed: () {
                      editEventCubit.addStartDate(startDate);
                      editEventCubit.addEndDate(endDate);
                      if (startDate != null &&
                          endDate != null &&
                          eventName != null &&
                          selectedImagePath != null &&
                          selectedPriceValue.isNotEmpty &&
                          capacityValue.isNotEmpty) {
                        editEventCubit.updateEventData(editEventCubit.eventModel);
                      }
                      // _createBottomSheet();
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
                          editEventCubit.addPrice(
                              _inputPriceValuecontroller.value.text.isNotEmpty
                                  ? selectedPriceValue
                                  : "0");
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
                          print(
                              "_inputPriceValuecontroller.text ${_inputPriceValuecontroller.text}, selectedvalue ${selectedPriceValue}");
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
                          editEventCubit.addCapacity(capacityValue);
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
              editEventCubit.addVisibility(
                  selectedVisibilityValue == "Public" ? true : false);
            });
          },
        ));
  }
}
