import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/cubit/onboarding_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/font_styles.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/navigation_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class DOBScreen extends StatefulWidget {
  bool? routeFromMain;
   DOBScreen({super.key,this.routeFromMain=false});

  @override
  State<DOBScreen> createState() => _DOBScreenState();
}

class _DOBScreenState extends State<DOBScreen> {
  bool _isDobValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  late final onBoardingCubit = BlocProvider.of<OnboardingCubit>(context);
   // final OnBoardingUserStepTwoState onBoardingUserStepTwoState;
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');
  TextEditingController _dateController = TextEditingController();

  late final DateTime? picked;
  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    if(widget.routeFromMain == true){
      setUserData();
    }


  }

  void setUserData() async{
    final serializedUserModel = await getIt<SharedPreferencesUtil>().getString(SharedPreferenceConstants.userModel);
    UserModel userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));
    setState(() {
      onBoardingCubit.userModel = userModel;
    });

  }

  @override
  Widget build(BuildContext context) {

    return UIScaffold(
        appBar: AppBarComponent("",showBackbutton:(widget.routeFromMain?? false)?false:true ,),
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: setPassword());
  }

  Widget setPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(StringConstants.whensYouDob,
                  style:
                      FontStylesConstants.style22(color: ColorConstants.white)),
              SizedBoxConstants.sizedBoxForthyH(),
              InkWell(
                  onTap: () => _selectDate(context),
                  child: _dateController.value.text.isNotEmpty
                      ? TextComponent(_dateController.text,
                          style: FontStylesConstants.style30(
                              color: themeCubit.textColor, letterSpacing: 0.5))
                      : TextComponent(
                          StringConstants.formatDOB,
                          style: FontStylesConstants.style30(
                              color: ColorConstants.lightGray,
                              letterSpacing: 0.8),
                        )),
            ],
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: _dateController.value.text.isNotEmpty
                    ? themeCubit.primaryColor
                    : ColorConstants.lightGray.withOpacity(0.2),
                textColor: _dateController.value.text.isNotEmpty
                    ? ColorConstants.black
                    : ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressed: () {
                  if(_dateController.value.text.isNotEmpty) {
                    // onBoardingCubit.secondStepInputValues("dob");
                    onBoardingCubit.setDobValues(_dateController.value.text);

                    NavigationUtil.push(
                        context, RouteConstants.whatDoYouDoScreen);
                  }

                }),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    // DateTime specificLastDate = lastDate.subtract(Duration(days: 365));
    DateTime now = DateTime.now(); // Get the current date and time
    int currentYear = now.year - 16;
    DateTime lastDate = DateTime(currentYear, 12,31);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: lastDate,
      // lastDate: lastDate.subtract(const Duration(days: 16 * 365)),
      // lastDate: .subtract(const Duration(days: 16 * 365)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd MM yyyy').format(picked);
      });
    }
  }
}
