import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/models/get_filters_data_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, dynamic> availableDates = {
    StringConstants.today: false,
    "Tomorrow": false,
    "This Week": true,
    "This Month": false,
    "This weekend": false,
    "Choose a date": false,
  };

  Map<String, dynamic> categories = {
    "Music": true,
    "Business": false,
    "Food & Drink": false,
    "Community": false,
    "Art": false,
    "Health": false,
    "Tech": false,
    "Seasonal": false,
    "Fashion": false,
    "Travel & Outdoor": false,
    "Sports & Fitness": false,
    "Education": false,
  };

  Map<String, dynamic> price = {
    "Free": false,
    "Paid": false,
  };
  List<String> priceValue = ["Free", "Paid"];
  List<CategoryData> categoryData = [];
  List<DateFilterData> dateFilterData = [];
  String? selectedDateFilter;
  String? isFree;
  bool? isFreeValue;
  List<String> selectedCategories = [];
  late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  late PageController _pageController = PageController(initialPage: 0);

  String startingDate = DateFormat.yMMMMd().format(DateTime.now());
  String endingDate = DateFormat.yMMMMd().format(DateTime.now());

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        startingDate = DateFormat.yMMMMd().format(picked);
        // startingDate = dayNameTR;

        // startingDate = "${picked.month} ${picked.day} ${picked.year}";
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    print("startdate ${startingDate}");
    DateTime selectedStartDate =
    DateFormat.yMMMMd().parse(
        startingDate.toString());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: selectedStartDate,
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        endingDate = DateFormat.yMMMMd().format(picked);
        // startingDate = dayNameTR;

        // startingDate = "${picked.month} ${picked.day} ${picked.year}";
      });
    }
  }

  @override
  void initState() {
    print(
        "state.getFiltersDataModel?.categoryData ${eventCubit.filtersListModel.categoryData?.map((e) => e.title)}");
    categoryData = eventCubit.filtersListModel.categoryData ?? [];
    dateFilterData = eventCubit.filtersListModel.dateFilterData ?? [];
    selectedDateFilter = eventCubit.selectedDateFilter;
    selectedCategories = eventCubit.selectedCategories ?? [];
    isFree = eventCubit.isFree;
    isFreeValue = eventCubit.isFreeValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return BlocConsumer<EventCubit, EventState>(
      listener: (context, state) {
        if (state is GetFiltersDataSuccessState) {
          print(
              "state.getFiltersDataModel?.categoryData ${state.getFiltersDataModel?.categoryData?.map((e) => e.title)}");
          if (state.getFiltersDataModel?.categoryData != null) {
            categoryData = state.getFiltersDataModel!.categoryData!;
          }
          if (state.getFiltersDataModel?.dateFilterData != null) {
            dateFilterData = state.getFiltersDataModel!.dateFilterData!;
          }
        }
        // else if(state is EventFiltersSuccessState){
        //   print("Filter Updated 0");
        //   eventCubit.eventModelList.clear();
        //   eventCubit.eventModelList.addAll(state.eventModel ?? []);
        //   eventCubit.initializeEventWrapperData(state.eventModelWrapper!);
        // }
      },
      builder: (context, state) {
        return Container(
          height: AppConstants.responsiveHeight(context) + 30,
          child: PageView(
              controller: _pageController,
              // scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _filters(context, themeCubit),
                _chooseDate(context, themeCubit),
              ]),
        );
      },
    );
  }

  Widget _chooseDate(context, themeCubit) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBarComponent(StringConstants.chooseDate,
              titleFontSize: 18,
              isBackBtnCircular: false,
              centerTitle: false, overrideBackPressed: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          },
              action: IconComponent(
                iconData: Icons.close,
                onTap: () => NavigationUtil.pop(context),
              )),
          Container(
            margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  StringConstants.startDate,
                  style: FontStylesConstants.style16(
                    fontWeight: FontWeight.normal,
                    color: themeCubit.textColor,
                  ),
                ),
                SizedBoxConstants.sizedBoxEightH(),

                TextComponent(
                  "",
                  listOfText: [startingDate],
                  listOfTextStyle: [
                    FontStylesConstants.style22(
                      // fontWeight: FontWeight.normal,
                      color: themeCubit.textColor,
                    ),
                  ],
                  listOfOnPressedFunction: [
                    () {
                      _selectStartDate(context);
                    }
                  ],
                ),

                SizedBoxConstants.sizedBoxThirtyH(),

                TextComponent(
                  StringConstants.endDate,
                  style: FontStylesConstants.style16(
                    fontWeight: FontWeight.normal,
                    color: themeCubit.textColor,
                  ),
                ),
                SizedBoxConstants.sizedBoxEightH(),

                TextComponent(
                  "",
                  listOfText: [endingDate],
                  listOfTextStyle: [
                    FontStylesConstants.style22(
                      // fontWeight: FontWeight.normal,
                      color: themeCubit.textColor,
                    ),
                  ],
                  listOfOnPressedFunction: [
                    () {
                      _selectEndDate(context);
                    }
                  ],
                )

                // TagComponent()
              ],
            ),
          ),
          // SizedBoxConstants.sizedBoxThirtyH(),
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(32).copyWith(bottom: 120),
              // alignment: Alignment.bottomCenter,
              child: ButtonComponent(
                  bgcolor: ColorConstants.white,
                  textColor: themeCubit.backgroundColor,
                  isBold: true,
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                    setState(() {
                      dateFilterData.map((item) {
                        print(" item titel   ${item.title}");
                        return item.title ==
                                StringConstants.chooseDate.toLowerCase()
                            ? {'title': "${startingDate}-${endingDate}"}
                            : item;
                      }).toList();
                    });

                    // dateFilterData.where((element) => element  == StringConstants.chooseDate.toLowerCase()).toList() replace it with slected start date and end date
                  },
                  buttonText: StringConstants.selectDateRange)),
        ],
      ),
    );
  }

  Widget _filters(BuildContext context, ThemeCubit themeCubit) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Container(
            height: AppConstants.responsiveHeight(context) + 80,
            padding: const EdgeInsets.only(
                top: 16.0, left: 32.0, right: 32.0, bottom: 32),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: AppConstants.bottomPadding(context) + 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          StringConstants.filters,
                          style: FontStylesConstants.style18(
                              color: themeCubit.primaryColor),
                        ),
                        IconComponent(
                          iconData: Icons.close,
                          onTap: () => NavigationUtil.pop(context),
                        ),
                      ]),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        StringConstants.date,
                        style: FontStylesConstants.style16(
                          fontWeight: FontWeight.normal,
                          color: themeCubit.textColor,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxEightH(),

                      // Wrap(
                      //   direction: Axis.horizontal,
                      //   children: availableDates.keys.map((e) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(4.0),
                      //       child: TagComponent(
                      //         customIconText: e,
                      //         customFontWeight: availableDates[e]!
                      //             ? FontWeight.w600
                      //             : FontWeight.normal,
                      //         customTextColor: availableDates[e]!
                      //             ? themeCubit.backgroundColor
                      //             : themeCubit.textColor,
                      //         backgroundColor: availableDates[e]!
                      //             ? themeCubit.primaryColor
                      //             : themeCubit.textSecondaryColor
                      //             .withOpacity(0.4),
                      //         customTextSize: 16,
                      //         tagAlignment: null,
                      //         onTap: () {
                      //           setState(() {
                      //             availableDates
                      //                 .updateAll((key, value) => false);
                      //
                      //             // remove selection of all
                      //             availableDates[e] = !availableDates[e]!;
                      //             navigateIfDateChosen(e);
                      //           });
                      //         },
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: dateFilterData.map((e) {
                          bool isSelected = selectedDateFilter == e.slug;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e.title,
                              customFontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: isSelected
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: isSelected
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                navigateIfDateChosen(e.title!);
                                setState(() {
                                  // Deselect all dates
                                  availableDates
                                      .updateAll((key, value) => false);

                                  if (selectedDateFilter != e.slug) {
                                    selectedDateFilter = e.slug;
                                    eventCubit.selectedDateFilter =
                                        selectedDateFilter;
                                  } else {
                                    selectedDateFilter = "";
                                    eventCubit.selectedDateFilter =
                                        selectedDateFilter;
                                  }

                                  availableDates[e.title ?? ""] =
                                      true; // Assuming e.title uniquely identifies each date filter
                                });
                              },
                            ),
                          );
                        }).toList(),
                      )

                      // TagComponent()
                    ],
                  ),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        StringConstants.categories,
                        style: FontStylesConstants.style16(
                          fontWeight: FontWeight.normal,
                          color: themeCubit.textColor,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxEightH(),
                      //
                      // Wrap(
                      //   direction: Axis.horizontal,
                      //   children: categories.keys.map((e) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(4.0),
                      //       child: TagComponent(
                      //         customIconText: e,
                      //         customFontWeight: categories[e]!
                      //             ? FontWeight.w600
                      //             : FontWeight.normal,
                      //         customTextColor: categories[e]!
                      //             ? themeCubit.backgroundColor
                      //             : themeCubit.textColor,
                      //         backgroundColor: categories[e]!
                      //             ? themeCubit.primaryColor
                      //             : themeCubit.textSecondaryColor
                      //             .withOpacity(0.4),
                      //         customTextSize: 16,
                      //         tagAlignment: null,
                      //         onTap: () {
                      //           setState(() {
                      //             // categories.updateAll(
                      //             //     (key, value) => false); // remove selection of all
                      //             categories[e] = !categories[e]!;
                      //           });
                      //         },
                      //       ),
                      //     );
                      //   }).toList(),
                      // )

                      Wrap(
                        direction: Axis.horizontal,
                        children: categoryData.map((e) {
                          bool isSelected =
                              selectedCategories?.contains(e.slug) ?? false;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e.title,
                              customFontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: isSelected
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: isSelected
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                print("selection-------");
                                setState(() {
                                  if (isSelected) {
                                    print("selected removed");
                                    selectedCategories?.remove(e.slug);
                                    eventCubit.selectedCategories =
                                        selectedCategories;
                                  } else {
                                    print("selected");
                                    selectedCategories?.add(e.slug ?? "");
                                    eventCubit.selectedCategories =
                                        selectedCategories;
                                  }
                                });
                                print(
                                    "Selected Categories: ${selectedCategories?.join(", ") ?? "None"}");
                              },
                            ),
                          );
                        }).toList(),
                      )

                      // TagComponent()
                    ],
                  ),
                  SizedBoxConstants.sizedBoxTwentyH(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        StringConstants.price,
                        style: FontStylesConstants.style16(
                          fontWeight: FontWeight.normal,
                          color: themeCubit.textColor,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxEightH(),

                      Wrap(
                        direction: Axis.horizontal,
                        children: priceValue.map((e) {
                          bool isSelected = isFree == e;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e,
                              customFontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: isSelected
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: isSelected
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                setState(() {
                                  // Toggle selection
                                  if (isFree != e) {
                                    isFree = e;
                                    if (isFree == "Free") {
                                      isFreeValue = true;
                                      eventCubit.isFree = isFree;
                                      eventCubit.isFreeValue = isFreeValue;
                                    } else {
                                      isFreeValue = false;
                                      eventCubit.isFree = isFree;
                                      eventCubit.isFreeValue = isFreeValue;
                                    }
                                  } else {
                                    isFreeValue = null;
                                    isFree = null; // Clear selection
                                    eventCubit.isFree = isFree;
                                    eventCubit.isFreeValue = isFreeValue;
                                  }

                                  print("isFree $isFree   isFreeValue ");
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),

                      // TagComponent()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(32).copyWith(bottom: 120),
          // alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ButtonComponent(
                    bgcolor: ColorConstants.white,
                    textColor: themeCubit.backgroundColor,
                    isBold: true,
                    onPressed: () {
                      DateTime selectedStartDate = DateFormat("MMMM d, yyyy").parse(startingDate);
                      DateTime selectedEndDate = DateFormat("MMMM d, yyyy").parse(endingDate);
                      String? startDate = selectedStartDate.toString();
                      String? endDate = selectedEndDate.toString();
                      setState(() {
                      });
                      if(selectedDateFilter != "choose_a_date"){
                        startDate = null;
                        endDate = null;
                      }
                      else{
                        if(startingDate.isNotEmpty && endingDate.isNotEmpty){
                          selectedDateFilter = null;
                          setState(() {
                          });
                        }
                      }


                      eventCubit.sendEventFilters(
                          "1",
                          startDate,
                          endDate,
                          selectedDateFilter,
                          selectedCategories ?? [],
                          isFreeValue);
                      NavigationUtil.pop(context);
                      // ToastComponent.showToast(StringConstants.filtersApplied,
                      //     context: context);
                    },
                    buttonText: StringConstants.applyFilters),
              ),
              SizedBoxConstants.sizedBoxFourW(),
              Expanded(
                child: ButtonComponent(
                    bgcolor: ColorConstants.primaryColor,
                    textColor: themeCubit.backgroundColor,
                    isBold: true,
                    onPressed: () {
                      eventCubit.isFilteredApply = false;
                      eventCubit.selectedDateFilter = null;
                      eventCubit.selectedCategories = [];
                      eventCubit.isFree = null;
                      eventCubit.isFreeValue = null;

                      eventCubit.fetchEventDataByKeys("1");
                      NavigationUtil.pop(context);
                      // ToastComponent.showToast(StringConstants.filtersApplied,
                      //     context: context);
                    },
                    buttonText: StringConstants.clear),
              )
            ],
          ),
        ),
      ],
    );
  }

  void navigateIfDateChosen(String e) {
    if (e.toLowerCase() == StringConstants.chooseDate.toLowerCase()) {
      // availableDates.removeWhere((key, value) => key == e);
      // availableDates.addEntries([

      // ])
      // change "choose a date" to "custom date"
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }
}
