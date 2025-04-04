// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:http/http.dart' as http;

class Jobapplycontroller extends GetxController {
  var isLoding = false.obs;
  var JobapplyData;

  Future<void> Jobapplycontroller_Fuction({required String Tokan, required String CandidateId, required String JobId, required String CompanyId}) async {
    try {
      isLoding.value = true;

      final responce = await http.get(Uri.parse('${AppUrl.JobApply}?CandidateId=$CandidateId&JobId=$JobId&CompanyId=$CompanyId'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        JobapplyData = jsonDecode(responce.body); log('JobapplyData :- $JobapplyData');
        ToastificationSuccess.Success(JobapplyData['data']['message']);
        print('Tokan :- $Tokan'); print('CandidateId :- $CandidateId'); print('JobId :- $JobId'); print('CompanyId : $CompanyId');
      } else {
        throw {
          'JobapplyData Error this :- ${responce.statusCode}, ${responce.body}'
        };
      }
    } catch (e) {
      log('JobapplyData Error this :- $e');
    } finally {
      isLoding.value = false;
    }
  }
}
