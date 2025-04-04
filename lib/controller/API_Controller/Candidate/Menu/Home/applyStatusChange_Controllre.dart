// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ApplyStatusChange extends GetxController{
  var isLoding = false.obs;
  var ApplyStatusData = {}.obs;
  
  Future<void> ApplyStatusChange_Fuction({String? CandidateId, String? JobApplyId, int? CandStatus, String? Tokan})async{
    try{
      isLoding.value = true;
      final responce = await http.get(Uri.parse('${AppUrl.applyStatusChange}?CandidateId=$CandidateId&JobApplyId=$JobApplyId&CandStatus=$CandStatus'),headers: {API_KEY.api_key : API_KEY.key, Clientip.clientip : Clientip.ip, Logintoken.logintoken : Tokan ?? ''});

      print('${AppUrl.applyStatusChange}?CandidateId=$CandidateId&JobApplyId=$JobApplyId&CandStatus=$CandStatus');
      print({"CandidateId" : CandidateId, "JobApplyId" : JobApplyId, 'CandStatus' : CandStatus});

      if(responce.statusCode == 200 || responce.statusCode == 201){
        ApplyStatusData.value = jsonDecode(responce.body);
        print('ApplyStatusData :- $ApplyStatusData');
      }
      else{
        throw{
          'ApplyStatusData Error Data :- ${responce.statusCode}, ${responce.body}'
        };
      }
      print({"CandidateId" : CandidateId, "JobApplyId" : JobApplyId, 'CandStatus' : CandStatus});
    }catch(e){
      print('ApplyStatusData Error Data :- $e');
    }finally{
      isLoding.value = false;
    }
  }
}