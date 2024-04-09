import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:flutter/material.dart';

class FontStylesConstants {



  static TextStyle style30({
    final underLine = false,
    final letterSpacing= 0.0,
    Color color = ColorConstants.black,
    FontWeight fontWeight = FontWeight.bold,
  }) => TextStyle(
      fontSize: 30,
      color: color,
      fontWeight: fontWeight,
      fontFamily: FontConstants.fontProtestStrike,
      fontStyle: FontStyle.normal,
      letterSpacing: letterSpacing,
      decorationColor: color,
      decoration:
      underLine ? TextDecoration.underline : TextDecoration.none);



  static TextStyle style28({
    final underLine = false,
    final letterSpacing= 0.0,
    Color color = ColorConstants.black,
    FontWeight fontWeight = FontWeight.bold,
  }) => TextStyle(
          fontSize: 28,
          color: color,
          fontWeight: fontWeight,
          fontFamily: FontConstants.inter,//add inter here,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          decorationColor: color,
          decoration:
          underLine ? TextDecoration.underline : TextDecoration.none);


  static TextStyle style22({
    final underLine = false,
    final letterSpacing= 0.0,
    Color color = ColorConstants.white,
    FontWeight fontWeight = FontWeight.normal,
  }) => TextStyle(
      fontSize: 22,
      color: color,
      fontWeight: fontWeight,
      fontFamily: FontConstants.fontProtestStrike,//add inter here,
      fontStyle: FontStyle.normal,
      letterSpacing: letterSpacing,
      decorationColor: color,
      decoration:
      underLine ? TextDecoration.underline : TextDecoration.none);

  static TextStyle style14({
    final underLine = false,
    final letterSpacing= 0.0,
    Color color = ColorConstants.black,
    FontWeight fontWeight = FontWeight.normal,
  }) => TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: fontWeight, //add inter here,
      fontStyle: FontStyle.normal,
      letterSpacing: letterSpacing,
      decorationColor: color,
      decoration:
      underLine ? TextDecoration.underline : TextDecoration.none);

  // static TextStyle style33({
  //   Color color = ColorConstants.lightBlack,
  //   FontWeight fontWeight = FontWeight.w800,
  // }) =>
  //     GoogleFonts.nunito(
  //       color: color,
  //       fontWeight: fontWeight,
  //       // fontStyle: FontStyle.normal,
  //       fontSize: 33.sp,
  //     );
  //
  // static TextStyle style25({
  //   Color color = ColorConstants.lightBlack,
  //   FontWeight fontWeight = FontWeight.bold,
  // }) =>
  //     GoogleFonts.nunito(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       fontSize: 25.sp,
  //     );
  //
  // static TextStyle style20({
  //   Color color = ColorConstants.lightBlack,
  //   FontWeight fontWeight = FontWeight.bold,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       fontSize: 20.sp,
  //     );
  //
  // static TextStyle style17({
  //   Color color = ColorConstants.lightBlack,
  //   FontWeight fontWeight = FontWeight.bold,
  // }) =>
  //     GoogleFonts.nunito(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       fontSize: 17.sp,
  //       decoration: TextDecoration.none,
  //     );
  //
  // static TextStyle style14Bold({
  //   Color color = ColorConstants.lightBlack,
  //   FontWeight fontWeight = FontWeight.bold,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       fontSize: 14.sp,
  //     );
  //
  // static TextStyle style14({
  //   Color color = ColorConstants.black,
  //   FontWeight fontWeight = FontWeight.normal,
  //   TextDecoration decoration = TextDecoration.none,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       decoration: decoration,
  //       fontSize: 14.sp,
  //     );
  //
  // static TextStyle style12({
  //   Color color = ColorConstants.black,
  //   FontWeight fontWeight = FontWeight.normal,
  //   TextDecoration decoration = TextDecoration.none,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       decoration: decoration,
  //       fontSize: 12.sp,
  //     );
  //
  // static TextStyle style10({
  //   Color color = ColorConstants.black,
  //   FontWeight fontWeight = FontWeight.normal,
  //   TextDecoration decoration = TextDecoration.none,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       decoration: decoration,
  //       fontSize: 10.sp,
  //     );
  //
  // static TextStyle style16({
  //   Color color = ColorConstants.black,
  //   FontWeight fontWeight = FontWeight.normal,
  //   TextDecoration decoration = TextDecoration.none,
  // }) =>
  //     GoogleFonts.inter(
  //       color: color,
  //       fontWeight: fontWeight,
  //       fontStyle: FontStyle.normal,
  //       decoration: decoration,
  //       fontSize: 16.sp,
  //     );
}