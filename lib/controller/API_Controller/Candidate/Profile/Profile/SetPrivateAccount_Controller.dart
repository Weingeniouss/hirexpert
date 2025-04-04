// ignore_for_file: avoid_print, non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class SetprivateaccountController extends GetxController {
  var isLoding = false.obs;
  var Setprivateaccount_data;

  // ignore: non_constant_identifier_names
  Future Setprivateaccount_Fuction({String? IsPrivate, String? UserBy, String? UserType, String? Tokan}) async {
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
      final responce = await http.post(
        Uri.parse(AppUrl.SetPrivateAccount),
        headers: {
          API_KEY.api_key: API_KEY.key,
          Clientip.clientip: Clientip.ip,
          Logintoken.logintoken: Tokan ?? ''
        },
        body: body,
      );

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Setprivateaccount_data = jsonDecode(responce.body);
        print('Setprivateaccount_data :- $Setprivateaccount_data');
      } else {
        throw {
          '${responce.statusCode}, ${responce.body}',
        };
      }
    } catch (e) {
      'SetPravet Error :- $e';
    } finally {
      isLoding.value = false;
    }
  }
}
