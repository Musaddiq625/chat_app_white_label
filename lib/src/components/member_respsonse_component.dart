import 'package:chat_app_white_label/src/components/custom_bubble_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:flutter/material.dart';

import '../constants/font_styles.dart';
import 'contacts_card_component.dart';

class MemberResponseComponent extends StatelessWidget {
  final ContactModel? contact;
  final String name;
  final String url;
  final String title;
  final bool showShareIcon;
  final bool dividerValue;
  final bool isPending;
  final Function()? onTapPending;
  final String? messageValue;
  // final List<Map<String, String>>? questionsAndAnswers;
  final List<EventQuestions>? questionsAndAnswers;
  final List<Question>? questions;

  MemberResponseComponent({
    this.contact,
    this.showShareIcon = false,
    this.dividerValue = false,
    required this.name,
    required this.title,
    required this.url,
    this.messageValue,
    this.questionsAndAnswers,
    this.questions,
    this.onTapPending,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              // margin: EdgeInsets.only(left: 5),
              width:
              AppConstants.responsiveWidth(context, percentage: 63),
              child: ContactCard(
                name: name,
                url: url,
                title: title,
                // contact: contact,
                showShareIcon: showShareIcon,
                showDivider: dividerValue,
                imageSize: 40,
              ),
            ),
            if(isPending == true)
            GestureDetector(
              onTap: onTapPending,
              child: Container(
                // margin:const EdgeInsets.only(right: 0) ,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 3, bottom: 3),
                decoration: const BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // color: themeCubit.darkBackgroundColor,
                ),
                child: TextComponent(StringConstants.pending,
                    textAlign: TextAlign.right),
              ),
            ),
          ],
        ),
        SizedBoxConstants.sizedBoxTenH(),
        Container(
          alignment: Alignment.centerRight,
          width: AppConstants.responsiveWidth(context, percentage: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              if (messageValue != null && (messageValue ?? "").isNotEmpty)
                CustomBubbleComponent(
                  headingValue:   StringConstants.messageForYou,
                  detailValue: messageValue,
                ),
              CustomBubbleComponent(
                  questionAnswerPairs: questionsAndAnswers,
                questions: questions,
              ),
                // Container(
                //   width: AppConstants.responsiveWidth(context, percentage: 65),
                //   decoration: BoxDecoration(
                //     color: ColorConstants.blackLight,
                //     borderRadius: BorderRadius.all(Radius.circular(15)),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       CustomBubbleComponent(
                //         headingValue:   StringConstants.messageForYou,
                //         detailValue: messageValue,
                //       ),
                //       // Padding(
                //       //   padding: const EdgeInsets.only(
                //       //       top: 10.0, left: 20, right: 20, bottom: 10),
                //       //   child: Column(
                //       //     crossAxisAlignment: CrossAxisAlignment.start,
                //       //     children: [
                //       //       TextComponent(
                //       //         StringConstants.messageForYou,
                //       //         style: FontStylesConstants.style14(
                //       //             color: ColorConstants.grey.withOpacity(0.8)),
                //       //         maxLines: 10,
                //       //       ),
                //       //       if (messageValue != null)
                //       //         TextComponent(
                //       //           messageValue!,
                //       //           style: FontStylesConstants.style14(
                //       //               color: ColorConstants.white),
                //       //           maxLines: 10,
                //       //         ),
                //       //     ],
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children:



              //  ...questionsAndAnswers!.asMap().entries.map((entry) {
              //     int index = entry.key;
              //     // Map<String, String> qa = entry.value;
              //     // bool isLast = index == questionsAndAnswers!.length - 1;
              //     return CustomBubbleComponent(
              //       questionAnswerPairs: questionsAndAnswers,
              //       // headingValue:    qa['question']!,
              //       // detailValue: qa['answer'],
              //       // showDivider: !(isLast),
              //     );
              //     //   Column(
              //     //   crossAxisAlignment: CrossAxisAlignment.start,
              //     //   children: [
              //     //     Padding(
              //     //       padding: const EdgeInsets.only(
              //     //           top: 0.0, left: 20, right: 20, bottom: 0),
              //     //       child: Column(
              //     //         crossAxisAlignment: CrossAxisAlignment.start,
              //     //         children: [
              //     //           TextComponent(
              //     //             qa['question']!,
              //     //             style: FontStylesConstants.style14(
              //     //                 color:
              //     //                 ColorConstants.grey.withOpacity(0.8)),
              //     //             maxLines: 10,
              //     //           ),
              //     //           TextComponent(
              //     //             qa['answer']!,
              //     //             style: FontStylesConstants.style14(
              //     //                 color: ColorConstants.white),
              //     //             maxLines: 10,
              //     //           ),
              //     //         ],
              //     //       ),
              //     //     ),
              //     //     if (!isLast) DividerCosntants.divider1,
              //     //     // Only add the divider if it's not the last item
              //     //   ],
              //     // );
              //   }).toList(),

                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                //   child: Column(
                //     children: [
                //       //Question1
                //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.grey.withOpacity(0.8)), maxLines: 10,),
                //      //Answer1
                //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.white), maxLines: 10,),
                //     ],
                //   ),
                // ),
                // DividerCosntants.divider1,
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                //   child: Column(
                //     children: [
                //       //Question2
                //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.grey.withOpacity(0.8)), maxLines: 10,),
                //       //Answer2
                //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.white), maxLines: 10,),
                //     ],
                //   ),
                // ),
              // ),
              // Container(
              //
              //   width: AppConstants.responsiveWidth(context, percentage: 65),
              //   decoration: BoxDecoration(
              //     color: ColorConstants.blackLight,
              //     borderRadius: BorderRadius.all(Radius.circular(15)),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(top:10.0,bottom: 10),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: questionsAndAnswers!.asMap().entries.map((entry) {
              //         int index = entry.key;
              //         Map<String, String> qa = entry.value;
              //         bool isLast = index == questionsAndAnswers!.length - 1;
              //
              //         return Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(
              //                   top: 0.0, left: 20, right: 20, bottom: 0),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   TextComponent(
              //                     qa['question']!,
              //                     style: FontStylesConstants.style14(
              //                         color:
              //                             ColorConstants.grey.withOpacity(0.8)),
              //                     maxLines: 10,
              //                   ),
              //                   TextComponent(
              //                     qa['answer']!,
              //                     style: FontStylesConstants.style14(
              //                         color: ColorConstants.white),
              //                     maxLines: 10,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             if (!isLast) DividerCosntants.divider1,
              //             // Only add the divider if it's not the last item
              //           ],
              //         );
              //       }).toList(),
              //
              //       // Padding(
              //       //   padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
              //       //   child: Column(
              //       //     children: [
              //       //       //Question1
              //       //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.grey.withOpacity(0.8)), maxLines: 10,),
              //       //      //Answer1
              //       //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.white), maxLines: 10,),
              //       //     ],
              //       //   ),
              //       // ),
              //       // DividerCosntants.divider1,
              //       // Padding(
              //       //   padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
              //       //   child: Column(
              //       //     children: [
              //       //       //Question2
              //       //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.grey.withOpacity(0.8)), maxLines: 10,),
              //       //       //Answer2
              //       //       TextComponent("helllo asdasd asdasd asdasdas asdasdasd asdasd asdasd asdasd asdasd asdasd asdasd asdasd", style: FontStylesConstants.style14(color: ColorConstants.white), maxLines: 10,),
              //       //     ],
              //       //   ),
              //       // ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBoxConstants.sizedBoxTenH(),
        // DividerCosntants.divider1,
      ],
    );
  }
}
