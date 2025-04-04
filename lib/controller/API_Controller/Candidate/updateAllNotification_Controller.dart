// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:http/http.dart' as http;

class UpdateallnotificationController extends GetxController {
  var isloding = false.obs;  var Updateallnotification;

  Future<void> Updateallnotification_fuction(
      {required String Tokan, required String candidateID}) async {
    try {
      Map<String, dynamic> body = {
        'candidateID': candidateID,
      };
      final Responce = await http.post(Uri.parse(AppUrl.updateAllNotification), body: body, headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});

      isloding.value = true;

      if (Responce.statusCode == 200 || Responce.statusCode == 201) {
        Updateallnotification = jsonDecode(Responce.body);
        ToastificationSuccess.Success(Updateallnotification['message']);
        log('Updateallnotification :- $Updateallnotification');
      } else {
        ToastificationError.Error(Updateallnotification['message']);
        throw {
          'Updateallnotification Error this :- ${Responce.body}, ${Responce.statusCode}'
        };
      }
    } catch (e) {
      print('UpdateNotification Error Code :- ${e}');
    } finally {
      isloding.value = false;
    }
  }
}
