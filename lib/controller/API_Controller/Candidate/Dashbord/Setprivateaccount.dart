// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class SetPrivateAccount extends GetxController {
  var isloding = false.obs;
  var setprivateaccount;

  Future<void> SetPrivateAccount_fuction({required String IsPrivate,required String UserBy,required String UserType, required String Tokans}) async {
    print('IsPrivate : $IsPrivate');
    print('UserBy : $UserBy');
    print('UserType : $UserType');

    final body = {
      'IsPrivate': IsPrivate,
      'UserBy': UserBy,
      'UserType': UserType,
    };

    print('Body : $body');

    try {
      isloding.value = true;

      final responsive = await http.post(Uri.parse(AppUrl.SetPrivateAccounts), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokans},body: body);
      if (responsive.statusCode == 200 || responsive.statusCode == 201) {
        setprivateaccount = await jsonDecode(responsive.body);
        log('setprivateaccount Data :- $setprivateaccount');
      } else {
        throw {
          'setprivateaccount Error :- ${responsive.statusCode}, ${responsive.body}',
        };
      }
    } catch (e) {
      print('setprivateaccount Error :- $e');
    } finally {
      isloding.value = false;
    }
  }
}
