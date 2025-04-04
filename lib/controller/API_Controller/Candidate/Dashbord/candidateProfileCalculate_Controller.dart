// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class CandidateprofilecalculateController extends GetxController{
  var isloding = false.obs; var Candidateprofilecalculatedata;

  Future<void> CandidateprofilecalculateFuction({required String Tokan,required String CandidateId, required String Timezone})
  async{
    try{
      isloding.value = true;

      final Responce = await http.get(Uri.parse('${AppUrl.candidateProfileCalculate}?CandidateId=$CandidateId&Timezone=$Timezone'),headers: {API_KEY.api_key : API_KEY.key, Clientip.clientip : Clientip.ip, Logintoken.logintoken : Tokan});

      print({'Tokan' : Tokan, 'CandidateId' : CandidateId, 'Timezone' : Timezone});

      if(Responce.statusCode == 200 || Responce.statusCode == 201){
        Candidateprofilecalculatedata = await jsonDecode(Responce.body);
        print('Candidateprofilecalculate :- $Candidateprofilecalculatedata');
      }else{
        throw{
          'Candidateprofilecalculate Error this :- ${Responce.statusCode}, ${Responce.body}'
        };
      }
      print({'Tokan' : Tokan, 'CandidateId' : CandidateId, 'Timezone' : Timezone});
    }catch(e){
      'Candidateprofilecalculate Errro this :- $e';
    }finally{
      isloding.value = false;
    }
  }
}