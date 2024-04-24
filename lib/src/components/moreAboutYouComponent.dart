// import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
// import 'package:chat_app_white_label/src/components/button_component.dart';
// import 'package:chat_app_white_label/src/components/image_component.dart';
// import 'package:chat_app_white_label/src/components/list_tile_component.dart';
// import 'package:chat_app_white_label/src/components/text_component.dart';
// import 'package:chat_app_white_label/src/constants/color_constants.dart';
// import 'package:chat_app_white_label/src/constants/font_styles.dart';
// import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
// import 'package:chat_app_white_label/src/constants/string_constants.dart';
// import 'package:chat_app_white_label/src/utils/navigation_util.dart';
// import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class MoreAboutYouComponent{
//
//   final Map<String, dynamic> _tempmoreAboutValue = {};
//   List<String> height = [
//     '3\'3 (99 cm)',
//     '3\'4 (102 cm)',
//     '3\'5 (104 cm)',
//     '3\'6 (107 cm)',
//     '3\'7 (109 cm)',
//     '3\'8 (112 cm)',
//     '3\'9 (114 cm)',
//     '3\'10 (117 cm)',
//     '3\'11 (119 cm)',
//     '4\'0 (122 cm)',
//     '4\'3 (130 cm)',
//     '4\'4 (132 cm)',
//     '4\'5 (134 cm)',
//     '4\'6 (137 cm)',
//     '4\'7 (139 cm)',
//     '4\'8 (142 cm)',
//     '4\'9 (144 cm)',
//     '4\'10 (147 cm)',
//     '4\'11 (149 cm)',
//     '5\'0 (152 cm)',
//     '5\'3 (160 cm)',
//     '5\'4 (163 cm)',
//     '5\'5 (165 cm)',
//     '5\'6 (168 cm)',
//     '5\'7 (170 cm)',
//     '5\'8 (173 cm)',
//     '5\'9 (175 cm)',
//     '5\'10 (178 cm)',
//     '5\'11 (180 cm)',
//     '6\'0 (183 cm)',
//     '6\'3 (190 cm)',
//     '6\'4 (193 cm)',
//     '6\'5 (196 cm)',
//     '6\'6 (198 cm)',
//     '6\'7 (201 cm)',
//     '6\'8 (203 cm)',
//     '6\'9 (206 cm)',
//     '6\'10 (208 cm)',
//     '6\'11 (211 cm)',
//     '7\'0 (213 cm)',
//     '7\'3 (221 cm)',
//     '7\'4 (224 cm)',
//     '7\'5 (226 cm)',
//     '7\'6 (229 cm)',
//     '7\'7 (231 cm)',
//     '7\'8 (234 cm)',
//     '7\'9 (236 cm)',
//     '7\'10 (239 cm)',
//     '7\'11 (241 cm)',
//     '8\'0 (244 cm)',
//     '8\'3 (251 cm)',
//     '8\'4 (254 cm)',
//     '8\'5 (257 cm)',
//     '8\'6 (259 cm)',
//     '8\'7 (262 cm)',
//     '8\'8 (264 cm)',
//     '8\'9 (267 cm)',
//     '8\'10 (270 cm)',
//     '8\'11 (272 cm)',
//     '9\'0 (274 cm)',
//     '9\'3 (280 cm)',
//     '9\'4 (283 cm)',
//     '9\'5 (286 cm)',
//     '9\'6 (289 cm)',
//     '9\'7 (291 cm)',
//     '9\'8 (294 cm)',
//     '9\'9 (297 cm)',
//     '9\'10 (300 cm)',
//     '9\'11 (302 cm)',
//     '10\'0 (305 cm)',
//   ];
//
//   final Map<String, dynamic> _moreAboutYou = {
//   StringConstants.diet: {
//   "Love Meat": true,
//   "vegeterian": false,
//   "vegan": false,
//   "Everything is fine": false,
//   "i'd rather not say ": false
//   },
//   };
//
//   Future<void> moreAboutYouSelection(
//       String image, String title, String key, Map<String, dynamic> data,BuildContext context,
//       {bool isHeight = false}) {
//     late final themeCubit = BlocProvider.of<ThemeCubit>(context);
//     String? selectedValue = "";
//     bool selection = false;
//     selectedValue = _tempmoreAboutValue[key];
//     String? heightValue;
//
//     // _tempmoreaboutvalue[key] = "vegan"
//
//     void addSelection(String key) {
//       selectedValue = "";
//       selectedValue = key;
//       selection = true;
//     }
//
//     void removeSelection() {
//       selectedValue = "";
//       selection = false;
//     }
//
//     return BottomSheetComponent.showBottomSheet(context,
//         isShowHeader: false,
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: StatefulBuilder(
//             builder: (context, setState1) {
//               if (isHeight) {
//                 selection =
//                 true; // make selection true when the sheet opens to enable the button
//               }
//
//               return Column(
//                 children: [
//                   SizedBoxConstants.sizedBoxTwentyH(),
//                   ImageComponent(
//                     imgUrl: image,
//                     height: 35,
//                     width: 35,
//                     imgProviderCallback: (imgProvider) {},
//                   ),
//                   SizedBoxConstants.sizedBoxTwelveH(),
//                   TextComponent(
//                     title,
//                     style: FontStylesConstants.style22(
//                       color: themeCubit.textColor,
//                     ),
//                   ),
//                   SizedBoxConstants.sizedBoxTwelveH(),
//                   if (isHeight)
//                     SizedBox(
//                         height: 200,
//                         // padding: const EdgeInsets.only(top: 32),
//                         child: CupertinoPicker(
//                           itemExtent: 50,
//                           magnification: 1.22,
//                           squeeze: 1.2,
//                           useMagnifier: true,
//                           scrollController: FixedExtentScrollController(
//                             initialItem: height.indexOf(selectedValue ?? "0"),
//                           ),
//                           onSelectedItemChanged: (value) {
//                             addSelection(height[value]);
//
//                             setState1(() {});
//                             // setState(() {});
//                           },
//                           children: height.map((e) {
//                             return Container(
//                               alignment: Alignment.center,
//                               child: TextComponent(
//                                 e,
//                                 style: FontStylesConstants.style22(
//                                     color: ColorConstants.white),
//                               ),
//                             );
//                           }).toList(),
//
//                           // List.generate(100, (index) {
//                           //   final feet = 3 + index ~/ 12;
//                           //   final inches = (3 + index % 12) % 12;
//                           //   final heightInCm =
//                           //       ((feet * 30.48) + (inches * 2.54)).toInt();
//
//                           //   return GestureDetector(
//                           //     onTap: () {
//                           //       setState1(() {
//                           //         heightValue = "$feet'$inches"
//                           //             '" ( ${(heightInCm)} cm)';
//                           //         if (heightValue != null) {
//                           //           addSelection(heightValue!);
//                           //         }
//                           //       });
//                           //     },
//                           //     child: Container(
//                           // alignment: Alignment.center,
//                           //       child: TextComponent(
//                           //         // "$feet'$inches"
//                           //         // '" ( ${(heightInCm)} cm)',
//                           //         "$feet'$inches"
//                           //         '" ( ${(heightInCm)} cm)',
//                           // style: FontStylesConstants.style22(
//                           //     color: Colors.white),
//                           //       ),
//                           //     ),
//                           //   );
//                           // })),
//                         ))
//                   else
//                     Column(
//                         children: data.entries.map((e) {
//                           if (e.key == selectedValue) {
//                             setState1(() {
//                               selection = true;
//                             });
//                           }
//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 5),
//                             child: ListTileComponent(
//                               title: e.key,
//                               titleSize: 14,
//                               onTap: () {
//                                 setState1(() {
//                                   if (selectedValue == e.key) {
//                                     removeSelection();
//                                   } else {
//                                     addSelection(e.key);
//                                   }
//                                 });
//                               },
//                               backgroundColor: selectedValue == e.key
//                                   ? themeCubit.primaryColor
//                                   : themeCubit.darkBackgroundColor100,
//                               titleColor: selectedValue == e.key
//                                   ? themeCubit.backgroundColor
//                                   : null,
//                               trailingIcon: null,
//                             ),
//                           );
//                         }).toList()),
//                   SizedBoxConstants.sizedBoxTwelveH(),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ButtonComponent(
//                       buttonText: isHeight
//                           ? StringConstants.done
//                           : StringConstants.save,
//                       textColor: themeCubit.backgroundColor,
//                       bgcolor: themeCubit.primaryColor,
//                       onPressed: selection == false
//                           ? null
//                           : () {
//                         // _tempmoreAboutValue.clear();
//
//                         // if (selectedValue != null && selectedValue != "")
//                         if (selection) {
//                           if (!isHeight) {
//                             _moreAboutYou[key][selectedValue] = selection;
//                           }
//                           _tempmoreAboutValue.addAll(
//                               {key: selectedValue}); //"Diet":"vegan"
//                           setState(() {});
//                           NavigationUtil.pop(context);
//                         }
//
//                         // _tempmoreAboutValue
//                         //     .addAll({selectedMoreAboutValue: selection});
//                         // print(_tempmoreAboutValue);
//                       },
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         ));
//   }
//
// }