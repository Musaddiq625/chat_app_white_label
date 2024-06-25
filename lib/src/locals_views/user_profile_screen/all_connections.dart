import 'dart:math';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/wrappers/friend_list_response_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bottom_sheet_component.dart';
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
  // List<ContactModel> filteredContacts = [];
  List<FriendListData> filteredContacts = [];
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
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
  TextEditingController searchController = TextEditingController();
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);

  String? totalCount;

  void _showPopupMenu() {
    _key.currentState?.showButtonMenu();
  }

  @override
  void initState() {
    super.initState();
    userScreenCubit.fetchMyFriendListData();

    // filteredContacts = contacts; // Initialize with all contacts
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserScreenCubit, UserScreenState>(
      listener: (context, state) {
        if (state is FetchMyFriendListDataLoadingState) {
        } else if (state is FetchMyFriendListSuccessState) {
          userScreenCubit.initializeFriendListResponseWrapperData(
              state.friendListResponseWrapper);
          filteredContacts.addAll((userScreenCubit.friendListResponseWrapper.data ?? []));
          totalCount = (userScreenCubit.friendListResponseWrapper.data?.length?? 0).toString();
        } else if (state is FetchMyFriendListFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: AppBarComponent(
              StringConstants.connections,
              titleText2: totalCount ?? "0",
              centerTitle: false,
              isBackBtnCircular: false,
            ),
            //  appBar(),
            appBarHeight: 500,
            removeSafeAreaPadding: false,
            bgColor: ColorConstants.black,
            // bgImage:
            //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
            widget: main());
      },
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SearchTextField(
              title: "Search",
              hintText: "Search name, postcode..",
              onSearch: (text) {
                setState(() {
                  filteredContacts = (userScreenCubit.friendListResponseWrapper.data ?? [])
                      .where((contact) =>
                  (contact.firstName ?? "").toLowerCase().contains(text.toLowerCase()) ||
                      (contact.lastName ?? "").toLowerCase().contains(text.toLowerCase()) ||
                      (contact.aboutMe ?? "").toLowerCase().contains(text.toLowerCase())
                  ).toList();
                });
              },
              textEditingController: searchController,
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: filteredContacts.length,
              separatorBuilder: (BuildContext context, int index) {
                return const DividerComponent();
              },
              itemBuilder: (ctx, index) {
                final contact = filteredContacts[index];
                return ListTileComponent(
                    leadingText:"${contact.firstName} ${contact.lastName}",
                    // contacts[index].name // StringConstants.linkedIn,
                    removeBorderFromTile: true,
                    customPadding: const EdgeInsets.only(left: 20, right: 16),
                    leadingsubText: contact.aboutMe,
                    //contacts[index].title, // 'Graphic Designer',
                    // trailingIcon: Icons.add_circle,
                    trailingIconSize: 30,
                    leadingIcon: contact.image,
                    // contacts[index]
                    //     .url, //  'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                    leadingIconHeight: 40,
                    leadingIconWidth: 40,
                    isLeadingImageProfileImage: true,
                    trailingWidget: showMore(),
                    // moreBtnTap: () {
                    //   return showMore();
                    // },
                    // isLeadingImageSVG: true,
                    // isSocialConnected: true,
                    subIconColor: themeCubit.textColor,
                    // trailingText: "heelo",
                    onTap: () {
                      NavigationUtil.push(
                          context, RouteConstants.profileScreenLocal,args: contact.id);
                    });
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
        body: CommonBottomSheetComponent(
            title: StringConstants.areYouSureYouwantToRemoveFromConnection,
            description: '',
            isImageAsset: true,
            btnColor: ColorConstants.red,
            btnTextColor: themeCubit.textColor,
            btnText: StringConstants.yesRemove,
            onBtnTap: () {
              NavigationUtil.pop(context);
              return _connectionRemovedBottomSheet();
            },
            image: AssetConstants.warning));

    // Column(
    //   children: [
    //     const SizedBox(height: 25),
    //     Image.asset(
    //       AssetConstants.warning,
    //       width: 60,
    //       height: 60,
    //     ),
    //     const SizedBox(height: 20),
    //     const TextComponent(
    //         StringConstants.areYouSureYouwantToRemoveFromConnection,
    //         style: TextStyle(
    //             color: ColorConstants.white,
    //             fontSize: 20,
    //             fontFamily: FontConstants.fontProtestStrike)),
    //     const SizedBox(height: 20),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         InkWell(
    //             onTap: () => Navigator.pop(context),
    //             child: TextComponent(
    //               StringConstants.goBack,
    //               style: TextStyle(color: themeCubit.textColor),
    //             )),
    //         const SizedBox(width: 30),
    //         ButtonComponent(
    //           isSmallBtn: true,
    //           bgcolor: ColorConstants.red,
    //           textColor: themeCubit.textColor,
    //           buttonText: StringConstants.yesRemove,
    //           onPressed: () {
    //             NavigationUtil.pop(context);
    //             _connectionRemovedBottomSheet();
    //             // NavigationUtil.popAllAndPush(
    //             //     context, RouteConstants.homeScreenLocal);
    //           },
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //   ],
    // ));
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

  Widget showMore() {
    return PopupMenuButton(
      offset: const Offset(0, -100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set the border radius
      ),
      color: ColorConstants.darkBackgrounddColor,
      key: ValueKey('key${Random().nextInt(1000)}'),
      icon: IconComponent(
        svgData: AssetConstants.more,
        borderColor: Colors.transparent,
        backgroundColor: themeCubit.darkBackgroundColor200,
        iconColor: Colors.white,
        circleSize: 35,
        iconSize: 5,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(children: [
            IconComponent(
              svgData: AssetConstants.message,
              iconColor: ColorConstants.lightGray,
            ),
            SizedBoxConstants.sizedBoxSixW(),
            TextComponent(
              'Message',
              style: FontStylesConstants.style14(color: ColorConstants.white),
            ),
          ]),
          height: 0,
          value: 'message',
        ),
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
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
              style: FontStylesConstants.style14(color: ColorConstants.red),
            ),
          ]),
          value: 'remove_connection',
        ),
      ],
      // onSelected: onMenuItemSelected,
      onSelected: (value) {
        if (value == 'remove_connection') {
          _askToRemoveConnectionBottomSheet();
          // Handle share action
        } else if (value == 'something_else') {
          // Handle something else action
        }
        // Add more conditions as needed
      },
    );
  }
}
