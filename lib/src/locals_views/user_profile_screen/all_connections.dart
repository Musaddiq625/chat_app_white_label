import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/contacts_card_component.dart';
import '../../components/search_text_field_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../models/contact.dart';

class AllConnections extends StatefulWidget {
  const AllConnections({super.key});

  @override
  State<AllConnections> createState() => _AllConnectionsState();
}

class _AllConnectionsState extends State<AllConnections> {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
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
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    // ... other contacts
  ];
  TextEditingController searchController = TextEditingController();

  void _showPopupMenu() {
    _key.currentState?.showButtonMenu();
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: appBar(),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: IconComponent(
              svgData: AssetConstants.backArrow,
              svgDataCheck: false,
              iconColor: ColorConstants.lightGray,
              iconSize: 40,
              circleHeight: 40,
            ),
          ),
          TextComponent(
            StringConstants.connections,
            style: FontStylesConstants.style28(color: themeCubit.primaryColor),
          ),
          SizedBoxConstants.sizedBoxTenW(),
          TextComponent(
            "134",
            style: FontStylesConstants.style28(color: ColorConstants.lightGray),
          ),
        ],
      ),
    );
  }

  Widget main() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTenH(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SearchTextField(
              title: "Search",
              hintText: "Search name, postcode..",
              onSearch: (text) {
                // widget.viewModel.onSearchStories(text);
              },
              textEditingController: searchController,
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (ctx, index) {
                return ContactCard(
                  showShareIcon: true,
                  iconGradient: false,
                  popUpMenu: true,
                  icon: AssetConstants.more,
                  iconColor: ColorConstants.lightGray,
                  contact: contacts[index],
                  iconSize: 30,
                  onShareTap: () {},
                  onProfileTap: () {},
                  popupMenuItems: [
                    PopupMenuItem(
                      child: Row(children: [
                        IconComponent(
                          svgData: AssetConstants.message,
                          iconColor: ColorConstants.lightGray,
                        ),
                        TextComponent(
                          'Message',
                          style: FontStylesConstants.style14(
                              color: ColorConstants.white),
                        ),
                      ]),
                      height: 0,
                      value: 'message',
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.all(0),
                      height: 0,
                      child: DividerCosntants.divider1,
                      value: 'remove_connection',
                    ),
                    PopupMenuItem(
                      height: 0,
                      child: Row(children: [
                        IconComponent(
                          iconData: Icons.close,
                          iconColor: ColorConstants.red,
                        ),
                        TextComponent(
                          'Remove Connection',
                          style: FontStylesConstants.style14(
                              color: ColorConstants.red),
                        ),
                      ]),
                      value: 'remove_connection',
                    ),
                    // Add more PopupMenuItems as needed
                  ],
                  onMenuItemSelected: (String value) {
                    switch (value) {
                      case 'message':
                        // Handle share action
                        break;
                      case 'remove_connection':
                        _askToRemoveConnectionBottomSheet();
                        break;
                      default:
                        // Handle default case or additional cases
                        break;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _askToRemoveConnectionBottomSheet() {
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
            const TextComponent(
                StringConstants.areYouSureYouwantToRemoveFromConnection,
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
                  isSmallBtn: true,
                  bgcolor: ColorConstants.red,
                  textColor: themeCubit.textColor,
                  buttonText: StringConstants.yesRemove,
                  onPressed: () {
                    NavigationUtil.pop(context);
                    _connectionRemovedBottomSheet();
                    // NavigationUtil.popAllAndPush(
                    //     context, RouteConstants.homeScreenLocal);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  _connectionRemovedBottomSheet() {
    _navigateToBack();
    BottomSheetComponent.showBottomSheet(context,
        bgColor: themeCubit.darkBackgroundColor,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            SizedBoxConstants.sizedBoxTwentyH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconComponent(
                  iconData: Icons.check_circle,
                  iconColor: themeCubit.primaryColor,
                  iconSize: 25,
                ),
                SizedBoxConstants.sizedBoxSixW(),
                const TextComponent(StringConstants.connectionRemoved,
                    style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 20,
                        fontFamily: FontConstants.fontProtestStrike)),
              ],
            ),
            SizedBoxConstants.sizedBoxTwentyH(),
          ],
        ));
  }

  _navigateToBack() async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
  }
}
