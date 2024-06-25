import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/event_card.dart';
import 'package:chat_app_white_label/src/components/group_card.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/locals_views/event_screen/event_screen.dart';
import 'package:chat_app_white_label/src/locals_views/group_screens/view_group_screen.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  TextEditingController searchController = TextEditingController();
  List<EventModel> filteredContacts = [];
  int currentPageValue = 1;
  String searchValue = "";
  bool searching = false;
  bool loading = false;
  final _debouncer = Debouncer(milliseconds: 700);
  final _debouncerSearch = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    eventCubit.searchEventDataByKeys(currentPageValue.toString(), searchValue);
    super.initState();
  }


  @override
  void dispose() {
   filteredContacts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCubit, EventState>(
      listener: (context, state) {
        if (state is EventFetchLoadingState) {
          AppConstants.closeKeyboard;
          filteredContacts.clear();
          setState(() {
            searching = true;
          });
          print("searching value loading $searching");
        }
        else if (state is SearchEventFetchLoadingState){
          AppConstants.closeKeyboard;
          filteredContacts.clear();
          setState(() {
            searching = true;
          });
          print("searching value loading $searching");

        }
        else if (state is EventFetchPaginationSearchLoadingState) {

          print("loading value loading $loading");
          setState(() {
            loading = true;
          });
        }
        else if (state is SearchEventFetchSuccessState) {
          print("searching value success $searching");
          setState(() {
            searching = false;
          });

          filteredContacts.clear();
          eventCubit.searchEventModelList.addAll(state.eventModel ?? []);
          eventCubit.initializeSearchEventWrapperData(state.eventModelWrapper!);
          filteredContacts = eventCubit.searchEventModelList;
          // setState(() {
          //   isLoading = false;
          // });

          // eventCubit.eventModelList.addAll(state.eventModel ?? []);
          // eventCubit.initializeEventData(state.eventModel ?? []);
          // eventCubit.initializeEventWrapperData(state.eventModelWrapper!);
          // LoggerUtil.logs("fetch data value ${state.eventModel?[0].toJson()}");
        }
        else if (state is EventFetchPaginationSearchSuccessState) {
          print("loading value success $loading");
          setState(() {
            loading = false;
          });
          // LoadingDialog.hideLoadingDialog(context);
          // eventCubit.eventModelList.clear();
          // filteredContacts.clear();
          eventCubit.searchEventModelList.addAll(state.eventModel ?? []);
          eventCubit.initializeSearchEventWrapperData(state.eventModelWrapper!);
          filteredContacts.addAll(state.eventModel!);
          // setState(() {
          //   isLoading = false;
          // });

          // eventCubit.eventModelList.addAll(state.eventModel ?? []);
          // eventCubit.initializeEventData(state.eventModel ?? []);
          // eventCubit.initializeEventWrapperData(state.eventModelWrapper!);
          // LoggerUtil.logs("fetch data value ${state.eventModel?[0].toJson()}");
        }
        else if (state is EventFetchFailureState) {
          // LoadingDialog.hideLoadingDialog(context);
          ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: AppConstants.closeKeyboard,
          child: UIScaffold(
              appBar: AppBarComponent(
                StringConstants.search,
                centerTitle: false,
                isBackBtnCircular: false,
              ),
              appBarHeight: 500,
              removeSafeAreaPadding: false,
              bgColor: ColorConstants.black,
              // bgImage:
              //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
              widget: main()),
        );
      },
    );
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBoxConstants.sizedBoxTenH(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: SearchTextField(
                  title: "Search",
                  hintText: "Search events",
                  searching: searching,
                  onSearch: (text) {
                    setState(() {
                      if (text.length > 2) {
                        setState(() {
                          currentPageValue = 1;
                          searchValue = text;
                        });
                        _debouncer.run(() {
                          eventCubit.searchEventDataByKeys(
                              currentPageValue.toString(), text);
                        });
                      } else if (text.length == 0) {
                        setState(() {
                          currentPageValue = 1;
                          searchValue = text;
                        });
                        _debouncer.run(() {
                          eventCubit.searchEventDataByKeys(
                              currentPageValue.toString(), searchValue);
                        });
                      }

                      filteredContacts
                          .where((contact) =>
                              (contact.userName ?? "")
                                  .toLowerCase()
                                  .contains(text.toLowerCase()) ||
                              (contact.userAboutMe ?? "")
                                  .toLowerCase()
                                  .contains(text.toLowerCase()) ||
                              (contact.title ?? "")
                                  .toLowerCase()
                                  .contains(text.toLowerCase()) ||
                              (contact.description ?? "")
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                          .toList();
                    });
                  },
                  textEditingController: searchController,
                ),
              ),
              SizedBoxConstants.sizedBoxTwentyH(),
              Expanded(
                child:
                (filteredContacts.length >0)?
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filteredContacts.length,shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var event = filteredContacts[index];
                    bool? isLastItemOfLastRow;
                    if (filteredContacts.length >= 10) {
                        isLastItemOfLastRow = index >= filteredContacts.length - 2;
                    }

                    print("isLastItemOfLastRow $isLastItemOfLastRow");
                    if (isLastItemOfLastRow == true) {
                      if (eventCubit.searchEventResponseWrapper.meta!.remainingCount! > 0) {
                          currentPageValue++;
                        _debouncerSearch.run(() {
                          eventCubit.searchEventDataByNewPageValueKeys(
                              currentPageValue.toString(), searchValue);
                        });
                      }
                    }
                    return GestureDetector(
                            onTap: () {
                              if (event.type == "event") {
                                if (event.isMyEvent == true) {
                                  NavigationUtil.push(
                                      context, RouteConstants.viewYourEventScreen,
                                      args: event.id ?? "");
                                }
                                else {
                                  NavigationUtil.push(
                                      context, RouteConstants.eventScreen,
                                      args: EventScreenArg(event.id ?? "", ""));
                                }
                              } else {
                                if (event.isMyEvent == true) {
                                  NavigationUtil.push(
                                      context, RouteConstants.viewYourGroupScreen,
                                      args: event.id);
                                } else {
                                  NavigationUtil.push(
                                      context, RouteConstants.viewGroupScreen,
                                      args: ViewGroupArg(
                                          event.id ?? "", false, false));
                                }
                              }
                            },
                            child: (event.type == "event")
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: EventCard(
                                      title: event.title ?? "",
                                      totalCount: int.parse(
                                          (event.eventTotalParticipants ?? "0")
                                              .toString()),
                                      imageUrl: event.images != null &&
                                              !event.images!.isEmpty
                                          ? (event.images?.first ?? "")
                                          : "",
                                      images: (event.eventRequest ?? [])
                                          .where((element) =>
                                              element.requestStatus == "Accepted")
                                          .take(3)
                                          .map((e) => e.image ?? "")
                                          .toList(),
                                      startTime:
                                          (event.venues ?? []).first.startDatetime,
                                      endTime:
                                          (event.venues ?? []).first.endDatetime,
                                      radius2: 20,
                                      viewTicket: false, //!(event.isFree ?? false),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: GroupCard(
                                      imageUrl: (event.images ?? []).firstWhere(
                                          (element) => (element ?? "").isNotEmpty,
                                          orElse: () => ""),
                                      images: [],
                                      name: event.title ?? "",
                                      membersCount:
                                          (event.eventTotalParticipants ?? "")
                                              .toString(),
                                    ),
                                  ),
                          );

                  },
                ):
                Center(
                    child: TextComponent(
                      "No Event Found",
                      style: FontStylesConstants.style30(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.normal),
                    ))

              ),
              // SizedBoxConstants.sizedBoxTenH(),

              // SizedBoxConstants.sizedBoxTenH(),
            ],
          ),
          if(loading==true)
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.grey1),
              ),
            ),

        ],
      ),
    );
  }
}
