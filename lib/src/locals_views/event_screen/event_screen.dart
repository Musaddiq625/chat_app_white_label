import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/about_event_component.dart';
import 'package:chat_app_white_label/src/components/common_bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/joinBottomSheetComponent.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/shareBottomSheetComponent.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/payment_success_screen.dart';
import 'package:chat_app_white_label/src/locals_views/main_screen/cubit/main_screen_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/ticket_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../components/circle_button_component.dart';
import '../../components/icon_component.dart';
import '../../components/icons_button_component.dart';
import '../../components/info_sheet_component.dart';
import '../../components/profile_image_component.dart';
import '../../components/toast_component.dart';
import '../../constants/color_constants.dart';
import '../../models/contact.dart';
import '../on_boarding/cubit/onboarding_cubit.dart';

class EventScreen extends StatefulWidget {
  String? eventId;
  EventScreenArg? eventScreenArg;
  String? userId;
  String? userName;
  String? userImage;
  String? userAboutMe;

  EventScreen(
      {super.key,
      this.eventId,
      this.eventScreenArg,
      this.userId,
      this.userName,
      this.userImage,
      this.userAboutMe});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

final String _fullText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
bool _showFullText = false;
bool ticketRequired = true;
final TextEditingController _controller = TextEditingController();

class _EventScreenState extends State<EventScreen> {
  List<EventRequest>? acceptedRequests;
  EventRequest? yourEventRequest;
  bool alreadyJoin = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
  final List<ContactModel> contacts = [
    // ContactModel('Jesse Ebert', 'Graphic Designer', "", "00112233455"),
    // ContactModel('Albert Ebert', 'Manager', "", "45612378123"),
    // ContactModel('Json Ebert', 'Tester', "", "03323333333"),
    // ContactModel('Mack', 'Intern', "", "03312233445"),
    // ContactModel('Julia', 'Developer', "", "88552233644"),
    // ContactModel('Rose', 'Human Resource', "", "55366114532"),
    // ContactModel('Frank', 'xyz', "", "25651412344"),
    // ContactModel('Taylor', 'Test', "", "5511772266"),
  ];
  final List<String> images = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
    // Replace with your asset path
    // Add more image providers as needed
  ];
  double radius = 30;
  String? userId;
  int _count = 0;
  int _price = 0;
  int _totalAmount = 0;
  final _debouncer = Debouncer(milliseconds: 1000);
  late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  late final mainScreenCubit = BlocProvider.of<MainScreenCubit>(context);
  UserModel? userModel;
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      eventCubit.eventModel = EventModel();
      await eventCubit.fetchEventDataById(widget.eventScreenArg?.eventId ?? "");
      userScreenCubit.fetchMyFriendListData();

      // if (eventCubit.eventModel.pricing?.price != "0" &&
      //     (eventCubit.eventModel.pricing?.price ?? "").isNotEmpty) {
      //   _price = int.parse(eventCubit.eventModel.pricing?.price ?? "");
      // }
      final serializedUserModel = await getIt<SharedPreferencesUtil>()
          .getString(SharedPreferenceConstants.userModel);
      userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));

      setState(() {
        userId = "${userModel?.id}";
      });

      if (eventCubit.eventModel.eventRequest != null) {
        alreadyJoin = (eventCubit.eventModel.eventRequest ?? [])
            .any((eventRequest) => eventRequest.userId == userId);

        // yourEventRequest = eventCubit.eventModel.eventRequest
        //     ?.where((eventRequest) => eventRequest.userId == userId)
        //     .toList()
        //     .first;
        yourEventRequest = eventCubit.eventModel.eventRequest
            ?.where((eventRequest) => eventRequest.userId == userId)
            .firstWhere((eventRequest) => true, orElse: () => EventRequest());
      }

      // _price = 50;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCubit, EventState>(
      listener: (context, state) {
        if (state is EventFetchByIdLoadingState) {
        } else if (state is EventFetchByIdSuccessState) {
          LoggerUtil.logs("fetch event data-- ${state.eventModel?.toJson()}");
          eventCubit.initializeEventData(state.eventModel!);
          print(
              "eventDate ${eventCubit.eventModel.venues?.first.startDatetime}");
          acceptedRequests = eventCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .toList();
          print("1 yourEventRequest${yourEventRequest}");
          if (eventCubit.eventModel.pricing?.price != "0" &&
              (eventCubit.eventModel.pricing?.price ?? "").isNotEmpty) {
            String priceWithoutDollarSign =
                (eventCubit.eventModel.pricing?.price ?? "").replaceAllMapped(
              RegExp(r'^[€£\$SAR]?([0-9,.]+)'),
              // Correctly passing RegExp as the first argument
              (match) =>
                  match.group(1)?.toString() ??
                  '', // Correctly passing a function as the second argument
            );

            if (priceWithoutDollarSign.isNotEmpty) {
              _price = int.parse(priceWithoutDollarSign);
              print("price $_price");
            }
            if (eventCubit.eventModel.eventRequest != null) {
              alreadyJoin = (eventCubit.eventModel.eventRequest ?? [])
                  .any((eventRequest) => eventRequest.userId == userId);
              print(
                  "userId ${userId} object ${eventCubit.eventModel.eventRequest!.any((eventRequest) => eventRequest.userId == userId)}");
              // yourEventRequest = eventCubit.eventModel.eventRequest
              //     ?.where((eventRequest) => eventRequest.userId == userId)
              //     .toList()
              //     .first;
              yourEventRequest = eventCubit.eventModel.eventRequest
                  ?.where((eventRequest) => eventRequest.userId == userId)
                  .firstWhere((eventRequest) => true,
                      orElse: () => EventRequest());
              // print(" 0 yourEventRequest${yourEventRequest?.toJson()}");
              print(" 0 yourEventRequest${yourEventRequest?.toJson()}");
            }
            print("alreadyJoin 1 ${alreadyJoin}");
          }
        } else if (state is EventFetchByIdFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is BuyTicketRequestLoadingState) {
        } else if (state is BuyTicketRequestSuccessState) {
          Navigator.pop(context);
          NavigationUtil.push(
            context,
            RouteConstants.paymentSuccessScreen,
            args: PaymentSuccessArg(
                eventCubit.eventModel.title ?? "",
                eventCubit.eventModel.venues?.first.startDatetime ?? "",
                eventCubit.eventModel.venues?.first.endDatetime ?? "",
                eventCubit.eventModel.venues?.first.location ?? "",
                eventCubit.eventModel.images?.first ?? ""),
          );
          // eventCubit.initializeEventData(state.eventModel!);
          // print("eventDate ${eventCubit.eventModel.venues?.first.startDatetime}");
        } else if (state is SendEventRequestSuccessState) {
          print("SendEventRequestSuccessState ${alreadyJoin}");
          eventCubit.initializeEventData(state.eventModel!);
          print(
              "eventDate ${eventCubit.eventModel.venues?.first.startDatetime}");
          acceptedRequests = eventCubit.eventModel.eventRequest
              ?.where(
                  (eventRequest) => eventRequest.requestStatus == "Accepted")
              .toList();
          print("1 yourEventRequest${yourEventRequest}");
          if (eventCubit.eventModel.pricing?.price != "0" &&
              (eventCubit.eventModel.pricing?.price ?? "").isNotEmpty) {
            String priceWithoutDollarSign =
                (eventCubit.eventModel.pricing?.price ?? "").replaceAllMapped(
              RegExp(r'^[€£\$SAR]?([0-9,.]+)'),
              // Correctly passing RegExp as the first argument
              (match) =>
                  match.group(1)?.toString() ??
                  '', // Correctly passing a function as the second argument
            );

            if (priceWithoutDollarSign.isNotEmpty) {
              _price = int.parse(priceWithoutDollarSign);
              print("price $_price");
            }
            if (eventCubit.eventModel.eventRequest != null) {
              alreadyJoin = (eventCubit.eventModel.eventRequest ?? [])
                  .any((eventRequest) => eventRequest.userId == userId);
              print(
                  "userId ${userId} object ${eventCubit.eventModel.eventRequest!.any((eventRequest) => eventRequest.userId == userId)}");
              // yourEventRequest = eventCubit.eventModel.eventRequest
              //     ?.where((eventRequest) => eventRequest.userId == userId)
              //     .toList()
              //     .first;
              yourEventRequest = eventCubit.eventModel.eventRequest
                  ?.where((eventRequest) => eventRequest.userId == userId)
                  .firstWhere((eventRequest) => true,
                      orElse: () => EventRequest());
              // print(" 0 yourEventRequest${yourEventRequest?.toJson()}");
              print(" 0 yourEventRequest${yourEventRequest?.toJson()}");
            }
            print("alreadyJoin 1 ${alreadyJoin}");
          }
          setState(() {
            alreadyJoin = true;
          });
          _navigateToBack();
        } else if (state is BuyTicketRequestFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        } else if (state is EventFavSuccessState) {
          eventCubit.initializeEventData(state.eventModel!);
          print(
              "eventDate ${eventCubit.eventModel.venues?.first.startDatetime}");
        } else if (state is EventFavRequestFailureState) {
          eventCubit.eventModel.eventFavouriteBy?.length--;
        }
      },
      builder: (context, state) {
        return UIScaffold(
          removeSafeAreaPadding: false,
          bgColor: themeCubit.backgroundColor,
          widget: SingleChildScrollView(
            child: Container(
              // color: themeCubit.backgroundColor,
              child: Column(
                children: [
                  _eventWidget(),
                  // (eventCubit.eventModel.eventTotalParticipants != null &&
                  //         eventCubit.eventModel.eventTotalParticipants != "0")
                  //     ?

                  eventCubit.eventModel.title != null
                      ? _members()
                      : _shimmerMembers(),

                  SizedBoxConstants.sizedBoxHundredH(),
                  // : Container(
                  //     color: ColorConstants.black,
                  //     height: 500,
                  //   )
                ],
              ),
            ),
          ),
          floatingActionButton: ((eventCubit.eventModel.id ?? "").isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (eventCubit.eventModel.pricing?.price != "0" &&
                              (eventCubit.eventModel.pricing?.price ?? "")
                                  .isNotEmpty)
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              width: AppConstants.responsiveWidth(context,
                                  percentage: 30),
                              child: ButtonWithIconComponent(
                                btnText: '${StringConstants.getTicket}',
                                showIcon: false,
                                onPressed: () {
                                  print(
                                      "getTicket price ${(eventCubit.eventModel.pricing?.price)}");
                                  _getTicketBottomSheet();
                                },
                              ),
                            )
                          : Container(
                              alignment: Alignment.bottomLeft,
                            ),
                      (yourEventRequest?.id == null && alreadyJoin == false)
                          ? Container(
                              alignment: Alignment.bottomRight,
                              width: AppConstants.responsiveWidth(context,
                                  percentage: 30),
                              child: ButtonWithIconComponent(
                                btnText: '  ${StringConstants.join}',
                                icon: Icons.add_circle,

                                bgcolor: themeCubit.primaryColor,
                                // btnTextColor: themeCubit.textColor,
                                onPressed: () {
                                  JoinBottomSheet.showJoinBottomSheet(
                                      context,
                                      _controller,
                                      eventCubit.eventModel.id ?? "",
                                      eventCubit.eventModel.userId,
                                      eventCubit.eventModel.userName,
                                      eventCubit.eventModel.userImages,
                                      eventCubit.eventModel.title ?? "",
                                      (eventCubit.eventModel.isFree ?? true)
                                          ? "Free to join"
                                          : "Ticket Required",
                                      "ABC",
                                      "",
                                      questions:
                                          eventCubit.eventModel.question);
                                  // _showJoinBottomSheet();
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _eventWidget() {
    return Stack(children: [
      (eventCubit.eventModel.images?.first != null)
          ? GestureDetector(
              onTap: () {
                NavigationUtil.push(context, RouteConstants.viewFullImage,
                    args: eventCubit.eventModel.images?.first ?? "");
              },
              child: Image.network(
                eventCubit.eventModel.images?.first ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 500,
              ),
            )
          : Container(
              color: ColorConstants.black,
              height: 500,
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, bottom: 80),
              child: IconComponent(
                iconData: Icons.arrow_back_ios_new_outlined,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: ColorConstants.white,
                iconSize: 20,
                circleSize: 40,
                onTap: () => Navigator.pop(context),
              ),
            ),

            (eventCubit.eventModel.title != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // Align children vertically
                          children: [
                            if ((acceptedRequests ?? []).isNotEmpty)
                              SizedBox(
                                width: radius * 3,
                                //radius * images.length.toDouble(),
                                // Calculate the total width of images
                                height: radius,
                                // Set the height to match the image size
                                child: Stack(
                                  children: [
                                    // ?? images.length
                                    for (int i = 0;
                                        i <
                                            (acceptedRequests!
                                                    .isNotEmpty // eventCubit.eventModelList[index].eventParticipants!.isNotEmpty   //
                                                ? acceptedRequests!
                                                    .length //eventCubit.eventModelList[index].eventParticipants!.length  //acceptedRequests!.length//
                                                : images.length);
                                        i++)
                                      Positioned(
                                        left: i * radius / 1.5,
                                        // Adjust the left offset
                                        child: ClipOval(
                                            child: ImageComponent(
                                          imgUrl:
                                              acceptedRequests?[i].image ?? "",
                                          // eventCubit.eventModelList[index].eventParticipants!.isNotEmpty
                                          //     ? eventCubit.eventModelList[index].eventParticipants![i].image!
                                          //     : images[i],
                                          width: radius,
                                          height: radius,
                                          imgProviderCallback:
                                              (ImageProvider<Object>
                                                  imgProvider) {},
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
                            if ((eventCubit.eventModel.eventTotalParticipants ??
                                        "") !=
                                    "0" &&
                                (eventCubit.eventModel.eventTotalParticipants ??
                                        "")
                                    .isNotEmpty &&
                                eventCubit.eventModel.eventTotalParticipants !=
                                    null)
                              TextComponent(
                                "+${(eventCubit.eventModel.eventTotalParticipants ?? 0)} ${StringConstants.joined}",
                                style: FontStylesConstants.style14(
                                    color: ColorConstants.white),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextComponent(
                          eventCubit.eventModel.title ?? "",
                          style: FontStylesConstants.style30(
                              color: ColorConstants.white),
                          maxLines: 2,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTenH(),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: eventCubit.eventModel.venues != null &&
                                (eventCubit.eventModel.venues ?? []).isNotEmpty
                            ? TextComponent(
                                "",
                                listOfText: [
                                  if (eventCubit.eventModel.venues != null &&
                                      (eventCubit.eventModel.venues ?? [])
                                          .isNotEmpty)
                                    DateFormat('d MMM \'at\' hh a').format(
                                        DateTime.parse(
                                            (eventCubit.eventModel.venues ?? [])
                                                .first
                                                .startDatetime!)),
                                  // eventCubit.eventModel.venues?.first.startDatetime ?? "",
                                  "-",
                                  if (eventCubit.eventModel.venues != null &&
                                      (eventCubit.eventModel.venues ?? [])
                                          .isNotEmpty)
                                    DateFormat('d MMM \'at\' hh a').format(
                                        DateTime.parse(
                                            (eventCubit.eventModel.venues ?? [])
                                                    .first
                                                    .endDatetime ??
                                                "")),
                                  // eventCubit.eventModel.venues?.first.endDatetime ?? "asdasd",
                                  eventCubit
                                          .eventModel.venues?.first.location ??
                                      "asdasddas"
                                ],
                                listOfTextStyle: [
                                  FontStylesConstants.style14(
                                      color: ColorConstants.white),
                                  FontStylesConstants.style14(
                                      color: ColorConstants.white),
                                  FontStylesConstants.style14(
                                      color: ColorConstants.white),
                                  FontStylesConstants.style14(
                                      color: ColorConstants.white),
                                ],
                                style: FontStylesConstants.style14(
                                    color: ColorConstants.white),
                              )
                            : const TextComponent(""),
                      ),
                    ],
                  )
                : _shimmerTopEventData(),

            SizedBoxConstants.sizedBoxTenH(),
            (eventCubit.eventModel.title != null)
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        IconComponent(
                          iconData: Icons.favorite,
                          backgroundColor: ColorConstants.darkBackgrounddColor
                              .withOpacity(0.9),
                          iconColor:
                              eventCubit.eventModel.isFavourite == false ||
                                      eventCubit.eventModel.isFavourite == null
                                  ? Colors.white
                                  : ColorConstants.red,
                          customIconText:
                              "${eventCubit.eventModel.eventFavouriteBy?.length ?? 0}",
                          circleSize: 70,
                          circleHeight: 36,
                          iconSize: 20,
                          onTap: () {
                            _debouncer.run(() {
                              if (eventCubit.eventModel.isFavourite == false ||
                                  eventCubit.eventModel.isFavourite == null) {
                                eventCubit
                                    .eventModel.eventFavouriteBy?.length++;
                                if (widget.eventScreenArg?.indexValue != null &&
                                    (widget.eventScreenArg?.indexValue ?? "")
                                        .isNotEmpty) {
                                  print(
                                      "index value  ${widget.eventScreenArg?.indexValue}");
                                  eventCubit.eventModelList[int.parse(
                                      widget.eventScreenArg?.indexValue ??
                                          "0")] = eventCubit
                                      .eventModelList[int.parse(
                                          widget.eventScreenArg?.indexValue ??
                                              "0")]
                                      .copyWith(isFavourite: true);
                                }

                                eventCubit.eventModel = eventCubit.eventModel
                                    .copyWith(isFavourite: true);
                                eventCubit.sendEventFavById(
                                    eventCubit.eventModel.id ?? "", true);
                              } else {
                                eventCubit
                                    .eventModel.eventFavouriteBy?.length--;
                                if (widget.eventScreenArg?.indexValue != null &&
                                    (widget.eventScreenArg?.indexValue ?? "")
                                        .isNotEmpty) {
                                  eventCubit.eventModelList[int.parse(
                                      widget.eventScreenArg?.indexValue ??
                                          "0")] = eventCubit
                                      .eventModelList[int.parse(
                                          widget.eventScreenArg?.indexValue ??
                                              "0")]
                                      .copyWith(isFavourite: false);
                                }

                                eventCubit.eventModel = eventCubit.eventModel
                                    .copyWith(isFavourite: false);
                                eventCubit.sendEventFavById(
                                    eventCubit.eventModel.id ?? "", false);
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        IconComponent(
                            // iconData: Icons.share,
                            svgData: AssetConstants.share,
                            backgroundColor: ColorConstants.darkBackgrounddColor
                                .withOpacity(0.9),
                            circleSize: 35,
                            iconSize: 14,
                            onTap: () {
                              ShareBottomSheet.shareBottomSheet(
                                  context,
                                  eventCubit.eventModel.title!,
                                  eventCubit.eventModel.id!,
                                  userScreenCubit
                                          .friendListResponseWrapper.data ??
                                      [],
                                  StringConstants.event);
                              // _shareEventBottomSheet();
                            }),
                        showMore(),
                      ],
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          IconComponent(
                            iconData: Icons.favorite,
                            backgroundColor: ColorConstants.darkBackgrounddColor
                                .withOpacity(0.9),
                            iconColor: eventCubit.eventModel.isFavourite ==
                                        false ||
                                    eventCubit.eventModel.isFavourite == null
                                ? Colors.white
                                : ColorConstants.red,
                            customIconText:
                                "${eventCubit.eventModel.eventFavouriteBy?.length ?? 0}",
                            circleSize: 70,
                            circleHeight: 36,
                            iconSize: 20,
                            onTap: () {
                              _debouncer.run(() {
                                if (eventCubit.eventModel.isFavourite ==
                                        false ||
                                    eventCubit.eventModel.isFavourite == null) {
                                  eventCubit
                                      .eventModel.eventFavouriteBy?.length++;
                                  if (widget.eventScreenArg?.indexValue !=
                                          null &&
                                      (widget.eventScreenArg?.indexValue ?? "")
                                          .isNotEmpty) {
                                    print(
                                        "index value  ${widget.eventScreenArg?.indexValue}");
                                    eventCubit.eventModelList[int.parse(
                                        widget.eventScreenArg?.indexValue ??
                                            "0")] = eventCubit
                                        .eventModelList[int.parse(
                                            widget.eventScreenArg?.indexValue ??
                                                "0")]
                                        .copyWith(isFavourite: true);
                                  }

                                  eventCubit.eventModel = eventCubit.eventModel
                                      .copyWith(isFavourite: true);
                                  eventCubit.sendEventFavById(
                                      eventCubit.eventModel.id ?? "", true);
                                } else {
                                  eventCubit
                                      .eventModel.eventFavouriteBy?.length--;
                                  if (widget.eventScreenArg?.indexValue !=
                                          null &&
                                      (widget.eventScreenArg?.indexValue ?? "")
                                          .isNotEmpty) {
                                    eventCubit.eventModelList[int.parse(
                                        widget.eventScreenArg?.indexValue ??
                                            "0")] = eventCubit
                                        .eventModelList[int.parse(
                                            widget.eventScreenArg?.indexValue ??
                                                "0")]
                                        .copyWith(isFavourite: false);
                                  }

                                  eventCubit.eventModel = eventCubit.eventModel
                                      .copyWith(isFavourite: false);
                                  eventCubit.sendEventFavById(
                                      eventCubit.eventModel.id ?? "", false);
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          IconComponent(
                              // iconData: Icons.share,
                              svgData: AssetConstants.share,
                              backgroundColor: ColorConstants
                                  .darkBackgrounddColor
                                  .withOpacity(0.9),
                              circleSize: 35,
                              iconSize: 14,
                              onTap: () {
                                ShareBottomSheet.shareBottomSheet(
                                    context,
                                    eventCubit.eventModel.title!,
                                    eventCubit.eventModel.id!,
                                    userScreenCubit
                                            .friendListResponseWrapper.data ??
                                        [],
                                    StringConstants.event);
                                // _shareEventBottomSheet();
                              }),
                          showMore(),
                        ],
                      ),
                    ),
                  ),

            _aboutTheEvent(),
            // _members(),
          ],
        ),
      ),
    ]);
  }

  Widget _shimmerTopEventData() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                              ((eventCubit.eventModel.eventParticipants ?? [])
                                      .isNotEmpty
                                  ? (eventCubit.eventModel.eventParticipants ??
                                          [])
                                      .length
                                  : images.length);
                          i++)
                        Positioned(
                          left: i * radius / 1.5,
                          // Adjust the left offset
                          child: ClipOval(
                              child: ImageComponent(
                            imgUrl: (eventCubit.eventModel.eventParticipants ??
                                        [])
                                    .isNotEmpty
                                ? (eventCubit.eventModel.eventParticipants ??
                                        [])[i]
                                    .image!
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
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 15),
                  height: 15,
                  width: AppConstants.responsiveWidth(context, percentage: 30),
                  color: ColorConstants.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 10,
              width: AppConstants.responsiveWidth(context, percentage: 60),
              color: ColorConstants.white,
            ),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 10,
              width: AppConstants.responsiveWidth(context, percentage: 60),
              color: ColorConstants.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerAboutTheEvent() {
    return Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Shimmer.fromColors(
          baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 200,
                      color: ColorConstants.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      width: 100,
                      color: ColorConstants.white,
                    ),
                  ],
                ),
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              Container(
                margin: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 15,
                      width: AppConstants.responsiveWidth(context),
                      color: ColorConstants.white,
                    ),
                    SizedBoxConstants.sizedBoxTenH()
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Widget _aboutTheEvent() {
    return Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: eventCubit.eventModel.title == null
            ? _shimmerAboutTheEvent()
            : Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 18, right: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextComponent(StringConstants.abouttheEvent,
                                style: FontStylesConstants.style18(
                                    color: themeCubit.primaryColor)),
                            if ((eventCubit.eventModel.description ?? "")
                                .isNotEmpty)
                              SizedBox(
                                height: 10,
                              ),
                            if ((eventCubit.eventModel.description ?? "")
                                .isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showFullText = !_showFullText;
                                  });
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _showFullText
                                            ? eventCubit.eventModel.description
                                            : (((eventCubit
                                                                .eventModel
                                                                .description
                                                                ?.length) ??
                                                            0) >
                                                        150
                                                    ? eventCubit
                                                        .eventModel.description
                                                        ?.substring(0, 150)
                                                    : eventCubit.eventModel
                                                        .description) ??
                                                "No description available",
                                        style: TextStyle(
                                            color: themeCubit.textColor),
                                      ),
                                      if ((eventCubit.eventModel.description
                                                  ?.length ??
                                              0) >
                                          150)
                                        TextSpan(
                                          text: _showFullText
                                              ? ' ${StringConstants.showLess}'
                                              : ' ...${StringConstants.readMore}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: themeCubit.textColor),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTwentyH(),
                      Container(
                        child: Column(
                          children: [
                            AboutEventComponent(
                              name: (eventCubit.eventModel
                                                  .eventTotalParticipants ??
                                              "")
                                          .isNotEmpty &&
                                      (eventCubit.eventModel
                                                  .eventTotalParticipants ??
                                              "") !=
                                          "null"
                                  ? "${eventCubit.eventModel.eventTotalParticipants} ${StringConstants.participants}"
                                  : "0 ${StringConstants.participants}",
                              detail: (acceptedRequests
                                              ?.take(1)
                                              .map((e) => e.name)
                                              .join(', ') ??
                                          "")
                                      .isNotEmpty
                                  ? "${acceptedRequests?.take(1).map((e) => e.name).join(', ')} and more"
                                  : "No Participants",
                              //"Elena, Ilsa and more",
                              icon: AssetConstants.happy,
                              eventParticipants: acceptedRequests,
                              showPersonIcon: true,
                              selectedImages: images,
                            ),
                            AboutEventComponent(
                              name: StringConstants.flexibleDate,
                              detail: eventCubit.eventModel.venues != null &&
                                      (eventCubit.eventModel.venues ?? [])
                                          .isNotEmpty
                                  ? "${DateFormat('d MMM \'at\' hh a').format(DateTime.parse(eventCubit.eventModel.venues!.first.startDatetime!))} - ${DateFormat('d MMM \'at\' hh a').format(DateTime.parse(eventCubit.eventModel.venues?.first.endDatetime ?? ""))}"
                                  : StringConstants.dateWillbeDecidelater,
                              //StringConstants.dateWillbeDecidelater,
                              icon: AssetConstants.calendar,
                            ),
                            if (((eventCubit.eventModel.venues ?? [])
                                        .first
                                        .location ??
                                    "")
                                .isNotEmpty)
                              AboutEventComponent(
                                name: eventCubit.eventModel.venues != null &&
                                        (eventCubit.eventModel.venues ?? [])
                                            .isNotEmpty
                                    ? ((eventCubit.eventModel.venues ?? [])
                                            .first
                                            .location ??
                                        "")
                                    : "",
                                detail:
                                    StringConstants.exactLocationAfterJoining,
                                icon: AssetConstants.marker,
                                // divider: (eventCubit.eventModel.pricing?.price !=
                                //             "0" &&
                                //         (eventCubit.eventModel.pricing?.price ??
                                //                 "")
                                //             .isNotEmpty)
                                //     ? true
                                //     : false,
                              ),
                            //(ticketRequired == true)
                            AboutEventComponent(
                              name: (eventCubit.eventModel.pricing?.price !=
                                          "0" &&
                                      (eventCubit.eventModel.pricing?.price ??
                                              "")
                                          .isNotEmpty)
                                  ? (eventCubit.eventModel.pricing?.price ?? "")
                                  : StringConstants.freeToJoin,
                              detail: (eventCubit.eventModel.pricing?.price !=
                                          "0" &&
                                      (eventCubit.eventModel.pricing?.price ??
                                              "")
                                          .isNotEmpty)
                                  ? StringConstants.ticketrequired
                                  : StringConstants.noCharityRequired,
                              icon: AssetConstants.tag,
                              divider: (eventCubit.eventModel.pricing?.price !=
                                          "0" &&
                                      (eventCubit.eventModel.pricing?.price ??
                                              "")
                                          .isNotEmpty)
                                  ? false
                                  : true,
                            ),
                            if (eventCubit.eventModel.pricing?.price != "0" &&
                                (eventCubit.eventModel.pricing?.price ?? "")
                                    .isEmpty)
                              AboutEventComponent(
                                divider: false,
                                name: StringConstants.freeToJoin,
                                detail: StringConstants.noCharityRequired,
                                icon: AssetConstants.tag,
                              ),
                            SizedBoxConstants.sizedBoxTenH()
                          ],
                        ),
                      ),
                    ]),
              ));
  }

  Widget _shimmerMembers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 18),
                    child: Container(
                      height: 15,
                      width: 150,
                      color: ColorConstants.white,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxThirtyH(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Container(
                            height: 15,
                            width: 20,
                            color: ColorConstants.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBoxConstants.sizedBoxSixtyH(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _members() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 18),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 18,
                        color: themeCubit.primaryColor),
                    children: <TextSpan>[
                      const TextSpan(text: "${StringConstants.members}  "),
                      TextSpan(
                        text: eventCubit.eventModel.eventTotalParticipants ??
                            "0", //contacts.length.toString(),
                        style: TextStyle(
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            SizedBoxConstants.sizedBoxThirtyH(),
            if (yourEventRequest?.requestStatus != "Accepted" &&
                yourEventRequest != null &&
                yourEventRequest?.id != null)
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 5),
                        // width:
                        // AppConstants.responsiveWidth(context, percentage: 75),
                        child: ContactCard(
                          name: (yourEventRequest?.name ?? ""),
                          url: (yourEventRequest?.image ?? ""),
                          title: (yourEventRequest?.aboutMe ?? ""),
                          showShareIcon: false,
                          showDivider: false,
                          imageSize: 40,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextComponent(yourEventRequest?.requestStatus ?? "",
                        style: FontStylesConstants.style12(
                            color: ColorConstants.lightGray)),
                  ),
                ],
              ),
            if (yourEventRequest?.requestStatus != "Accepted" &&
                yourEventRequest != null &&
                yourEventRequest?.id != null)
              DividerCosntants.divider1,
            ListView.separated(
              separatorBuilder: (context, index) => const DividerComponent(),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: (acceptedRequests ?? []).length,
              // (eventCubit.eventModel.eventParticipants ?? []).length,
              //contacts.length,
              itemBuilder: (context, index) => ListTileComponent(
                leadingText: acceptedRequests?[index].name,
                // eventCubit.eventModel.eventParticipants?[index].name,
                // StringConstants.linkedIn,
                removeBorderFromTile: true,
                customPadding: const EdgeInsets.only(left: 20, right: 16),
                leadingsubText: acceptedRequests?[index].aboutMe,
                //eventCubit.eventModel.eventParticipants?[index].aboutMe,
                //contacts[index].title,
                // 'Graphic Designer',
                // trailingIcon: Icons.add_circle,
                trailingIconSize: 30,
                leadingIcon: acceptedRequests?[index].image ?? "",
                //eventCubit.eventModel.eventParticipants?[index].image,
                //'https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png',
                leadingIconHeight: 20,
                leadingIconWidth: 20,
                isLeadingImageProfileImage: true,
                // trailingWidget: showMore(),
                // moreBtnTap: () {
                //   return showMore();
                // },
                // isLeadingImageSVG: true,

                // isSocialConnected: true,
                subIconColor: themeCubit.textColor,
                // trailingText: "heelo",
                onTap: () async{
                  final serializedUserModel = await getIt<SharedPreferencesUtil>()
                      .getString(SharedPreferenceConstants.userModel);
                  userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));
                  // userId = await getIt<SharedPreferencesUtil>()
                  //     .getString(SharedPreferenceConstants.userIdValue);
                 String?  myId = userModel?.id;


                  if(acceptedRequests?[index].userId != myId){
                    NavigationUtil.push(
                        context, RouteConstants.profileScreenLocal,
                        args: acceptedRequests?[index].userId);
                  }
                  else {
                    print("My Id $myId  accpeted id ${acceptedRequests?[index].userId}");
                    NavigationUtil.push(
                        context, RouteConstants.mainScreen,args: "4");
                    // mainScreenCubit.updateIndex(4);

                  }

                },
              ),
            ),
            // ContactCard(
            //     imageSize: 45,
            //     name: contacts[index].name,
            //     title: contacts[index].title,
            //     url: contacts[index].url,
            //     // contact: contacts[index],
            //     showShareIcon: false)),
            SizedBoxConstants.sizedBoxForthyH(),
          ],
        ),
      ),
    );
  }

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
  //                   child: TextComponent(StringConstants.shareEvent,
  //                       style: FontStylesConstants.style18(
  //                           color: themeCubit.primaryColor)),
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
  //                 // IconComponent(
  //                 //   svgDataCheck: false,
  //                 //   svgData: AssetConstants.instagram,
  //                 //   backgroundColor: Colors.transparent,
  //                 //   borderColor: Colors.transparent,
  //                 //   circleSize: 60,
  //                 //   customText: StringConstants.instagram,
  //                 //   customTextColor: themeCubit.textColor,
  //                 //   iconSize: 60,
  //                 // ),
  //                 Column(children: [
  //                   ImageComponent(height: 60,width: 60,imgUrl:  AssetConstants.instagram, imgProviderCallback: (imageProvider){},),
  //                   SizedBoxConstants.sizedBoxTenH(),
  //                   TextComponent(StringConstants.instagram,style: FontStylesConstants.style12(color: ColorConstants.white),)
  //                 ],),
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
  //               thickness: 0.5,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 16),
  //               child: TextComponent(
  //                 StringConstants.yourConnections,
  //                 style: TextStyle(
  //                     color: themeCubit.primaryColor,
  //                     fontFamily: FontConstants.fontProtestStrike,
  //                     fontSize: 18),
  //               ),
  //             ),
  //             Expanded(
  //               child: ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: contacts.length,
  //                 itemBuilder: (ctx, index) {
  //                   return ContactCard(
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
  //               style: TextStyle(
  //                   fontSize: 20,
  //                   fontFamily: FontConstants.fontProtestStrike,
  //                   height: 1.5),
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
  //           SizedBoxConstants.sizedBoxTwentyH(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               InkWell(
  //                   onTap: () => Navigator.pop(context),
  //                   child: TextComponent(
  //                     StringConstants.goBack,
  //                     style: TextStyle(color: themeCubit.textColor),
  //                   )),
  //               SizedBoxConstants.sizedBoxThirtyW(),
  //               ButtonComponent(
  //                 bgcolor: themeCubit.primaryColor,
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

  _showMoreBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.share,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: themeCubit.primaryColor,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const TextComponent(StringConstants.saveEvent,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ColorConstants.white)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.thumb_down,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: themeCubit.primaryColor,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const TextComponent(StringConstants.showLessLikeThis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ColorConstants.white)),
                ],
              ),
            ),
            const Divider(
              thickness: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 12, bottom: 12),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    iconData: Icons.remove_circle,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: Colors.red,
                    circleSize: 35,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(StringConstants.reportEvent,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red)),
                ],
              ),
            ),
          ],
        ));
  }

  _showJoinBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            // color: themeCubit.darkBackgroundColor,
          ),
          // padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(StringConstants.join,
                            style: FontStylesConstants.style18(
                                color: themeCubit.primaryColor)),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: IconComponent(
                            iconData: Icons.close,
                            borderColor: Colors.transparent,
                            iconColor: themeCubit.textColor,
                            circleSize: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent("Property \nnetworking event",
                            style: FontStylesConstants.style28(
                                color: ColorConstants.white)),
                        Image.asset(
                          AssetConstants.ticketWithCircle,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    TextComponent(StringConstants.freeToJoin,
                        style: FontStylesConstants.style14(
                            color: ColorConstants.white)),
                    SizedBoxConstants.sizedBoxTwentyH(),
                  ],
                ),
              ),
              DividerCosntants.divider1,
              _messageComponent(),
              DividerCosntants.divider1,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      StringConstants.somethingToKnow,
                      style: TextStyle(
                          color: themeCubit.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.chatMsg,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.clock,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxForthyH(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: ButtonComponent(
                  buttonText: StringConstants.join,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    _sendMessage();
                    Navigator.pop(context);
                    _navigateToBack();
                    BottomSheetComponent.showBottomSheet(
                      context,
                      isShowHeader: false,
                      body: InfoSheetComponent(
                        heading: StringConstants.requestSent,
                        body: StringConstants.requestStatus,
                        image: AssetConstants.paperPlaneImage,
                        // svg: true,
                      ),
                      // whenComplete:_navigateToBack(),
                    );
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
              ),
              SizedBoxConstants.sizedBoxTenH()
            ],
          ),
        ));
  }

  _navigateToBack() async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
  }

  _messageComponent() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              ProfileImageComponent(
                url: "",
                size: 30,
              ),
              SizedBoxConstants.sizedBoxTenW(),
              TextComponent(
                "Message for Raul",
                style: FontStylesConstants.style18(
                    color: ColorConstants.primaryColor),
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextComponent(
            StringConstants.doYouHaveQuestion,
            style: FontStylesConstants.style14(color: ColorConstants.white),
            maxLines: 4,
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextFieldComponent(
            _controller,
            filled: true,
            textFieldFontSize: 12,
            hintText: StringConstants.typeYourMessage,
            fieldColor: ColorConstants.lightGray.withOpacity(0.5),
            maxLines: 4,
            minLines: 4,
          ),
          // TextField(
          //   controller: _controller,
          //   maxLines: 4,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: themeCubit.darkBackgroundColor.withOpacity(0.5),
          //     hintText: StringConstants.typeYourMessage,
          //     // suffixIcon: IconButton(
          //     //   icon: Icon(Icons.send),
          //     //   onPressed: _sendMessage,
          //     // ),
          //     hintStyle: TextStyle(
          //         color: ColorConstants.lightGray.withOpacity(0.5),
          //         fontSize: 14),
          //     border: InputBorder.none,
          //   ),
          // ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text;
        _controller.clear();
      });
    }
  }

  _getTicketBottomSheet() {
    BottomSheetComponent.showBottomSheet(context, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
        // padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          // color: themeCubit.darkBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(StringConstants.selectNumberOfTickets,
                      style: FontStylesConstants.style18(
                          color: themeCubit.primaryColor)),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: IconComponent(
                      iconData: Icons.close,
                      borderColor: Colors.transparent,
                      iconColor: themeCubit.textColor,
                      circleSize: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: ColorConstants.iconBg,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  // color: themeCubit.darkBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      StringConstants.ticket,
                      style: TextStyle(color: ColorConstants.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          "SAR ${_price}",
                          style: FontStylesConstants.style18(
                              color: ColorConstants.white),
                        ),
                        Row(
                          children: [
                            CircleButtonComponent(
                                icon: Icons.remove,
                                onPressed: () => onRemovePressed(setState),
                                backgroundColor: ColorConstants.iconBg),
                            Container(
                              // padding: const EdgeInsets.symmetric(horizontal: 25),
                              width: 30,
                              alignment: Alignment.center,
                              child: TextComponent('$_count',
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                      color: ColorConstants.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            CircleButtonComponent(
                                icon: Icons.add,
                                onPressed: () => onAddPressed(setState),
                                backgroundColor: ColorConstants.iconBg),
                          ],
                        )
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH()
                  ],
                ),
              ),
            ),
            SizedBoxConstants.sizedBoxEighteenH(),
            Divider(
              thickness: 0.1,
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      StringConstants.total,
                      style: TextStyle(color: ColorConstants.white),
                    ),
                    TextComponent(
                      "SAR ${_totalAmount}",
                      style: TextStyle(color: ColorConstants.white),
                    ),
                  ],
                )),
            Divider(
              thickness: 0.1,
            ),
            SizedBoxConstants.sizedBoxEighteenH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonComponent(
                  btnWidth:
                      AppConstants.responsiveWidth(context, percentage: 90),
                  buttonText: StringConstants.next,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    NavigationUtil.pop(context);
                    _getPaymentBottomSheet();
                    // _sendMessage();
                    // NavigationUtil.push(
                    //     context, RouteConstants.paymentSuccessScreen);
                    // _navigateToBack();
                    // BottomSheetComponent.showBottomSheet(
                    //   context,
                    //   isShowHeader: false,
                    //   body: InfoSheetComponent(
                    //     heading: StringConstants.requestSent,
                    //     body: StringConstants.requestStatus,
                    //     image: AssetConstants.paperPlaneImage,
                    //     // svg: true,
                    //   ),
                    //   // whenComplete:_navigateToBack(),
                    // );
                  },
                  bgcolor: themeCubit.primaryColor,
                )
              ],
            ),
            SizedBoxConstants.sizedBoxTenH(),
          ],
        ),
      );
    }));
  }

  _getPaymentBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        isShowHeader: false,
        takeFullHeightWhenPossible: true,
        isScrollable: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
        height: AppConstants.responsiveHeight(context),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          // color: themeCubit.darkBackgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: IconComponent(
                              iconData: Icons.close,
                              borderColor: Colors.transparent,
                              iconColor: themeCubit.textColor,
                              circleSize: 50,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        eventCubit.eventModel.images?.first ??
                            "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    SizedBoxConstants.sizedBoxSixteenH(),
                    TextComponent(
                      eventCubit.eventModel.title ?? "",
                      //"Fireworks Night",
                      style: FontStylesConstants.style18(
                          color: ColorConstants.white),
                    ),
                    // TextComponent("17 Feb . 11AM - 2PM . Manchester",
                    //     style: FontStylesConstants.style14(
                    //         color: ColorConstants.white)),
                    eventCubit.eventModel.venues != null &&
                            (eventCubit.eventModel.venues ?? []).isNotEmpty
                        ? TextComponent(
                            "",
                            listOfText: [
                              if (eventCubit.eventModel.venues != null &&
                                  (eventCubit.eventModel.venues ?? [])
                                      .isNotEmpty)
                                DateFormat('d MMM \'at\' hh a').format(
                                    DateTime.parse(
                                        (eventCubit.eventModel.venues ?? [])
                                                .first
                                                .startDatetime ??
                                            "")),
                              // eventCubit.eventModel.venues?.first.startDatetime ?? "",
                              "-",
                              if (eventCubit.eventModel.venues != null &&
                                  (eventCubit.eventModel.venues ?? [])
                                      .isNotEmpty)
                                DateFormat('d MMM \'at\' hh a').format(
                                    DateTime.parse(
                                        (eventCubit.eventModel.venues ?? [])
                                                .first
                                                .endDatetime ??
                                            "")),
                              // eventCubit.eventModel.venues?.first.endDatetime ?? "asdasd",
                              eventCubit.eventModel.venues?.first.location ??
                                  "asdasddasasdasd asdasd asd"
                            ],
                            listOfTextStyle: [
                              FontStylesConstants.style14(
                                  color: ColorConstants.white),
                              FontStylesConstants.style14(
                                  color: ColorConstants.white),
                              FontStylesConstants.style14(
                                  color: ColorConstants.white),
                              FontStylesConstants.style14(
                                  color: ColorConstants.white),
                            ],
                            style: FontStylesConstants.style14(
                                color: ColorConstants.white),
                          )
                        : const TextComponent(""),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          SizedBoxConstants.sizedBoxEighteenH(),
                          Container(
                            // margin: EdgeInsets.all(20),
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: ColorConstants.iconBg,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              // color: themeCubit.darkBackgroundColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextComponent(
                                  StringConstants.ticket,
                                  style: TextStyle(color: ColorConstants.white),
                                ),
                                TextComponent(
                                  "${_count}",
                                  style: TextStyle(color: ColorConstants.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBoxConstants.sizedBoxThirtyH(),
                          TextComponent(
                            StringConstants.anyQuestionWhenEventCreated,
                            style: TextStyle(color: ColorConstants.white),
                            maxLines: 3,
                          ),
                          SizedBoxConstants.sizedBoxTenH(),
                          TextFieldComponent(
                            _controller,
                            filled: true,
                            textFieldFontSize: 12,
                            hintText:
                                "There could be multiple questions aligned so they will come here",
                            fieldColor:
                                ColorConstants.lightGray.withOpacity(0.5),
                            maxLines: 4,
                            minLines: 4,
                          ),
                          SizedBoxConstants.sizedBoxSixtyH(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //     flex: 1,
            //     child: Column(
            //   children: [   TextComponent("teasdasd",style: TextStyle(color: Colors.white),),
            //     TextComponent("teasdasd",style: TextStyle(color: Colors.white),),
            //     TextComponent("teasdasd",style: TextStyle(color: Colors.white),),
            //     TextComponent("teasdasd",style: TextStyle(color: Colors.white),),],
            // ))

            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Divider(
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextComponent(
                                StringConstants.total,
                                style: TextStyle(color: ColorConstants.white),
                              ),
                              TextComponent(
                                "SAR ${_totalAmount}",
                                style: FontStylesConstants.style30(
                                    color: ColorConstants.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (Platform.isIOS)
                              ? Container(
                                  width: AppConstants.responsiveWidth(context,
                                      percentage: 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorConstants.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.apple,
                                        color: ColorConstants.black,
                                      ),
                                      TextComponent(
                                        StringConstants.pay,
                                        style: FontStylesConstants.style16(
                                            color: ColorConstants.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          // ButtonComponent(
                          //   horizontalLength:
                          //   AppConstants.responsiveWidth(context, percentage: 18),
                          //   buttonText: StringConstants.pay,
                          //   textColor: themeCubit.backgroundColor,
                          //   onPressedFunction: () {
                          //     _sendMessage();
                          //     Navigator.pop(context);
                          //     _navigateToBack();
                          //     BottomSheetComponent.showBottomSheet(
                          //       context,
                          //       isShowHeader: false,
                          //       body: InfoSheetComponent(
                          //         heading: StringConstants.requestSent,
                          //         body: StringConstants.requestStatus,
                          //         image: AssetConstants.paperPlaneImage,
                          //         // svg: true,
                          //       ),
                          //       // whenComplete:_navigateToBack(),
                          //     );
                          //   },
                          //   bgcolor: ColorConstants.white,
                          // ),

                          SizedBox(
                            width: AppConstants.responsiveWidth(context,
                                percentage: 40),
                            child: ButtonWithIconComponent(
                              btnText: '${StringConstants.payWithCard}',
                              // icon: Icons.add_circle,
                              showIcon: false,
                              bgcolor: themeCubit.primaryColor,
                              // btnTextColor: themeCubit.textColor,
                              onPressed: () {
                                TicketModel ticketModel = TicketModel(
                                  eventId: eventCubit.eventModel.id,
                                  userId: onBoardingCubit.userModel.id,
                                  transectionId:
                                      FirebaseUtils.getDateTimeNowAsId(),
                                  ticketQty: _count.toString(),
                                  ticketPrice: _price.toString(),
                                  ticketTotalPrice: _totalAmount.toString(),
                                );
                                eventCubit.buyTicketRequest(ticketModel);

                                // _paymentSuccessBottomSheet();
                                // JoinBottomSheet.showJoinBottomSheet(context, _controller,
                                //     "Property networking event", "Group", "ABC", "");
                                // _showJoinBottomSheet();
                              },
                            ),
                          ),
                          // ButtonWithIconComponent(
                          //   btnWidth:  AppConstants.responsiveWidth(context,percentage: 40),
                          //   isSmallBtn: true,
                          //   buttonText: StringConstants.payWithCard,
                          //   textColor: themeCubit.backgroundColor,
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //     _paymentSuccessBottomSheet();
                          //   },
                          //   bgcolor: themeCubit.primaryColor,
                          // )
                        ],
                      ),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ))
          ],
        ),
      );
    }));
  }

  _paymentSuccessBottomSheet() {
    BottomSheetComponent.showBottomSheet(context, isShowHeader: false,
        body: StatefulBuilder(builder: (context, setState) {
      return Container(
        // padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          // color: themeCubit.darkBackgroundColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: IconComponent(
                      iconData: Icons.close,
                      borderColor: Colors.transparent,
                      iconColor: themeCubit.textColor,
                      circleSize: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              color: ColorConstants.white,
              child: QrImageView(
                data: '1234567890',
                version: QrVersions.auto,
                size: 150.0,
              ),
            ),
            SizedBoxConstants.sizedBoxSixteenH(),
            TextComponent(
              "Fireworks Night",
              style: FontStylesConstants.style18(color: ColorConstants.white),
            ),
            SizedBoxConstants.sizedBoxSixteenH(),
            TextComponent(StringConstants.when,
                style: FontStylesConstants.style14(
                    color: ColorConstants.lightGray)),
            SizedBoxConstants.sizedBoxSixteenH(),
            TextComponent("17 Feb . 11AM - 2PM ",
                style:
                    FontStylesConstants.style14(color: ColorConstants.white)),
            SizedBoxConstants.sizedBoxSixteenH(),
            TextComponent(StringConstants.where,
                style: FontStylesConstants.style14(
                    color: ColorConstants.lightGray)),
            SizedBoxConstants.sizedBoxSixteenH(),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: TextComponent(
                "Pique Cafe\n Al-Semairi, Yanbu Al Bahir 46455 Riyadh Saudia Arabia",
                style: FontStylesConstants.style14(color: ColorConstants.white),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBoxConstants.sizedBoxEighteenH(),
            Container(
              width: 150,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: ColorConstants.iconBg.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // color: themeCubit.darkBackgroundColor,
              ),
              child: TextComponent(
                StringConstants.viewInMap,
                style: TextStyle(color: ColorConstants.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBoxConstants.sizedBoxSixtyH(),
            Container(
              width: 250,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: ColorConstants.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: themeCubit.darkBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconComponent(
                    // iconData: Icons.facebook,
                    svgDataCheck: false,
                    svgData: AssetConstants.applePay,
                    // borderColor: Colors.red,
                    backgroundColor: ColorConstants.transparent,
                    iconSize: 100,
                    borderSize: 0,
                    // circleSize: 30,
                    // circleHeight: 30,
                  ),
                  // Icon(
                  //   Icons.apple,
                  //   color: ColorConstants.white,
                  // ),
                  SizedBoxConstants.sizedBoxTenW(),
                  TextComponent(
                    StringConstants.addToAppleWallet,
                    style: TextStyle(color: ColorConstants.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxEighteenH(),
          ],
        ),
      );
    }));
  }

  void onRemovePressed(StateSetter stateSetter) {
    if (_count > 0) {
      stateSetter(() {
        _count--;
        _totalAmount -= _price; // Subtract the fixed amount
      });
    } else if (_count < 99) {
      // Ensure _count does not go below 0
      stateSetter(() {
        _count++;
        _totalAmount += _price; // Add the fixed amount
      });
    }
  }

  void onAddPressed(StateSetter stateSetter) {
    if (_count < 99) {
      // Prevent exceeding the maximum limit
      stateSetter(() {
        _count++;
        _totalAmount += _price; // Add the fixed amount
      });
    }
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
        backgroundColor: ColorConstants.darkBackgrounddColor.withOpacity(0.9),
        iconColor: Colors.white,
        circleSize: 35,
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
          // _showBlockBottomSheet();
        } else if (value == 'report') {
          eventCubit.eventReport(eventCubit.eventModel.id ?? "");
          NavigationUtil.pop(context);
          // _showReportBottomSheet();
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
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class EventScreenArg {
  final String eventId;
  final String indexValue;

  EventScreenArg(
    this.eventId,
    this.indexValue,
  );
}
