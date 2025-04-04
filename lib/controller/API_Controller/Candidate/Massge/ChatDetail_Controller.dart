// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ChatdetailController extends GetxController {
  var isLoding = false.obs;
  var Chat_data;

  @override
  void onInit() {
    ChatdetailsControllers_Fuction();
    super.onInit();
  }

  Future ChatdetailsControllers_Fuction({String? RoomId, String? CandidateId, String? EmpCanId, String? JobId, String? Page, String? LastTime, String? Timezone, String? ReceiverId,String? Tokan, String? SenderId}) async {

    final body = {'RoomId': RoomId, 'CandidateId': CandidateId, 'EmpCanId': EmpCanId, 'JobId': JobId, 'Page': Page, 'LastTime': LastTime, 'Timezone': Timezone, 'ReceiverId': ReceiverId, 'SenderId' : SenderId};
    print({'RoomId': RoomId, 'CandidateId': CandidateId, 'EmpCanId': EmpCanId, 'JobId': JobId, 'Page': Page, 'LastTime': LastTime, 'Timezone': Timezone, 'ReceiverId': ReceiverId,'SenderId' : SenderId});

    try {
      isLoding.value = (true);

      final responce = await http.post(
        Uri.parse(AppUrl.ChatDetail),
        headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? 'Tokans'},
        body: body,
      );

      print(body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Chat_data = jsonDecode(responce.body);
        log("Chat Massge data :- $Chat_data");
      } else {
        throw {'${responce.statusCode}, ${responce.body}'};
      }
    } catch (e) {
      print('Chat Massage Error  :- $e');
    } finally {
      isLoding.value = (false);
    }
  }
}
