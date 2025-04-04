// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class TermsAndConditionsControllers extends GetxController{
  var isLoding = false.obs;
  var TermsAndConditions_data;

  @override
  void onInit() {
    TermsAndConditions_Fuction();
    super.onInit();
  }

  Future TermsAndConditions_Fuction()async{
    try{
      final responce = await http.get(Uri.parse(AppUrl.termsConditions),headers: {
        API_KEY.api_key : API_KEY.key,
        Clientip.clientip : Clientip.ip,
      });

      if(responce.statusCode == 200 || responce.statusCode == 201){
        TermsAndConditions_data = jsonDecode(responce.body);
        print('TermsAndConditions_data :- $TermsAndConditions_data');
      }else{
        throw{
          '${responce.statusCode}, ${responce.body}'
        };
      }
    }catch(e){
      'TermsandConditions Error :- $e';
    }finally{
      isLoding.value = false;
    }
  }
}