// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ChatlistController extends GetxController {
  var isloding = false.obs;
  var ChatlistController_data;

  Future<void> Chatlistcontroller_fuction({String? RoomId, String? SenderId, String? JobId, String? Page, String? ReceiverId, String? Timezone, String? CandidateId, String? Tokan})
  async {

    Map<String, String> body = {
      'RoomId': RoomId.toString(),
      'JobId': JobId.toString(),
      'Page': Page.toString(),
      'ReceiverId': ReceiverId.toString(),
      'Timezone' : Timezone.toString(),
      'CandidateId': CandidateId.toString(),
      'SenderId' : SenderId.toString(),
    };

    try {
      isloding.value = true;
      final responce = await http.post(Uri.parse(AppUrl.ChatDetail), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''}, body: body);
      print('Chatlistcontroller :- $body');

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        ChatlistController_data = jsonDecode(responce.body);
        log('ChatlistController_data :- $ChatlistController_data');
      } else {
        throw {
          'ChatlistController_data Error:- ${responce.statusCode}, ${responce.body}'
        };
      }
    } catch (e) {
      print('ChatlistErrorList Error :- $e');
    } finally {
      isloding.value = false;
    }
  }
}
