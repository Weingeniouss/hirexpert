// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:http/http.dart' as http;

class Interview_Status_Controllers extends GetxController{
  var isLoding = false.obs;
  var Interviwe_Statusdata;

  Future<void> Interviwe_Status_Fuction({String? Tokan, String? Page,String? Timezone,String? CandidateId})async{
    try{
      isLoding.value = true;

      final responce = await http.get(Uri.parse('${AppUrl.JobInterviewLists}?Page=$Page&Timezone=$Timezone&CandidateId=$CandidateId'),headers: {
        API_KEY.api_key : API_KEY.key,
        Clientip.clientip : Clientip.ip,
        Logintoken.logintoken : Tokan ?? '',
      });

      if(responce.statusCode == 200 || responce.statusCode == 201){
        Interviwe_Statusdata = await jsonDecode(responce.body);
        log('Interviwe_Statusdata :- $Interviwe_Statusdata');
      }else{
        throw{
          'Interviwe_StatusdataData :- ${responce.statusCode}, ${responce.body}'
        };
      }
    }catch(e){'Interviwe_StatusdataError :- $e';}
    finally{
      isLoding.value = false;
    }
  }
}