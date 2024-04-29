import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/drop_down_bottom_sheet.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/icons_button_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/question_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/success_share_bottom_sheet.dart';
import 'package:chat_app_white_label/src/components/switch_permission_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/models/event_data_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreens extends StatefulWidget {
  const CreateGroupScreens({super.key});

  @override
  State<CreateGroupScreens> createState() => _CreateGroupScreensState();
}

class _CreateGroupScreensState extends State<CreateGroupScreens> {
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
  String groupName = 'xyz Group';
  int? selectedIndexPrice;
  int? _draggingIndex;
  final List<String> values = ['Public', 'Private'];
  String? selectedVisibilityValue = "Public";
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  String? selectedImagePath;

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

  List<String> questions = ['Question 1'];
  List<TextEditingController> _questionControllers =
      []; // Initialize with one question
  final TextEditingController _controllerQuestions = TextEditingController();

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
        appBar: AppBarComponent(
          StringConstants.makeAGroup,
          centerTitle: false,
          isBackBtnCircular: false,
        ),
        widget: _createGroup());
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

  Widget _createGroup() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                                groupName,
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
                      StringConstants.groupDetail,
                      style: TextStyle(
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 20,
                          color: themeCubit.primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  ListTileComponent(
                    leadingIcon: AssetConstants.marker,
                    leadingText: StringConstants.location,
                    leadingIconWidth: 25,
                    leadingIconHeight: 25,
                    trailingText: "Manchester",
                    subTextColor: themeCubit.textColor,
                    onTap: _selectLocation,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextComponent(
                      StringConstants.groupDescription,
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
                    leadingIcon: AssetConstants.marker,
                    leadingText: StringConstants.visibility,
                    leadingIconWidth: 25,
                    leadingIconHeight: 25,
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
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      buttonText: StringConstants.createGroup,
                      textColor: themeCubit.backgroundColor,
                      onPressed: () {
                        // EventUtils.createEvent(_eventDataModel!);
                        // _createBottomSheet();
                        _createEventBottomSheet();
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
      ),
    );
  }

  _createEventBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: SuccessShareBottomSheet(
            contacts: contacts,
            successTitle: StringConstants.groupCreatedSuccessfully));
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
                    TextComponent(
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
}
