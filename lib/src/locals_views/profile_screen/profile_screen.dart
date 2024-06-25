import 'dart:math';

import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/event_card.dart';
import 'package:chat_app_white_label/src/components/group_card.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/shareBottomSheetComponent.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/back_button_component.dart';
import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/info_sheet_component.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../models/contact.dart';
import '../../utils/navigation_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';
import 'cubit/view_user_screen_cubit.dart';

class ProfileScreen extends StatefulWidget {
  String userId;

  ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late ViewUserScreenCubit viewUserScreenCubit =
      BlocProvider.of<ViewUserScreenCubit>(context);
  bool connectSend = false;
  int _currentPage = 0;
  String? isFriendValue;
  late PageController _pageController;
  final List<String> images = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
  ];
  double radius = 22;

  double radius2 = 20;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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

  List<Map<String, dynamic>> tagLists = [];

  List<Map<String, dynamic>> tagList = [
    {
      'iconData': Icons.favorite,
      'name': "Women",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "Active",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Dog(s)",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Regularly",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Socially",
    },
    {
      'iconData': Icons.height,
      'name': "5'7(170cm)",
    },
    // Add more tag data items as required
  ];

  List<Map<String, dynamic>> interestTagList = [
    {
      'iconData': Icons.favorite,
      'name': "Cinema",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "City Event",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Foods & restaurants",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Networking",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Workout",
    },
    {
      'iconData': Icons.height,
      'name': "Dancing",
    },
    // Add more tag data items as required
  ];

  List<Map<String, dynamic>> eventList = [
    {
      'joined': "+1456",
      'eventName': "Property networking event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1226",
      'eventName': "Drum Code London",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1134",
      'eventName': "Property test event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
    {
      'joined': "+1146",
      'eventName': "Networking event",
      'dateTime': "17Feb. 11AM - 2PM"
    },
  ];

  List<InterestData>? interestData = [];
  List<InterestData>? hobbiesData = [];
  List<InterestData>? creativityData = [];
  int? age;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    viewUserScreenCubit.fetchUserData(widget.userId);
    viewUserScreenCubit.fetchEventGroupData(widget.userId);

    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
  }

  @override
  void dispose() {
    viewUserScreenCubit.userModelList.clear();
    _pageController.dispose();
    super.dispose();
  }

  _yesShareItBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.requestSend +
            " ${userModel?.firstName ?? ""} ${userModel?.lastName ?? ""}",
        body: StringConstants.connectSendBody,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return MainScaffold(
    //   // bgImage: "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
    //   // removeSafeAreaPadding: false,
    //   // removeBgImage: false,
    //   bgImage: true,
    //   overrideBackgroundImage: "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
    //   body: _profileWidget(),
    // );
    return BlocConsumer<ViewUserScreenCubit, ViewUserScreenState>(
      listener: (context, state) {
        if (state is ViewUserScreenLoadingState) {
        }
        else if (state is ViewUserScreenSuccessState) {
          viewUserScreenCubit.initializeUserData(state.userModelList!);
          userModel = viewUserScreenCubit.userModelList.first;
          // isFriendValue = viewUserScreenCubit.userModelList.first.isFriend;
          isFriendValue = userModel?.isFriend;
          if (isFriendValue == "Pending") {
            setState(() {
              connectSend = true;
            });
          }
          // hobbiesData = viewUserScreenCubit.userModelList.first.interest?.hobbies;
          hobbiesData = userModel?.interest?.hobbies;
          creativityData =
              viewUserScreenCubit.userModelList.first.interest?.creativity;
          creativityData = userModel?.interest?.creativity;
          interestData?.addAll(hobbiesData ?? []);
          interestData?.addAll(creativityData ?? []);
          tagLists = [
            if ((userModel?.moreAbout?.diet ?? "").isNotEmpty &&
                userModel?.moreAbout?.diet != null)
              {
                'iconData': AssetConstants.diet,
                'name': userModel?.moreAbout?.diet,
              },
            if ((userModel?.moreAbout?.workout ?? "").isNotEmpty &&
                userModel?.moreAbout?.workout != null)
              {
                'iconData': AssetConstants.workout,
                'name': userModel?.moreAbout?.workout,
              },
            if ((userModel?.moreAbout?.height ?? "").isNotEmpty &&
                userModel?.moreAbout?.height != null)
              {
                'iconData': AssetConstants.height,
                'name': userModel?.moreAbout?.height,
              },
            if ((userModel?.moreAbout?.smoking ?? "").isNotEmpty &&
                userModel?.moreAbout?.smoking != null)
              {
                'iconData': AssetConstants.smoking,
                'name': userModel?.moreAbout?.smoking,
              },
            if ((userModel?.moreAbout?.drinking ?? "").isNotEmpty &&
                userModel?.moreAbout?.drinking != null)
              {
                'iconData': AssetConstants.drinking,
                'name': userModel?.moreAbout?.drinking,
              },
            if ((userModel?.moreAbout?.pets ?? "").isNotEmpty &&
                userModel?.moreAbout?.pets != null)
              {
                'iconData': AssetConstants.pets,
                'name': userModel?.moreAbout?.pets,
              },
          ];
          String dateString =
              userModel?.dateOfBirth ?? DateTime.now().toString();
          DateTime selectedDate;
          try {
            selectedDate =
                DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dateString!);
            // DateTime birthDate = DateTime.parse(selectedDate);
          } catch (_) {
            selectedDate = DateFormat("dd MM yyyy").parse(dateString);
            // DateTime birthDate = DateTime.parse(selectedDate);
          }
          DateTime currentDate = DateTime.now();
          age = currentDate.year - selectedDate.year;
        }
        else if (state is ViewUserScreenFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is ViewUserEventGroupLoadingState) {
        } else if (state is ViewUserEventGroupSuccessState) {
          // viewUserScreenCubit.userModelList.clear();
          viewUserScreenCubit
              .initializeUserEventGroupData(state.userEventGroupWrapper);
          LoggerUtil.logs(
              "viewUserScreenCubit ${viewUserScreenCubit.eventGroupWrapper.data?.toJson()}");
        } else if (state is ViewUserEventGroupFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
          removeSafeAreaPadding: false,
          bgColor: ColorConstants.backgroundColor,
          widget: SingleChildScrollView(
              child: Container(
            color: themeCubit.backgroundColor,
            child: Column(
              children: [
                _profileWidget(),
                SizedBoxConstants.sizedBoxTenH(),
                if ((viewUserScreenCubit.userModelList).isNotEmpty) _aboutMe(),
                SizedBoxConstants.sizedBoxTenH(),
                _myInterest(),
                SizedBoxConstants.sizedBoxTenH(),
                _event(),
                SizedBoxConstants.sizedBoxTenH(),
                _clubs(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
          floatingActionButton: ((userModel?.firstName ?? "").isNotEmpty)
              ? isFriendValue != "Accepted"
                  ? connectSend
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ButtonComponent(
                            bgcolor: themeCubit.primaryColor,
                            buttonText: StringConstants.connectSent,
                            textColor: themeCubit.backgroundColor,
                            onPressed: () {
                              _yesShareItBottomSheet();
                              // NavigationUtil.push(
                              //     context, RouteConstants.localsEventScreen);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ButtonComponent(
                            bgcolor: themeCubit.primaryColor,
                            buttonText: StringConstants.connect,
                            textColor: themeCubit.backgroundColor,
                            onPressed: () {
                              viewUserScreenCubit.sendFriendRequest(
                                  userModel!.id!, "request_sent");
                              setState(() {
                                connectSend = true;
                              });
                              // NavigationUtil.push(
                              //     context, RouteConstants.localsEventScreen);
                            },
                          ),
                        )
                  : Container()
              : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _profileWidget() {
    return Column(
      children: [
        // Use a Container with a specific height or Flexible with FlexFit.loose
        // Here, I'm using a Container with a specific height as an example
        Container(
          height: AppConstants.responsiveHeight(context,
              percentage: 98), // Adjust this value as needed
          child: Stack(
            children: [
              if((viewUserScreenCubit.userModelList).isNotEmpty)
                   Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: viewUserScreenCubit
                                .userModelList.first.userPhotos?.length,
                            itemBuilder: (context, index) {
                              final file = viewUserScreenCubit
                                  .userModelList.first.userPhotos?[index];
                              return Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      file ?? "",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              // AppBarComponent(""),
              if ((viewUserScreenCubit.userModelList).isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: InkWell(
                    onTap: () => NavigationUtil.pop(context),
                    child: BackButtonComponent(
                        bgColor: ColorConstants.iconBg,
                        image: AssetConstants.backArrow,
                        //! pass your asset here
                        enableDark: false,
                        isImage: true,
                        isCircular: true,
                        onTap: () {
                          NavigationUtil.pop(context);
                        }),
                  ),
                ),
               ((viewUserScreenCubit.userModelList).isNotEmpty)?_infoWidget():_ShimmerInfoWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Carousel indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                (viewUserScreenCubit.userModelList.first.userPhotos ?? [])
                    .length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 4,
                width: 15,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            }),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                " ${viewUserScreenCubit.userModelList.first.firstName ?? ""} ${viewUserScreenCubit.userModelList.first.lastName ?? ""}",
                style: FontStylesConstants.style38(color: ColorConstants.white),
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.business_center_rounded,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    viewUserScreenCubit.userModelList.first.aboutMe ?? "",
                    //"Founder, WeUno",
                    style: FontStylesConstants.style16(),
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.cake,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "$age yo",
                    style: FontStylesConstants.style16(),
                  ),
                  SizedBoxConstants.sizedBoxTwentyW(),
                  const Icon(
                    Icons.location_on_sharp,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "Manchester",
                    style: FontStylesConstants.style16(),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.tag_faces_rounded,
                    color: ColorConstants.lightGray,
                    size: 14,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  TextComponent(
                    "2 mutual, connections",
                    style: FontStylesConstants.style16(),
                  ),
                  SizedBoxConstants.sizedBoxEightW(),
                  SizedBox(
                    width: radius * images.length.toDouble(),
                    // Calculate the total width of images
                    height: radius,
                    // Set the height to match the image size
                    child: Stack(
                      children: [
                        for (int i = 0; i < images.length; i++)
                          Positioned(
                            left: i * radius / 1.5,
                            // Adjust the left offset
                            child: ClipOval(
                                child: ImageComponent(
                              imgUrl: images[i],
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
                  const SizedBox(width: 10),
                  IconComponent(
                    svgData: AssetConstants.share,
                    // iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 33,
                    iconSize: 13,
                    onTap: () {
                      ShareBottomSheet.shareBottomSheet(
                          context, "", "", [], StringConstants.profile);
                    },
                  ),
                  showMore(),
                ],
              ),
              SizedBoxConstants.sizedBoxHundredH(),
            ],
          )
        ],
      ),
    );
  }

  Widget _ShimmerInfoWidget() {
    return Shimmer.fromColors(
        baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
      child:
      Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Carousel indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                (viewUserScreenCubit.userModelList ??[])
                    .length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 4,
                width: 15,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            }),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 10,
                color: ColorConstants.white,
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.business_center_rounded,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  Container(
                    width: 80,
                    height: 10,
                    color: ColorConstants.white,
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Row(
                children: [
                  const Icon(
                    Icons.cake,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  Container(
                    width: 50,
                    height: 10,
                    color: ColorConstants.white,
                  ),
                  SizedBoxConstants.sizedBoxTwentyW(),
                  const Icon(
                    Icons.location_on_sharp,
                    color: ColorConstants.lightGray,
                    size: 15,
                  ),
                  SizedBoxConstants.sizedBoxFourW(),
                  Container(
                    width: 150,
                    height: 10,
                    color: ColorConstants.white,
                  ),
                ],
              ),
              Row(
                children: [

                  IconComponent(
                    svgData: AssetConstants.share,
                    // iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.white,
                    circleSize: 33,
                    iconSize: 13,
                    onTap: () {
                      ShareBottomSheet.shareBottomSheet(
                          context, "", "", [], StringConstants.profile);
                    },
                  ),
                  showMore(),
                ],
              ),
              SizedBoxConstants.sizedBoxHundredH(),
            ],
          )
        ],
      ),
    ));
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
        backgroundColor: ColorConstants.iconBg,
        iconColor: Colors.white,
        circleSize: 33,
        iconSize: 5,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          height: 0,
          child: Row(children: [
            IconComponent(
              iconData: Icons.block,
              iconColor: ColorConstants.red,
            ),
            SizedBoxConstants.sizedBoxSixW(),
            TextComponent(
              StringConstants.block,
              style: FontStylesConstants.style14(color: ColorConstants.red),
            ),
          ]),
          value: 'block',
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
              StringConstants.report,
              style: FontStylesConstants.style14(color: ColorConstants.red),
            ),
          ]),
          value: 'report',
        ),
      ],
      // onSelected: onMenuItemSelected,
      onSelected: (value) {
        if (value == 'block') {
          _showBlockBottomSheet();
        } else if (value == 'report') {
          _showReportBottomSheet();
        }
        // Add more conditions as needed
      },
    );
  }

  _showBlockBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: CommonBottomSheetComponent(
          title: "Block Alyna",
          description: StringConstants.blockDetail,
          image: AssetConstants.warning,
          isImageAsset: true,
          btnColor: ColorConstants.red,
          btnTextColor: ColorConstants.white,
          btnText: StringConstants.block,
          size14Disc: true,
          onBtnTap: () {},
        ));
  }

  _showReportBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: CommonBottomSheetComponent(
          title: "Report Alyna",
          description: StringConstants.reportDetail,
          image: AssetConstants.warning,
          isImageAsset: true,
          btnColor: ColorConstants.red,
          btnTextColor: ColorConstants.white,
          btnText: StringConstants.report,
          size14Disc: true,
          onBtnTap: () {},
        ));
  }

  Widget _aboutMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: AppConstants.responsiveWidth(context),
        child: Card(
          color: themeCubit.darkBackgroundColor,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextComponent(
                      StringConstants.aboutMe,
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor),
                    )),
                SizedBoxConstants.sizedBoxTenH(),
                TextComponent(
                  viewUserScreenCubit.userModelList.first.bio ?? "",
                  // "New to the city, keen to explore with new minded people and build my own network",
                  style:
                      FontStylesConstants.style14(color: ColorConstants.white),
                  maxLines: 6,
                ),
                SizedBoxConstants.sizedBoxTenH(),
                Wrap(
                  // spacing: , // Adjust the spacing between items
                  runSpacing: 8,
                  children: [
                    IconComponent(
                      iconData: Icons.facebook,
                      borderColor: Colors.transparent,
                      backgroundColor: ColorConstants.blue,
                      circleSize: 30,
                    ),
                    SizedBoxConstants.sizedBoxTenW(),
                    ImageComponent(
                      height: 30,
                      width: 30,
                      imgUrl: AssetConstants.instagram,
                      imgProviderCallback: (imageProvider) {},
                    ),
                    // IconComponent(
                    //   // iconData: Icons.facebook,
                    //   svgDataCheck: false,
                    //   svgData: AssetConstants.instagramNoSVg,
                    //   // borderColor: Colors.red,
                    //   backgroundColor: ColorConstants.transparent,
                    //   iconSize: 100,
                    //   borderSize: 0,
                    //   // circleSize: 30,
                    //   // circleHeight: 30,
                    // ),

                    // Row(// Space between items
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.diet != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.diet,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.diet ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //     SizedBoxConstants.sizedBoxTenW(),
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.workout != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.workout,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.workout ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //     SizedBoxConstants.sizedBoxTenW(),
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.height != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.height,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.height ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //     SizedBoxConstants.sizedBoxTenW(),
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.smoking != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.smoking,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.smoking ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //     SizedBoxConstants.sizedBoxTenW(),
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.drinking != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.drinking,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.drinking ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //     SizedBoxConstants.sizedBoxTenW(),
                    //     if((viewUserScreenCubit.userModelList.first.moreAbout?.diet?? "").isNotEmpty && viewUserScreenCubit.userModelList.first.moreAbout?.pets != null)
                    //       TagComponent(
                    //         iconData: AssetConstants.pets,
                    //         customTextColor: themeCubit.textColor,
                    //         backgroundColor:
                    //         ColorConstants.lightGray.withOpacity(0.3),
                    //         iconColor: themeCubit.primaryColor,
                    //         customIconText: viewUserScreenCubit.userModelList.first.moreAbout?.pets ?? "",
                    //         circleHeight: 35,
                    //         iconSize: 20,
                    //       ),
                    //   ],
                    // )

                    SizedBoxConstants.sizedBoxTenW(),
                    ...(tagLists)
                        .map((tag) =>
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, right: 5, left: 5),
                                child: TagComponent(
                                  iconData: tag['iconData'],
                                  customTextColor: themeCubit.textColor,
                                  backgroundColor:
                                      ColorConstants.lightGray.withOpacity(0.3),
                                  iconColor: themeCubit.primaryColor,
                                  customIconText: tag['name'],
                                  circleHeight: 35,
                                  iconSize: 20,
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenW(),
                            ]))
                        .toList(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myInterest() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextComponent(
                      StringConstants.myInterests,
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor),
                    )),
                SizedBoxConstants.sizedBoxTenH(),
                Wrap(
                  children: [
                    ...?interestData
                        ?.map((tag) =>
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: TagComponent(
                                  iconData: tag.icon,
                                  customTextColor: themeCubit.textColor,
                                  backgroundColor:
                                      ColorConstants.lightGray.withOpacity(0.3),
                                  iconColor: themeCubit.primaryColor,
                                  customIconText: tag.value,
                                  circleHeight: 35,
                                  iconSize: 20,
                                ),
                              ),
                              SizedBoxConstants.sizedBoxTenW(),
                            ]))
                        .toList(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _event() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: FontStylesConstants.style20(
                        color: themeCubit.primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${StringConstants.events}  ",
                      ),
                      TextSpan(
                        text:
                            "${viewUserScreenCubit.eventGroupWrapper.data?.totalCounts?.eventsCount ?? 0}",
                        style: FontStylesConstants.style20(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                NavigationUtil.push(context, RouteConstants.userAllEvents,
                    args: widget.userId);
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(
                        "See all",
                        style: FontStylesConstants.style15(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                      IconComponent(
                        iconData: Icons.arrow_forward_ios,
                        backgroundColor: ColorConstants.transparent,
                        borderColor: ColorConstants.transparent,
                        iconSize: 18,
                        borderSize: 0,
                        circleSize: 20,
                        iconColor: ColorConstants.lightGray,
                      )
                    ],
                  )),
            ),
          ],
        ),
        SizedBoxConstants.sizedBoxTenH(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // This makes the list scrollable horizontally
          child: Row(
            children: [
              ...?viewUserScreenCubit.eventGroupWrapper.data?.events
                  ?.map(((tag) => GestureDetector(
                        onTap: () {
                          LoggerUtil.logs("tap--- ${tag.toJson()}");
                          if (tag.isMyEvent == true) {
                            NavigationUtil.push(
                                context, RouteConstants.viewYourEventScreen,
                                args: tag.id ?? "");
                          } else {
                            NavigationUtil.push(
                                context, RouteConstants.eventScreen,
                                args: EventScreenArg(tag.id ?? "", ""));
                          }
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
                      )))
                  .toList(),
            ],
          ),
        )
      ],
    );
  }

  Widget _clubs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: FontStylesConstants.style20(
                      color: themeCubit.primaryColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${StringConstants.groups}  ",
                      ),
                      TextSpan(
                        text:
                            "${viewUserScreenCubit.eventGroupWrapper.data?.totalCounts?.groupsCount ?? 0}",
                        style: FontStylesConstants.style20(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                NavigationUtil.push(context, RouteConstants.userAllGroups,
                    args: widget.userId);
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    children: [
                      TextComponent(
                        "See all",
                        style: FontStylesConstants.style15(
                            color: ColorConstants.lightGray.withOpacity(0.8)),
                      ),
                      IconComponent(
                        iconData: Icons.arrow_forward_ios,
                        backgroundColor: ColorConstants.transparent,
                        borderColor: ColorConstants.transparent,
                        iconSize: 18,
                        borderSize: 0,
                        circleSize: 20,
                        iconColor: ColorConstants.lightGray,
                      )
                    ],
                  )),
            ),
          ],
        ),
        SizedBoxConstants.sizedBoxTenH(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // This makes the list scrollable horizontally
          child: Row(
            children: [
              ...?viewUserScreenCubit.eventGroupWrapper.data?.groups
                  ?.map(
                    (tag) => GestureDetector(
                        onTap: () {
                          if (tag.isMyEvent == false) {
                            NavigationUtil.push(
                                context, RouteConstants.viewGroupScreen,
                                args: ViewGroupArg(tag.id ?? "", false, false));
                          } else {
                            NavigationUtil.push(
                                context, RouteConstants.viewYourGroupScreen,
                                args: tag.id ?? "");
                          }
                        },
                        child: GroupCard(
                          imageUrl: (tag.images ?? []).firstWhere(
                              (element) => (element ?? "").isNotEmpty,
                              orElse: () => ""),
                          images: [],
                          name: tag.title ?? "",
                          membersCount: tag.members.toString(),
                        )),
                  )
                  .toList(),
            ],
          ),
        )
      ],
    );
  }
}
