import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../components/text_component.dart';
import '../../components/text_field_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/theme_cubit/theme_cubit.dart';

class DOBScreen extends StatefulWidget {
  const DOBScreen({super.key});

  @override
  State<DOBScreen> createState() => _DOBScreenState();
}

class _DOBScreenState extends State<DOBScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =

      TextEditingController(text: '+92');
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
        removeSafeAreaPadding: false,
        bgColor: themeCubit.backgroundColor,
        widget: setPassword());
  }

  Widget setPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconComponent(
                iconData: Icons.arrow_back_ios,
                borderColor: Colors.transparent,
                backgroundColor: ColorConstants.iconBg,
                iconColor: Colors.white,
                circleSize: 30,
                iconSize: 20,
              ),
              SizedBox(
                height: 30,
              ),
              TextComponent(
                "What is your",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              TextComponent(
                "birthday?",
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontFamily: FontConstants.fontProtestStrike,
                      fontSize: 30),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "DD    MM    YYYY",
                    hintStyle: TextStyle(
                        color: ColorConstants.lightGray,
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 30),
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    // Limit to 12 characters
                    FilteringTextInputFormatter.digitsOnly,
                    // Accept only digits
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: ColorConstants.lightGray.withOpacity(0.2),
                textColor: ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressedFunction: () {}),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DatePickerDialog(
      restorationId: 'date_picker_dialog',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _selectDate(context),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );


    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //   });
  }
}
