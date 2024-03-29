import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/create_event_tile_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../components/ui_scaffold.dart';
import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: onBoarding());
  }

  Widget onBoarding() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: enterName(),
      ),
    );
  }

  enterName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:()=> NavigationUtil.pop(context),
                  child: IconComponent(
                    iconData: Icons.arrow_back_ios_new_outlined,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.iconBg,
                    iconColor: ColorConstants.white,
                    circleSize: 30,
                    iconSize: 20,
                  ),
                ),
                TextComponent(StringConstants.skip,
                    style: TextStyle(
                      fontSize: 14,
                      color: themeCubit.textColor,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextComponent(
              StringConstants.tellUsABitAboutYourSelf,
              style: TextStyle(
                  fontSize: 22,
                  color: themeCubit.textColor,
                  fontFamily: FontConstants.fontProtestStrike),
            ),
            SizedBox(
              height: 10,
            ),
            TextComponent(
              StringConstants.alsoDoThisLaterInProfile,
              style: TextStyle(
                fontSize: 12,
                color: ColorConstants.lightGray,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextComponent(
              StringConstants.bio,
              style: TextStyle(
                fontSize: 12,
                color: themeCubit.textColor,
              ),
            ),
            TextFieldComponent(
              _bioController,
              hintText: StringConstants.bioHint,
              maxLines: 5,
              textColor: themeCubit.textColor,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 0.4,
            ),
            socials(),
            moreAboutYou(),
          ],
        ),
        SizedBox(height: 30,),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ButtonComponent(
              bgcolor: themeCubit.primaryColor,
              textColor: themeCubit.backgroundColor,
              buttonText: StringConstants.continues,
              onPressedFunction: () {
                NavigationUtil.push(context, RouteConstants.interestScreen);
              }),
        )
      ],
    );
  }

  socials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextComponent(StringConstants.socials,
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.lightGray,
            )),
        CreateEventTileComponent(
            // icon: Icons.location_on,
            // iconColor: ColorConstants.white,
            iconText: StringConstants.linkedIn,
            subIcon: Icons.add_circle,
            subIconColor: themeCubit.textColor,
            subText: "",
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
            // icon: Icons.location_on,
            // iconColor: ColorConstants.white,
            iconText: StringConstants.instagram,
            subIcon: Icons.check_circle,
            subIconColor: themeCubit.primaryColor,
            subText: "Connected",
            subTextColor: themeCubit.primaryColor,
            onTap: () {}),
      ],
    );
  }

  moreAboutYou(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextComponent(StringConstants.moreAboutYou,
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.lightGray,
            )),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.diet,
            subIconColor: themeCubit.textColor,
            subText: "Love Meat",
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.workout,
            subIconColor: themeCubit.primaryColor,
            subText: "Very Active",
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.height,
            subIconColor: themeCubit.primaryColor,
            subText: "5'8",
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.weight,
            subIconColor: themeCubit.primaryColor,
            subText: "",
            subTextColor: themeCubit.textColor,
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.smoking,
            subIconColor: themeCubit.primaryColor,
            subText: "No",
            subTextColor: themeCubit.textColor,
            onTap: () {}),
        SizedBox(height: 10,),
        CreateEventTileComponent(
          // icon: Icons.location_on,
          // iconColor: ColorConstants.white,
            iconText: StringConstants.drinking,
            subIconColor: themeCubit.primaryColor,
            subText: "No",
            subTextColor: themeCubit.textColor,
            onTap: () {}),
      ],
    );
  }
}
