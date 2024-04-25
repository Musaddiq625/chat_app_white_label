import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
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

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: true,
        appBar: AppBarComponent(StringConstants.chat,
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
        widget:_main());
  }

  _main(){
   return Container(
      color: themeCubit.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Container(
            color: themeCubit.backgroundColor,
            child: Column(
              children: [
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
                    filledColor:
                    ColorConstants.backgroundColor.withOpacity(0.1),
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
                itemBuilder: (context, index) =>
                const ChatTileComponent())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.sad,
                  height: 65,
                  width: 65,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonComponent(
                    buttonText: StringConstants.startChat,
                    bgcolor: themeCubit.primaryColor,
                    textColor: themeCubit.backgroundColor,
                    onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }

  _showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        height: AppConstants.responsiveHeight(context, percentage: 90),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                            StringConstants.createChat,
                            style: TextStyle(
                                color: themeCubit.primaryColor,
                                fontSize: 20,
                                fontFamily: FontConstants.fontProtestStrike),
                          ),
                          InkWell(
                              onTap: () => NavigationUtil.pop(context),
                              child: const Icon(Icons.close))
                        ],
                      ),
                      TextComponent(
                        StringConstants.startDirectChat,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: FontConstants.fontNunitoSans,
                            color: themeCubit.textColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dummyContactList.length,
                      itemBuilder: (context, index) {
                        return ContactTileComponent(
                          title: dummyContactList[index].name,
                          subtitle: dummyContactList[index].designation,
                          isSelected: selectedContacts.contains(index),
                          onTap: () {
                            if (selectedContacts.contains(index)) {
                              selectedContacts.remove(index);
                            } else {
                              selectedContacts.add(index);
                            }
                            setState(() {});
                            LoggerUtil.logs(selectedContacts);
                          },
                        );
                      }),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  width: double.infinity,
                  height: 45,
                  child: ButtonComponent(
                      buttonText: StringConstants.startChatting,
                      bgcolor: themeCubit.primaryColor,
                      onPressed: () {}),
                ),
              ],
            )
          ],
        ),
      );
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
