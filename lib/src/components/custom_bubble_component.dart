import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:flutter/material.dart';

class CustomBubbleComponent extends StatelessWidget {
  // final List<Map<String, String>>? questionAnswerPairs;
  final List<EventQuestions>? questionAnswerPairs;
  final List<Question>? questions;

  final String? headingValue;
  final String? detailValue;
  final Color bgColor;
  final double borderRadius;
  final double padding;
  final bool showDivider;

  CustomBubbleComponent({
    Key? key,
    this.headingValue,
    this.detailValue,
    this.questionAnswerPairs,
    this.questions,
    this.showDivider = false,
    this.bgColor = ColorConstants.blackLight,
    this.borderRadius = 15.0,
    this.padding = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // late final viewYourEventCubit =
    // BlocProvider.of<ViewYourEventScreenCubit>(context);
    // final List<Question>? questions;
    // questions = viewYourEventCubit.eventModel.question;
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      width: AppConstants.responsiveWidth(context, percentage: 65),
      // Adjust width as needed
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (headingValue != null && detailValue != null)
            Padding(
              padding: EdgeInsets.only(
                  top: padding, left: 20, right: 20, bottom: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (headingValue != null)
                    TextComponent(
                      headingValue!,
                      style: FontStylesConstants.style14(
                          color: ColorConstants.grey.withOpacity(0.8)),
                      maxLines: 10,
                    ),
                  if (detailValue != null)
                    TextComponent(
                      detailValue!,
                      style: FontStylesConstants.style14(
                          color: ColorConstants.white),
                      maxLines: 10,
                    ),
                ],
              ),
            ),
          if (questionAnswerPairs != null) SizedBoxConstants.sizedBoxTenH(),
          if (questionAnswerPairs != null)
            ..._buildQuestionAnswerPairs(context),
          if (questionAnswerPairs != null) SizedBoxConstants.sizedBoxTwentyH(),
          if (showDivider) DividerCosntants.divider1
        ],
      ),
    );
  }

  List<Widget> _buildQuestionAnswerPairs(BuildContext context) {
    List<Widget> widgets = [];
    EventQuestions qa;
    Question question;
    if (questionAnswerPairs != null) {
      for (int i = 0; i < (questionAnswerPairs ?? []).length; i++) {
        qa = questionAnswerPairs![i];
        for (int j = 0; j < (questions ?? []).length; j++) {
          question = questions![j];
          widgets.add(
            Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(qa.questionId == question.questionId)
                  TextComponent(
                    question.question!,
                    style: FontStylesConstants.style14(
                        color: ColorConstants.grey.withOpacity(0.8)),
                    maxLines: 10,
                  ),
                  if(qa.questionId == question.questionId)
                  TextComponent(
                    qa.answer!,
                    style:
                    FontStylesConstants.style14(color: ColorConstants.white),
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          );
          if(qa.questionId == question.questionId) {
            if (i < questionAnswerPairs!.length - 1) {
              widgets.add(DividerCosntants.divider1);
            }
          }
        }


      }
    }
    return widgets;
  }
}
