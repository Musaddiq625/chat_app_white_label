import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/shareBottomSheetComponent.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/filter_screen/filter_screen.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components/button_component.dart';
import '../../constants/route_constants.dart';
import '../../models/contact.dart';
import '../../utils/navigation_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final List<String> images = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
    // Replace with your asset path
    // Add more image providers as needed
  ];

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
  int _currentPage = 0;
  int currentPageValue = 1;
  bool isApiCalled = false;
  late PageController _pageController;
  double radius = 30;
  late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  late final mainScreenCubit = BlocProvider.of<MainScreenCubit>(context);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await eventCubit.fetchEventDataByKeys(currentPageValue.toString());
    });
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_onPageChanged);
    // ..addListener(() {
    //   setState(() {
    //     _currentPage = _pageController.page!.round();
    //   });
    // });
    super.initState();
  }

  void _onPageChanged() {
    print(
        "Page changed to: ${_pageController.page!.round()}  currentPAgeValue ${currentPageValue}");
    int currentPage = _pageController.page!.round();
    if (currentPage == eventCubit.eventModelList.length - 1) {
      LoggerUtil.logs("Page is last-01");

      if (eventCubit.eventResponseWrapper.meta!.remainingCount! > 0) {
        if (isApiCalled == false) {
          currentPageValue++;
          eventCubit.fetchEventDataByKeys(currentPageValue.toString());
        }

        setState(() {
          isApiCalled = true;
        });
      }
    } else {
      setState(() {
        isApiCalled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCubit, EventState>(
      listener: (context, state) {
        if(state is EventFetchLoadingState){
          // LoadingDialog.showProgressLoadingDialog(context);
        }
        else if (state is EventFetchSuccessState) {
          // LoadingDialog.hideLoadingDialog(context);
          eventCubit.eventModelList.addAll(state.eventModel ?? []);
          // eventCubit.initializeEventData(state.eventModel ?? []);
          eventCubit.initializeEventWrapperData(state.eventModelWrapper!);
          LoggerUtil.logs("fetch data value ${state.eventModel?[0].toJson()}");
        } else if (state is EventFetchFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        print(
            "eventCubit.eventModelList.length ${eventCubit.eventModelList.length}");
        return Stack(
          children: [
            (eventCubit.eventModelList.isNotEmpty)?
            PageView.builder(
              controller: _pageController,
              itemCount: eventCubit.eventModelList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                // isLast = index == eventCubit.eventModelList.length - 1;
                return

                  Container(
                  width: AppConstants.responsiveWidth(context),
                  // color: ColorConstants.red,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        // "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                        eventCubit.eventModelList[index].images!.isNotEmpty
                            ? eventCubit.eventModelList[index].images!.first
                            : "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg"),
                    fit: BoxFit.cover,
                  )),
                  child: _eventWidget(index),
                );
              },
            ):
            Container(
              width: AppConstants.responsiveWidth(context),
              // color: ColorConstants.red,
              decoration: BoxDecoration(
                  color: Colors.black,

                  ),
              child: LoadingDialog.circularProgressLoader(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _topData(),
            ),
          ],
        );
      },
    );
  }

  Widget _topData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextComponent(StringConstants.locals,
            style: FontStylesConstants.style47()),
        const Spacer(),
        IconComponent(
          iconData: Icons.notifications,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
          onTap: () {
            mainScreenCubit.updateIndex(3);
            // NavigationUtil.push(context, RouteConstants.notificationScreen);
          },
        ),
        const SizedBox(width: 10),
        IconComponent(
          svgData: AssetConstants.filter,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
          onTap: () {
            BottomSheetComponent.showBottomSheet(
              context,
              takeFullHeightWhenPossible: true,
              isShowHeader: false,
              isScrollable: false,
              body: const FilterScreen(),
            );

            // NavigationUtil.push(context, RouteConstants.filterScreen);
          },
        ),
        const SizedBox(width: 10),
        IconComponent(
          iconData: Icons.search_rounded,
          borderColor: Colors.transparent,
          backgroundColor: ColorConstants.iconBg,
          iconColor: Colors.white,
          circleSize: 40,
        )
      ],
    );
  }

  Widget _eventWidget(int index) {
    print("eventCubit.eventModelList[index].eventTotalParticipants ${eventCubit.eventModelList[index].eventTotalParticipants}");
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // _topData(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // Align children vertically
                children: [
                  SizedBox(
                    width: radius * 3, //radius * images.length.toDouble(),
                    // Calculate the total width of images
                    height: radius,
                    // Set the height to match the image size
                    child: Stack(
                      children: [
                        // ?? images.length
                        for (int i = 0;
                            i <
                                (eventCubit.eventModelList[index]
                                        .eventParticipants!.isNotEmpty
                                    ? eventCubit.eventModelList[index]
                                        .eventParticipants!.length
                                    : images.length);
                            i++)
                          Positioned(
                            left: i * radius / 1.5,
                            // Adjust the left offset
                            child: ClipOval(
                                child: ImageComponent(
                              imgUrl: eventCubit.eventModelList[index]
                                      .eventParticipants!.isNotEmpty
                                  ? eventCubit.eventModelList[index]
                                      .eventParticipants![i].image!
                                  : images[i],
                              width: radius,
                              height: radius,
                              imgProviderCallback:
                                  (ImageProvider<Object> imgProvider) {},
                            )
                                // Image(
                                //   image: images[i],
                                //   width: radius,
                                //   height: radius,
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                          ),
                      ],
                    ),
                  ),
                  TextComponent(
                    "+${(eventCubit.eventModelList[index].eventTotalParticipants ?? 0 )} ${StringConstants.joined}",
                    style: FontStylesConstants.style14(
                        color: ColorConstants.white),
                  ),
                ],
              ),
              TextComponent(
                eventCubit.eventModelList[index].title ?? "",
                style: FontStylesConstants.style35(),
                maxLines: 2,

                // style: TextStyle(
                //     fontSize: 38,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //     fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 10,
              ),
              TextComponent(
                "",
                listOfText: [
                  DateFormat('d MMM \'at\' hh a').format(DateTime.tryParse(
                      (eventCubit.eventModelList[index].venues ?? [])
                              .first
                              .startDatetime ??
                          "") ?? DateTime.now()),
                  //    DateFormat('d MMM \'at\' hh a').format(DateTime.parse(eventCubit.eventModelList[index].venues?.first.endDatetime ?? "")),
                  "-",
                  DateFormat('d MMM \'at\' hh a').format(DateTime.tryParse(
                      (eventCubit.eventModelList[index].venues ?? [])
                              .first
                              .endDatetime ??
                          "")?? DateTime.now()),
                  "-",
                  eventCubit.eventModelList[index].venues?.first.location ??
                      "asdasddas"
                ],
                listOfTextStyle: [
                  FontStylesConstants.style14(color: ColorConstants.white),
                  FontStylesConstants.style14(color: ColorConstants.white),
                  FontStylesConstants.style14(color: ColorConstants.white),
                  FontStylesConstants.style14(color: ColorConstants.white),
                  FontStylesConstants.style14(color: ColorConstants.white),
                ],
                style: FontStylesConstants.style14(color: ColorConstants.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonComponent(
                      bgcolor: themeCubit.primaryColor,
                      textColor: themeCubit.backgroundColor,
                      buttonText: StringConstants.viewEvent,
                      isSmallBtn: true,
                      onPressed: () {
                        LoggerUtil.logs("eventCubit.eventModelList[index].isMyEvent ${eventCubit.eventModelList[index].toJson()}");
                        if(  eventCubit.eventModelList[index].isMyEvent == true){
                          NavigationUtil.push(context, RouteConstants.viewYourEventScreen,
                              args: eventCubit.eventModelList[index].id);
                        }
                        else{
                          NavigationUtil.push(context, RouteConstants.eventScreen,
                              args: EventScreenArg(eventCubit.eventModelList[index].id ?? "", index.toString()));
                        }

                      }),
                  const Spacer(),
                  IconComponent(
                    iconData: Icons.favorite,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: eventCubit.eventModelList[index].isFavourite == false || eventCubit.eventModelList[index].isFavourite == null?Colors.white: ColorConstants.red,
                    circleSize: 35,
                    iconSize: 20,
                    onTap: (){
                      if(eventCubit.eventModelList[index].isFavourite == false || eventCubit.eventModelList[index].isFavourite == null){
                        eventCubit.eventModelList[index] = eventCubit.eventModelList[index].copyWith(isFavourite: true);
                        eventCubit.sendEventFavById(eventCubit.eventModelList[index].id ?? "",true);
                      }
                      else{
                        eventCubit.eventModelList[index] = eventCubit.eventModelList[index].copyWith(isFavourite: false);
                        eventCubit.sendEventFavById(eventCubit.eventModelList[index].id ?? "",false);
                      }

                    },
                  ),
                  const SizedBox(width: 10),
                  IconComponent(
                      // iconData: Icons.share,
                      svgData: AssetConstants.share,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.iconBg,
                      iconColor: Colors.white,
                      circleSize: 35,
                      iconSize: 15,
                      onTap: () {
                        ShareBottomSheet.shareBottomSheet(
                            context, contacts, StringConstants.event);
                        // showShareBottomSheet(context,contacts);
                        // ShareBottomSheet(contacts: contacts,contextValue: context,);
                      }
                      // _shareEventBottomSheet
                      ),
                  const SizedBox(width: 10),
                  showMore(),
                  //    IconComponent(
                  //       svgData: AssetConstants.more,
                  //       borderColor: Colors.transparent,
                  //       backgroundColor: ColorConstants.iconBg,
                  //       iconColor: Colors.white,
                  //       circleSize: 35,
                  //       iconSize: 15,
                  //
                  //   ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // void showShareBottomSheet(BuildContext context, List<ContactModel> contacts) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ShareBottomSheet(contacts: contacts, contextValue: context);
  //     },
  //   );
  // }

  Widget showMore() {
    return PopupMenuButton(
      offset: const Offset(0, -140),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set the border radius
      ),
      color: ColorConstants.darkBackgrounddColor,
      key: ValueKey('key${Random().nextInt(1000)}'),
      icon: IconComponent(
        svgData: AssetConstants.more,
        borderColor: Colors.transparent,
        backgroundColor: ColorConstants.iconBg,
        iconColor: Colors.white,
        circleSize: 35,
        iconSize: 5,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(children: [
            IconComponent(
              iconData: Icons.bookmark,
              iconColor: ColorConstants.lightGray,
            ),
            SizedBoxConstants.sizedBoxSixW(),
            TextComponent(
              StringConstants.saveEvent,
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
              iconData: Icons.thumb_down,
              iconColor: ColorConstants.lightGray,
            ),
            SizedBoxConstants.sizedBoxSixW(),
            TextComponent(
              StringConstants.showLessLikeThis,
              style: FontStylesConstants.style14(color: ColorConstants.white),
            ),
          ]),
          value: 'remove_connection',
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
              iconData: Icons.remove_circle_sharp,
              iconColor: ColorConstants.red,
            ),
            SizedBoxConstants.sizedBoxSixW(),
            TextComponent(
              StringConstants.reportEvent,
              style: FontStylesConstants.style14(color: ColorConstants.red),
            ),
          ]),
          value: 'remove_connection',
        ),
      ],
      // onSelected: onMenuItemSelected,
      onSelected: (value) {
        if (value == 'share') {
          // Handle share action
        } else if (value == 'something_else') {
          // Handle something else action
        }
        // Add more conditions as needed
      },
    );
  }

// _showMoreBottomSheet() {
//   BottomSheetComponent.showBottomSheet(context,
//       takeFullHeightWhenPossible: false,
//       bgColor: themeCubit.darkBackgroundColor,
//       isShowHeader: false,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconComponent(
//                     iconData: Icons.share,
//                     borderColor: Colors.transparent,
//                     backgroundColor: ColorConstants.iconBg,
//                     iconColor: themeCubit.primaryColor,
//                     circleSize: 35,
//                     iconSize: 20,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   TextComponent(
//                     StringConstants.saveEvent,
//                     style: FontStylesConstants.style14(
//                         color: ColorConstants.white,
//                         fontWeight: FontWeight.bold),
//                     // style: TextStyle(
//                     //     fontWeight: FontWeight.bold,
//                     //     fontSize: 14,
//                     //     color: themeCubit.textColor)
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(
//               thickness: 0.2,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconComponent(
//                     iconData: Icons.thumb_down,
//                     borderColor: Colors.transparent,
//                     backgroundColor: ColorConstants.iconBg,
//                     iconColor: themeCubit.primaryColor,
//                     circleSize: 35,
//                     iconSize: 20,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   TextComponent(StringConstants.showLessLikeThis,
//                       style: FontStylesConstants.style14(
//                           color: ColorConstants.white,
//                           fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             const Divider(
//               thickness: 0.2,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 35, top: 8, bottom: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconComponent(
//                     iconData: Icons.remove_circle,
//                     borderColor: Colors.transparent,
//                     backgroundColor: ColorConstants.iconBg,
//                     iconColor: Colors.red,
//                     circleSize: 35,
//                     iconSize: 20,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   TextComponent(
//                     StringConstants.reportEvent,
//                     style: FontStylesConstants.style14(
//                         color: ColorConstants.red,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ));
// }
//
// _shareEventBottomSheet() {
//   BottomSheetComponent.showBottomSheet(context,
//       bgColor: themeCubit.darkBackgroundColor,
//       takeFullHeightWhenPossible: false,
//       isShowHeader: false,
//       body: Container(
//         constraints: const BoxConstraints(maxHeight: 600),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
//                   child: TextComponent(
//                     StringConstants.shareEvent,
//                     style: FontStylesConstants.style18(
//                         color: themeCubit.primaryColor),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 20.0),
//                     child: IconComponent(
//                       iconData: Icons.close,
//                       borderColor: Colors.transparent,
//                       iconColor: themeCubit.textColor,
//                       circleSize: 50,
//                       backgroundColor: Colors.transparent,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconComponent(
//                   // iconData: Icons.link,
//                   svgData: AssetConstants.copyLink,
//                   borderColor: Colors.transparent,
//                   backgroundColor: themeCubit.primaryColor,
//                   iconColor: ColorConstants.black,
//                   circleSize: 60,
//                   customText: StringConstants.copyLink,
//                   customTextColor: themeCubit.textColor,
//                 ),
//                 IconComponent(
//                   iconData: Icons.facebook,
//                   borderColor: Colors.transparent,
//                   backgroundColor: ColorConstants.blue,
//                   circleSize: 60,
//                   iconSize: 30,
//                   customText: StringConstants.facebook,
//                   customTextColor: themeCubit.textColor,
//                 ),
//                 Column(
//                   children: [
//                     ImageComponent(
//                       height: 60,
//                       width: 60,
//                       imgUrl: AssetConstants.instagram,
//                       imgProviderCallback: (imageProvider) {},
//                     ),
//                     SizedBoxConstants.sizedBoxTenH(),
//                     TextComponent(
//                       StringConstants.instagram,
//                       style: FontStylesConstants.style12(
//                           color: ColorConstants.white),
//                     )
//                   ],
//                 ),
//                 // IconComponent(
//                 //   svgDataCheck: true,
//                 //   svgData: AssetConstants.instagram,
//                 //   backgroundColor: Colors.transparent,
//                 //   borderColor: Colors.transparent,
//                 //   circleSize: 60,
//                 //   customText: StringConstants.instagram,
//                 //   customTextColor: themeCubit.textColor,
//                 //   iconSize: 60,
//                 // ),
//                 IconComponent(
//                   svgData: AssetConstants.share,
//                   iconColor: ColorConstants.black,
//                   borderColor: Colors.transparent,
//                   // backgroundColor:ColorConstants.transparent,
//                   circleSize: 60,
//                   customText: StringConstants.share,
//                   customTextColor: themeCubit.textColor,
//                 )
//               ],
//             ),
//             SizedBoxConstants.sizedBoxTenH(),
//             const Divider(
//               thickness: 0.1,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 16),
//               child: TextComponent(StringConstants.yourConnections,
//                   style: FontStylesConstants.style18(
//                       color: themeCubit.primaryColor)),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: contacts.length,
//                 itemBuilder: (ctx, index) {
//                   bool isLast = index == contacts!.length - 1;
//                   return ContactCard(
//                     showDivider: (!isLast),
//                     name: contacts[index].name,
//                     title: contacts[index].title,
//                     url: contacts[index].url,
//                     // contact: contacts[index],
//                     onShareTap: () {
//                       Navigator.pop(context);
//                       _shareWithConnectionBottomSheet(
//                           StringConstants.fireWorks, contacts[index].name);
//                     },
//                     onProfileTap: () {
//                       NavigationUtil.push(
//                           context, RouteConstants.profileScreenLocal);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ));
// }
//
// _shareWithConnectionBottomSheet(String eventName, String userName) {
//   BottomSheetComponent.showBottomSheet(context,
//       bgColor: themeCubit.darkBackgroundColor,
//       takeFullHeightWhenPossible: false,
//       isShowHeader: false,
//       body: Column(
//         children: [
//           const SizedBox(height: 25),
//           const ProfileImageComponent(url: ''),
//           const SizedBox(height: 20),
//           RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               style: FontStylesConstants.style20(),
//               // style: TextStyle(
//               //     fontSize: 20,
//               //     fontFamily: FontConstants.fontProtestStrike,
//               //     height: 1.5),
//               children: <TextSpan>[
//                 TextSpan(text: StringConstants.areYouSureYouwantToShare),
//                 TextSpan(
//                   text: eventName,
//                   style: TextStyle(color: themeCubit.primaryColor),
//                 ),
//                 TextSpan(text: " with \n"),
//                 TextSpan(
//                   text: "$userName?",
//                   style: TextStyle(color: themeCubit.primaryColor),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                   onTap: () => {
//                         Navigator.pop(context),
//                         _shareEventBottomSheet(),
//                       },
//                   child: TextComponent(
//                     StringConstants.goBack,
//                     style: TextStyle(color: themeCubit.textColor),
//                   )),
//               const SizedBox(width: 30),
//               ButtonComponent(
//                 bgcolor: themeCubit.primaryColor,
//                 isSmallBtn: true,
//                 textColor: themeCubit.backgroundColor,
//                 buttonText: StringConstants.yesShareIt,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   _yesShareItBottomSheet();
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//         ],
//       ));
// }
//
// _yesShareItBottomSheet() {
//   _navigateToBack();
//   BottomSheetComponent.showBottomSheet(
//     context,
//     isShowHeader: false,
//     body: InfoSheetComponent(
//       heading: StringConstants.eventShared,
//       image: AssetConstants.garland,
//     ),
//   );
// }
//
// _navigateToBack() async {
//   Future.delayed(const Duration(milliseconds: 1800), () async {
//     NavigationUtil.pop(context);
//   });
// }
}
