// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class SearchfilterApiController extends GetxController {
  var isLoading = false.obs;
  Map<String, dynamic>? searchFilterApiData;


  Future<void> fetchSearchFilterApiData({required String token}) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(AppUrl.CandFilterList), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: token});
      if (response.statusCode == 200 || response.statusCode == 201) {
        searchFilterApiData = jsonDecode(response.body);
        // log('SearchfilterApidata: $searchFilterApiData');
      } else {
        log('Error: ${response.statusCode}, ${response.body}'); searchFilterApiData = {};
      }
    } catch (e) {
      log('SearchfilterApidata Error: $e'); searchFilterApiData = {};
    } finally {
      isLoading.value = false;
    }
  }
}
