import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/custom_button.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ContactCard extends StatefulWidget {
  final ContactModel contact;
  final bool showShareIcon;

  const ContactCard(
      {Key? key, required this.contact, this.showShareIcon = true})
      : super(key: key);

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileImageComponent(url: widget.contact.url),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contact.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.contact.title,
                    style: TextStyle(
                        fontSize: 14, color: ColorConstants.lightGray),
                  ),
                ],
              ),
              Spacer(),
              if (widget.showShareIcon)
                IconComponent(
                  iconData: Icons.share,
                  borderColor: Colors.transparent,
                  backgroundColor: ColorConstants.yellow,
                  iconColor: Colors.white70,
                  circleSize: 40,
                  iconSize: 25,
                  onTap: () {
                    print("Hello 1 $context");
                    // Navigator.pop(context);

                    BottomSheetComponent.showBottomSheet(context,
                        takeFullHeightWhenPossible: false,
                        isShowHeader: false,
                        body: Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              ProfileImageComponent(url: widget.contact.url),
                              SizedBox(height: 20),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: ColorConstants.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "Are you sure you want to share \n Event Fireworks night with \n "),
                                    TextSpan(
                                      text: "${widget.contact.name}?",
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Text("Go back")),
                                  SizedBox(width: 30),
                                  ButtonComponent(
                                    buttonText: "Yes, share it",
                                    onPressedFunction: () async {
                                      print("Hello 2 ${context} ");
                                      BuildContext currentContext = context;
                                      BottomSheetComponent.showBottomSheet(
                                          currentContext,
                                          takeFullHeightWhenPossible: false,
                                          isShowHeader: false,
                                          body: Container(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 30),
                                                Image.network(
                                                  "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                                                  fit: BoxFit.fill,
                                                  width: double.infinity,
                                                  height: 100,
                                                ),
                                                SizedBox(height: 30),
                                                Text(
                                                  "Event Shared !",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 28),
                                                ),
                                                SizedBox(height: 50),
                                              ],
                                            ),
                                          ));
                                    },
                                    bgcolor: ColorConstants.yellow,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ));
                  },
                )
            ],
          ),
          Divider(thickness: 0.2),
        ],
      ),
    );
  }
}
