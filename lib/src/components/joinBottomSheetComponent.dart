

import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/creatorQuestionAnswers.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/models/message_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../locals_views/create_event_screen/cubit/event_cubit.dart';
import '../locals_views/on_boarding/cubit/onboarding_cubit.dart';

class JoinBottomSheet {
  static navigateToBack(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      NavigationUtil.pop(context);
    });
  }

  static showJoinBottomSheet(
    BuildContext context,
    TextEditingController messageController,
    String eventId,
    String? userId,
    String? userName,
    String? userImage,
    String name,
    String detail,
    String messageFor,
    String messageForImage, {
    List<Question>? questions,
  }) {
    print("userName ${userName} userimage ${userImage}");
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
    // late final evenCubit = BlocProvider.of<EventCubit>(context);
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state is SendEventRequestLoadingState) {
              LoadingDialog.showLoadingDialog(context);
            } else if (state is SendEventRequestSuccessState) {
              LoadingDialog.hideLoadingDialog(context);
              messageController.clear();
              // eventCubit.eventRequestModel = EventRequestModel();
              Navigator.pop(context);
              BottomSheetComponent.showBottomSheet(
                context,
                isShowHeader: false,
                body: InfoSheetComponent(
                  heading: StringConstants.requestSent,
                  body: StringConstants.requestStatus,
                  image: AssetConstants.paperPlaneImage,
                  // svg: true,
                ),
              ).then((_) {
               // navigateToBack();
              });
            } else if (state is SendEventRequestFailureState) {
              LoadingDialog.hideLoadingDialog(context);
              ToastComponent.showToast(state.toString(), context: context);
            }
          },
          builder: (context, state) {
            late final eventCubit = BlocProvider.of<EventCubit>(context);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                // color: themeCubit.darkBackgroundColor,
              ),
              // padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 10),
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
                              onTap: () => {
                                messageController.clear(),
                                Navigator.pop(context)},
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
                  if (questions != null && questions.isNotEmpty) DividerCosntants.divider1,
                  if (questions != null && questions.isNotEmpty)
                    questionsFromCreatorComponent(questions),
                  DividerCosntants.divider1,
                  messageComponent(
                      context, messageController, userName?? "", userImage?? ""),
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
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: ButtonComponent(
                      buttonText: StringConstants.join,
                      textColor: themeCubit.backgroundColor,
                      onPressed: () {

                        eventCubit.eventRequestModel =
                            eventCubit.eventRequestModel.copyWith(
                                id: FirebaseUtils.getDateTimeNowAsId(),
                              query: eventCubit.query,
                            );
                        print("eventCubit.eventRequestModel ${eventCubit.eventRequestModel.toJson()}");
                        eventCubit.sendEventRequest(eventId, eventCubit.eventRequestModel);
                        // sendMessage(messageController);
                      },
                      bgcolor: themeCubit.primaryColor,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxTenH()
                ],
              ),
            );
          },
        ));
  }


  static showJoinBottomSheetGroup(
      BuildContext context,
      TextEditingController messageController,
      String eventId,
      String requestStatus,
      String? userId,
      String? userName,
      String? userImage,
      String name,
      String detail,
      String messageFor,
      String messageForImage, {
        List<Question>? questions,
      }) async{
    UserModel? userModel;
    String phoneNumber;
    String myId;
    String myName;
    final serializedUserModel = await getIt<SharedPreferencesUtil>()
        .getString(SharedPreferenceConstants.userModel);
    userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));

    myId= userModel.id!;
    phoneNumber= userModel.phoneNumber!;
    myName= "${userModel.firstName} ${userModel.lastName}";

    print("userName ${userName} userimage ${userImage}");
    print("myName ${myName} phoneNumber ${phoneNumber} userId ${userId}");
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
    // late final evenCubit = BlocProvider.of<EventCubit>(context);
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state is SendEventRequestLoadingState) {
              LoadingDialog.showLoadingDialog(context);
            } else if (state is SendEventRequestSuccessState) {
              LoadingDialog.hideLoadingDialog(context);
              messageController.clear();
              // eventCubit.eventRequestModel = EventRequestModel();
              Navigator.pop(context);
              BottomSheetComponent.showBottomSheet(
                context,
                isShowHeader: false,
                body: InfoSheetComponent(
                  heading: StringConstants.requestSent,
                  body: StringConstants.requestStatus,
                  image: AssetConstants.paperPlaneImage,
                  // svg: true,
                ),
              ).then((_) {
                // navigateToBack();
              });
            } else if (state is SendEventRequestFailureState) {
              LoadingDialog.hideLoadingDialog(context);
              ToastComponent.showToast(state.toString(), context: context);
            }
          },
          builder: (context, state) {
            late final eventCubit = BlocProvider.of<EventCubit>(context);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                // color: themeCubit.darkBackgroundColor,
              ),
              // padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20.0, left: 20, right: 10),
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
                              onTap: () => {
                                messageController.clear(),
                                Navigator.pop(context)},
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
                  if (questions != null && questions.isNotEmpty) DividerCosntants.divider1,
                  if (questions != null && questions.isNotEmpty)
                    questionsFromCreatorComponent(questions),
                  DividerCosntants.divider1,
                  messageComponent(
                      context, messageController, userName?? "", userImage?? ""),
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
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: ButtonComponent(
                      buttonText: StringConstants.join,
                      textColor: themeCubit.backgroundColor,
                      onPressed: () async{
                        await ChatUtils.addMoreMembersToGroupChat(
                          eventId ?? "",
                          [phoneNumber] ?? [],
                        );
                        await ChatUtils.sendGropuMessage(
                          groupChatId: eventId,
                          msg: "${userName}#%#added ${myName}",
                          type: MessageType.info,
                        );
                        eventCubit.eventRequestModel =
                            eventCubit.eventRequestModel.copyWith(
                              id: FirebaseUtils.getDateTimeNowAsId(),
                              query: eventCubit.query,
                            );
                        print("eventCubit.eventRequestModel ${eventCubit.eventRequestModel.toJson()}");
                        eventCubit.sendGroupJoinRequest(eventId,requestStatus,eventCubit.eventRequestModel);
                        // sendMessage(messageController);
                      },
                      bgcolor: themeCubit.primaryColor,
                    ),
                  ),
                  SizedBoxConstants.sizedBoxTenH()
                ],
              ),
            );
          },
        ));
  }


  static messageComponent(
      BuildContext context,
      TextEditingController controller,
      String messageFor,
      String messageForImage) {
    late final evenCubit = BlocProvider.of<EventCubit>(context);
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
                "Message for $messageFor",
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
            onChanged: (_) {
              evenCubit.addEventRequestQuery(controller.value.text);
            },
          ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  static questionsFromCreatorComponent(List<Question> questions) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            StringConstants.questionsFromCreator,
            style:
                FontStylesConstants.style18(color: ColorConstants.primaryColor),
            maxLines: 5,
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
