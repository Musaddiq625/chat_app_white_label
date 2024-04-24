import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    "Music": false,
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

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextComponent(
              StringConstants.filters,
              style:
                  FontStylesConstants.style18(color: themeCubit.primaryColor),
            ),
            IconComponent(
              iconData: Icons.close,
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                StringConstants.date,
                style: FontStylesConstants.style18(),
              ),
              TagComponent()
            ],
          )
        ],
      ),
    );
  }
}
