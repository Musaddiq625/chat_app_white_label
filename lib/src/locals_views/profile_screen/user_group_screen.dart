import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/group_card.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/locals_views/profile_screen/cubit/view_user_screen_cubit.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/ui_scaffold.dart';
import '../../screens/chat_screen/chat_screen.dart';
import '../../utils/logger_util.dart';
import '../../wrappers/all_groups_wrapper.dart';

class UserGroupScreen extends StatefulWidget {
  String userId;

  UserGroupScreen({super.key, required this.userId});

  @override
  State<UserGroupScreen> createState() => _UserGroupScreenState();
}

class _UserGroupScreenState extends State<UserGroupScreen> {
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
  late ViewUserScreenCubit viewUserScreenCubit =
  BlocProvider.of<ViewUserScreenCubit>(context);

  @override
  void initState() {
    // for (var i = 0;
    //     i < (widget.allGroupsArg?.allEventsData ?? {}).keys.length;
    //     i++) {
    //   var key = widget.allGroupsArg?.allEventsData?.keys.elementAt(i);
    //   if (widget.allGroupsArg?.allEventsData?[key]?.isNotEmpty ?? false) {
    //     _selectedIndex = i;
    //     break; // Exit the loop once we've found the first non-empty category
    //   }
    // }
    viewUserScreenCubit.fetchAllEventGroupData(widget.userId, "group");


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewUserScreenCubit, ViewUserScreenState>(
      listener: (context, state) {
        if (state is ViewUserAllEventGroupLoadingState) {
        } else if (state is ViewUserAllEventGroupSuccessState) {
          viewUserScreenCubit
              .initializeAllUserEventGroupData(state.userEventGroupWrapper);
          LoggerUtil.logs("viewUserScreenCubit ${viewUserScreenCubit.userEventGroupWrapper.data?.toJson()}");
        } else if (state is ViewUserAllEventGroupFailureState) {
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: AppBarComponent(
              StringConstants.allGroups,
              centerTitle: false,
              isBackBtnCircular: false,
            ),
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
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          Expanded(
            child: GridView.builder(
              // Set the scroll direction to horizontal
              scrollDirection: Axis.vertical,
              // Define the number of items in the cross axis (columns)
              // You can adjust this number based on your design requirements
              itemCount: viewUserScreenCubit.userEventGroupWrapper.data?.groups?.length,
              // widget.allGroupsArg?.allEventsData?.values.elementAt(_selectedIndex).length,
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
                print("viewUserScreenCubit.userEventGroupWrapper.data?.groups?[index] ${viewUserScreenCubit.userEventGroupWrapper.data?.groups?[index]}");
                var event = viewUserScreenCubit.userEventGroupWrapper.data?.groups?[index]; //eventList[index];
                // Return an EventCard for the current event
                return GestureDetector(
                    onTap: () {
                      if (event?.isMyEvent == false) {
                        NavigationUtil.push(
                            context, RouteConstants.viewGroupScreen,
                            args: ViewGroupArg(
                                event?.id ?? "", false, false));
                      } else {
                        NavigationUtil.push(
                            context, RouteConstants.viewYourGroupScreen,
                            args: event?.id ?? "");
                      }
                    },
                    child:
                    // EventCard(
                    //   title: event?[index].title ?? "",
                    //   totalCount: (event?[index].acceptedCount ?? 0) as int,
                    //   imageUrl: (event?[index].images ?? []).firstWhere(
                    //           (element) => (element ?? "").isNotEmpty,
                    //       orElse: () => ""),
                    //   images: (event?[index].eventRequest ?? [])
                    //       .take(3) // Take only the first three elements
                    //       .map((e) =>
                    //   e.image ??
                    //       "") // Transform each element to its image property, or "" if null
                    //       .toList(),
                    //   startTime: (event?[index].venue ?? []).first.startDatetime,
                    //   endTime: (event?[index].venue ?? []).first.endDatetime,
                    //   radius2: 20,
                    //   viewTicket: !(event?[index].isFree ?? false),
                    // ),
                    GroupCard(
                      imageUrl: (event?.images ?? []).firstWhere(
                              (element) => (element ?? "").isNotEmpty,
                          orElse: () => ""),
                      images: [],
                      name: event?.title ?? "",
                      membersCount: (event?.members ?? "").toString(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
