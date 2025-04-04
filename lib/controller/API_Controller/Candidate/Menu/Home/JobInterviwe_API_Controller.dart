// ignore_for_file: prefer_typing_uninitialized_variables, file_names, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class JobinterviweApiController extends GetxController {
  var isloding = false.obs;
  var JobInterviwe_data= {}.obs;

  @override
  void onInit() {
    JobinterviweApiController_Fuction();
    super.onInit();
  }

  Future JobinterviweApiController_Fuction({String? Page, String? Timezone, String? CandidateId, String? Tokan})
  async {
    try {
      isloding.value = true;
      update();
      print({'Page': Page, 'Timezone': Timezone, 'CandidateId': CandidateId, 'Token': Tokan});

      final Response = await http.get(
        Uri.parse('${AppUrl.JobInterviewLists}?Page=$Page&Timezone=$Timezone&CandidateId=$CandidateId'),
        headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? '',},
      );

      if (Response.statusCode == 200 || Response.statusCode == 201) {
        if (Response.body.isNotEmpty) {
          JobInterviwe_data.value = jsonDecode(Response.body);
          print("JobInterviwe_data: $JobInterviwe_data");
        } else {
          throw{
            'JobInterviwe_data Error list :- ${Response.statusCode}, ${Response.body}'
          };
        }
      } else {
        print("Error: Invalid status code ${Response.statusCode}");
        throw Exception("Invalid status code ${Response.statusCode}, Response: ${Response.body}");
      }
    } catch (e) {
      print("this Job Error :- $e");
    } finally {
      isloding.value = false;
      update();
    }
  }
}
