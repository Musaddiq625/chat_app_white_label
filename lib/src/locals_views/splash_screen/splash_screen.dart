import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bottom_sheet_component.dart';
import '../../components/button_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgImage:
            "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: getStarted());
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                "Attend Events.",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: themeCubit.backgroundColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
               Text(
                "Connect with People.",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: themeCubit.backgroundColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "It all start here.",
                style: TextStyle(fontSize: 15, color: themeCubit.backgroundColor),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: ButtonComponent(
                    bgcolor: themeCubit.backgroundColor,
                    textColor: themeCubit.primaryColor,
                    buttonText: StringConstants.getStarted,
                    onPressedFunction: () {
                      _showJoinBottomSheet();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  _showJoinBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: themeCubit.darkBackgroundColor.withOpacity(0.8),
          ),
          padding: const EdgeInsets.only(top: 20.0, left: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                StringConstants.getStarted,
                style: TextStyle(
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                StringConstants.connectWithPeople,
                style: TextStyle(color: ColorConstants.lightGray, fontSize: 15),
              ),
              Text(
                StringConstants.registerCreateManageEvents,
                style: TextStyle(color: ColorConstants.lightGray, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ButtonComponent(
                    bgcolor: ColorConstants.btnGradientColor,
                    textColor: ColorConstants.black,
                    buttonText: StringConstants.continueWithPhone,
                    onPressedFunction: () {
                      _showJoinBottomSheet();
                    }),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ButtonComponent(
                    bgcolor: ColorConstants.lightGray,
                    textColor: themeCubit.textColor,
                    buttonText: StringConstants.continueWithEmail,
                    onPressedFunction: () {
                      _showJoinBottomSheet();
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 9.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apple,
                              color: ColorConstants.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.42,
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 9.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstants.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apple,
                              color: ColorConstants.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: StringConstants.agreeToOur,
                      style: TextStyle(
                          color: ColorConstants.lightGray,
                          fontSize: 15), // Change the color here
                    ),
                    TextSpan(
                      text: StringConstants.termsAndConditions,
                      style: TextStyle(
                          color: ColorConstants.lightGray,
                          decoration: TextDecoration.underline,
                          fontSize: 15), // Change the color here
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
