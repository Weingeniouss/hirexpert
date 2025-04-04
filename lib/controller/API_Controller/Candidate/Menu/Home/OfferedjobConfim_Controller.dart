// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class OfferedjobconfimController extends GetxController {
  var isLoding = false.obs;
  var Offeredjobconfim_data;

  Future<void> Offeredjobconfim_Fuction({required String ApplyStatus, required String JobApplyId, required String Tokan}) async {
    try {
      Map<String,dynamic> body = {
        'ApplyStatus': ApplyStatus,
        'JobApplyId': JobApplyId,
      };
      isLoding.value = true;

      final responce = await http.post(Uri.parse(AppUrl.OfferedjobConfim), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan}, body: body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Offeredjobconfim_data = jsonDecode(responce.body);
        log('Offeredjobconfim_data :- $Offeredjobconfim_data');
      } else {
        throw {
          'Offeredjobconfim_data Error this ${responce.statusCode}, ${responce.body}'
        };
      }
    } catch (e) {
      print('Offeredjobconfim_data Error this :- $e');
    } finally {
      isLoding.value = false;
    }
  }
}
