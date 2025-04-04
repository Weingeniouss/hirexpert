// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, prefer_final_fields, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/common/Tostification/Toastification_error.dart';

class SecondInterviewController extends GetxController {
  var isLoding = false.obs; var SecondInterviewdata;

  Future<void> SecondInterviewController_Fuction({required String Tokan, required String InterviewQueId, required String JobApplyId, required String CandidateId, required String InterviewStatus, String? InterviewId, required String InterviewDate, String? Description, required String Timezone, required String InterviewType})
  async {
    Map<String, String> body = {
      'InterviewQueId': InterviewQueId, 'JobApplyId': JobApplyId, 'CandidateId': CandidateId, 'InterviewStatus': InterviewStatus,
      if (InterviewId != null) 'InterviewId': InterviewId,
      'InterviewDate': InterviewDate,
      if (Description != null) 'Description': Description,
      'Timezone': Timezone, 'InterviewType': InterviewType,
    };

    try {
      isLoding.value = true;
      update();

      final responce = await http.post(Uri.parse(AppUrl.JobInterview), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan}, body: body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        var decodedResponse = jsonDecode(responce.body);
        if (decodedResponse is Map<String, dynamic>) {
          SecondInterviewdata = decodedResponse;
          ToastificationSuccess.Success(decodedResponse['data']['Message']);
          log('SecondInterviewdata :- ${jsonEncode(SecondInterviewdata)}');
        } else {
          ToastificationError.Error(decodedResponse['data']['Message']);
          print('Unexpected response format: $decodedResponse');
        }
        update();
      } else {
        print('SecondInterview Error :- ${responce.statusCode}, ${responce.body}');
      }
    } catch (e) {
      print('SecondInterview Error :- $e');
    } finally {
      isLoding.value = false;
      update();
    }
  }
}
