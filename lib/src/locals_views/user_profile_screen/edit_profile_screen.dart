import 'dart:math';

import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/choose_image_component.dart';
import 'package:chat_app_white_label/src/components/country_code_picker_component.dart';
import 'package:chat_app_white_label/src/components/divider.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/on_boarding/about_you_screen.dart';
import 'package:chat_app_white_label/src/utils/service/validation_service.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  final _formKey = GlobalKey<FormState>();

  final data = [
    "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
  ];

  List<Map<String, dynamic>> interestTagList = [
    {
      'iconData': Icons.favorite,
      'name': "Cinema",
    },
    {
      'iconData': Icons.sports_gymnastics,
      'name': "City Event",
    },
    {
      'iconData': Icons.add_circle,
      'name': "Foods & restaurants",
    },
    {
      'iconData': Icons.pending_actions,
      'name': "Networking",
    },
    {
      'iconData': Icons.hourglass_bottom,
      'name': "Workout",
    },
    {
      'iconData': Icons.height,
      'name': "Dancing",
    },
    // Add more tag data items as required
  ];

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      appBar: AppBarComponent(
        StringConstants.editProfile,
        isBackBtnCircular: false,
        centerTitle: false,
        action: GestureDetector(
          onTap: () {
            print('_FORMKEY: ${_formKey}');

            if (_formKey.currentState?.validate() == true) {
              Navigator.pop(context);
            }
          },
          child: TextComponent(StringConstants.saveChanges,
              style: TextStyle(
                fontSize: 14,
                color: themeCubit.textColor,
              )),
        ),
      ),
      removeSafeAreaPadding: false,
      bgColor: themeCubit.backgroundColor,
      widget: SingleChildScrollView(
        child: Column(
          children: [
            ReorderableGridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(16),
              childAspectRatio: 0.85,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  final element = data.removeAt(oldIndex);
                  data.insert(newIndex, element);
                  // data.add(newIndex.toString());
                });
              },
              children: data
                  .map(
                    (e) =>

                        //  Container(
                        //           key: ValueKey('value ${Random().nextInt(1000)}'),
                        //           color: Colors.red,
                        //         )

                        ChooseImageComponent(
                      selectedImages:
                          e, // 'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                      key: ValueKey('value ${Random().nextInt(1000)}'),
                    ),
                  )
                  .toList(),
            ),
            TextComponent(StringConstants.dragAndHold,
                style: TextStyle(color: themeCubit.textColor)),
            SizedBoxConstants.sizedBoxTenH(),
            const DividerComponent(),
            const AboutYouScreen(
              comingFromEditProfile: true,
            ),
            const DividerComponent(),
            Container(
              width: AppConstants.responsiveWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextComponent(StringConstants.myInterests,
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.lightGray,
                          )),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Container(
                      width: AppConstants.responsiveWidth(context),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeCubit.darkBackgroundColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Wrap(
                          children: interestTagList
                              .map((tag) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: TagComponent(
                                            iconData: tag['iconData'],
                                            customTextColor:
                                                themeCubit.textColor,
                                            backgroundColor: ColorConstants
                                                .lightGray
                                                .withOpacity(0.3),
                                            iconColor: themeCubit.primaryColor,
                                            customIconText: tag['name'],
                                            circleHeight: 35,
                                            iconSize: 20,
                                          ),
                                        ),
                                        // SizedBoxConstants.sizedBoxTenW(),
                                      ]))
                              .toList()),
                    ),
                  ]),
            ),
            const DividerComponent(),
            PersonalInfoWidget(
              personalInfoFormKey: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoWidget extends StatefulWidget {
  final GlobalKey<FormState> personalInfoFormKey;
  const PersonalInfoWidget({super.key, required this.personalInfoFormKey});

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);

  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dayTextController =
      TextEditingController(text: DateTime.now().day.toString());
  final TextEditingController _yearTextController =
      TextEditingController(text: DateTime.now().year.toString());
  final TextEditingController _monthTextController =
      TextEditingController(text: DateTime.now().month.toString());

  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  DateTime selectedDate = DateTime.now();

  final Map<String, dynamic> genderList = {
    StringConstants.male: true,
    StringConstants.female: false,
    StringConstants.nonBinary: false,
    StringConstants.ratherNotSay: false
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dayTextController.text = selectedDate.day.toString();
        _yearTextController.text = selectedDate.year.toString();
        _monthTextController.text = selectedDate.month.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Form(
        key: widget.personalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextComponent(StringConstants.personalInfo,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.lightGray,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // InkWell(
                //   onTap:()=> NavigationUtil.pop(context),
                //   child: IconComponent(
                //     iconData: Icons.arrow_back_ios_new_outlined,
                //     borderColor: Colors.transparent,
                //     backgroundColor: ColorConstants.iconBg,
                //     iconColor: Colors.white,
                //     circleSize: 30,
                //     iconSize: 20,
                //   ),
                // ),
                // SizedBoxConstants.sizedBoxForthyH(),

                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(
                  _firstNameController,
                  title: StringConstants.firstName,
                  filled: true,
                  hintText: "",
                  textColor: themeCubit.textColor,
                  titlePaddingFromLeft: 15,
                  onChanged: (value) {
                    // handleTextFieldsOnChange();
                  },
                  validator: (firstName) {
                    return ValidationService.validateText(firstName!,
                        fieldName: StringConstants.firstName);
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(
                  _lastNameController,
                  title: StringConstants.lastName,
                  titlePaddingFromLeft: 15,
                  filled: true,
                  hintText: "",
                  textColor: themeCubit.textColor,
                  onChanged: (value) {
                    // handleTextFieldsOnChange();
                  },
                  validator: (lastName) {
                    return ValidationService.validateText(lastName!,
                        fieldName: StringConstants.lastName);
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                // SizedBoxConstants.sizedBoxTenH(),
                TextFieldComponent(
                  _emailcontroller,
                  title: StringConstants.email,
                  filled: true,
                  hintText: "",
                  textColor: themeCubit.textColor,
                  titlePaddingFromLeft: 15,
                  onChanged: (value) {
                    // handleTextFieldsOnChange();
                  },
                  validator: (email) {
                    return ValidationService.validateEmail(email!);
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),

                TextFieldComponent(
                  _phoneNumberController,
                  filled: true,
                  title: StringConstants.phoneNumber,
                  titlePaddingFromLeft: 15,

                  prefixWidget: CountryCodePickerComponent(
                    isSignupScreen: false,
                    onChange: (CountryCode) {
                      _countryCodeController.text = '+${CountryCode.dialCode}';
                    },
                  ),
                  maxLength: AppConstants.phoneNumberMaxLength,
                  keyboardType: TextInputType.phone,
                  // autoFocus: true,
                  hintText: StringConstants.phoneTextFieldHint,
                  validator: (phone) => ValidationService.validatePhone(
                      phone!.trim(),
                      fieldName: StringConstants.phoneNumber),
                  onChanged: (phone) {
                    // handlePhoneOnChange();
                    // setState(() {
                    // _phoneNumberValid = _formKey.currentState!.validate();
                    // });
                  },
                ),
                SizedBoxConstants.sizedBoxTenH(),
                GestureDetector(
                  onTap: () {
                    BottomSheetComponent.showBottomSheet(
                        isShowHeader: false,
                        context, body: Builder(builder: (context) {
                      return Column(
                        children: [
                          //todo: add gender list
                        ],
                      );
                    }));
                  },
                  child: TextFieldComponent(
                    _genderController,
                    title: StringConstants.gender,
                    filled: true,
                    hintText: "",
                    titlePaddingFromLeft: 15,
                    enabled: false,
                    textColor: themeCubit.textColor,

                    // validator: (gender) {
                    //   return ValidationService.validateEmptyField(gender!);
                    // },
                  ),
                ),
                SizedBoxConstants.sizedBoxTenH(),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 15),
                      child: TextComponent(StringConstants.dateofBirth,
                          style:
                              FontStylesConstants.style14(color: Colors.white)),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        AppConstants.closeKeyboard();
                        _selectDate(context);

                        // CalendarDatePicker(
                        //     initialDate: DateTime.now(),
                        //     firstDate: DateTime.now(),
                        //     lastDate: DateTime.now(),
                        //     onDateChanged: (date) {
                        //       print('DATE: ${date}');
                        //     });
                      },
                      child: Row(children: [
                        Expanded(
                          child: TextFieldComponent(
                            _dayTextController,
                            filled: true,
                            suffixIcon: IconComponent(
                              iconData: Icons.keyboard_arrow_down,
                              iconColor: ColorConstants.grey,
                            ),
                            hintText: "",
                            titlePaddingFromLeft: 15,
                            enabled: false,
                            // title: _dayTextController.text,
                            textColor: themeCubit.textColor,
                            onChanged: (value) {
                              // handleTextFieldsOnChange();
                            },
                            validator: (day) {
                              return ValidationService.validateEmptyField(day!);
                            },
                          ),
                        ),
                        SizedBoxConstants.sizedBoxTwentyW(),
                        Expanded(
                          child: TextFieldComponent(
                            _monthTextController,
                            suffixIcon: IconComponent(
                              iconData: Icons.keyboard_arrow_down,
                              iconColor: ColorConstants.grey,
                            ),
                            filled: true,
                            hintText: "",
                            enabled: false,
                            titlePaddingFromLeft: 15,
                            textColor: themeCubit.textColor,
                            onChanged: (value) {
                              // handleTextFieldsOnChange();
                            },
                            validator: (day) {
                              return ValidationService.validateEmptyField(day!);
                            },
                          ),
                        ),
                        SizedBoxConstants.sizedBoxTwentyW(),
                        Expanded(
                          child: TextFieldComponent(
                            _yearTextController,
                            filled: true,
                            enabled: false,
                            hintText: "",
                            titlePaddingFromLeft: 15,
                            suffixIcon: IconComponent(
                              iconData: Icons.keyboard_arrow_down,
                              iconColor: ColorConstants.grey,
                            ),
                            textColor: themeCubit.textColor,
                            onChanged: (value) {
                              // handleTextFieldsOnChange();
                            },
                            validator: (day) {
                              return ValidationService.validateEmptyField(day!);
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                )

                // Spacer(),
              ],
            ),
            SizedBoxConstants.sizedBoxForthyH(),
            // SizedBox(
            //     width: MediaQuery.sizeOf(context).width * 0.9,
            //     child: ButtonComponent(
            //       bgcolor: themeCubit.primaryColor,

            //       textColor: ColorConstants.black,

            //       buttonText: StringConstants.continues,
            //       // onPressed: isFieldsValidate ? onContinuePressed : null,
            //       // onPressedFunction: () {

            //       // }),
            //     ))
          ],
        ),
      ),
    );
  }
}
