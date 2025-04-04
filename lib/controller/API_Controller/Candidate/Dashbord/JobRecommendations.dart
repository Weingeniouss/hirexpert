// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class Job_Recommendations_Controller extends GetxController {
  var isLoding = false.obs;
  var JobRecommendationsData;

  Future Job_Recommendations_Fuction({String? Timezone,String? CandidateId,String? JobId,String? TechId,String? Tokan}) async {
    print({ 'Timezone': Timezone, 'CandidateId': CandidateId, 'JobId': JobId, 'TechId': TechId,});
    final body = {'Timezone' : Timezone, 'CandidateId' : CandidateId,};

    try {
      isLoding.value = true;

      final responce = await http.post(Uri.parse(AppUrl.recommendationsJob), headers: {
        API_KEY.api_key: API_KEY.key,
        Clientip.clientip: Clientip.ip,
        Logintoken.logintoken: Tokan ?? '',
      },
      body: body
      );

      print(body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        JobRecommendationsData = await jsonDecode(responce.body); JobRecommendationsData = {};
        print('JobRecommendationsData :- $JobRecommendationsData');
      } else {
        throw {
          'JobRecommendationsData Error :- ${responce.statusCode}, ${responce.body}',
        };
      }
    } catch (e) {
      print('JobRecommendationsData Error :-  $e');
    } finally {
      isLoding.value = false;
    }
  }
}
