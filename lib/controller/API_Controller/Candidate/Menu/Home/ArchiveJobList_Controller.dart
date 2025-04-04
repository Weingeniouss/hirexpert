// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, invalid_use_of_protected_member, unused_import

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/app_constance.dart';

class ArchivejoblistController extends GetxController {
  var isloding = false.obs;
  var Archivejoblistdata = Rxn<Map<String, dynamic>>(); // Observable for nullable data

  @override
  void onInit() {
    Archivejoblist_Fuction();
    super.onInit();
  }

  Future<void> Archivejoblist_Fuction({String? CandidateId, String? Timezone, String? Tokan}) async {
    try {
      isloding.value = true;

      print({'CandidateId': CandidateId, 'Timezone': Timezone, 'Tokan': Tokan});

      final response = await http.get(
        Uri.parse('${AppUrl.ArchiveJobList}?CandidateId=$CandidateId&Timezone=$Timezone'),
        headers: {
          API_KEY.api_key: API_KEY.key,
          Clientip.clientip: Clientip.ip,
          Logintoken.logintoken: Tokan ?? '',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Archivejoblistdata.value = jsonDecode(response.body);
        log('Archivejoblistdata: ${Archivejoblistdata.value}');
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Archivejoblist Error: $e');
    } finally {
      isloding.value = false;
    }
  }
}