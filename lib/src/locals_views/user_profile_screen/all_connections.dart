import 'package:chat_app_white_label/src/components/back_button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/contacts_card_component.dart';
import '../../components/search_text_field_component.dart';
import '../../components/text_component.dart';
import '../../components/text_field_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
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
    // ... other contacts
  ];
  TextEditingController searchController = TextEditingController();

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
              iconSize:40,
              circleHeight: 40,
            ),
          ),
          // BackButtonComponent(
          //     image: AssetConstants.backArrow,
          //     //! pass your asset here
          //     bgColor: ColorConstants.transparent,
          //     enableDark: false,
          //     isImage: true,
          //     isCircular: true,
          //     overrideSize:40 ,
          //     onTap: () {
          //
          //     }),
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
            padding:EdgeInsets.symmetric(horizontal: 15),
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
                  // actions:[
                  //   PopupMenuButton<int>(
                  //     key: _key,
                  //     itemBuilder: (context) {
                  //       return <PopupMenuEntry<int>>[
                  //         PopupMenuItem(child: Text('0'), value: 0),
                  //         PopupMenuItem(child: Text('1'), value: 1),
                  //       ];
                  //     },
                  //   ),
                  // ],
                  iconGradient: false,
                  icon: AssetConstants.more,
                  iconColor: ColorConstants.lightGray,
                  contact: contacts[index],
                  iconSize: 6,
                  onShareTap: () {
                    // _key.currentState.showButtonMenu(),
                  },
                  onProfileTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
            child: const Text('Doge'), value: 'Doge'),
        PopupMenuItem<String>(
            child: const Text('Lion'), value: 'Lion'),
      ],
      elevation: 8.0,
    );
  }
}
