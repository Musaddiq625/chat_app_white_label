import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/route_constants.dart';
import '../../utils/loading_dialog.dart';
import '../../utils/logger_util.dart';
import '../../utils/navigation_util.dart';
import '../otp/otp_screen.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    late LoginCubit loginCubit;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        LoggerUtil.logs('login state: $state');
        if (state is LoginLoadingState) {
          LoadingDialog.showLoadingDialog(context);
        } else if (state is LoginSuccessSignUpState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.push(context, RouteConstants.otpScreen,
              args: OtpScreenArg(
                  state.verificationId,
                  "${_countryCodeController.text}${_phoneNumbercontroller.text}",
                  _countryCodeController.text));
        } else if (state is LoginSuccessSignInState) {
          LoadingDialog.hideLoadingDialog(context);
          NavigationUtil.push(context, RouteConstants.chatScreen);
        } else if (state is LoginFailureState) {
          LoadingDialog.hideLoadingDialog(context);
        } else if (state is LoginCancleState) {
          LoadingDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        loginCubit = context.read<LoginCubit>();
        return PopScope(
          canPop: true,
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 50, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _phoneNumbercontroller.text = '1122334455';
                      },
                      child: const Text(
                        'Enter Your Phone Number',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Whatsapp will need to verify your account',
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              _countryCodeController.text =
                                  '+${countryCode.dialCode!}';
                              print("country code ${countryCode.dialCode}");
                            },
                            initialSelection: 'pk',
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneNumbercontroller,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                            ),
                            onChanged: (value) {
                              print(value);
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12),
                              // Limit to 12 characters
                              FilteringTextInputFormatter.digitsOnly,
                              // Accept only digits
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('International carrier charges may apply',
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_phoneNumbercontroller.text.isEmpty ||
                            _phoneNumbercontroller.text.length < 10) {
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
                        loginCubit.loginUsers(_countryCodeController.text +
                            _phoneNumbercontroller.text);
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
