import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SearchTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  const SearchTextFieldComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for people, conversations..',
          hintStyle: const TextStyle(
            color: ColorConstants.grey,
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: const Icon(
            Icons.search,
            color: ColorConstants.grey,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
