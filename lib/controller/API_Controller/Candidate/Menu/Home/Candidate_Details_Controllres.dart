// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class CandidatedetailsControllers_Controllrs extends GetxController {
  var isLoding = false.obs; var Candidatedetails_data;

  Future CandidatedetailsControllers_Fuction({String? CandidateId, String? Timezone, String? IsLabel, String? CompanyId, String? Tokan})
  async {
    try{
      isLoding.value = true;
      final responce = await http.get(Uri.parse('${AppUrl.CandidateDetails}?CandidateId=$CandidateId&Timezone=$Timezone&IsLabel=$IsLabel&CompanyId=$CompanyId'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});
      if(responce.statusCode == 200 || responce.statusCode == 201){
        Candidatedetails_data = await jsonDecode(responce.body);
        print({'${AppUrl.CandidateDetails}?CandidateId=$CandidateId&Timezone=$Timezone&IsLabel=$IsLabel&CompanyId=$CompanyId'});
        print(Candidatedetails_data);
      }else{
        throw{'Candidatedetails_data Error :- ${responce.statusCode}, ${responce.body}'};
      }
    }catch(e){'Candidatedetails Data Error :- $Candidatedetails_data';}
    finally{
      isLoding.value = false;
    }
  }
}