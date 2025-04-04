// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class UpcomingInterviwe_Controller extends GetxController{
  var isLoding = false.obs;
  var UpcomingInterviwedata;


  Future<void> UpcomingInterviwe_fuction({String? Timezone, String? CandidateID,  String? Tokan})
  async{
    try{
      isLoding.value = true;

      final Response = await http.get(Uri.parse('${AppUrl.upcomingInterviewList}?Timezone=$Timezone&CandidateId=$CandidateID'),headers: {
        API_KEY.api_key : API_KEY.key,
        Clientip.clientip : Clientip.ip,
        Logintoken.logintoken : Tokan ?? '',
      });

      if(Response.statusCode == 200 || Response.statusCode == 201){
        UpcomingInterviwedata = await jsonDecode(Response.body);
        print('UpcomingInterviwedata :- $UpcomingInterviwedata');
      }else{
        throw{
          'UpcomingInterviwedata Error :-  ${Response.statusCode}, ${Response.body}'
        };
      }
    }catch(e){print('UpcomingInterviwe Error :- $e');}finally{
      isLoding.value = false;
    }
  }
}