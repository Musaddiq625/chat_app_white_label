import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/event_card.dart';
import 'package:chat_app_white_label/src/components/group_card.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/all_event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/wrappers/events_going_to_response_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/event_summary_component.dart';
import '../../components/filter_component.dart';
import '../../components/icon_component.dart';
import '../../components/profile_image_component.dart';
import '../../components/text_component.dart';
import '../../constants/asset_constants.dart';
import '../../models/user_model.dart';
import '../event_screen/event_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);
  File? selectedImage;
  String? imageUrl;
  int? totalEventCountGoingTo;
  bool isEdit = true;
  bool eventActive = true;
  int _selectedIndex = 0;
  String userName = "Emily Rose";
  String img =
      "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg";

  final List<String> images2 = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
  ];

  final List<String> images = [
    // "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    // "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    // "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
    // "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    // "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    // "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
  ];

  List<Map<String, dynamic>> eventDetailList = [
    // {
    //   'name': "Meet the cheese",
    //   'price': "150",
    //   'sold': "4",
    //   'remaining': "96",
    //   'earned': "600",
    //   'active': true
    // },
    // {
    //   'name': "Hello to the future",
    //   'price': "150",
    //   'sold': "4",
    //   'remaining': "96",
    //   'earned': "600",
    //   'active': true
    // },
    // {
    //   'name': "Groves",
    //   'price': "150",
    //   'sold': "4",
    //   'remaining': "96",
    //   'earned': "600",
    //   'active': true
    // },
    // {
    //   'name': "Tale Town",
    //   'price': "150",
    //   'sold': "4",
    //   'remaining': "96",
    //   'earned': "600",
    //   'active': true
    // },
  ];

  List<EventRequest>? acceptedRequests;
  List<Map<String, dynamic>> eventList = [
    // {
    //   'joined': "+1456",
    //   'eventName': "Property networking event",
    //   'dateTime': "17Feb. 11AM - 2PM",
    //   'viewTicket': true
    // },
    // {
    //   'joined': "+1226",
    //   'eventName': "Drum Code London",
    //   'dateTime': "17Feb. 11AM - 2PM",
    //   'viewTicket': false
    // },
    // {
    //   'joined': "+1134",
    //   'eventName': "Property test event",
    //   'dateTime': "17Feb. 11AM - 2PM",
    //   'viewTicket': true
    // },
    // {
    //   'joined': "+1146",
    //   'eventName': "Networking event",
    //   'dateTime': "17Feb. 11AM - 2PM",
    //   'viewTicket': false
    // },
  ];

  List<String?>? imagesUserInEvents;

  final List<ImageProvider> imagesUserInEvent = [
    const CachedNetworkImageProvider(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your image URL
    const CachedNetworkImageProvider(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const CachedNetworkImageProvider(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    const CachedNetworkImageProvider(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your asset path
    // Add more image providers as needed
  ];

  double radius = 20;
  UserModel? userModel;
  Map<String, List<UpcomingEvents>>? eventFilters;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // userScreenCubit.fetchUserData("66472edbbb880ed91c93213d");
      userScreenCubit.fetchEventYouGoingToData();
      userScreenCubit.fetchGroupsData();
      userScreenCubit.fetchMyEventsData();
      final serializedUserModel = await getIt<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.userModel);
      userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));
      print("usermodel ${userModel?.toJson()}");
      setState(() {
        userName = "${userModel?.firstName} ${userModel?.lastName}";
        // imageUrl =  userModel?.userPhotos?.first ?? "";
      });
      print("userName $userName");
      print("imageUrl $imageUrl");
      LoggerUtil.logs(
          "sharedPreferencesUtil userModel Value ${userModel?.toJson()}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserScreenCubit, UserScreenState>(
      listener: (context, state) {
        if (state is UserScreenLoadingState) {
        } else if (state is UserScreenSuccessState) {
          userScreenCubit.initializeUserData(state.userModelList!);
          // userName = "${userScreenCubit.userModelList.first.firstName ?? ""} ${userScreenCubit.userModelList.first.lastName ?? ""}";
          LoggerUtil.logs(
              "User Data Success ${userScreenCubit.userModelList.first.toJson()}");
        } else if (state is FetchEventsGoingToSuccessState) {
          userScreenCubit.initializeEventsGoingToResponseWrapperData(
              state.eventsGoingToResponseWrapper);
          // userName = "${userScreenCubit.userModelList.first.firstName ?? ""} ${userScreenCubit.userModelList.first.lastName ?? ""}";
          LoggerUtil.logs(
              "Event Going To Success ${userScreenCubit.eventsGoingToResponseWrapper.toJson()}");
          totalEventCountGoingTo = (userScreenCubit.eventsGoingToResponseWrapper
                  .data?.totalEventsCount?.upcomingEvents ??
              0) as int?;
          eventFilters = {
            "Upcoming": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.upcomingEvents ??
                []),
            "Paid": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.paidEvents ??
                []),
            "Past": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.pastEvents ??
                []),
            "Free": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.freeEvents ??
                []),
            "Pending": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.pendingEvents ??
                [])
          };
          for (var i = 0; i < (eventFilters ?? {}).keys.length; i++) {
            var key = eventFilters?.keys.elementAt(i);
            if (eventFilters?[key]?.isNotEmpty ?? false) {
              _selectedIndex = i;
              break; // Exit the loop once we've found the first non-empty category
            }
          }
          // _selectedIndex = 0;
          print("event filters ${eventFilters}");
          print("_selectedIndex ${_selectedIndex}");
          print(
              "event filters _selectedIndex initial ${eventFilters?.values.elementAt(_selectedIndex)}");
          setState(() {});
        } else if (state is FetchGroupsToSuccessState) {
          userScreenCubit.initializeEventsGoingToResponseWrapperData(
              state.eventsGoingToResponseWrapper);
          // userName = "${userScreenCubit.userModelList.first.firstName ?? ""} ${userScreenCubit.userModelList.first.lastName ?? ""}";
          LoggerUtil.logs(
              "Event Going To Success ${userScreenCubit.eventsGoingToResponseWrapper.toJson()}");
          totalEventCountGoingTo = (userScreenCubit.eventsGoingToResponseWrapper
                  .data?.totalEventsCount?.upcomingEvents ??
              0) as int?;
          eventFilters = {
            "Upcoming": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.upcomingEvents ??
                []),
            "Paid": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.paidEvents ??
                []),
            "Past": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.pastEvents ??
                []),
            "Free": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.freeEvents ??
                []),
            "Pending": (userScreenCubit
                    .eventsGoingToResponseWrapper.data?.pendingEvents ??
                [])
          };
          for (var i = 0; i < (eventFilters ?? {}).keys.length; i++) {
            var key = eventFilters?.keys.elementAt(i);
            if (eventFilters?[key]?.isNotEmpty ?? false) {
              _selectedIndex = i;
              break; // Exit the loop once we've found the first non-empty category
            }
          }
          // _selectedIndex = 0;
          print("event filters ${eventFilters}");
          print("_selectedIndex ${_selectedIndex}");
          print(
              "event filters _selectedIndex initial ${eventFilters?.values.elementAt(_selectedIndex)}");
          setState(() {});
        } else if (state is UpdateUserScreenSuccessState) {
          userModel = state.userModel;
          userName = "${userModel?.firstName} ${userModel?.lastName}";

          imagesUserInEvents = acceptedRequests?.map((e) => e.image).where((image) => image!= null).toList(); // Filter out null values.toList();

          // acceptedRequests = userScreenCubit.eventModel.eventRequest
          //     ?.where(
          //         (eventRequest) => eventRequest.requestStatus == "Accepted")
          //     .toList();
          // pendingRequests = viewYourEventCubit.eventModel.eventRequest
          //     ?.where((eventRequest) => eventRequest.requestStatus == "Pending")
          //     .toList();

          // imageUrl =  userModel?.userPhotos?.first ?? "";
        } else if (state is FetchMyEventsDataSuccessState) {
          print("Event Data Success ${state.eventResponseWrapper?.toJson()}");
          userScreenCubit.eventModelList.addAll(state.eventModel ?? []);
          userScreenCubit
              .initializeEventWrapperData(state.eventResponseWrapper!);
          print("Event Data Success ${userScreenCubit.eventModelList.length}");
          // imageUrl =  userModel?.userPhotos?.first ?? "";
        } else if (state is UserScreenFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is FetchEventsGoingToFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is FetchGroupsToFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is FetchMyEventsDataFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: topBar(),
            removeSafeAreaPadding: true,
            bgColor: ColorConstants.black,
            // bgImage:
            //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
            widget: main());
      },
    );
  }

  Widget main() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // topBar(),
          profile(),

          if (eventDetailList.isNotEmpty) DividerCosntants.divider1,
          // if (eventDetailList.isNotEmpty)
            yourEvents(),
          // if(eventList.isNotEmpty)
          DividerCosntants.divider1,
          // if(eventList.isNotEmpty)
          eventsGoingTo(),
          if (eventList.isNotEmpty) DividerCosntants.divider1,
          if (eventList.isNotEmpty) groups(),
        ],
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            StringConstants.account,
            style: FontStylesConstants.style28(color: themeCubit.primaryColor),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  NavigationUtil.push(context, RouteConstants.earningScreen);
                },
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: ColorConstants.iconBg,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // color: themeCubit.darkBackgroundColor,
                    ),
                    child: Row(
                      children: [
                        IconComponent(
                          svgDataCheck: false,
                          iconColor: ColorConstants.primaryColor,
                          svgData: AssetConstants.coins,
                          backgroundColor: ColorConstants.transparent,
                          iconSize: 100,
                          borderSize: 0,
                        ),
                        SizedBoxConstants.sizedBoxTenW(),
                        TextComponent(
                          StringConstants.earnings,
                          style: FontStylesConstants.style16(
                              color: ColorConstants.white),
                        ),
                      ],
                    )),
              ),
              SizedBoxConstants.sizedBoxTenW(),
              IconComponent(
                iconData: Icons.settings,
                svgDataCheck: false,
                // svgData: AssetConstants.applePay,
                // borderColor: Colors.red,
                backgroundColor: ColorConstants.iconBg,
                iconSize: 20,
                borderSize: 0,
                circleSize: 35,
                onTap: () {
                  NavigationUtil.push(context, RouteConstants.settingsScreen);
                },
                // circleHeight: 30,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () => NavigationUtil.push(
                    context, RouteConstants.editProfileScreen,
                    args: userModel),
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: (selectedImage != null
                          ? FileImage(selectedImage!)
                          : isEdit == true && imageUrl != null
                              ? NetworkImage(imageUrl ?? '')
                              : const AssetImage(AssetConstants.profileDummy))
                      as ImageProvider,
                ),
              ),
              Positioned(
                  right: 5,
                  bottom: 5,
                  child: GestureDetector(
                    onTap: () async {
                      NavigationUtil.push(
                          context, RouteConstants.editProfileScreen,
                          args: userModel);
                      // if (selectedImage == null) {
                      //   final XFile? image = await ImagePicker()
                      //       .pickImage(source: ImageSource.gallery);
                      //   if (image != null) {
                      //     setState(() {
                      //       selectedImage = File(image.path);
                      //     });
                      //   }
                      // } else {
                      //   setState(() {
                      //     selectedImage = null;
                      //   });
                      // }
                    },
                    child: IconComponent(
                      iconData: selectedImage == null
                          ? Icons.edit
                          : Icons.cancel_outlined,
                      svgDataCheck: false,
                      // svgData: AssetConstants.applePay,
                      // borderColor: Colors.red,
                      backgroundColor: ColorConstants.primaryColor,
                      iconColor: ColorConstants.black,
                      iconSize: 20,
                      borderSize: 0,
                      circleSize: 35,
                    ),
                  ))
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextComponent(
            userName,
            style: FontStylesConstants.style20(),
          ),
          SizedBoxConstants.sizedBoxSixtyH(),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //     style: FontStylesConstants.style20(
                //         color: themeCubit.primaryColor),
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: "${StringConstants.yourEvents}  ",
                //       ),
                //       TextSpan(
                //         text: "387",
                //         style: FontStylesConstants.style20(
                //             color: ColorConstants.lightGray.withOpacity(0.8)),
                //       ),
                //     ],
                //   ),
                // ),
                TextComponent(
                  "",
                  listOfText: [
                    StringConstants.connections,
                    " ${images.length}",
                  ],
                  listOfTextStyle: [
                    FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    FontStylesConstants.style20(
                      color: ColorConstants.lightGray.withOpacity(0.8),
                    )
                  ],
                ),
                if (images.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      NavigationUtil.push(
                          context, RouteConstants.allConnectionScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          "See all",
                          style: FontStylesConstants.style15(
                              color: ColorConstants.lightGray.withOpacity(0.8)),
                        ),
                        SizedBoxConstants.sizedBoxTenW(),
                        IconComponent(
                          iconData: Icons.arrow_forward_ios,
                          backgroundColor: ColorConstants.transparent,
                          borderColor: ColorConstants.transparent,
                          iconSize: 18,
                          borderSize: 0,
                          circleSize: 18,
                          iconColor: ColorConstants.lightGray,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          if (images.isNotEmpty)
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        child: ProfileImageComponent(
                          url: images[index].toString(),
                          size: 50,
                        ),
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }

  Widget yourEvents() {


    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RichText(
              //   textAlign: TextAlign.start,
              //   text: TextSpan(
              //     style: FontStylesConstants.style20(
              //         color: themeCubit.primaryColor),
              //     children: <TextSpan>[
              //       TextSpan(
              //         text: "${StringConstants.yourEvents}  ",
              //       ),
              //       TextSpan(
              //         text: "387",
              //         style: FontStylesConstants.style20(
              //             color: ColorConstants.lightGray.withOpacity(0.8)),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextComponent(
                  "",
                  listOfText: [
                    StringConstants.yourEvents,
                    " ${(userScreenCubit.eventModelList.length )?? 0}",
                  ],
                  listOfTextStyle: [
                    FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    FontStylesConstants.style20(
                      color: ColorConstants.lightGray.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigationUtil.push(context, RouteConstants.allEventScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      "See all",
                      style: FontStylesConstants.style15(
                          color: ColorConstants.lightGray.withOpacity(0.8)),
                    ),
                    SizedBoxConstants.sizedBoxTenW(),
                    IconComponent(
                      iconData: Icons.arrow_forward_ios,
                      backgroundColor: ColorConstants.transparent,
                      borderColor: ColorConstants.transparent,
                      iconSize: 18,
                      borderSize: 0,
                      circleSize: 18,
                      iconColor: ColorConstants.lightGray,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // ...eventDetailList.map(
                ...userScreenCubit.eventModelList.map(
                  (tag) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          NavigationUtil.push(
                              context, RouteConstants.viewYourEventScreen);
                        },
                        child: EventSummary(
                          eventId:tag.id?? "" ,
                          eventTitle: tag.title ?? "",//"Meet & Mingle in Riyadh Season",
                          price:tag.pricing?.price ?? "",// "SAR 150",
                          ticketsSold: int.parse(tag.transectionData?.ticketSold ??"0"),
                            totalEarned:tag.transectionData?.totalEarned ?? "",
                            remainingTickets: 0,//(((tag.venues?? []).first.capacity?? 0)-(tag.transectionData?.ticketSold?? 0)),
                            eventActive:tag.isVisibility,
                            currenStats: true,
                            capacity: tag.venues?.first.capacity ?? "",
                            imagesUserInEvent: imagesUserInEvents
                          // capacity: "Unlimited",
                          // remainingTickets: 96,
                          // eventActive: true,
                          // totalEarned: "",
                          // imagesUserInEvent: images,
                          // imagesUserInEvent: [
                          //   // Your list of ImageProvider objects
                          // ],
                        ),
                      )),
                  // Container(
                  //   width: AppConstants.responsiveWidth(context,
                  //       percentage: 80),
                  //   // padding: const EdgeInsets.only(
                  //   //     left: 12, right: 12, top: 5, bottom: 5),
                  //   decoration: BoxDecoration(
                  //     color: ColorConstants.darkBackgrounddColor,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     // color: themeCubit.darkBackgroundColor,
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             left: 15, right: 15, top: 10, bottom: 5),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             TextComponent(
                  //               "Meet & Mingle in Riyadh Season",
                  //               style: FontStylesConstants.style16(
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //             TextComponent(
                  //               "SAR 150",
                  //               style: FontStylesConstants.style16(),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       DividerCosntants.divider1,
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             top: 8.0, left: 15, right: 15, bottom: 8),
                  //         child: Row(
                  //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               flex: 2,
                  //               child: Column(
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                 children: [
                  //                   SizedBox(
                  //                     width: radius *
                  //                         imagesUserInEvent.length
                  //                             .toDouble(),
                  //                     // Calculate the total width of images
                  //                     height: radius,
                  //                     // Set the height to match the image size
                  //                     child: Stack(
                  //                       children: [
                  //                         for (int i = 0;
                  //                             i < imagesUserInEvent.length;
                  //                             i++)
                  //                           Positioned(
                  //                             left: i * radius / 1.5,
                  //                             // Adjust the left offset
                  //                             child: ClipOval(
                  //                               child: Image(
                  //                                 image:
                  //                                     imagesUserInEvent[i],
                  //                                 width: radius,
                  //                                 height: radius,
                  //                                 fit: BoxFit.cover,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   SizedBoxConstants.sizedBoxTenH(),
                  //                   TextComponent(
                  //                     "4 Tickets Sold ",
                  //                     style: FontStylesConstants
                  //                         .style16(
                  //                             color: ColorConstants.white),
                  //                   ),
                  //                   SizedBoxConstants.sizedBoxForthyH(),
                  //                   SizedBox(
                  //                     width: 150,
                  //                     height: 10,
                  //                     child: LinearProgressIndicator(
                  //                       value: 0.2,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(20)),
                  //                       backgroundColor: ColorConstants
                  //                           .lightGray
                  //                           .withOpacity(0.3),
                  //                       color: ColorConstants.primaryColor,
                  //                     ),
                  //                   ),
                  //                   SizedBoxConstants.sizedBoxSixH(),
                  //                   TextComponent(
                  //                     "96 Remaning ",
                  //                     style: FontStylesConstants.style16(
                  //                         color: ColorConstants.white),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             // SizedBoxConstants.sizedBoxSixtyW(),
                  //             Expanded(
                  //               child: Column(
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                 children: [
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.only(left: 3.0),
                  //                     child: TextComponent(
                  //                       "SAR 600 ",
                  //                       style: FontStylesConstants.style22(
                  //                           color: ColorConstants
                  //                               .primaryColor),
                  //                     ),
                  //                   ),
                  //                   SizedBoxConstants.sizedBoxSixH(),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.only(left: 3.0),
                  //                     child: TextComponent(
                  //                       StringConstants.earned,
                  //                       style: FontStylesConstants
                  //                           .style16(
                  //                               color:
                  //                                   ColorConstants.white),
                  //                     ),
                  //                   ),
                  //                   SizedBoxConstants.sizedBoxTwentyH(),
                  //                   Transform.scale(
                  //                     scale: 0.8,
                  //                     // Adjust the scale factor as needed
                  //                     child: Switch(
                  //                       value: eventActive,
                  //                       activeColor: ColorConstants.white,
                  //                       activeTrackColor:
                  //                           themeCubit.primaryColor,
                  //                       onChanged: (bool value) {
                  //                         setState(() {
                  //                           eventActive = value;
                  //                         });
                  //                       },
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.only(left: 6.0),
                  //                     child: TextComponent(
                  //                       StringConstants.visible,
                  //                       style: FontStylesConstants.style16(
                  //                           color: ColorConstants.white),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // )
                )
              ],
            ),
          ),
          // SizedBoxConstants.sizedBoxTwentyH(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ButtonComponent(
              buttonText: StringConstants.createANewEvent,
              bgcolor: ColorConstants.darkBackgrounddColor,
              textColor: ColorConstants.white,
              onPressed: () => {
                NavigationUtil.push(context, RouteConstants.createEventScreen)
              },
            ),
          )
        ],
      ),
    );
  }

  Widget eventsGoingTo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //     style: FontStylesConstants.style20(
                //         color: themeCubit.primaryColor),
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: "${StringConstants.yourEvents}  ",
                //       ),
                //       TextSpan(
                //         text: "387",
                //         style: FontStylesConstants.style20(
                //             color: ColorConstants.lightGray.withOpacity(0.8)),
                //       ),
                //     ],
                //   ),
                // ),
                TextComponent(
                  "",
                  listOfText: [
                    StringConstants.eventsYouGoingTo,
                    // " ${totalEventCountGoingTo}",
                  ],
                  listOfTextStyle: [
                    FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    // FontStylesConstants.style20(
                    //   color: ColorConstants.lightGray.withOpacity(0.8),
                    // )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    NavigationUtil.push(context, RouteConstants.allEventScreen,
                        args: AllEventsArg(
                            userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount,
                            eventFilters));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(
                        "See all",
                        style: FontStylesConstants.style15(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                      SizedBoxConstants.sizedBoxTenW(),
                      IconComponent(
                        iconData: Icons.arrow_forward_ios,
                        backgroundColor: ColorConstants.transparent,
                        borderColor: ColorConstants.transparent,
                        iconSize: 18,
                        borderSize: 0,
                        circleSize: 18,
                        iconColor: ColorConstants.lightGray,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          FilterComponent(
              options: [
                (((userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount?.upcomingEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Upcoming",
                        count: ((userScreenCubit.eventsGoingToResponseWrapper
                                .data?.totalEventsCount?.upcomingEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount?.paidEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Paid",
                        count: ((userScreenCubit.eventsGoingToResponseWrapper
                                .data?.totalEventsCount?.paidEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount?.pastEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Past",
                        count: ((userScreenCubit.eventsGoingToResponseWrapper
                                .data?.totalEventsCount?.pastEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount?.freeEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Free",
                        count: ((userScreenCubit.eventsGoingToResponseWrapper
                                .data?.totalEventsCount?.freeEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((userScreenCubit.eventsGoingToResponseWrapper.data
                                ?.totalEventsCount?.pendingEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Pending",
                        count: ((userScreenCubit.eventsGoingToResponseWrapper
                                .data?.totalEventsCount?.pendingEvents ??
                            0) as int))
                    : FilterComponentArg()
              ],
              groupValue:
                  _selectedIndex, // Your state variable for selected index
              onValueChanged: (int value) => {
                    setState(
                      () => _selectedIndex = value,
                    ),
                    print(
                        "event filters ${eventFilters?.values.elementAt(_selectedIndex)}"),
                    print("filters selectedIndex ${_selectedIndex}"),
                  }),
          SizedBoxConstants.sizedBoxTwentyH(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // This makes the list scrollable horizontally
            child: Row(
              children: [
                ...?eventFilters?.values
                    .elementAt(_selectedIndex)
                    .map((tag) => GestureDetector(
                          onTap: () {
                            NavigationUtil.push(
                                context, RouteConstants.eventScreen,
                                args: EventScreenArg(tag.id ?? "", ""));
                          },
                          child: EventCard(
                            totalCount: (tag.acceptedCount ?? 0) as int,
                            imageUrl: (tag.images ?? []).firstWhere(
                                (element) => (element ?? "").isNotEmpty,
                                orElse: () => ""),
                            images: (tag.eventRequest ?? [])
                                .take(3) // Take only the first three elements
                                .map((e) =>
                                    e.image ??
                                    "") // Transform each element to its image property, or "" if null
                                .toList(),
                            title: tag.title ?? "",
                            startTime: (tag.venue ?? []).first.startDatetime,
                            endTime: (tag.venue ?? []).first.endDatetime,
                            // startTime: (tag.venue ?? []).firstWhere((element) => element.startDatetime!= null && element.startDatetime.toString().isNotEmpty, orElse: () => "" ),
                            radius2: 20,
                            viewTicket: !(tag.isFree ?? false),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxSixtyH(),
        ],
      ),
    );
  }

  Widget groups() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //     style: FontStylesConstants.style20(
                //         color: themeCubit.primaryColor),
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: "${StringConstants.yourEvents}  ",
                //       ),
                //       TextSpan(
                //         text: "387",
                //         style: FontStylesConstants.style20(
                //             color: ColorConstants.lightGray.withOpacity(0.8)),
                //       ),
                //     ],
                //   ),
                // ),
                TextComponent(
                  "",
                  listOfText: [
                    StringConstants.groups,
                    " 387",
                  ],
                  listOfTextStyle: [
                    FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    FontStylesConstants.style20(
                      color: ColorConstants.lightGray.withOpacity(0.8),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    NavigationUtil.push(context, RouteConstants.allEventScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(
                        "See all",
                        style: FontStylesConstants.style15(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                      SizedBoxConstants.sizedBoxTenW(),
                      IconComponent(
                        iconData: Icons.arrow_forward_ios,
                        backgroundColor: ColorConstants.transparent,
                        borderColor: ColorConstants.transparent,
                        iconSize: 18,
                        borderSize: 0,
                        circleSize: 18,
                        iconColor: ColorConstants.lightGray,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
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
          SizedBoxConstants.sizedBoxTwentyH(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // This makes the list scrollable horizontally
            child: Row(
              children: [
                ...eventList
                    .map((tag) => GroupCard(
                          imageUrl: img,
                          images: images2,
                          name: tag['eventName'],
                        ))
                    .toList(),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxTwentyH(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonComponent(
                buttonText: StringConstants.createANewGroup,
                bgcolor: ColorConstants.darkBackgrounddColor,
                textColor: ColorConstants.white,
                onPressed: () => {}),
          ),
          Padding(
              padding:
                  EdgeInsets.only(bottom: AppConstants.bottomPadding(context))),
        ],
      ),
    );
  }
}
