// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class Profile_Analytics_Controller extends GetxController {
  var isLoding = false.obs;
  var ProfileAnalyicsData;

  Future<void> Profile_Analytics_Fuction({String? Tokan, String? CandidateId, String? Timezone}) async {
    try {
      isLoding.value = true;

      final responce = await http.get(Uri.parse('${AppUrl.candidateProfileAnalytics}?CandidateId=$CandidateId&Timezone=$Timezone'), headers: {
        API_KEY.api_key: API_KEY.key,
        Clientip.clientip: Clientip.ip,
        Logintoken.logintoken: Tokan ?? '',
      });

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        ProfileAnalyicsData = await jsonDecode(responce.body);
        print('ProfileAnalyicsData  :- $ProfileAnalyicsData');
      } else {
        throw {
          'ProfileAnalyicsData Error :- ${responce.statusCode}, ${responce.body}'
        };
      }
    } catch (e) {
      print('ProfileAnalyicsDataError :- $e');
    } finally {
      isLoding.value = false;
    }
  }
}
