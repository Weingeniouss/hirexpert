// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ArchiveController extends GetxController{
  var isloding = false.obs;
  var ArchiveControllerdata;

  Future<void> ArchiveController_Fuction({String? JobId, String? IsLike, String? CandidateId,String? Tokan})
  async{
    try{
      isloding.value = true;

      print({'JobId' : JobId, 'IsLike' : IsLike, 'CandidateId': CandidateId, 'Tokan' : Tokan});

      final responce = await http.get(Uri.parse('${AppUrl.CanArchiveJob}?JobId=$JobId&IsLike=$IsLike&CandidateId=$CandidateId'),headers: {
        API_KEY.api_key : API_KEY.key,
        Clientip.clientip : Clientip.ip,
        Logintoken.logintoken : Tokan ?? ''
      });

      if(responce.statusCode == 200 || responce.statusCode == 201){
        ArchiveControllerdata = await jsonDecode(responce.body);
        log('ArchiveControllerdata :- $ArchiveControllerdata');
        print({'JobId' : JobId, 'IsLike' : IsLike, 'CandidateId': CandidateId, 'Tokan' : Tokan});
      }
      else{
        print({'JobId' : JobId, 'IsLike' : IsLike, 'CandidateId': CandidateId, 'Tokan' : Tokan,});
        throw{
          'ArchiveControllerdata Error this :- ${responce.statusCode}, ${responce.body}'
        };
      }
    }catch(e){
      print('ArchiveControllerdata Error this :- $e');
    }finally{
      isloding.value = false;
    }
  }
}