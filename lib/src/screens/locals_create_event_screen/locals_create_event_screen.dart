import 'package:chat_app_white_label/src/components/create_event_tile_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/search_text_field_component.dart';

class LocalsCreateEventScreen extends StatefulWidget {
  const LocalsCreateEventScreen({super.key});

  @override
  State<LocalsCreateEventScreen> createState() =>
      _LocalsCreateEventScreenState();
}

class _LocalsCreateEventScreenState extends State<LocalsCreateEventScreen> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool requireGuest = true;
  bool askQuestion = true;
  bool editQuestion = false;
  bool locationVisible = true;

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
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
                      height: 20,
                      child: IconComponent(
                        iconData: Icons.arrow_back_ios_new,
                        iconSize: 20,
                        circleHeight: 0,
                        iconColor: ColorConstants.lightGray,
                      )),
                  Text(
                    StringConstants.createEvent,
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 20,
                        color: ColorConstants.bgcolorbutton),
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
                        height: 671,
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
                          color: ColorConstants.bgcolorbutton),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: ColorConstants.white,
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
                                circleSize: 0,
                                borderSize: 0,
                                circleHeight: 0,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                StringConstants.start,
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Text(
                                "17 Feb at 11 am",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                                circleSize: 0,
                                borderSize: 0,
                                circleHeight: 0,
                              ),
                              Spacer(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Divider(
                                    thickness: 1,
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
                                circleSize: 0,
                                borderSize: 0,
                                circleHeight: 0,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                StringConstants.end,
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Text(
                                "2 pm",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                          color: ColorConstants.bgcolorbutton),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: StringConstants.typeYourMessage,
                      filled: true,
                      fillColor: ColorConstants.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.5),
                          fontSize: 14),
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
                          color: ColorConstants.bgcolorbutton),
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
                      color: ColorConstants.white,
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
                                    Text(
                                      StringConstants.requireGuestsApproval,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Container(
                                      child: Text(
                                          StringConstants
                                              .requireGuestsApprovalBody,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.lightGray
                                                  .withOpacity(0.6)),
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
                                activeTrackColor: ColorConstants.green,
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
                      color: ColorConstants.white,
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Container(
                                      child: Text(
                                          StringConstants
                                              .askQuestionWhenPeopleJoinBody,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.lightGray
                                                  .withOpacity(0.6)),
                                          textAlign: TextAlign.start),
                                    ),
                                    if (editQuestion != false)
                                      Row(
                                        children: [
                                          Text(
                                            StringConstants.editQuestions,
                                            style: TextStyle(fontSize: 15),
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
                                activeTrackColor: ColorConstants.green,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    askQuestion = value;
                                  });
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
                      bgcolor: ColorConstants.yellow,
                      buttonText: StringConstants.createEvent,
                      onPressedFunction: () {
                        // _yesShareItBottomSheet();
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

  _selectLocation() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.selectLocation,
                        style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: IconComponent(
                          iconData: Icons.close,
                          borderColor: Colors.transparent,
                          iconColor: Colors.black,
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

  _selectPrice() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.pricing,
                        style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: IconComponent(
                          iconData: Icons.close,
                          borderColor: Colors.transparent,
                          iconColor: Colors.black,
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
                              child:
                                  Text("Free", style: TextStyle(fontSize: 15)),
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
                              child: Text("£5", style: TextStyle(fontSize: 15)),
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
                              child:
                                  Text("£10", style: TextStyle(fontSize: 15)),
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
                              child:
                                  Text("£25", style: TextStyle(fontSize: 15)),
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
                              child: Text("£50"),
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
                              child: Text(
                                "£100",
                                style: TextStyle(fontSize: 15),
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
                  Text(StringConstants.setOtherAmount),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      hintText: "£",
                      filled: true,
                      fillColor: ColorConstants.backgroundColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.5),
                          fontSize: 14),
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
                      bgcolor: ColorConstants.yellow,
                      buttonText: StringConstants.createEvent,
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
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.capacity,
                        style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: FontConstants.fontProtestStrike,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: IconComponent(
                          iconData: Icons.close,
                          borderColor: Colors.transparent,
                          iconColor: Colors.black,
                          circleSize: 20,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(StringConstants.limitNumberOfParticipants),
                  SizedBox(
                    height: 10,
                  ),
                  Text(StringConstants.participants),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      hintText: "Unlimited",
                      filled: true,
                      fillColor: ColorConstants.backgroundColor.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: ColorConstants.transparent,
                          )),
                      hintStyle: TextStyle(
                          color: ColorConstants.lightGray.withOpacity(0.5),
                          fontSize: 14),
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
                      bgcolor: ColorConstants.yellow,
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
}
