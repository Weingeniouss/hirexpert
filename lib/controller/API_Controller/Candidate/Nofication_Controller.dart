// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

class NoficationController extends GetxController {
  var isloding = false.obs;
  var Noficationdata;

  Future<void> NoficationFuction({required String Timezone,required String Tokan}) async {
    try {
      isloding.value = true;

      final responce = await http.get(Uri.parse('${AppUrl.Notification}?Timezone=$Timezone'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});

      print({'Timezone' : Timezone, 'Tokan' : Tokan});

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Noficationdata = await jsonDecode(responce.body);
        log('Noficationdata :- $Noficationdata');
      } else {
        ToastificationError.Error('${responce.statusCode}, ${responce.body}');
        throw {
          'Noficationdata Error :- ${responce.statusCode}, ${responce.body}'
        };
      }
      print({'Timezone' : Timezone, 'Tokan' : Tokan});
    } catch (e) {
      ToastificationError.Error('$e');
      print('NoficationController Error:- $e');
    } finally {
      isloding.value = false;
    }
  }
}
