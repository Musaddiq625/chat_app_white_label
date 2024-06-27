import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/card_component.dart';
import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/locals_views/notification_screen/cubit/notification_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/profile_screen/cubit/view_user_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int connectionRequestCount = 14;
  UserModel? userModel;
  String? userId;
  late NotificationScreenCubit notificationScreenCubit =
      BlocProvider.of<NotificationScreenCubit>(context);

  late ViewUserScreenCubit viewUserScreenCubit =
      BlocProvider.of<ViewUserScreenCubit>(context);

  @override
  void initState() {
    fetchAndSetUserData();
    super.initState();
  }

  void fetchAndSetUserData() async {
    // Fetch notifications first to ensure UI updates are prioritized
    await notificationScreenCubit.fetchNotificationData();
    // Then fetch and decode the user model
    final serializedUserModel = await getIt<SharedPreferencesUtil>().getString(
      SharedPreferenceConstants.userModel,
    );
    userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));

    // Update the state with the new user ID
    setState(() {
      userId = userModel?.id;
    });
    // Optionally, print the updated user model
  }

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
    return BlocConsumer<NotificationScreenCubit, NotificationScreenState>(
      listener: (context, state) {
        if (state is NotificationScreenLoadingState) {
        } else if (state is NotificationSuccessState) {
          notificationScreenCubit
              .initializeNotificationData(state.notificationListingWrapper);
        } else if (state is NotificationScreenFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        }

        // TODO: implement listener
      },
      builder: (context, state) {
        return UIScaffold(
          bgColor: themeCubit.backgroundColor,
          removeSafeAreaPadding: true,
          appBar: AppBarComponent(
            StringConstants.notifications,
            showBackbutton: false,
          ),
          widget: SingleChildScrollView(
            child: Container(
              margin:
                  EdgeInsets.only(bottom: AppConstants.bottomPadding(context)),
              child: Column(
                children: [
                  CardComponent(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(
                                  "${StringConstants.connectionRequests} (${(notificationScreenCubit.notificationListingWrapper.data?.connectionRequests ?? []).length})",
                                  style: FontStylesConstants.style14(
                                      color: themeCubit.textColor)),
                              Row(
                                children: [
                                  TextComponent(
                                    '',
                                    listOfText: [StringConstants.seeAll],
                                    listOfOnPressedFunction: [
                                      () => NavigationUtil.push(
                                          context,
                                          RouteConstants
                                              .allConnectionRequestScreen,
                                          args: notificationScreenCubit
                                              .notificationListingWrapper
                                              .data
                                              ?.connectionRequests)
                                    ],
                                    listOfTextStyle: [
                                      FontStylesConstants.style14(
                                          color: themeCubit.textSecondaryColor),
                                    ],
                                  ),
                                  IconComponent(
                                    showCustomTextonLeft: true,
                                    iconColor: themeCubit.textSecondaryColor,
                                    iconData: Icons.chevron_right,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // ContactCard(
                        //     name: 'Jessi Ebert',
                        //     url:
                        //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                        //     title: 'title'),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 32),
                          // itemCount: (notificationScreenCubit
                          //             .notificationListingWrapper
                          //             .data
                          //             ?.connectionRequests ??
                          //         [])
                          //     .length,
                          itemCount: (notificationScreenCubit
                                      .notificationListingWrapper
                                      .data
                                      ?.connectionRequests ??
                                  [])
                              .take(3)
                              .length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const DividerComponent();
                          },
                          itemBuilder: (ctx, index) {
                            final connectionRequests = (notificationScreenCubit
                                    .notificationListingWrapper
                                    .data
                                    ?.connectionRequests ??
                                [])[index];
                            return ListTileComponent(
                                // icon: Icons.location_on,
                                // iconColor: ColorConstants.white,
                                leadingText: (connectionRequests.payload?.data)
                                    ?.friendName,
                                reducePadding: true,
                                leadingsubText:
                                    (connectionRequests.payload?.data)
                                        ?.friendAboutMe,
                                overrideTrailingWithBtn: true,
                                // trailingIcon: Icons.add_circle,
                                trailingIconSize: 30,
                                leadingIcon: (connectionRequests.payload?.data)
                                        ?.friendImage ??
                                    "",
                                leadingIconHeight: 40,
                                leadingIconWidth: 40,
                                isLeadingImageProfileImage: true,
                                trailingBtnTitle: StringConstants.connect,
                                trailingBtnTap: () async {
                                  await viewUserScreenCubit.sendFriendRequest(
                                      (connectionRequests.payload!.data)!
                                          .friendId!,
                                      "accepted");
                                  BottomSheetComponent.showBottomSheet(context,
                                      isShowHeader: false,
                                      body: CommonBottomSheetComponent(
                                        title: StringConstants
                                            .youAreNowConnectedWith,
                                        description:
                                            (connectionRequests.payload?.data)
                                                    ?.friendName ??
                                                "",
                                        onBtnTap: () {},
                                        btnText: StringConstants.message,
                                        image:
                                            (connectionRequests.payload?.data)
                                                    ?.friendImage ??
                                                "",
                                        isImageProfilePic: true,
                                      ));
                                },
                                isLeadingImageSVG: true,

                                // isSocialConnected: true,
                                subIconColor: themeCubit.textColor,
                                // trailingText: "heelo",
                                onTap: () {
                                  NavigationUtil.push(context,
                                      RouteConstants.profileScreenLocal,
                                      args: connectionRequests
                                          .payload?.data?.friendId);
                                });
                          },
                        ),

                        // const DividerComponent(),
                        // ListTileComponent(
                        //     // icon: Icons.location_on,
                        //     // iconColor: ColorConstants.white,
                        //     leadingText: StringConstants.linkedIn,
                        //     reducePadding: true,
                        //     leadingsubText: 'Graphic Designer',
                        //     overrideTrailingWithBtn: true,
                        //     // trailingIcon: Icons.add_circle,
                        //     trailingIconSize: 30,
                        //     leadingIcon:
                        //         'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                        //     leadingIconHeight: 40,
                        //     leadingIconWidth: 40,
                        //     isLeadingImageProfileImage: true,
                        //     trailingBtnTitle: StringConstants.connect,
                        //     trailingBtnTap: () {},
                        //     isLeadingImageSVG: true,
                        //
                        //     // isSocialConnected: true,
                        //     subIconColor: themeCubit.textColor,
                        //     // trailingText: "heelo",
                        //     onTap: () {
                        //       // BottomSheetComponent.showBottomSheet(
                        //       //   context,
                        //       //   isShowHeader: false,
                        //       //   // body: const SocialSheetComponent(
                        //       //   //   heading: StringConstants.whatsYourLinkedin,
                        //       //   //   isSvg: true,
                        //       //   //   textfieldHint: StringConstants.linkedinHintText,
                        //       //   //   image: AssetConstants.linkedin,
                        //       //   // ),
                        //       // );
                        //     }),
                        // SizedBoxConstants.sizedBoxTenH(),
                      ],
                    ),
                  ),
                  SizedBoxConstants.sizedBoxTenH(),
                  if ((notificationScreenCubit.notificationListingWrapper.data
                                  ?.todayNotifications ??
                              [])
                          .length >
                      0)
                    CardComponent(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextComponent(StringConstants.today,
                                    style: FontStylesConstants.style14(
                                        color: themeCubit.textColor)),
                              ],
                            ),
                          ),
                          // ContactCard(
                          //     name: 'Jessi Ebert',
                          //     url:
                          //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                          //     title: 'title'),

                          ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 32),
                            itemCount: (notificationScreenCubit
                                        .notificationListingWrapper
                                        .data
                                        ?.todayNotifications ??
                                    [])
                                .length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const DividerComponent();
                            },
                            itemBuilder: (ctx, index) {
                              final todayNotification = (notificationScreenCubit
                                      .notificationListingWrapper
                                      .data
                                      ?.todayNotifications ??
                                  [])[index];
                              return ListTileComponent(
                                  // icon: Icons.location_on,
                                  // iconColor: ColorConstants.white,
                                  leadingText:
                                      (todayNotification.payload?.notification)
                                          ?.title,
                                  //'Your friend has send you a friend request. lets get started',
                                  reducePadding: true,
                                  leadingsubText:
                                      (todayNotification.payload?.notification)
                                          ?.body,
                                  //'Graphic Designer',
                                  // overrideTrailingWithBtn: true,
                                  // trailingIcon: Icons.add_circle,
                                  // trailingIconSize: 30,
                                  leadingIcon: (todayNotification.payload?.data)
                                          ?.userImage ??
                                      "",
                                  //'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                                  leadingIconHeight: 40,
                                  leadingIconWidth: 40,
                                  isLeadingImageProfileImage: true,
                                  // trailingBtnTitle: StringConstants.connect,
                                  // trailingBtnTap: () {},
                                  isLeadingImageSVG: true,

                                  // isSocialConnected: true,
                                  subIconColor: themeCubit.textColor,
                                  profileImageTap: () async{
                                    final serializedUserModel =
                                        await getIt<SharedPreferencesUtil>()
                                        .getString(SharedPreferenceConstants
                                        .userModel);
                                    userModel = UserModel.fromJson(
                                        jsonDecode(serializedUserModel!));
                                    // userId = await getIt<SharedPreferencesUtil>()
                                    //     .getString(SharedPreferenceConstants.userIdValue);
                                    String? myId = userModel?.id;
                                    if (todayNotification
                                        .payload?.data?.userId !=
                                        myId) {
                                      NavigationUtil.push(context,
                                          RouteConstants.profileScreenLocal,
                                          args: todayNotification
                                              .payload?.data?.userId);
                                    } else {
                                      NavigationUtil.push(
                                          context, RouteConstants.mainScreen,
                                          args: "4");
                                    }
                                  },
                                  // trailingText: "heelo",
                                  onTap: () {
                                    if (todayNotification.payload?.data?.type ==
                                        "event") {
                                      if (userId ==
                                          todayNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourEventScreen,
                                            args: todayNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(
                                            context, RouteConstants.eventScreen,
                                            args: EventScreenArg(
                                                todayNotification.payload?.data
                                                        ?.eventId ??
                                                    "",
                                                ""));
                                      }
                                    } else if (todayNotification
                                            .payload?.data?.type ==
                                        "event_invite") {
                                      if (userId ==
                                          todayNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourEventScreen,
                                            args: todayNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(
                                            context, RouteConstants.eventScreen,
                                            args: EventScreenArg(
                                                todayNotification.payload?.data
                                                        ?.eventId ??
                                                    "",
                                                ""));
                                      }
                                    } else if (todayNotification
                                            .payload?.data?.type ==
                                        "group_invite") {
                                      if (userId ==
                                          todayNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourGroupScreen,
                                            args: todayNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewGroupScreen,
                                            args: ViewGroupArg(
                                                todayNotification.payload?.data
                                                        ?.eventId ??
                                                    "",
                                                false,
                                                true));
                                      }
                                    } else {
                                      if (userId ==
                                          todayNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourGroupScreen,
                                            args: todayNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewGroupScreen,
                                            args: ViewGroupArg(
                                                todayNotification.payload?.data
                                                        ?.eventId ??
                                                    "",
                                                false,
                                                true));
                                      }
                                    }
                                  });
                            },
                          ),
                          // ListTileComponent(
                          //     // icon: Icons.location_on,
                          //     // iconColor: ColorConstants.white,
                          //     leadingText:
                          //         'Your friend has send you a friend request. lets get started',
                          //     reducePadding: true,
                          //     leadingsubText: 'Graphic Designer',
                          //     // overrideTrailingWithBtn: true,
                          //     // trailingIcon: Icons.add_circle,
                          //     // trailingIconSize: 30,
                          //     leadingIcon:
                          //         'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                          //     leadingIconHeight: 40,
                          //     leadingIconWidth: 40,
                          //     isLeadingImageProfileImage: true,
                          //     // trailingBtnTitle: StringConstants.connect,
                          //     // trailingBtnTap: () {},
                          //     isLeadingImageSVG: true,
                          //
                          //     // isSocialConnected: true,
                          //     subIconColor: themeCubit.textColor,
                          //     // trailingText: "heelo",
                          //     onTap: () {
                          //       // BottomSheetComponent.showBottomSheet(
                          //       //   context,
                          //       //   isShowHeader: false,
                          //       //   // body: const SocialSheetComponent(
                          //       //   //   heading: StringConstants.whatsYourLinkedin,
                          //       //   //   isSvg: true,
                          //       //   //   textfieldHint: StringConstants.linkedinHintText,
                          //       //   //   image: AssetConstants.linkedin,
                          //       //   // ),
                          //       // );
                          //     }),
                          // const DividerComponent(),
                          // ListTileComponent(
                          //     // icon: Icons.location_on,
                          //     // iconColor: ColorConstants.white,
                          //     leadingText:
                          //         'Your friend has send you a friend request. lets get started',
                          //     reducePadding: true,
                          //     leadingsubText: 'Graphic Designer',
                          //     // overrideTrailingWithBtn: true,
                          //     // trailingIcon: Icons.add_circle,
                          //     // trailingIconSize: 30,
                          //     leadingIcon:
                          //         'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                          //     leadingIconHeight: 40,
                          //     leadingIconWidth: 40,
                          //     isLeadingImageProfileImage: true,
                          //     // trailingBtnTitle: StringConstants.connect,
                          //     // trailingBtnTap: () {},
                          //     isLeadingImageSVG: true,
                          //
                          //     // isSocialConnected: true,
                          //     subIconColor: themeCubit.textColor,
                          //     // trailingText: "heelo",
                          //     onTap: () {
                          //       // BottomSheetComponent.showBottomSheet(
                          //       //   context,
                          //       //   isShowHeader: false,
                          //       //   // body: const SocialSheetComponent(
                          //       //   //   heading: StringConstants.whatsYourLinkedin,
                          //       //   //   isSvg: true,
                          //       //   //   textfieldHint: StringConstants.linkedinHintText,
                          //       //   //   image: AssetConstants.linkedin,
                          //       //   // ),
                          //       // );
                          //     }),
                          // SizedBoxConstants.sizedBoxTenH(),
                        ],
                      ),
                    ),
                  // SizedBoxConstants.sizedBoxTenH(),
                  if ((notificationScreenCubit.notificationListingWrapper.data
                                  ?.earlierThisWeekNotifications ??
                              [])
                          .length >
                      0)
                    CardComponent(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextComponent(
                                    StringConstants
                                        .earlierThisWeekNotifications,
                                    style: FontStylesConstants.style14(
                                        color: themeCubit.textColor)),
                              ],
                            ),
                          ),
                          // ContactCard(
                          //     name: 'Jessi Ebert',
                          //     url:
                          //         "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Jake-Sully.Avatar.webp",
                          //     title: 'title'),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 32),
                            itemCount: (notificationScreenCubit
                                        .notificationListingWrapper
                                        .data
                                        ?.earlierThisWeekNotifications ??
                                    [])
                                .length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const DividerComponent();
                            },
                            itemBuilder: (ctx, index) {
                              final earlyerThisWeekNotification =
                                  (notificationScreenCubit
                                          .notificationListingWrapper
                                          .data
                                          ?.earlierThisWeekNotifications ??
                                      [])[index];
                              return ListTileComponent(
                                  // icon: Icons.location_on,
                                  // iconColor: ColorConstants.white,
                                  leadingText: (earlyerThisWeekNotification
                                          .payload?.notification)
                                      ?.title,
                                  //'Your friend has send you a friend request. lets get started',
                                  reducePadding: true,
                                  leadingsubText: (earlyerThisWeekNotification
                                          .payload?.notification)
                                      ?.body,
                                  //'Graphic Designer',
                                  // overrideTrailingWithBtn: true,
                                  // trailingIcon: Icons.add_circle,
                                  // trailingIconSize: 30,
                                  leadingIcon: (earlyerThisWeekNotification
                                              .payload?.data)
                                          ?.userImage ??
                                      "",
                                  //'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                                  leadingIconHeight: 40,
                                  leadingIconWidth: 40,
                                  isLeadingImageProfileImage: true,
                                  // trailingBtnTitle: StringConstants.connect,
                                  // trailingBtnTap: () {},
                                  isLeadingImageSVG: true,

                                  // isSocialConnected: true,
                                  subIconColor: themeCubit.textColor,
                                  // trailingText: "heelo",
                                  profileImageTap: () async {
                                    final serializedUserModel =
                                        await getIt<SharedPreferencesUtil>()
                                            .getString(SharedPreferenceConstants
                                                .userModel);
                                    userModel = UserModel.fromJson(
                                        jsonDecode(serializedUserModel!));
                                    // userId = await getIt<SharedPreferencesUtil>()
                                    //     .getString(SharedPreferenceConstants.userIdValue);
                                    String? myId = userModel?.id;
                                    if (earlyerThisWeekNotification.payload?.data?.userId != myId) {
                                      print(" earlyerThisWeekNotification.payload?.data?.userId ${ earlyerThisWeekNotification
                                          .payload?.data?.userId}");
                                      NavigationUtil.push(context,
                                          RouteConstants.profileScreenLocal,
                                          args: earlyerThisWeekNotification
                                              .payload?.data?.userId);
                                    } else {
                                      NavigationUtil.push(
                                          context, RouteConstants.mainScreen,
                                          args: "4");
                                    }
                                  },
                                  onTap: () {
                                    if (earlyerThisWeekNotification
                                            .payload?.data?.type ==
                                        "event") {
                                      if (userId ==
                                          earlyerThisWeekNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourEventScreen,
                                            args: earlyerThisWeekNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(
                                            context, RouteConstants.eventScreen,
                                            args: EventScreenArg(
                                                earlyerThisWeekNotification
                                                        .payload
                                                        ?.data
                                                        ?.eventId ??
                                                    "",
                                                ""));
                                      }
                                    } else if (earlyerThisWeekNotification
                                            .payload?.data?.type ==
                                        "event_invite") {
                                      if (userId ==
                                          earlyerThisWeekNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourEventScreen,
                                            args: earlyerThisWeekNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(
                                            context, RouteConstants.eventScreen,
                                            args: EventScreenArg(
                                                earlyerThisWeekNotification
                                                        .payload
                                                        ?.data
                                                        ?.eventId ??
                                                    "",
                                                ""));
                                      }
                                    } else if (earlyerThisWeekNotification
                                            .payload?.data?.type ==
                                        "group_invite") {
                                      if (userId ==
                                          earlyerThisWeekNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourGroupScreen,
                                            args: earlyerThisWeekNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewGroupScreen,
                                            args: ViewGroupArg(
                                                earlyerThisWeekNotification
                                                        .payload
                                                        ?.data
                                                        ?.eventId ??
                                                    "",
                                                false,
                                                true));
                                      }
                                    } else {
                                      if (userId ==
                                          earlyerThisWeekNotification
                                              .payload?.data?.userId) {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewYourGroupScreen,
                                            args: earlyerThisWeekNotification
                                                .payload?.data?.eventId);
                                      } else {
                                        NavigationUtil.push(context,
                                            RouteConstants.viewGroupScreen,
                                            args: ViewGroupArg(
                                                earlyerThisWeekNotification
                                                        .payload
                                                        ?.data
                                                        ?.eventId ??
                                                    "",
                                                false,
                                                true));
                                      }
                                    }
                                  }
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
