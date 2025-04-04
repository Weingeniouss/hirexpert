// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class SetmaglistController extends GetxController {
  var isLoding = false.obs;
  var Setmaglist_data;

  Future<void> Setmaglist_Fuction({String? Tokan, String? Timezone, String? Page, String? CandidateId})
  async {
    try {
      isLoding.value = true;

      final Responce = await http.get(Uri.parse('${AppUrl.CanChatList}?CandidateId=$CandidateId&Page=$Page&Timezone=$Timezone'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});

      if (Responce.statusCode == 200 || Responce.statusCode == 201) {
        Setmaglist_data = jsonDecode(Responce.body);
        print('Setmaglist_data :- $Setmaglist_data');
      } else {
        throw {'SetMaglist Error :- ${Responce.statusCode}, ${Responce.body}'};
      }
    } catch (e) {
      'Error SetMasg :- $e';
    } finally {
      isLoding.value = false;
    }
  }
}
