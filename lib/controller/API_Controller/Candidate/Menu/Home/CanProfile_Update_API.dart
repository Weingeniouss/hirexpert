// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;
import '../../../../../view/utils/API_Key.dart';

class CanProfile_Update_API extends GetxController {
  var isLoding = false;
  var CanProfileUpdate;

  Future<void> CanProfile_Update_API_Fuction({
    required String CandidateId,
    required File Profile,
     String? EmployerId,
     String? CompanyId,
     String? OldProfile,
     String? Tokan,
  }) async {
    if (!await Profile.exists()) {
      print('Profile file does not exist');
      return;
    }

    String base64Image = base64Encode(await Profile.readAsBytes());
    print("Base64 image length: ${base64Image.length}");

    print('CandidateId :- $CandidateId');
    print('Profile :- $base64Image');
    print('EmployerId :- $EmployerId');
    print('CompanyId :- $CompanyId');
    print('OldProfile :- $OldProfile');

     final Map<String, dynamic> body = {
        'CandidateId': CandidateId,
        'Profile': base64Image,
        'EmployerId': EmployerId,
        'CompanyId': CompanyId,
        'OldProfile': OldProfile
    };

    print('CandidateId :- $CandidateId');
    print('Profile :- $base64Image');
    print('EmployerId :- $EmployerId');
    print('CompanyId :- $CompanyId');
    print('OldProfile :- $OldProfile');
    print('Tokan :- $Tokan');

    try {
      isLoding = true;

      final responce = await http.post(Uri.parse(AppUrl.update_profile),
          headers: {
            API_KEY.api_key: API_KEY.key,
            Clientip.clientip: Clientip.ip,
            Logintoken.logintoken: Tokan ?? '',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        CanProfileUpdate = jsonDecode(responce.body);
        print('CanProfileUpdate :- $CanProfileUpdate');
      }else{
        ToastificationError.Error('${responce.statusCode}, ${responce.body}');
        throw("CanProfileUpdate Error :- ${responce.statusCode}, ${responce.body}");
      }
    } catch (e) {
      print('CandidateId :- $e');
      ToastificationError.Error(e.toString());
    } finally {
      isLoding = false;
    }
  }
}
