import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/event_card.dart';
import '../../components/ui_scaffold.dart';

class AllYourEventScreen extends StatefulWidget {
  AllYourEventScreen({super.key});

  @override
  State<AllYourEventScreen> createState() => _AllYourEventScreenState();
}

class _AllYourEventScreenState extends State<AllYourEventScreen> {
  int _selectedIndex = 0;
  String img =
      "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg";
  final List<String> images2 = [
    "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png",
    "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg",
    "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg",
  ];
  List<Map<String, dynamic>> eventList = [
    {
      'joined': "+1456",
      'eventName': "Property networking event",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
    {
      'joined': "+1226",
      'eventName': "Drum Code London",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
    {
      'joined': "+1134",
      'eventName': "Property test event",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
    {
      'joined': "+1146",
      'eventName': "Networking event",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
    {
      'joined': "+1456",
      'eventName': "Property networking event",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
    {
      'joined': "+1226",
      'eventName': "Drum Code London",
      'dateTime': "17Feb. 11AM - 2PM",
      'viewTicket': false
    },
  ];
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);

  @override
  void initState() {
    // TODO: implement initState
    // for (var i = 0; i < (widget.allEventsArg?.allEventsData ?? {}).keys.length; i++) {
    //   var key = widget.allEventsArg?.allEventsData?.keys.elementAt(i);
    //   if (widget.allEventsArg?.allEventsData?[key]?.isNotEmpty?? false) {
    //     _selectedIndex = i;
    //     break; // Exit the loop once we've found the first non-empty category
    //   }
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.myEvents,
          centerTitle: false,
          isBackBtnCircular: false,
        ),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          // FilterComponent(
          //     options: [
          //       (((userScreenCubit.allEventsArg?.totalEventsCount?.upcomingEvents ?? 0)
          //                   as int) >
          //               0)
          //           ? FilterComponentArg(
          //               title: "Upcoming",
          //               count: ((widget.allEventsArg?.totalEventsCount
          //                       ?.upcomingEvents ??
          //                   0) as int))
          //           : FilterComponentArg(),
          //       (((widget.allEventsArg?.totalEventsCount?.paidEvents ?? 0)
          //                   as int) >
          //               0)
          //           ? FilterComponentArg(
          //               title: "Paid",
          //               count: ((widget
          //                       .allEventsArg?.totalEventsCount?.paidEvents ??
          //                   0) as int))
          //           : FilterComponentArg(),
          //       (((widget.allEventsArg?.totalEventsCount?.pastEvents ?? 0)
          //                   as int) >
          //               0)
          //           ? FilterComponentArg(
          //               title: "Past",
          //               count: ((widget
          //                       .allEventsArg?.totalEventsCount?.pastEvents ??
          //                   0) as int))
          //           : FilterComponentArg(),
          //       (((widget.allEventsArg?.totalEventsCount?.freeEvents ?? 0)
          //                   as int) >
          //               0)
          //           ? FilterComponentArg(
          //               title: "Free",
          //               count: ((widget
          //                       .allEventsArg?.totalEventsCount?.freeEvents ??
          //                   0) as int))
          //           : FilterComponentArg(),
          //       (((widget.allEventsArg?.totalEventsCount?.pendingEvents ?? 0)
          //                   as int) >
          //               0)
          //           ? FilterComponentArg(
          //               title: "Pending",
          //               count: ((widget.allEventsArg?.totalEventsCount
          //                       ?.pendingEvents ??
          //                   0) as int))
          //           : FilterComponentArg()
          //     ],
          //     groupValue:
          //         _selectedIndex, // Your state variable for selected index
          //     onValueChanged: (int value) => {
          //           setState(
          //             () => _selectedIndex = value,
          //           ),
          //           print(
          //               "event filters ${widget.allEventsArg?.allEventsData?.values.elementAt(_selectedIndex)}"),
          //           print("filters selectedIndex ${_selectedIndex}"),
          //         }),
          // SizedBoxConstants.sizedBoxTwentyH(),
          Expanded(
            child: GridView.builder(
              // Set the scroll direction to horizontal
              scrollDirection: Axis.vertical,
              // Define the number of items in the cross axis (columns)
              // You can adjust this number based on your design requirements
              itemCount: userScreenCubit.eventModelList.length,
              // Define the number of items in the main axis (rows)
              // Since we're using a horizontal scroll direction, this will be 1
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisCount: 2, // Number of items in the cross axis
                childAspectRatio: 2 / 3, // Aspect ratio of the items
              ),
              // Define how each item in the grid should be built
              itemBuilder: (BuildContext context, int index) {
                // Get the current event from the list
                var event = userScreenCubit.eventModelList[index]; //eventList[index];
                // Return an EventCard for the current event
                return GestureDetector(
                  onTap: () {
                    NavigationUtil.push(context, RouteConstants.viewYourEventScreen,
                        args:  event.id);
                  },
                  child: EventCard(
                    title: event.title ?? "",
                    totalCount: int.parse((event.eventTotalParticipants?? "0").toString()),
                    imageUrl: event.images!= null &&!event.images!.isEmpty? (event.images?.first ?? "") : "",
                    images: (event.eventRequest ?? []).where((element) => element.requestStatus == "Accepted")
                        .take(3) // Take only the first three elements
                        .map((e) =>
                            e.image ??
                            "") // Transform each element to its image property, or "" if null
                        .toList(),
                    startTime: (event.venues ?? []).first.startDatetime,
                    endTime: (event.venues ?? []).first.endDatetime,
                    radius2: 20,
                    viewTicket: !(event.isFree ?? false),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
