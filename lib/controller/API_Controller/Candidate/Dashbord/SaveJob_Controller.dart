// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class SaveJob_Controller extends GetxController {
  var isLoding = false.obs;
  RxMap<String, dynamic>? SaveJobData = RxMap();

  Future SaveJob_Fuction({String? CandidateId, String?Timezone, String? Tokan}) async {
    try {
      isLoding.value = true;
      final responce = await http.get(Uri.parse('${AppUrl.SaveJob}?CandidateId=$CandidateId&Timezone=$Timezone'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? '',});
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        SaveJobData = await jsonDecode(responce.body); print('SavejobData :- $SaveJobData');
      } else {
        throw {'SavejobData Error :- ${responce.statusCode}, ${responce.body}'};
      }
    } catch (e) {
      print('SaveJobData :- $e');
    } finally {
      isLoding.value = false;
    }
  }
}
