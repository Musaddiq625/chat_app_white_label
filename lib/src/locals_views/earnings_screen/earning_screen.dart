import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/earning_detail_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/info_sheet_component.dart';
import 'package:chat_app_white_label/src/components/list_tile_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/icon_component.dart';
import '../../constants/size_box_constants.dart';
import '../../utils/service/validation_service.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isFieldsValidate = false;
  final TextEditingController _amountController = TextEditingController();
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    ContactModel('Jesse Ebert', 'Graphic Designer', ""),
    // ... other contacts
  ];
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        appBar: AppBarComponent(
          StringConstants.earnings,
          centerTitle: false,
          isBackBtnCircular: false,
          action: GestureDetector(
            onTap: _withDrawBottomSheet,
            child: TextComponent(
              StringConstants.withDraw,
              style: FontStylesConstants.style16(color: ColorConstants.white),
            ),
          ),
        ),
        appBarHeight: 500,
        removeSafeAreaPadding: false,
        bgColor: ColorConstants.black,
        // bgImage:
        //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        widget: main());
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          Container(
            width: AppConstants.responsiveWidth(context, percentage: 100),
            decoration: const BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // color: themeCubit.darkBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          StringConstants.totalMoneyEarnedForFar,
                          style: FontStylesConstants.style16(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.black),
                        ),
                        TextComponent(
                          "SAR 1400",
                          style: FontStylesConstants.style38(
                              color: ColorConstants.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: 120,
                    // color: ColorConstants.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageComponent(
                          isAsset: true,
                          imgUrl: AssetConstants.earnedCoins,
                          height: 100,
                          width: 100,
                          imgProviderCallback: (imgProvider) {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          ListTileComponent(

              // iconColor: ColorConstants.white,
              iconText: StringConstants.addBankDetails,
              subIconColor: ColorConstants.iconBg,
              overrideLeadingIconSize: 30,
              leadingIconHeight: 20,
              leadingIconWidth: 20,
              leadingIcon: AssetConstants.bank,
              isLeadingImageSVG: true,
              isLeadingIconAsset:true,
              onTap: () {
                _addBankDetailsBottomSheet();
              }),
          SizedBoxConstants.sizedBoxThirtyH(),
          TextComponent(
            StringConstants.earningDetails,
            style: FontStylesConstants.style16(color: ColorConstants.lightGray),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (ctx, index) {
                return EarningDetailComponent(
                    profileImageUrl: "",
                    userName: "Aly",
                    detail: "Meet & Mingle in Riyadh season",
                    earningsAmount: "200");
              },
            ),
          ),
        ],
      ),
    );
  }

  _withDrawBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: Column(
        children: [
          const InfoSheetComponent(
            heading: StringConstants.amountToWithDraw,
            image: AssetConstants.withDraw,
          ),
          Container(
            color: themeCubit.darkBackgroundColor,
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              children: [
                TextFieldComponent(_amountController,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    hintText: "SAR",
                    keyboardType: TextInputType.number,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                ButtonComponent(

                  buttonText: StringConstants.next,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    Navigator.pop(context);
                    transactionCompleted();
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
                SizedBoxConstants.sizedBoxThirtyH(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  _addBankDetailsBottomSheet() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                child: TextComponent(
                  StringConstants.addBankDetails,
                  style: FontStylesConstants.style18(
                      color: themeCubit.primaryColor),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconComponent(
                    iconData: Icons.close,
                    borderColor: Colors.transparent,
                    iconColor: themeCubit.textColor,
                    circleSize: 50,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: ColorConstants.transparent,
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              children: [
                TextFieldComponent(_amountController,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    title: StringConstants.accountNumber,
                    keyboardType: TextInputType.number,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(_amountController,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    title: StringConstants.accountTitle,
                    keyboardType: TextInputType.number,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(_amountController,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    title: StringConstants.bankCode,
                    keyboardType: TextInputType.number,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxSixtyH(),
                ButtonComponent(

                  buttonText: StringConstants.next,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    Navigator.pop(context);
                    transactionCompleted();
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
                SizedBoxConstants.sizedBoxThirtyH(),
              ],
            ),
          ),

        ],
      ),
    );
  }


  void transactionCompleted(){
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.transactionComplete,
        body: StringConstants.transactionStatus,
        image: AssetConstants.transectionComplete,
        // svg: true,
      ),
      // whenComplete:_navigateToBack(),
    );
  }

  void handleTextFieldsOnChange() {
    if (isFieldsValidate != _formKey.currentState!.validate()) {
      isFieldsValidate = _formKey.currentState!.validate();
      setState(() {});
    }
  }
}
