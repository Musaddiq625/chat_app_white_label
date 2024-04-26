import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/components/user_list_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  int _selectedIndex = 0;
  List selectedContacts = [];
  TextEditingController searchController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: true,
        appBar: AppBarComponent(StringConstants.chat,
            titleFontSize: 30,
            showBackbutton: false,
            action: InkWell(
              onTap: () {
                _showCreateChatBottomSheet();
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstants.btnGradientColor,
                        ColorConstants.white
                      ],
                    )),
                child: Icon(
                  Icons.add,
                  color: themeCubit.backgroundColor,
                ),
              ),
            )),
        bgColor: themeCubit.backgroundColor,
        widget: _main());
  }

  _main() {
    return Padding(
      // color: ColorConstants.red,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        children: [
          Container(
            color: ColorConstants.black,
            child: Column(
              children: [
                SizedBoxConstants.sizedBoxTenH(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextComponent(
                //       StringConstants.chat,
                //       style: TextStyle(
                //           color: themeCubit.primaryColor,
                //           fontSize: 30,
                //           fontFamily: FontConstants.fontProtestStrike),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         _showCreateChatBottomSheet();
                //       },
                //       child: Container(
                //         width: 32,
                //         height: 32,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             gradient: LinearGradient(
                //               begin: Alignment.topLeft,
                //               end: Alignment.bottomRight,
                //               colors: [
                //                 ColorConstants.btnGradientColor,
                //                 ColorConstants.white
                //               ],
                //             )),
                //         child: Icon(
                //           Icons.add,
                //           color: themeCubit.backgroundColor,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: SearchTextField(
                    title: "Search",
                    hintText: "Search name, postcode..",
                    onSearch: (text) {
                      // widget.viewModel.onSearchStories(text);
                    },
                    textEditingController: searchController,
                    filledColor: themeCubit.darkBackgroundColor,
                  ),
                ),
                // TextFieldComponent(
                //   TextEditingController(),
                //   fieldColor: themeCubit.darkBackgroundColor,
                //   suffixIcon: const Padding(
                //     padding: EdgeInsets.only(right: 15),
                //     child: Icon(Icons.search),
                //   ),
                //   hintText: 'Search for People',
                // ),
                SizedBoxConstants.sizedBoxTenH(),
                FilterComponent(
                  options: [
                    FilterComponentArg(title: 'All'),
                    FilterComponentArg(title: "Unread"),
                    FilterComponentArg(title: "DMS", count: 111),
                    FilterComponentArg(title: "DMS", count: 23),
                    FilterComponentArg(title: "Event", count: 104)
                  ],
                  groupValue:
                      _selectedIndex, // Your state variable for selected index
                  onValueChanged: (int value) =>
                      setState(() => _selectedIndex = value),
                ),
                SizedBoxConstants.sizedBoxTwentyH()
              ],
            ),
          ),
          Expanded(
            child: dummyContactList.isNotEmpty
                ? ListView.builder(
                    itemCount: 16,
                    itemBuilder: (context, index) => const ChatTileComponent())
                : Container(
              width: AppConstants.responsiveWidth(context,percentage: 80),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetConstants.sad,
                          height: 65,
                          width: 65,
                        ),
                        SizedBoxConstants.sizedBoxTwentyH(),
                        TextComponent(
                          StringConstants.itsReallyQuiet,
                          style: TextStyle(
                              fontFamily: FontConstants.fontProtestStrike,
                              color: themeCubit.textColor,
                              fontSize: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextComponent(
                            StringConstants.startChatwithYourFriends,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: themeCubit.textColor),
                          ),
                        ),
                        SizedBoxConstants.sizedBoxTwentyH(),
                        ButtonComponent(
                            // isSmallBtn: true,
                            btnWidth: AppConstants.responsiveWidth(context,percentage: 40),
                            buttonText: StringConstants.startChat,
                            bgcolor: themeCubit.primaryColor,
                            textColor: themeCubit.backgroundColor,
                            onPressed: () {})
                      ],
                    ),
                ),
          ),
          SizedBoxConstants.sizedBoxThirtyH()
        ],
      ),
    );
  }

  _showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return UserListComponent(
          headingName: StringConstants.createChat,
          dummyContactList: contacts,
          selectedContacts: selectedContacts,
          subtitle: true,
          btnName: StringConstants.startChatting,
          onBtnTap: () {});
    }));
  }
}

class DummyContacts {
  String name;
  String designation;

  DummyContacts({required this.name, required this.designation});
}

List<DummyContacts> dummyContactList = [
  DummyContacts(name: 'Jesse Ebert', designation: 'Graphic Designer'),
  DummyContacts(
      name: 'Ann Chovey', designation: 'Infrastructure Project Manager'),
  DummyContacts(name: 'Luz Stamm', designation: 'Accountant'),
  DummyContacts(name: 'Accountant', designation: 'Digital Marketing'),
  DummyContacts(name: 'Digital Marketing', designation: 'Graphic Designer'),
  DummyContacts(name: 'Graphic Designer', designation: 'Graphic Designer'),
  DummyContacts(name: 'Jesse Ebert', designation: 'Graphic Designer'),
  DummyContacts(
      name: 'Ann Chovey', designation: 'Infrastructure Project Manager'),
  DummyContacts(name: 'Luz Stamm', designation: 'Accountant'),
  DummyContacts(name: 'Accountant', designation: 'Digital Marketing'),
  DummyContacts(name: 'Digital Marketing', designation: 'Graphic Designer'),
  DummyContacts(name: 'Graphic Designer', designation: 'Graphic Designer')
];
