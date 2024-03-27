import 'dart:ui';

import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: getStarted());
  }

  Widget getStarted() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AssetConstants.splash,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(AssetConstants.done),
          //       fit: BoxFit.cover,
          //     )
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextComponent(
                "Attend Events.",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: themeCubit.backgroundColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              TextComponent(
                "Connect with People.",
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: themeCubit.backgroundColor,
                    fontFamily: FontConstants.fontProtestStrike),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextComponent(
                "It all start here.",
                style:
                    TextStyle(fontSize: 15, color: themeCubit.backgroundColor),
              ),
              const SizedBox(
                height: 60,
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
        body: Stack(
          children: [
            Positioned(
                // top: 130,
                // left: 220,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // gradient: LinearGradient(colors: [
                    //   Color(0xff7c7c7c),
                    //   Color(0xff1c1c1c),
                    //   // Color(0xff9b9b9b),
                    //   // Color(0xff9b9b9b),
                    //   // Color(0xff9b9b9b),
                    // ]),
                    color: ColorConstants.blackLight,
                  ),
                )),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      // color: themeCubit.darkBackgroundColor.withOpacity(0.8),
                    ),
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 30, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextComponent(
                          StringConstants.getStarted,
                          style: TextStyle(
                              color: themeCubit.textColor,
                              fontFamily: FontConstants.fontProtestStrike,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextComponent(
                          StringConstants.connectWithPeople,
                          style: TextStyle(
                              color: ColorConstants.lightGray, fontSize: 15),
                        ),
                        TextComponent(
                          StringConstants.registerCreateManageEvents,
                          style: TextStyle(
                              color: ColorConstants.lightGray, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorConstants.btnGradientColor,
                                Color.fromARGB(255, 220, 210, 210)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          child: ButtonComponent(
                              bgcolor: ColorConstants.transparent,
                              textColor: ColorConstants.black,
                              buttonText: StringConstants.continueWithPhone,
                              onPressedFunction: () {
                                NavigationUtil.push(
                                    context, RouteConstants.signUpNumber);
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
                                NavigationUtil.push(
                                    context, RouteConstants.signUpEmail);
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
                              width: MediaQuery.sizeOf(context).width * 0.42,
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
                                      // Container(
                                      //   height: 25,
                                      //   width: 25,
                                      //   child: Image.asset(
                                      //     AssetConstants.google,
                                      //   ),
                                      // ),
                                      SvgPicture.asset(
                                        height: 20,
                                        AssetConstants.google,
                                        colorFilter: ColorFilter.mode(
                                            themeCubit.backgroundColor,
                                            BlendMode.srcIn),
                                      ),
                                      // Icon(
                                      //   Icons.svg,
                                      //   color: ColorConstants.black,
                                      // )
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
                        // const TextComponent(
                        //   listOfText: [
                        //     StringConstants.agreeToOur,
                        //     StringConstants.termsAndConditions,
                        //   ],
                        // ),

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
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
