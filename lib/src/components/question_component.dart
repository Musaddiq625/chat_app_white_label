import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/icons_button_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../locals_views/create_event_screen/cubit/event_cubit.dart';
import '../utils/firebase_utils.dart';

class QuestionComponent {
  static void selectQuestion(
      BuildContext context,
      List<TextEditingController> questionControllers,
      // List<String> questions,
      Map<int, String> selectedQuestionRequired,
      Map<int, String> selectedQuestionPublic,
      Function(List<Question>) onDone,
      {Map<int, String>? questionId}) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    late EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
    // Map<int, String> selectedQuestionRequired = {};
    // Map<int, String> selectedQuestionPublic = {};
    List<Question> questionsList = eventCubit.eventModel.question ?? [];

    Widget question(StateSetter setStateBottomSheet) {
      late final themeCubit = BlocProvider.of<ThemeCubit>(context);
      final FocusNode buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
      // final FocusScopeNode _focusScopeNode = FocusScopeNode();
      int? draggingIndex;
      return ReorderableListView(
        primary: false,
        shrinkWrap: true,
        buildDefaultDragHandles: questionControllers.length > 1,
        // disable drag&drop if there's only one item

        physics: const NeverScrollableScrollPhysics(),
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Container(
            color: Colors.transparent, // Change this to your desired color
            child: child,
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setStateBottomSheet(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            // final String item = questions.removeAt(oldIndex);
            final TextEditingController controller =
                questionControllers.removeAt(oldIndex);
            // questions.insert(newIndex, item);
            questionControllers.insert(newIndex, controller);
          });
        },
        children: List<Widget>.generate(questionControllers.length, (int index) {
          selectedQuestionRequired[index] ??= 'Required';
          selectedQuestionPublic[index] ??= 'Public';
          return Container(
            key: ValueKey(DateTime.now().microsecondsSinceEpoch.toString()),
            child: Column(children: [
              Row(
                children: [
                  TextComponent(
                    'Question ${index + 1}', //'${questions[index]}',
                    style: TextStyle(color: themeCubit.textColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      setStateBottomSheet(() {
                        questionControllers.removeAt(index);
                        // questions.removeAt(index);// Remove the question
                        print("questionsList.map((e) => e.question); ${questionsList.map((e) => e.question)}");

                      })
                    },
                    child: IconComponent(
                      iconData: Icons.delete,
                      borderColor: ColorConstants.red,
                      backgroundColor: ColorConstants.red,
                      iconColor: ColorConstants.white,
                      iconSize: 15,
                      circleSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBoxConstants.sizedBoxTenH(),
              Container(
                margin: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.lightGray.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width:
                          AppConstants.responsiveWidth(context, percentage: 70),
                      margin: EdgeInsets.only(top: 5),
                      child: Material(
                        color: ColorConstants.transparent,
                        child: TextFieldComponent(
                            // focusNode: buttonFocusNode,
                            key: ValueKey(DateTime.now().microsecondsSinceEpoch.toString()),
                            questionControllers[index],
                            hintText: StringConstants.typeYourQuestion,
                            textColor: themeCubit.textColor,
                            fieldColor: ColorConstants.transparent,
                            filled: true,
                            onChanged: (value) {}),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setStateBottomSheet(() {
                          draggingIndex = index;
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 5),
                          child: IconComponent(
                            iconData: Icons.menu,
                            borderColor: ColorConstants.transparent,
                            backgroundColor: ColorConstants.transparent,
                            iconColor:
                                ColorConstants.lightGray.withOpacity(0.4),
                            iconSize: 25,
                            circleSize: 25,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconComponent(
                    iconData: Icons.keyboard_arrow_down,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    iconColor: ColorConstants.lightGray,
                    iconSize: 25,
                    circleSize: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MenuAnchor(
                        style: MenuStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              themeCubit.backgroundColor),
                        ),
                        childFocusNode: buttonFocusNode,
                        menuChildren: <Widget>[
                          Row(
                            children: [
                              Checkbox(
                                value: selectedQuestionRequired[index] ==
                                    'Required',
                                onChanged: (bool? value) {
                                  print("Required Selected");
                                  if (value != null) {
                                    setStateBottomSheet(() {
                                      selectedQuestionRequired[index] =
                                          'Required';
                                    });
                                  }
                                },
                                shape: const CircleBorder(),
                                activeColor: ColorConstants.primaryColor,
                                checkColor: Colors.black,
                              ),
                              TextComponent(
                                "Required",
                                style: TextStyle(color: themeCubit.textColor),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 0.1,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: selectedQuestionRequired[index] ==
                                    'Optional',
                                onChanged: (bool? value) {
                                  print("Otional Selected $value");
                                  if (value != null) {
                                    setStateBottomSheet(() {
                                      selectedQuestionRequired[index] =
                                          'Optional';
                                    });
                                  }
                                },
                                shape: const CircleBorder(),
                                activeColor: ColorConstants.primaryColor,
                                checkColor: Colors.black,
                              ),
                              TextComponent(
                                "Optional",
                                style: TextStyle(color: themeCubit.textColor),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ],
                        builder: (BuildContext context,
                            MenuController controller, Widget? child) {
                          return TextButton(
                            focusNode: buttonFocusNode,
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: TextComponent(
                              selectedQuestionRequired[index]!,
                              style: const TextStyle(
                                  color: ColorConstants.lightGray),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBoxConstants.sizedBoxTenW(),
                  IconComponent(
                    iconData: Icons.keyboard_arrow_down,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    iconColor: ColorConstants.lightGray,
                    iconSize: 25,
                    circleSize: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MenuAnchor(
                        alignmentOffset: const Offset(-250, 0),
                        style: MenuStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              themeCubit.backgroundColor),
                        ),
                        childFocusNode: buttonFocusNode,
                        menuChildren: <Widget>[
                          Row(
                            children: [
                              Checkbox(
                                value:
                                    selectedQuestionPublic[index] == 'Public',
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    setStateBottomSheet(() {
                                      selectedQuestionPublic[index] = 'Public';
                                    });
                                  }
                                },
                                shape: const CircleBorder(),
                                activeColor: ColorConstants.primaryColor,
                                checkColor: Colors.black,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(
                                    'Public',
                                    style:
                                        TextStyle(color: themeCubit.textColor),
                                  ),
                                  TextComponent(
                                    'Responses can be seen by everyone',
                                    style:
                                        TextStyle(color: themeCubit.textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                          DividerCosntants.divider1,
                          Row(
                            children: [
                              Checkbox(
                                value:
                                    selectedQuestionPublic[index] == 'Private',
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    setStateBottomSheet(() {
                                      selectedQuestionPublic[index] = 'Private';
                                    });
                                  }
                                },
                                shape: const CircleBorder(),
                                activeColor: ColorConstants.primaryColor,
                                checkColor: Colors.black,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(
                                    'Private',
                                    style:
                                        TextStyle(color: themeCubit.textColor),
                                  ),
                                  TextComponent(
                                    'Only host can see the responses',
                                    style:
                                        TextStyle(color: themeCubit.textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          )
                        ],
                        builder: (BuildContext context,
                            MenuController controller, Widget? child) {
                          return TextButton(
                            focusNode: buttonFocusNode,
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: Column(
                              children: [
                                TextComponent(
                                  selectedQuestionPublic[index]!,
                                  style: const TextStyle(
                                      color: ColorConstants.lightGray),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBoxConstants.sizedBoxTenH(),
                ],
              ),
            ]),
          );
        }),
      );
    }
    print("question controller $questionControllers");
    // print("question lenght ${questions.length} questions.value ${questions}");
    BottomSheetComponent.showBottomSheet(context,
        isEnableDrag: false,
        takeFullHeightWhenPossible: false, isShowHeader: false,
        body: PopScope(
          canPop: false,
          child: StatefulBuilder(builder: (context, setState2) {

                print("event cubit questions $questionsList");
                print("event cubit questions ${questionsList.map((e) => e.question)}");
                return Container(
                    // constraints: BoxConstraints(
                        // maxHeight: AppConstants.responsiveHeight(context, percentage: 80)),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBoxConstants.sizedBoxTwentyH(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextComponent(
                          StringConstants.questions,
                          style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontFamily: FontConstants.fontProtestStrike,
                              fontSize: 18),
                        ),
                        InkWell(
                          onTap: ()  {
                            // if( questionControllers[0].value.text.isEmpty)
                            // print("length-- ${  questionControllers[0].value.text}")
                
                            for (int i = 0; i < questionControllers.length; i++)
                              {
                                if (questionControllers[i].value.text.isEmpty)
                                  {
                                    // print(
                                    //     "questions length $i ${questionControllers[i].text} ${questions[i]}  ${questions.length}");
                                    setState2(() {
                                      questionControllers[i].clear();
                                      selectedQuestionPublic[i] = "";
                                      selectedQuestionRequired[i] = "";
                                      selectedQuestionPublic.remove(i);
                                      selectedQuestionRequired.remove(i);
                                      questionControllers.removeAt(i);
                                      // questions.remove(i);
                                      // questions
                                      //     .removeWhere((element) => element == "");
                                      // questionControllers.removeWhere(
                                      //     (element) => element.text == "");
                                      // selectedQuestionPublic.removeWhere(
                                      //     (key, value) => value.isEmpty);
                                      // selectedQuestionRequired.removeWhere(
                                      //     (key, value) => value.isEmpty);
                                      // questions
                                      //     .removeWhere((element) => element == "");
                                    });
                                  }
                                else if(questionControllers[i].value.text.isNotEmpty){
                                  print("2");
                                  if(questionsList.length>0){
                                    for (int j = 0; j < questionControllers.length; j++) {
                                      bool matchFound = false;
                                      for (int k = 0; k < questionsList.length; k++) {
                                        if (questionsList[k].question != null && questionControllers[j].value.text.toString() == questionsList[k].question.toString()) {
                                          matchFound = true;
                                          break; // Found a matching controller, no need to continue checking other controllers
                                        }
                                        // else{
                                        //   matchFound= false;
                                        //   break;
                                        // }
                                      }
                                      if (matchFound) {
                                        print("should not delete");
                                        // print("Should not delete questionsList[${j}].question ${questionsList[j].question} ");
                                      } else {
                                        print("should delete");
                                        // print("Should delete questionsList[${j}].question ${questionsList[j].question} ");
                
                                        setState2(() { // Assuming setState2 was a typo, corrected to setState
                                          questionControllers[j].clear(); // Use k instead of i
                                          selectedQuestionPublic[j] = ""; // Use k instead of i
                                          selectedQuestionRequired[j] = ""; // Use k instead of i
                                          selectedQuestionPublic.remove(j); // Use k instead of i
                                          selectedQuestionRequired.remove(j); // Use k instead of i
                                          questionControllers.removeAt(j); // Use k instead of i
                                          // questions.remove(j); // Use j to remove from questionsList
                                        });
                                        break; // Exit the outer loop after processing
                                      }
                                    }
                                  }
                                  else{
                                    print("3");
                                    setState2(() {
                                      questionControllers[i].clear();
                                      selectedQuestionPublic[i] = "";
                                      selectedQuestionRequired[i] = "";
                                      selectedQuestionPublic.remove(i);
                                      selectedQuestionRequired.remove(i);
                                      questionControllers.removeAt(i);
                                      // questions.removeAt(i);
                                    });
                                  }
                
                                }
                              };
                
                            print(
                                "questions controller ${questionControllers.map((e) => e)}   ");
                            Navigator.pop(context);
                          },
                          child: IconComponent(
                            iconData: Icons.close,
                            borderColor: Colors.transparent,
                            iconColor: Colors.white,
                            circleSize: 20,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    TextComponent(
                      StringConstants.choseToAskQuestion,
                      maxLines: 2,
                      style: TextStyle(color: themeCubit.textColor),
                    ),
                    SizedBoxConstants.sizedBoxSixteenH(),
                    question(setState2),
                    SizedBoxConstants.sizedBoxTwentyH(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWithIconComponent(
                          btnText: '  ${StringConstants.addQuestion}',
                          icon: Icons.add_circle,
                          btnTextStyle: const TextStyle(
                              color: ColorConstants.black,
                              fontWeight: FontWeight.bold),
                          onPressed: () {
                            // setState2(() =>
                            //     // questions.add('Question ${questions.length + 1}')
                            // );
                            setState2((){
                            TextEditingController newController =
                                TextEditingController();
                            // Add the new controller to the _questionControllers list
                            questionControllers.add(newController);

                            });
                          },
                        ),
                        ButtonComponent(
                          isSmallBtn: true,
                          bgcolor: ColorConstants.primaryColor,
                          textColor: ColorConstants.black,
                          buttonText: StringConstants.done,
                
                          onPressed: () {
                            List<Question> questionsList =
                                eventCubit.eventModel.question ?? [];
                            questionsList.clear();
                            for (int i = 0; i < questionControllers.length; i++) {
                              print(
                                  "questions length++ $i ${questionControllers[i].text}");
                              if (questionControllers[i].value.text.isEmpty) {
                                print(
                                    "questions length $i ${questionControllers[i].text}  ");
                                setState2(() {
                                  questionControllers.removeAt(i);
                                  selectedQuestionPublic.remove(i);
                                  selectedQuestionRequired.remove(i);
                                  // questions.removeAt(i);
                                  // questions.removeWhere((element) => element == "");
                                  // questionControllers
                                  //     .removeWhere((element) => element.text == "");
                                  // selectedQuestionPublic
                                  //     .removeWhere((key, value) => value.isEmpty);
                                  // selectedQuestionRequired
                                  //     .removeWhere((key, value) => value.isEmpty);
                                  // questions.removeWhere((element) => element == "");
                                });
                              }
                              LoggerUtil.logs("questionControllers ${questionControllers[i].value.text}  ${selectedQuestionPublic[i]}   ${selectedQuestionRequired[i]}");
                              Question newQuestion = Question(
                                questionId: questionId?[i] ??
                                    FirebaseUtils.getDateTimeNowAsId(),
                                // Assuming you have a mechanism to generate unique IDs
                                question: questionControllers[i].value.text,
                                // Pass the entire list of controllers
                                isPublic: selectedQuestionPublic[
                                            questionControllers[i]] ==
                                        "Public"
                                    ? true
                                    : false,
                                isRequired: selectedQuestionRequired[
                                            questionControllers[i]] ==
                                        "Required"
                                    ? true
                                    : false,
                                sequence: i + 1,
                              );
                              questionsList.add(newQuestion);
                            }
                            questionsList
                                .removeWhere((element) => element.question == "");
                            onDone(questionsList);
                            NavigationUtil.pop(context);
                          },
                          // onPressed: () {
                          //
                          //   List<Question> questionsList = eventCubit.eventModel.question?? [];
                          //   for(int i = 0; i < questionControllers.length; i++){
                          //     LoggerUtil.logs("questionControllers ${questionControllers[i].value.text}  ${selectedQuestionPublic[i]}   ${selectedQuestionRequired[i]}");
                          //     Question newQuestion = Question(
                          //       questionId: "auto", // Assuming you have a mechanism to generate unique IDs
                          //       question: questionControllers[i].value.text, // Pass the entire list of controllers
                          //       isPublic: selectedQuestionPublic[questionControllers[i]]=="Public"?true:false ,
                          //       isRequired: selectedQuestionRequired[questionControllers[i]]=="Required"?true:false ,
                          //     );
                          //     questionsList.add(newQuestion);
                          //   }
                          //   eventCubit.eventModel.copyWith(question: questionsList);
                          //   // NavigationUtil.pop(context);
                          //
                          //   LoggerUtil.logs("eventCubit.eventModel.questions ${eventCubit.eventModel.question}");
                          // },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
              }),
        ));
  }
}
