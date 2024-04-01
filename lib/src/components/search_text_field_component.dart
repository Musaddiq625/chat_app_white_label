import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/asset_constants.dart';
import 'icon_component.dart';

class SearchTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget? action;
  final Function(String)? onSearch;
  final TextEditingController? textEditingController;

  SearchTextField({
    required this.title,
    required this.hintText,
    this.action,
    required this.onSearch,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Column(
        // children: [
        Container(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextField(
          onSubmitted: onSearch,
          controller: textEditingController,
          textInputAction: TextInputAction.search,
          style: TextStyle(
              color: ColorConstants.white,
          ),
          decoration: InputDecoration(

              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              suffixIcon: GestureDetector(
                onTap: () => onSearch!(textEditingController?.text ?? ''),
                child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 8),
                    child: IconComponent(
                      iconData: Icons.search_rounded,
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.transparent,
                      iconColor: ColorConstants.lightGray.withOpacity(0.5),
                      iconSize: 25,
                      circleSize: 25,
                    )),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              filled: true,
              fillColor: ColorConstants.backgroundColor.withOpacity(0.3),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent))),
        ),
      ),
    );
    //     if (onSearch == null)
    //       Container(
    //         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    //         child: Text(
    //           title,
    //         ),
    //       ),
    //     // Visibility(
    //     //   visible: onSearch != null,
    //     //   child: Container(
    //     //     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    //     //     child: TextField(
    //     //       onSubmitted: onSearch,
    //     //       controller: textEditingController,
    //     //       textInputAction: TextInputAction.search,
    //     //       decoration: InputDecoration(
    //     //           prefixIcon: Icon(Icons.search),
    //     //           hintText: hintText,
    //     //           filled: true,
    //     //           fillColor: Color(0xffDFFAFF).withOpacity(0.8),
    //     //           border: OutlineInputBorder(
    //     //               borderSide: BorderSide(color: Colors.transparent)),
    //     //           enabledBorder: OutlineInputBorder(
    //     //               borderSide: BorderSide(color: Colors.transparent)),
    //     //           focusedBorder: OutlineInputBorder(
    //     //               borderSide: BorderSide(color: Colors.transparent))),
    //     //     ),
    //     //   ),
    //     // ),
    //   ],
    // );
  }
}
