// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class CountrylistApi extends GetxController {
  var isLoding = false.obs;
  var CountrylistApi_data = <String, dynamic>{}.obs;

  @override
  void onInit() {
    CountrylistApi_Fuction();
    super.onInit();
  }

  Future<void> CountrylistApi_Fuction() async {
    try {
      isLoding.value = true;
      final response = await http.get(Uri.parse(AppUrl.CountryList), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip});
      if (response.statusCode == 200 || response.statusCode == 201) {
        CountrylistApi_data.value = jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Countrylist Error: $e');
    } finally {
      isLoding.value = false;
    }
  }
}