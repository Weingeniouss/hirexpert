// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class PrivacypolicyController extends GetxController {
  var isLoding = false.obs;
  var Privacypolicy_data;

  Future Privacypolicy_Fuction() async {
    try {
      isLoding.value = true;

      if (kDebugMode) {
        print('Befor :-  $Privacypolicy_data');
      }

      final responce = await http.get(Uri.parse(AppUrl.privacyPolicy), headers: {
        API_KEY.api_key: API_KEY.key,
        Clientip.clientip: Clientip.ip,
      });
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Privacypolicy_data = jsonDecode(responce.body);
        print('Privacypolicy_data :- $Privacypolicy_data');
      } else {
        throw {
          '${responce.statusCode}, ${responce.body}',
        };
      }

      if (kDebugMode) {
        print('After :-  $Privacypolicy_data');
      }

    } catch (e) {
      'Privacypolicy_data Error = $e';
    } finally {
      isLoding.value = false;
    }
  }
}
