import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';

import '../../constants/font_styles.dart';

class SelectProfileImageScreen extends StatefulWidget {
  final List<String> selectedImages;
  const SelectProfileImageScreen({super.key, required this.selectedImages});

  @override
  State<SelectProfileImageScreen> createState() =>
      _SelectProfileImageScreenState();
}

class _SelectProfileImageScreenState extends State<SelectProfileImageScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late OnboardingCubit onBoardingCubit =
      BlocProvider.of<OnboardingCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  int _currentPage = 0;
  late PageController _pageController;
  final List<ImageProvider> images = [
    const CachedNetworkImageProvider(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    // Replace with your image URL
    const CachedNetworkImageProvider(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const CachedNetworkImageProvider(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    // Replace with your asset path
    // Add more image providers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnBoardingState>(
      listener: (context, state) {
        LoggerUtil.logs('login state: $state');
        if (state is OnBoardingLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        } else if (state is OnBoardingUserDataFirstStepSuccessState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.push(context, RouteConstants.dobScreen);
        }
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: const AppBarComponent(""),
            removeSafeAreaPadding: false,
            bgColor: themeCubit.backgroundColor,
            widget: setProfileImage());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
  }

  Widget setProfileImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                StringConstants.selectYourPicture,
                style: FontStylesConstants.style22(color: ColorConstants.white),
              ),
              SizedBoxConstants.sizedBoxTwelveH(),
              TextComponent(
                StringConstants.chooseAnyOfTheUplodedImages,
                style: FontStylesConstants.style14(
                    color: ColorConstants.lightGray),
                maxLines: 6,
              ),
              SizedBoxConstants.sizedBoxForthyH(),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.selectedImages.length, // imgList.length,
                  itemBuilder: (context, index) {
                    final file = widget.selectedImages[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          // Wrap the Image.network with ClipOval
                          child: Container(
                            width: 200, // Set the width of the oval
                            height: 400, // Set the height of the oval
                            child: Image.file(
                              File(file),
                              fit: BoxFit
                                  .cover, // Use BoxFit.cover to ensure the image covers the oval area
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.selectedImages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 4,
                    width: 15,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
              ),
              if (widget.selectedImages.length - 1 != _currentPage)
                SizedBoxConstants.sizedBoxThirtyH(),
              if (widget.selectedImages.length - 1 != _currentPage)
                Center(
                  child: TextComponent(StringConstants.scrollLeft,
                      style: FontStylesConstants.style14(
                          color: ColorConstants.lightGray)),
                ),
            ],
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: themeCubit.primaryColor,
                textColor: ColorConstants.black,
                buttonText: StringConstants.confirmProfilePicture,
                onPressed: () {
                  onBoardingCubit.userDetailFirstStep("selectedImage");
                }),
          )
        ],
      ),
    );
  }
}
