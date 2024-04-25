import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

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
    StringConstants.today: false,
    "Free": true,
    "Paid": false,
  };

  late PageController _pageController = PageController(initialPage: 0);

  String startingDate = DateFormat.yMMMMd().format(DateTime.now());
  String endingDate = DateFormat.yMMMMd().format(DateTime.now());
  Future<void> _selectDate(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
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
                      _selectDate(context);
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
                      _selectDate(context);
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
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
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

                      Wrap(
                        direction: Axis.horizontal,
                        children: availableDates.keys.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e,
                              customFontWeight: availableDates[e]!
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: availableDates[e]!
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: availableDates[e]!
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                setState(() {
                                  availableDates.updateAll((key, value) =>
                                      false); // remove selection of all
                                  availableDates[e] = !availableDates[e]!;
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

                      Wrap(
                        direction: Axis.horizontal,
                        children: categories.keys.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e,
                              customFontWeight: categories[e]!
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: categories[e]!
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: categories[e]!
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                setState(() {
                                  // categories.updateAll(
                                  //     (key, value) => false); // remove selection of all
                                  categories[e] = !categories[e]!;
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
                        StringConstants.price,
                        style: FontStylesConstants.style16(
                          fontWeight: FontWeight.normal,
                          color: themeCubit.textColor,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxEightH(),

                      Wrap(
                        direction: Axis.horizontal,
                        children: price.keys.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TagComponent(
                              customIconText: e,
                              customFontWeight: price[e]!
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              customTextColor: price[e]!
                                  ? themeCubit.backgroundColor
                                  : themeCubit.textColor,
                              backgroundColor: price[e]!
                                  ? themeCubit.primaryColor
                                  : themeCubit.textSecondaryColor
                                      .withOpacity(0.4),
                              customTextSize: 16,
                              tagAlignment: null,
                              onTap: () {
                                setState(() {
                                  price.updateAll((key, value) =>
                                      false); // remove selection of all
                                  price[e] = !price[e]!;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      )

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
            child: ButtonComponent(
                bgcolor: ColorConstants.white,
                textColor: themeCubit.backgroundColor,
                isBold: true,
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
                buttonText: StringConstants.applyFilters)),
      ],
    );
  }
}
