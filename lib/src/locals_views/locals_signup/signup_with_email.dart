import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/app_bar_component.dart';
import '../../components/button_component.dart';
import '../../components/icon_component.dart';
import '../../constants/font_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/size_box_constants.dart';
import '../../constants/string_constants.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../utils/navigation_util.dart';
import '../../utils/theme_cubit/theme_cubit.dart';
import '../otp_screen/otp_screen.dart';
import 'cubit/signup_cubit.dart';

class SignUpWithEmail extends StatefulWidget {
  String? routeType;

  SignUpWithEmail({super.key, this.routeType,});

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  bool _isEmailValid = false;
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  late SignUpCubit signupCubit = BlocProvider.of<SignUpCubit>(context);
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit,SignUpState>(
        listener: (context, state) async {
          LoggerUtil.logs('login state: $state');
          if (state is SignUpLoadingState) {
            LoadingDialog.showLoadingDialog(context);
          } else if (state is SignUpSignUpState) {
            LoadingDialog.hideLoadingDialog(context);
            if(widget.routeType == "number"){
              NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                  args: OtpArg(
                      "", "","","setPasswordAfterNumber"
                  ));
            }
            else{
              NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                  args: OtpArg(
                      "", "","","setPasswordBeforeNumber"
                  ));
            }
          } else if (state is SignUpSignInState) {
            LoadingDialog.hideLoadingDialog(context);
            NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
          } else if (state is SignUpFailureState) {
            LoadingDialog.hideLoadingDialog(context);
          } else if (state is SignUpCancleState) {
            LoadingDialog.hideLoadingDialog(context);
          }
        },
      builder:(context,state){
        return UIScaffold(
            appBar: AppBarComponent(""),
            removeSafeAreaPadding: false,
            bgColor: themeCubit.backgroundColor,
            widget: continueWithEmail());
      });

  }

  Widget continueWithEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                StringConstants.whatsYourEmailAddress,
                style: TextStyle(
                    fontSize: 22,
                    color: themeCubit.textColor,
                    fontFamily: FontConstants.fontProtestStrike),
              ),
              SizedBoxConstants.sizedBoxThirtyH(),
              TextFieldComponent(
                _emailcontroller,
                hintText: "abc@gmail.com",
                textColor: themeCubit.textColor,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid=value.length >=8 && value.trim().isNotEmpty;
                    });
                  }
              ),
              SizedBoxConstants.sizedBoxForthyH(),
              TextComponent(
                StringConstants.verificationCodeSentToEmail,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.lightGray,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ButtonComponent(
                bgcolor: _isEmailValid
                    ? themeCubit.primaryColor
                    : ColorConstants.lightGray.withOpacity(0.2),
                textColor:_isEmailValid
                    ? ColorConstants.black
                    : ColorConstants.lightGray,
                buttonText: StringConstants.continues,
                onPressedFunction: () {

                  if (_emailcontroller.text.isEmpty ||
                      _emailcontroller.text.length < 10) {
                    Fluttertoast.showToast(
                        msg: "Please enter a valid phone number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  signupCubit.loginWithEmail(_emailcontroller.text);

                  // if(widget.routeType == "number"){
                  //   NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                  //       args: OtpArg(
                  //           "", "","","setPasswordAfterNumber"
                  //       ));
                  // }
                  // else{
                  //   NavigationUtil.push(context, RouteConstants.otpScreenLocal,
                  //       args: OtpArg(
                  //           "", "","","setPasswordBeforeNumber"
                  //       ));
                  // }

                }),
          )
        ],
      ),
    );
  }
}
