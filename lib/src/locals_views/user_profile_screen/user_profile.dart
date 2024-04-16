import 'dart:io';

import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/icon_component.dart';
import '../../components/profile_image_component.dart';
import '../../components/text_component.dart';
import '../../constants/asset_constants.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  File? selectedImage;
  String? imageUrl;
  bool isEdit = false;
  String userName = "Emily Rose";

  final List<ImageProvider> images = [
    const NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    const NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const NetworkImage(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    const NetworkImage(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    const NetworkImage(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const NetworkImage(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget main() {
    return Column(
      children: [
        topBar(),
        profile(),
      ],
    );
  }

  Widget topBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            StringConstants.account,
            style: FontStylesConstants.style28(color: themeCubit.primaryColor),
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: ColorConstants.iconBg,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: themeCubit.darkBackgroundColor,
                  ),
                  child: Row(
                    children: [
                      IconComponent(
                        // iconData: Icons.facebook,
                        svgDataCheck: false,
                        svgData: AssetConstants.applePay,
                        // borderColor: Colors.red,
                        backgroundColor: ColorConstants.transparent,
                        iconSize: 100,
                        borderSize: 0,
                        // circleSize: 30,
                        // circleHeight: 30,
                      ),
                      SizedBoxConstants.sizedBoxTenW(),
                      TextComponent(
                        StringConstants.earnings,
                        style: FontStylesConstants.style16(
                            color: ColorConstants.white),
                      ),
                    ],
                  )),
              SizedBoxConstants.sizedBoxTenW(),
              IconComponent(
                iconData: Icons.settings,
                svgDataCheck: false,
                // svgData: AssetConstants.applePay,
                // borderColor: Colors.red,
                backgroundColor: ColorConstants.iconBg,
                iconSize: 20,
                borderSize: 0,
                circleSize: 35,
                // circleHeight: 30,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundImage: (selectedImage != null
                        ? FileImage(selectedImage!)
                        : isEdit == true && imageUrl != null
                            ? NetworkImage(imageUrl ?? '')
                            : const AssetImage(AssetConstants.profileDummy))
                    as ImageProvider,
              ),
              Positioned(
                  right: 5,
                  bottom: 5,
                  child: GestureDetector(
                    onTap: () async {
                      if (selectedImage == null) {
                        final XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            selectedImage = File(image.path);
                          });
                        }
                      } else {
                        setState(() {
                          selectedImage = null;
                        });
                      }
                    },
                    child: IconComponent(
                      iconData: selectedImage == null
                          ? Icons.edit
                          : Icons.cancel_outlined,
                      svgDataCheck: false,
                      // svgData: AssetConstants.applePay,
                      // borderColor: Colors.red,
                      backgroundColor: ColorConstants.primaryColor,
                      iconColor: ColorConstants.black,
                      iconSize: 20,
                      borderSize: 0,
                      circleSize: 35,
                    ),
                  ))
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextComponent(
            userName,
            style: FontStylesConstants.style20(),
          ),
          SizedBoxConstants.sizedBoxSixtyH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: FontStylesConstants.style20(
                      color: themeCubit.primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${StringConstants.connections}  ",
                    ),
                    TextSpan(
                      text: "387",
                      style: FontStylesConstants.style20(
                          color: ColorConstants.lightGray.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(
                    "See all",
                    style: FontStylesConstants.style15(
                        color: ColorConstants.lightGray.withOpacity(0.8)),
                  ),
                  SizedBoxConstants.sizedBoxTenW(),
                  IconComponent(
                    iconData: Icons.arrow_forward_ios,
                    backgroundColor: ColorConstants.transparent,
                    borderColor: ColorConstants.transparent,
                    iconSize: 18,
                    borderSize: 0,
                    circleSize: 18,
                    iconColor: ColorConstants.lightGray,
                  )
                ],
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      child: ProfileImageComponent(
                        url: images[index].toString(),
                        size: 50,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
