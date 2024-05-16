import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/locals_views/create_event_screen/cubit/event_cubit.dart';
import 'package:chat_app_white_label/src/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorQuestionsAnswer extends StatefulWidget {
  final List<Question> questions;

  CreatorQuestionsAnswer({required this.questions});

  @override
  _CreatorQuestionsAnswerState createState() => _CreatorQuestionsAnswerState();
}

class _CreatorQuestionsAnswerState extends State<CreatorQuestionsAnswer> {
  List<TextEditingController> _controllers = [];
  late final eventCubit = BlocProvider.of<EventCubit>(context);
  late List<EventQuestions> questionsAnswer ;
  Set<int> _processedIndex = {};
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.questions.length, (index) => TextEditingController());
    questionsAnswer=eventCubit.eventRequestModel.eventQuestions?? [];
    questionsAnswer.clear();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.questions.asMap().entries.map((entry) {
          int index = entry.key;
          String question = (entry.value.question ?? "") ;
          return Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(question,maxLines: 6,style: FontStylesConstants.style14(color: Colors.white),),
                TextFieldComponent(
                  _controllers[index],
                  // title:question,
                  filled: true,
                  maxLines: 4,
                  onChanged: (_){
                    if (!_processedIndex.contains(index) ) {
                      EventQuestions eventQuestionReply = EventQuestions(
                          questionId: entry.value.questionId,
                          answer: _controllers[index].value.text
                      );
                      questionsAnswer.add(eventQuestionReply);
                      eventCubit.addEventRequestAnswers(questionsAnswer);
                      // Update the set of processed indices
                      setState(() {
                        _processedIndex.add(index);
                      });
                      print("questionsAnswerValues  ${questionsAnswer.map((e) => e.answer)}");
                    }
                    else if(_processedIndex.contains(index)){
                      EventQuestions existingReply = questionsAnswer[index];
                      existingReply.answer = _controllers[index].value.text; // Update the answer
                      eventCubit.addEventRequestAnswers(questionsAnswer);
                      print("eventCubit.eventRequestAnswer ${eventCubit.eventRequestModel.eventQuestions?.map((e) => e.answer)}");// Update the list in eventCubit
                      print("Updated questionsAnswerValues  ${questionsAnswer.map((e) => e.answer)}");
                    }
                    // EventQuestions eventQuestionReply= EventQuestions(
                    //   questionId: entry.value.questionId,
                    //   answer: _controllers[index].value.text
                    // );
                    // questionsAnswer.add(eventQuestionReply);
                    // eventCubit.addEventRequestAnswers(questionsAnswer);
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}