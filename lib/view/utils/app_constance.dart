// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/User_Controller/Candidate_Controller/LoginControoler/LoginValidation.dart';


//Save Login & Password !
SharedPreferences? pref;

String ComapanyID = '';
String JobApplyID = '';
String Username = '';
String FristName = '';

String Frist_name = ""; String Last_name = ""; String Email = ""; String Phone = ""; String Password = ""; String Comfarm_password = ""; String username = ''; String Candidate = ''; String TechId = ''; String Tokans = ''; bool islogin = false; String province = '';

int? savedIndex;
int? newIndex;


class Password_main {
  static TextEditingController Pass = Candidate_LoginValidation.password_controller = TextEditingController();
}

var City = '';
