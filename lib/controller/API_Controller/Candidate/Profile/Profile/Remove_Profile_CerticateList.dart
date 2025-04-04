// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class RemoveProfileCerticatelist extends GetxController {
  var isLoding = false.obs;
  var RemoveProfileCertication_data;

  @override
  void onInit() {
    RemoveProfileCerticatelist_fuction();
    super.onInit();
  }

  Future<void> RemoveProfileCerticatelist_fuction({String? Tokan, String? CertId}) async {
    try {
      isLoding.value = true;
      final responce = await http.get(
        Uri.parse('${AppUrl.CertificateList_list_remove}?CertId=$CertId'),
        headers: {
          API_KEY.api_key: API_KEY.key,
          Clientip.clientip: Clientip.ip,
          Logintoken.logintoken: Tokan ?? ''
        },
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        RemoveProfileCertication_data = jsonDecode(responce.body);
        print("RemoveProfileCertication_data :- $RemoveProfileCertication_data");
      } else {
        throw {
          'Error: ${responce.statusCode}, ${responce.body}',
        };
      }
    } catch (e) {
      print('RemoveProfileCertication Error: $e');
    } finally {
      isLoding.value = false;
    }
  }
}