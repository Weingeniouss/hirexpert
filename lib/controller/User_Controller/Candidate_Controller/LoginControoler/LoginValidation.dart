// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, avoid_print, prefer_const_constructors, deprecated_member_use, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/buttom/Candidate/candidate_buttom.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:toastification/toastification.dart';

import '../../../../view/utils/common/Tostification/Toastification_success.dart';

class Candidate_LoginValidation with ChangeNotifier {
  final OptionApiController login = Get.put(OptionApiController());
  final auth = FirebaseAuth.instance;

  TextEditingController email_controller = TextEditingController();
  static TextEditingController password_controller = TextEditingController();

  bool _Email_value = false;
  bool _password_value = false;

  String _throwEmailnameError = "";
  String _throwPasswordError = "";

  get Email_value => _Email_value;
  get password_value => _password_value;
  get throwEmailnameError => _throwEmailnameError;
  get throwPasswordError => _throwPasswordError;

  void Email_validation(value) {
    if (email_controller.text.isEmpty) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.Email;
    } else if (email_controller.text.length < 6) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.Email_less;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email_controller.text)) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.V_Email;
    } else {
      _Email_value = false;
      _throwEmailnameError = '';
    }
    notifyListeners();
  }

  void Password_validation(value) {
    if (password_controller.text.isEmpty) {
      _password_value = true;
      _throwPasswordError = Validation_Error.password;
    } else if (password_controller.text.length < 8) {
      _password_value = true;
      _throwPasswordError = Validation_Error.characters;
    } else if (!RegExp(r'[A-Z]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.uppercase;
    } else if (!RegExp(r'[a-z]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.lowercase;
    } else if (!RegExp(r'[0-9]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.digit;
    } else if (!RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.special;
    } else {
      _password_value = false;
      _throwPasswordError = "";
    }
    notifyListeners();
  }

  void Loginvalidation() {
    if (email_controller.text.isEmpty) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.Email;
    } else if (email_controller.text.length < 6) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.Email_less;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email_controller.text)) {
      _Email_value = true;
      _throwEmailnameError = Validation_Error.V_Email;
    } else {
      _Email_value = false;
      _throwEmailnameError = '';
    }

    if (password_controller.text.isEmpty) {
      _password_value = true;
      _throwPasswordError = Validation_Error.password;
    } else if (password_controller.text.length < 8) {
      _password_value = true;
      _throwPasswordError = Validation_Error.characters;
    } else if (!RegExp(r'[A-Z]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.uppercase;
    } else if (!RegExp(r'[a-z]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.lowercase;
    } else if (!RegExp(r'[0-9]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.digit;
    } else if (!RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(password_controller.text)) {
      _password_value = true;
      _throwPasswordError = Validation_Error.special;
    } else {
      _password_value = false;
      _throwPasswordError = "";
    }

    Loginvalidation_successfully();
    notifyListeners();
  }

  void Loginvalidation_successfully() async {
    if (!_Email_value && !_password_value) {
      try {
        await auth.signInWithEmailAndPassword(email: email_controller.text, password: password_controller.text);

        Get.dialog(Center(child: Image.asset(AppLoder.loging, scale: Get.width / 250)), barrierDismissible: false);

        await login.OptionApiController_fuction(UserType: 'Candidate', Email: email_controller.text, Password: password_controller.text);

        pref!.setString("Tokan", login.option_data['data']['LoginToken']);
        pref!.setString('Candidate', login.option_data['data']['UserDetails']['CandidateId']);
        pref!.setString('TechId', login.option_data['data']['UserDetails']['TechId']);
        pref!.setString('Username', login.option_data['data']['Username']);
        pref!.setString('FristName', login.option_data['data']['UserDetails']['FirstName']);

        Tokans = pref!.getString('Tokan')!;
        Candidate = pref!.getString('Candidate')!;
        TechId = pref!.getString('TechId')!;
        Username = pref!.getString('Username')!;
        FristName = pref!.getString('FristName')!;

        Get.back();

        if (login.option_data['status'] == true) {
          ToastificationSuccess.Success(login.option_data['message'] ?? 'An error occurred');
          Get.to(() => Candidate_Bottam(), duration: Duration(milliseconds: 500), transition: Transition.circularReveal);
        } else {
          ToastificationError.Error(login.option_data['message'] ?? 'An error occurred');
        }
      } on FirebaseAuthException catch (e) {
        ToastificationError.Error(e.message.toString());
      }
    }
    notifyListeners();
  }
}
