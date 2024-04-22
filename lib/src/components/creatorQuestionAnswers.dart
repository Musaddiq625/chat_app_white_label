import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:flutter/material.dart';

class CreatorQuestionsAnswer extends StatefulWidget {
  final List<String> questions;

  CreatorQuestionsAnswer({required this.questions});

  @override
  _CreatorQuestionsAnswerState createState() => _CreatorQuestionsAnswerState();
}

class _CreatorQuestionsAnswerState extends State<CreatorQuestionsAnswer> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.questions.length, (index) => TextEditingController());
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
          String question = entry.value;
          return Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
            child: TextFieldComponent(
              _controllers[index],
              title:question,
              filled: true,
              maxLines: 4,
            ),
          );
        }).toList(),
      ),
    );
  }
}