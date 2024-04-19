import 'package:chat_app_white_label/src/constants/string_constants.dart';

class ValidationService {
  static const _passwordMinLen8WithNumbers =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const _numberPattern = r'^[0-9]*$';
  static const _textPattern = r'^[A-Za-z ]+$';
  // static const String _otpPattern = r'^[0-9]{6,}$';
  static bool _isEmailValid(String email) {
    final regexEmail = RegExp(_emailPattern);
    return regexEmail.hasMatch(email);
  }

  static bool _isNumberValid(String number) {
    final regexPhone = RegExp(_numberPattern);
    return regexPhone.hasMatch(number);
  }

  static bool _validate(String password, String pattern) {
    final regexPassword = RegExp(pattern);
    return regexPassword.hasMatch(password);
  }

  static String? validateEmail(
    String email, {
    String? errorMessage,
    String? fieldName,
  }) {
    if (email.isEmpty) {
      return 'Email is required';
    } else if (email.length > 60) {
      return StringConstants.errorEmailLengthShouldBeSixtyCharactersOrLess;
    } else if (_isEmailValid(email)) {
      return null;
    } else {
      return errorMessage ?? StringConstants.errorInvalidEmail;
    }
  }

  static String? validatePassword(
    String password, {
    String? errorMessage,
    String? fieldName,
  }) {
    if (password.isEmpty) {
      return StringConstants.errorThisFieldCantBeEmpty;
    }
    // else if (password.length < 8) {
    //   return StringConstants.errorMinLengthPassword;
    // }
    else if (!_validate(password, _passwordMinLen8WithNumbers)) {
      return StringConstants.errorInvalidFormat;
    } else {
      return null;
    }
  }

  static String? validatePhone(
    String number, {
    String? errorMessage = StringConstants.errorInvalidPhone,
    required String? fieldName,
  }) {
    if (number.isEmpty) {
      return '${StringConstants.errorPleaseEnterYour} $fieldName';
    } else if (number.length < 10) {
      return StringConstants.errorLengthTenError;
    } else if (_isNumberValid(number) == true) {
      return null;
    } else {
      return errorMessage ?? StringConstants.errorInvalidPhone;
    }
  }

  static String? validateEmptyField(
    String controller, {
    String? errorMessage,
    bool check11CharLength = false,
  }) {
    if (controller.isEmpty) {
      if (errorMessage != null) {
        return errorMessage;
      } else {
        return StringConstants.errorThisFieldCantBeEmpty;
      }
    } else if (controller.length != 11 && check11CharLength) {
      return StringConstants.errorLengthTenError;
    }
    return null;
  }

  static String? validateConfirmPassword({
    required String? password,
    required String? confirmPass,
    String fieldName = StringConstants.confirmPassword,
    String confirmPasswordMessage = StringConstants.passwordDoesNotMatch,
  }) {
    if (password!.isEmpty) {
      return '${StringConstants.errorPleaseEnterYour} $fieldName';
    } else if (confirmPass != password) {
      return confirmPasswordMessage;
    } else {
      return null;
    }
  }

  static String? validateMinLength({
    required String value,
    required int minLength,
  }) {
    if (value.isEmpty) {
      return StringConstants.errorThisFieldCantBeEmpty;
    } else if (value.length < minLength) {
      return '${StringConstants.pleaseEnterAtLeast} '
          '$minLength ${StringConstants.characters}';
    } else {
      return null;
    }
  }

  static String? validateMaxLength({
    required String value,
    required int maxLength,
  }) {
    if (value.isEmpty) {
      return StringConstants.errorThisFieldCantBeEmpty;
    } else if (value.length > maxLength) {
      // return '${StringConstants.doctorscode} ';
      //  '$maxLength ${StringConstants.characters}';
    } else {
      return null;
    }
  }

  static String? validateText(
    String value, {
    required String fieldName,
  }) {
    if (value.isEmpty) {
      return '${StringConstants.errorPleaseEnterYour} $fieldName';
    } else if (!_validate(value.trim(), _textPattern)) {
      return StringConstants.errorInvalid + fieldName;
    } else {
      return null;
    }
  }

  static String? validateVerfCode(
      {required String otp,
      String fieldName = StringConstants.verificationCode}) {
    if (otp.isEmpty) {
      return '${StringConstants.errorPleaseEnterYour} $fieldName';
    } else if (!_validate(otp, _numberPattern)) {
      return StringConstants.errorInvalidVerfCode;
    } else {
      return null;
    }
  }
}
