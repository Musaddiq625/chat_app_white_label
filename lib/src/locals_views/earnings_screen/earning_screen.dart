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
import 'package:chat_app_white_label/src/locals_views/earnings_screen/cubit/earning_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/wrappers/earning_detail_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _amountWithDraw = TextEditingController();
  final TextEditingController _accountTitle = TextEditingController();
  final TextEditingController _accountBankCode = TextEditingController();
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "", "00112233455"),
    ContactModel('Albert Ebert', 'Manager', "", "45612378123"),
    ContactModel('Json Ebert', 'Tester', "", "03323333333"),
    ContactModel('Mack', 'Intern', "", "03312233445"),
    ContactModel('Julia', 'Developer', "", "88552233644"),
    ContactModel('Rose', 'Human Resource', "", "55366114532"),
    ContactModel('Frank', 'xyz', "", "25651412344"),
    ContactModel('Taylor', 'Test', "", "5511772266"),
  ];
  String id = "";
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late final earningCubit = BlocProvider.of<EarningScreenCubit>(context);

  @override
  void initState() {
    earningCubit.earningDetailData();
    earningCubit.userBankDetailData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarningScreenCubit, EarningScreenState>(
      listener: (context, state) {
        if (state is EarningScreenLoadingState) {
        } else if (state is EarningScreenSuccessState) {
          earningCubit.initializeEarningData(state.earningDetailWrapper!.data!);
        } else if (state is EarningScreenFailureState) {
          print("Earning Fetch Failed");
        } else if (state is UserBankDetailLoadingState) {
        } else if (state is WithDrawAmountLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        }
        else if (state is UserBankDetailSuccessState) {
          earningCubit
              .initializeBankDetailData(state.userBankDetailWrapper!.data!);
          _accountNumber.text =
              ((earningCubit.bankDetails ?? []).first.accountNo).toString();
          _accountTitle.text =
              ((earningCubit.bankDetails ?? []).first.accountTitle).toString();
          _accountBankCode.text =
              ((earningCubit.bankDetails ?? []).first.bankCode).toString();
          id = earningCubit.bankDetails.first.id ?? "";
          setState(() {});
        }
        else if (state is WithDrawAmountSuccessState) {
          _amountWithDraw.clear();

          LoadingDialog.hideLoadingDialog(context);
          Navigator.pop(context);
          transactionCompleted();
          Future.delayed(Duration(seconds: 3), () {

            NavigationUtil.pop(context);
          });
        }

        else if (state is UpdateUserBankDetailSuccessState) {
          earningCubit.userBankDetailData();
        }
        else if (state is UserBankDetailFailureState) {
          print("Earning Fetch Failed");
        }
        else if (state is WithDrawAmountFailureState) {
          _amountWithDraw.clear();
          LoadingDialog.hideLoadingDialog(context);
          print("Earning Fetch Failed");
          transactionFailed();
          Future.delayed(Duration(seconds: 3), () {
           NavigationUtil.pop(context);
          });
        }
      },
      builder: (context, state) {
        return UIScaffold(
            appBar: AppBarComponent(
              StringConstants.earnings,
              centerTitle: false,
              isBackBtnCircular: false,
              action: GestureDetector(
                onTap: _withDrawBottomSheet,
                child: TextComponent(
                  StringConstants.withDraw,
                  style:
                      FontStylesConstants.style16(color: ColorConstants.white),
                ),
              ),
            ),
            appBarHeight: 500,
            removeSafeAreaPadding: false,
            bgColor: ColorConstants.black,
            // bgImage:
            //     "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
            widget: main());
      },
    );
  }

  @override
  void dispose() {
    earningCubit.bankDetails.clear();
    earningCubit.earningData = EarningData();
    super.dispose();
  }

  Widget main() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxConstants.sizedBoxTwentyH(),
          earningCubit.bankDetails.isNotEmpty
              ? Container(
                  width: AppConstants.responsiveWidth(context, percentage: 100),
                  decoration: const BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // color: themeCubit.darkBackgroundColor,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 10),
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
                                "${AppConstants.currency} ${(earningCubit.earningData.totalEarnings ?? 0)
                                    .toString()}",
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
                )
              : Shimmer.fromColors(
                  baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width:
                        AppConstants.responsiveWidth(context, percentage: 100),
                    decoration: const BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // color: themeCubit.darkBackgroundColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 10),
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
                                  (earningCubit.earningData.totalEarnings ?? 0)
                                      .toString(),
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
                ),
          SizedBoxConstants.sizedBoxTenH(),
          earningCubit.bankDetails.isNotEmpty
              ? ListTileComponent(

                  // iconColor: ColorConstants.white,
                  leadingText: StringConstants.addBankDetails,
                  subIconColor: ColorConstants.iconBg,
                  overrideLeadingIconSize: 30,
                  leadingIconHeight: 20,
                  leadingIconWidth: 20,
                  leadingIcon: AssetConstants.bank,
                  isLeadingImageSVG: true,
                  isLeadingIconAsset: true,
                  onTap: () {
                    _addBankDetailsBottomSheet();
                  })
              : Shimmer.fromColors(
                  baseColor: ColorConstants.lightGray, //Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTileComponent(

                      // iconColor: ColorConstants.white,
                      leadingText: StringConstants.addBankDetails,
                      subIconColor: ColorConstants.iconBg,
                      overrideLeadingIconSize: 30,
                      leadingIconHeight: 20,
                      leadingIconWidth: 20,
                      leadingIcon: AssetConstants.bank,
                      isLeadingImageSVG: true,
                      isLeadingIconAsset: true,
                      onTap: () {
                        _addBankDetailsBottomSheet();
                      })),
          SizedBoxConstants.sizedBoxThirtyH(),
          TextComponent(
            StringConstants.earningDetails,
            style: FontStylesConstants.style16(color: ColorConstants.lightGray),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: earningCubit.earningData.earningsDetails?.length,
              itemBuilder: (ctx, index) {
                return earningCubit.bankDetails.isNotEmpty
                    ? EarningDetailComponent(
                        profileImageUrl: earningCubit
                                .earningData.earningsDetails?[index].image ??
                            "",
                        userName: earningCubit
                                .earningData.earningsDetails?[index].username ??
                            "",
                        detail: earningCubit.earningData.earningsDetails?[index]
                                .eventName ??
                            "",
                        earningsAmount: (earningCubit.earningData
                                    .earningsDetails?[index].price ??
                                "0")
                            .toString())
                    : Shimmer.fromColors(
                        baseColor: ColorConstants.lightGray,
                        //Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: EarningDetailComponent(
                            profileImageUrl: earningCubit.earningData
                                    .earningsDetails?[index].image ??
                                "",
                            userName: earningCubit.earningData.earningsDetails?[index].username ?? "",
                            detail: earningCubit.earningData.earningsDetails?[index].eventName ?? "",
                            earningsAmount: (earningCubit.earningData.earningsDetails?[index].price ?? "0").toString()));
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
                TextFieldComponent(_amountWithDraw,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    hintText: "${AppConstants.currency}",
                    keyboardType: TextInputType.number,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      // handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                ButtonComponent(
                  buttonText: StringConstants.next,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    earningCubit.withDrawAmountData(_amountWithDraw.text);
                    // Navigator.pop(context);
                    // transactionCompleted();
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
                TextFieldComponent(_accountNumber,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    title: StringConstants.accountNumber,
                    keyboardType: TextInputType.text,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      // handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(_accountTitle,
                    validator: (number) {
                      return ValidationService.validateEmail(number!);
                    },
                    title: StringConstants.accountTitle,
                    keyboardType: TextInputType.text,
                    textColor: themeCubit.textColor,
                    filled: true,
                    onChanged: (value) {
                      // handleTextFieldsOnChange();
                    }),
                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(_accountBankCode,
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
                  buttonText: StringConstants.save,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    earningCubit.updateUserBankDetailData(
                        id,
                        _accountNumber.text,
                        _accountTitle.text,
                        _accountBankCode.text);
                    Navigator.pop(context);
                    // transactionCompleted();
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

  void transactionCompleted() {
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
  void transactionFailed() {
    BottomSheetComponent.showBottomSheet(
      context,
      isShowHeader: false,
      body: InfoSheetComponent(
        heading: StringConstants.transactionFailed,
        image: AssetConstants.warning,
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
