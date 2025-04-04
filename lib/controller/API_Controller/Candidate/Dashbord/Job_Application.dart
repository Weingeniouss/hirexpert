// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class Job_Application_Controller extends GetxController{
  var isLoding = false.obs; var JobApplicationData;

  Future<void> JobApplication_Fuction({String? Tokan, String? CandidateId, String? Timezone})
  async {
    try {
      isLoding.value = true;

      final responce = await http.get(
          Uri.parse('${AppUrl.jobApplication}?CandidateId=$CandidateId&Timezone=$Timezone'),
          headers: {
            API_KEY.api_key: API_KEY.key,
            Clientip.clientip: Clientip.ip,
            Logintoken.logintoken: Tokan ?? '',
          });

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        JobApplicationData = await jsonDecode(responce.body);
        print('JobApplicationData :- $JobApplicationData');
      } else {
        throw {
          'JobApplication Error :- ${responce.statusCode}, ${responce.body}',
        };
      }
    } catch (e) {
      'JobApplication Error :- $e';
    } finally {
      isLoding.value = false;
    }
  }
}
