import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../constants/asset_constants.dart';
import 'icon_component.dart';

class SearchTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget? action;
  final Color filledColor;
  final Color iconColor;
  final bool searching;
  final Function(String)? onSearch;
  final TextEditingController? textEditingController;

  SearchTextField({
    required this.title,
    required this.hintText,
    this.action,
    this.searching = false,
    this.filledColor= ColorConstants.darkBackgrounddColor,
    this.iconColor = ColorConstants.white,
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
          onChanged: (text) {
            if (text.length >= 3) {
              onSearch!(text);
            } else {
              onSearch!('');
              // Display the entire list if the search text is less than 3 characters
              // This part depends on how you manage the state of your filtered list
              // For example, you might call a function to reset the filtered list to the original list
            }
          },
          style: TextStyle(
              color: ColorConstants.white,
          ),
          decoration: InputDecoration(

              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              suffixIcon: GestureDetector(
                onTap: () {
                  AppConstants.closeKeyboard();
                  onSearch!(textEditingController?.text ?? '');},

                child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 8),
                    child: searching==false ?
                    IconComponent(
                      iconData: Icons.search_rounded,
                      borderColor: ColorConstants.transparent,
                      backgroundColor: ColorConstants.transparent,
                      iconColor: iconColor,//ColorConstants.lightGray.withOpacity(0.5),
                      iconSize: 25,
                      circleSize: 25,
                    ):
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.grey1),
                          ),
                        )
                      ],
                    )

                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              filled: true,
              fillColor:filledColor,
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
