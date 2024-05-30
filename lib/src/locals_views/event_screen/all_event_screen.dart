import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/filter_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/wrappers/events_going_to_response_wrapper.dart';
import 'package:flutter/material.dart';

import '../../components/event_card.dart';
import '../../components/ui_scaffold.dart';

class AllEventScreen extends StatefulWidget {
  AllEventsArg? allEventsArg;

  AllEventScreen({super.key, this.allEventsArg});

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < (widget.allEventsArg?.allEventsData ?? {}).keys.length; i++) {
      var key = widget.allEventsArg?.allEventsData?.keys.elementAt(i);
      if (widget.allEventsArg?.allEventsData?[key]?.isNotEmpty?? false) {
        _selectedIndex = i;
        break; // Exit the loop once we've found the first non-empty category
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.eventsYouGoingTo,
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
          FilterComponent(
              options: [
                (((widget.allEventsArg?.totalEventsCount?.upcomingEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Upcoming",
                        count: ((widget.allEventsArg?.totalEventsCount?.upcomingEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((widget.allEventsArg?.totalEventsCount?.paidEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Paid",
                        count: ((widget.allEventsArg?.totalEventsCount?.paidEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((widget.allEventsArg?.totalEventsCount?.pastEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Past",
                        count: ((widget.allEventsArg?.totalEventsCount?.pastEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((widget.allEventsArg?.totalEventsCount?.freeEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Free",
                        count: ((widget.allEventsArg?.totalEventsCount?.freeEvents ??
                            0) as int))
                    : FilterComponentArg(),
                (((widget.allEventsArg?.totalEventsCount?.pendingEvents ??
                            0) as int) >
                        0)
                    ? FilterComponentArg(
                        title: "Pending",
                        count: ((widget.allEventsArg?.totalEventsCount?.pendingEvents ??
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
                        "event filters ${widget.allEventsArg?.allEventsData?.values.elementAt(_selectedIndex)}"),
                    print("filters selectedIndex ${_selectedIndex}"),
                  }),
          SizedBoxConstants.sizedBoxTwentyH(),
          Expanded(
            child: GridView.builder(
              // Set the scroll direction to horizontal
              scrollDirection: Axis.vertical,
              // Define the number of items in the cross axis (columns)
              // You can adjust this number based on your design requirements
              itemCount: widget.allEventsArg?.allEventsData?.values
                  .elementAt(_selectedIndex).length,
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
                var event = widget.allEventsArg?.allEventsData?.values
                    .elementAt(_selectedIndex); //eventList[index];
                // Return an EventCard for the current event
                return GestureDetector(
                  onTap: (){
                    NavigationUtil.push(
                        context, RouteConstants.eventScreen,
                        args: EventScreenArg(event?[index].id ?? "", ""));
                  },
                  child: EventCard(
                    title: event?[index].title ?? "",
                    totalCount: (event?[index].acceptedCount ?? 0) as int,
                    imageUrl: (event?[index].images ?? []).firstWhere(
                            (element) => (element ?? "").isNotEmpty,
                        orElse: () => ""),
                    images: (event?[index].eventRequest ?? [])
                        .take(3) // Take only the first three elements
                        .map((e) =>
                    e.image ??
                        "") // Transform each element to its image property, or "" if null
                        .toList(),
                    startTime: (event?[index].venue ?? []).first.startDatetime,
                    endTime: (event?[index].venue ?? []).first.endDatetime,
                    radius2: 20,
                    viewTicket: !(event?[index].isFree ?? false),
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

class AllEventsArg {
  final TotalEventsCount? totalEventsCount;
  final Map<String, List<UpcomingEvents>>? allEventsData;

  AllEventsArg(this.totalEventsCount, this.allEventsData);
}
