import 'dart:math';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/choose_image_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/about_you_screen.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  final data = [1, 2, 1, 15, 54, 15, 5];

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

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      appBar: AppBarComponent(
        StringConstants.editProfile,
        isBackBtnCircular: false,
        centerTitle: false,
        action: TextComponent(StringConstants.saveChanges,
            style: TextStyle(
              fontSize: 14,
              color: themeCubit.textColor,
            )),
      ),
      removeSafeAreaPadding: false,
      bgColor: themeCubit.backgroundColor,
      widget: SingleChildScrollView(
        child: Column(
          children: [
            ReorderableGridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(16),
              childAspectRatio: 0.85,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  final element = data.removeAt(oldIndex);
                  data.insert(newIndex, element);
                });
              },
              children: data
                  .map((e) => ChooseImageComponent(
                        selectedImages: [],
                        key: ValueKey('value ${Random().nextInt(1000)}'),
                      ))
                  .toList(),
            ),
            TextComponent(StringConstants.dragAndHold,
                style: TextStyle(color: themeCubit.textColor)),
            SizedBoxConstants.sizedBoxTenH(),
            const DividerComponent(),
            const AboutYouScreen(
              comingFromEditProfile: true,
            ),
            const DividerComponent(),

            Container(
              width: AppConstants.responsiveWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextComponent(StringConstants.myInterests,
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.lightGray,
                          )),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Container(
                      width: AppConstants.responsiveWidth(context),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeCubit.darkBackgroundColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Wrap(
                          children: interestTagList
                              .map((tag) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: TagComponent(
                                            iconData: tag['iconData'],
                                            customTextColor:
                                                themeCubit.textColor,
                                            backgroundColor: ColorConstants
                                                .lightGray
                                                .withOpacity(0.3),
                                            iconColor: themeCubit.primaryColor,
                                            customIconText: tag['name'],
                                            circleHeight: 35,
                                            iconSize: 20,
                                          ),
                                        ),
                                        // SizedBoxConstants.sizedBoxTenW(),
                                      ]))
                              .toList()),
                    ),
                  ]),
            ),
            const DividerComponent(),

            // PersonalInfoWidget(),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
