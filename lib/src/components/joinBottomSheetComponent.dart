import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/creatorQuestionAnswers.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JoinBottomSheet {
  static navigateToBack(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
  }

  static showJoinBottomSheet(
    BuildContext context,
    TextEditingController messageController,
    String name,
    String detail,
    String messageFor,
    String messageForImage, {
    List<String>? questions,
  }) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            // color: themeCubit.darkBackgroundColor,
          ),
          // padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(StringConstants.join,
                            style: FontStylesConstants.style18(
                                color: themeCubit.primaryColor)),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: IconComponent(
                            iconData: Icons.close,
                            borderColor: Colors.transparent,
                            iconColor: themeCubit.textColor,
                            circleSize: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextComponent(name,
                              maxLines: 3,
                              style: FontStylesConstants.style28(
                                  color: ColorConstants.white)),
                        ),
                        Image.asset(
                          AssetConstants.ticketWithCircle,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    TextComponent(detail,
                        style: FontStylesConstants.style14(
                            color: ColorConstants.white)),
                    SizedBoxConstants.sizedBoxTwentyH(),
                  ],
                ),
              ),
              if (questions != null) DividerCosntants.divider1,
              if (questions != null) questionsFromCreatorComponent(questions),
              DividerCosntants.divider1,
              messageComponent(messageController, messageFor, messageForImage),
              DividerCosntants.divider1,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      StringConstants.somethingToKnow,
                      style: TextStyle(
                          color: themeCubit.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.chatMsg,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.clock,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxForthyH(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: ButtonComponent(
                  buttonText: StringConstants.join,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    // sendMessage(messageController);
                    Navigator.pop(context);
                    navigateToBack(context);
                    BottomSheetComponent.showBottomSheet(
                      context,
                      isShowHeader: false,
                      body: InfoSheetComponent(
                        heading: StringConstants.requestSent,
                        body: StringConstants.requestStatus,
                        image: AssetConstants.paperPlaneImage,
                        // svg: true,
                      ),
                      // whenComplete:_navigateToBack(),
                    );
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
              ),
              SizedBoxConstants.sizedBoxTenH()
            ],
          ),
        ));
  }

  static messageComponent(TextEditingController controller, String messageFor,
      String messageForImage) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              ProfileImageComponent(
                url: messageForImage,
                size: 30,
              ),
              SizedBoxConstants.sizedBoxTenW(),
              TextComponent(
                "Message for ${messageFor}",
                style: FontStylesConstants.style18(
                    color: ColorConstants.primaryColor),
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextComponent(
            StringConstants.doYouHaveQuestion,
            style: FontStylesConstants.style14(color: ColorConstants.white),
            maxLines: 4,
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextFieldComponent(
            controller,
            filled: true,
            textFieldFontSize: 12,
            hintText: StringConstants.typeYourMessage,
            fieldColor: ColorConstants.lightGray.withOpacity(0.5),
            maxLines: 4,
            minLines: 4,
          ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  static questionsFromCreatorComponent(List<String> questions) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            StringConstants.questionsFromCreator,
            style:
                FontStylesConstants.style18(color: ColorConstants.primaryColor),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Column(
            children: [
              CreatorQuestionsAnswer(questions: questions),
            ],
          ),
          // TextComponent(
          //   StringConstants.doYouHaveQuestion,
          //   style: FontStylesConstants.style14(color: ColorConstants.white),
          //   maxLines: 4,
          // ),
          // SizedBoxConstants.sizedBoxTenH(),
          // TextFieldComponent(
          //   _messageController,
          //   filled: true,
          //   textFieldFontSize: 12,
          //   hintText: StringConstants.typeYourAnswer,
          //   fieldColor: ColorConstants.lightGray.withOpacity(0.5),
          //   maxLines: 4,
          // ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  void _sendMessage(TextEditingController controller) {
    // if (controller.text.isNotEmpty) {
    //   setState(() {
    //     controller.text;
    //     controller.clear();
    //   });
    // }
  }
}
