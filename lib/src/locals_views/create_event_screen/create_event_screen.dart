import 'package:chat_app_white_label/src/components/create_event_tile_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  State<CreateEventScreen> createState() =>
      _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
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

  List<String> questions = ['Question 1']; // Initialize with one question
  final TextEditingController _controllerQuestions = TextEditingController();

  void _addQuestion() {
    setState(() {
      questions.add('Question ${questions.length + 1}'); // Add a new question
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = questions.removeAt(oldIndex);
      questions.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        bgColor: themeCubit.backgroundColor,
        removeSafeAreaPadding: false,
        // appBar:_appBar(),
        widget: _createEvent());
  }

  // Widget _appBar(){
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 23),
  //     child:
  //   );
  // }

  toggleTaped() {
    print("Tapped ${themeCubit.isDarkMode}");
    themeCubit.toggleTheme();
  }

  Widget _createEvent() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 5),
              child: Row(
                children: [
                  SizedBox(
                      child: GestureDetector(
                    onTap: toggleTaped,
                    child: IconComponent(
                      iconData: Icons.arrow_back_ios_new,
                      iconSize: 20,
                      circleHeight: 30,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      iconColor: ColorConstants.lightGray,
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    StringConstants.createEvent,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 20,
                        color: themeCubit.primaryColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  IconComponent(
                                    iconData: Icons.edit,
                                    borderColor: ColorConstants.transparent,
                                    circleSize: 38,
                                    backgroundColor: ColorConstants.lightGray
                                        .withOpacity(0.5),
                                    iconColor: ColorConstants.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Edit Cover",
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "xyz Event",
                                  style: TextStyle(
                                      fontSize: 38,
                                      fontFamily:
                                          FontConstants.fontProtestStrike,
                                      color: ColorConstants.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      StringConstants.eventDetail,
                      style: TextStyle(
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 20,
                          color: themeCubit.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: themeCubit.darkBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconComponent(
                                iconData: Icons.calendar_month,
                                circleSize: 25,
                                iconSize: 25,
                                backgroundColor: ColorConstants.transparent,
                                borderColor: ColorConstants.transparent,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextComponent(
                                StringConstants.start,
                                style: TextStyle(
                                    fontSize: 15, color: themeCubit.textColor),
                              ),
                              Spacer(),
                              Text(
                                "17 Feb at 11 am",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: themeCubit.textColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconComponent(
                                iconData: Icons.straight,
                                circleSize: 25,
                                iconSize: 25,
                                backgroundColor: ColorConstants.transparent,
                                borderColor: ColorConstants.transparent,
                              ),
                              Spacer(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Divider(
                                    thickness: 0.1,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconComponent(
                                iconData: Icons.circle_rounded,
                                circleSize: 25,
                                iconSize: 25,
                                backgroundColor: ColorConstants.transparent,
                                borderColor: ColorConstants.transparent,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                StringConstants.end,
                                style: TextStyle(
                                    fontSize: 15, color: themeCubit.textColor),
                              ),
                              Spacer(),
                              Text(
                                "2 pm",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: themeCubit.textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateEventTileComponent(
                    icon: Icons.location_on,
                    iconText: StringConstants.location,
                    subText: "Manchester",
                    onTap: _selectLocation,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateEventTileComponent(
                      icon: Icons.airplane_ticket,
                      iconText: StringConstants.price,
                      subText: "Free",
                      onTap: _selectPrice),
                  SizedBox(
                    height: 10,
                  ),
                  CreateEventTileComponent(
                      icon: Icons.face,
                      iconText: StringConstants.capacity,
                      subText: "60",
                      onTap: _selectCapacity),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      StringConstants.eventDescription,
                      style: TextStyle(
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 20,
                          color: themeCubit.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controllerQuestions,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: StringConstants.typeYourMessage,
                      filled: true,
                      fillColor: themeCubit.darkBackgroundColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.send),
                      //   onPressed: _sendMessage,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      StringConstants.otherOptions,
                      style: TextStyle(
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 20,
                          color: themeCubit.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CreateEventTileComponent(
                      icon: Icons.location_on,
                      iconText: StringConstants.visibility,
                      subText: "Public",
                      onTap: () {}),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: themeCubit.darkBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconComponent(
                                iconData: Icons.airplane_ticket,
                                borderColor: ColorConstants.transparent,
                                backgroundColor: ColorConstants.transparent,
                                circleSize: 15,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextComponent(
                                        StringConstants.requireGuestsApproval,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: themeCubit.textColor)),
                                    Container(
                                      child: Text(
                                          StringConstants
                                              .requireGuestsApprovalBody,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.lightGray),
                                          textAlign: TextAlign.start),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: themeCubit.darkBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconComponent(
                                iconData: Icons.airplane_ticket,
                                borderColor: ColorConstants.transparent,
                                backgroundColor: ColorConstants.transparent,
                                circleSize: 15,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringConstants.askQuestionWhenPeopleJoin,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: themeCubit.textColor),
                                    ),
                                    Container(
                                      child: Text(
                                          StringConstants
                                              .askQuestionWhenPeopleJoinBody,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.lightGray),
                                          textAlign: TextAlign.start),
                                    ),
                                    if (editQuestion != false)
                                      Row(
                                        children: [
                                          Text(
                                            StringConstants.editQuestions,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: themeCubit.textColor),
                                          ),
                                          SizedBox(
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
                              Spacer(),
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
                    width: MediaQuery.of(context).size.width,
                    child: ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      buttonText: StringConstants.createEvent,
                      onPressedFunction: () {
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
      ),
    );
  }

  _createBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.eventCreatedSuccessfully,
        image: AssetConstants.group,
      ),
    );
    Future.delayed(const Duration(milliseconds: 1000), () async {
      NavigationUtil.pop(context);
      _createEventBottomSheet();
    });
  }

  _selectLocation() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  SizedBox(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          StringConstants.exactLocationApproval,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Spacer(),
                      Switch(
                        // This bool value toggles the switch.
                        value: locationVisible,
                        activeColor: ColorConstants.white,
                        activeTrackColor: ColorConstants.green,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            locationVisible = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )));
  }

  _createEventBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
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
                      padding: const EdgeInsets.only(right: 40.0, top: 10),
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
                    // AssetConstants.group,
                    AssetConstants.group,
                    width: 150,
                    height: 150,
                  ),
                  Container(
                    width: 300,
                    child: Text(
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
                    child: Text(
                      StringConstants.inviteYourFriend,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconComponent(
                    customTextColor: themeCubit.textColor,
                    iconData: Icons.link,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.yellow,
                    iconColor: Colors.white,
                    circleSize: 60,
                    customText: StringConstants.copyLink,
                  ),
                  IconComponent(
                    customTextColor: themeCubit.textColor,
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 60,
                    customText: StringConstants.facebook,
                  ),
                  IconComponent(
                    customTextColor: themeCubit.textColor,
                    iconData: Icons.install_desktop,
                    borderColor: Colors.transparent,
                    circleSize: 60,
                    customText: StringConstants.instagram,
                  ),
                  IconComponent(
                    customTextColor: themeCubit.textColor,
                    iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: const Color.fromARGB(255, 87, 64, 208),
                    circleSize: 60,
                    customText: StringConstants.share,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 0.1,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 5),
                child: Text(
                  StringConstants.yourConnections,
                  style: TextStyle(
                      color: themeCubit.primaryColor,
                      fontFamily: FontConstants.fontProtestStrike,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 18.0, top: 10, bottom: 16, right: 18),
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
                    child: const Text(StringConstants.goBack)),
                const SizedBox(width: 30),
                ButtonComponent(
                  buttonText: "Yes, share it",
                  onPressedFunction: () {
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

  _selectPrice() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent("Free",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: themeCubit.textColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent("£5",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: themeCubit.textColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent("£10",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: themeCubit.textColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent("£25",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: themeCubit.textColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent("£50",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: themeCubit.textColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 30, right: 30),
                              child: TextComponent(
                                "£100",
                                style: TextStyle(
                                    fontSize: 15, color: themeCubit.textColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Text(StringConstants.setOtherAmount,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor)),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      hintText: "£",
                      filled: true,
                      fillColor:
                          ColorConstants.backgroundColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.send),
                      //   onPressed: _sendMessage,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      buttonText: StringConstants.done,
                      onPressedFunction: () {
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

  _selectCapacity() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringConstants.limitNumberOfParticipants,
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringConstants.participants,
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      hintText: "Unlimited",
                      filled: true,
                      fillColor:
                          ColorConstants.backgroundColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: ColorConstants.transparent)),
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.send),
                      //   onPressed: _sendMessage,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      buttonText: StringConstants.done,
                      onPressedFunction: () {
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: ColorConstants.black.withOpacity(0.8)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                SizedBox(
                  height: 10,
                ),
                TextComponent(
                  StringConstants.choseToAskQuestion,
                  style: TextStyle(color: themeCubit.textColor),
                ),
                SizedBox(
                  height: 15,
                ),
                question(setState),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWithIconComponent(
                      btnText: '  ${StringConstants.addQuestion}',
                      icon: Icons.add_circle,
                      btnTextStyle: TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        setState(() =>
                            questions.add('Question ${questions.length + 1}'));
                      },
                    ),
                    ButtonComponent(
                      bgcolor: ColorConstants.primaryColor,
                      textColor: ColorConstants.black,
                      buttonText: StringConstants.done,
                      onPressedFunction: () {},
                    ),
                  ],
                ),
              ],
            ),
          ));
    }));
  }

  question(StateSetter setStateBottomSheet) {
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
    //                               Text(
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
    return ReorderableListView(
      shrinkWrap: true,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final String item = questions.removeAt(oldIndex);
          questions.insert(newIndex, item);
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
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    setStateBottomSheet(() {
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
            SizedBox(
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
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        hintText: StringConstants.typeYourQuestion,
                        filled: true,
                        fillColor: ColorConstants.transparent,
                        // suffixIcon:
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorConstants.transparent,
                            )),
                        hintStyle: TextStyle(
                            color: ColorConstants.lightGray, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: ColorConstants.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: ColorConstants.transparent)),
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
                        padding: EdgeInsets.only(right: 20),
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
                              shape: CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            TextComponent(
                              "Required",
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
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
                              shape: CircleBorder(),
                              activeColor: ColorConstants.primaryColor,
                              checkColor: Colors.black,
                            ),
                            TextComponent(
                              "Optional",
                              style: TextStyle(color: themeCubit.textColor),
                            ),
                            SizedBox(
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
                            style: TextStyle(color: ColorConstants.lightGray),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
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
                      alignmentOffset: Offset(-250, 0),
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
                              shape: CircleBorder(),
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
                                Text(
                                  'Responses can be seen by everyone',
                                  style: TextStyle(color: themeCubit.textColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        Divider(
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
                              shape: CircleBorder(),
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
                            SizedBox(
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
                                style:
                                    TextStyle(color: ColorConstants.lightGray),
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
