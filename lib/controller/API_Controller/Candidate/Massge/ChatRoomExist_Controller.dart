// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ChatroomexistController extends GetxController{
  var isLoding = false.obs;
  var Chatroomexist_data;

  Future<void> ChatroomexistController_Fuction({String? Tokan, String? SenderId, String? ReceiverId})async{
    try{
      final body = {
     'SenderId' : SenderId,
      'ReceiverId' : ReceiverId,
    };
    isLoding.value = true;

    final Response = await http.post(Uri.parse(AppUrl.ChatRoomExist),headers: {API_KEY.api_key : API_KEY.key,Clientip.clientip : Clientip.ip,Logintoken.logintoken : Tokan ?? ''},body: body);

    if(Response.statusCode == 200 || Response.statusCode == 201){
      Chatroomexist_data = jsonDecode(Response.body);
      print("Chatroomexist_data : $Chatroomexist_data");
    }
    }catch(e){print(e);}finally{
      isLoding.value = false;
    }
  }
}