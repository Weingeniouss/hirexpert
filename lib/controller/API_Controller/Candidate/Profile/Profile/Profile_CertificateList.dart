// ignore_for_file: avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class ProfileCertificateListController extends GetxController {
  var isLoading = false.obs;
  var profileCertificateListData = {}.obs;

  Future<void> fetchProfileCertificateList({String? candidateId, String? token}) async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('${AppUrl.CertificateList_list}?CandidateId=$candidateId'),
        headers: {
          API_KEY.api_key: API_KEY.key,
          Clientip.clientip: Clientip.ip,
          Logintoken.logintoken: token ?? ''
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        profileCertificateListData.value = jsonDecode(response.body);
        print('ProfileCertificateListData = ${profileCertificateListData.value}');
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('ProfileCertificateListData Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
