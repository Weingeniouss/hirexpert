// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

// class Favouritejob extends GetxController {
//   var isloding = false.obs;
//   Map<String, dynamic>? data;
//
//   @override
//   void onInit() {
//     super.onInit();
//     Favouritejob_fuction(CandidateId: Candidate, Page: '1', Timezone: 'asia/kolkata', Tokan: Tokans);
//   }
//
//   Future Favouritejob_fuction({required String CandidateId, required String Page, required String Timezone, required String Tokan,})
//   async {
//     try {
//       isloding.value = true;
//
//       final responce = await http.get(
//         Uri.parse('${AppUrl.savelist}?CandidateId=$CandidateId&Page=$Page&Timezone=$Timezone'),
//         headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan,},
//       );
//       if (responce.statusCode == 200 || responce.statusCode == 201) {
//         data = jsonDecode(responce.body);
//         print("data :- $data");
//       } else {
//         throw {
//           ToastificationError.Error('${responce.statusCode}'),
//           ToastificationError.Error(responce.body),
//           'Saving Data Error this :-  ${responce.body}, ${responce.statusCode}'
//         };
//       }
//     } catch (e) {
//       print('Error this :- $e',);
//       ToastificationError.Error( 'Error this :- $e');
//     } finally {
//       isloding.value = false;
//     }
//   }
// }

class Favouritejob extends GetxController {
  var isloding = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var data = <Map<String, dynamic>>[].obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    Favouritejob_fuction();

    // Infinite scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        Favouritejob_fuction();
      }
    });
  }

  Future<void> Favouritejob_fuction() async {
    if (isloding.value || !hasMore.value) return;

    try {
      isloding.value = true;

      final response = await http.get(Uri.parse('${AppUrl.savelist}?CandidateId=$Candidate&Page=${page.value}&Timezone=asia/kolkata'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokans});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newData = jsonDecode(response.body);
        if (newData is Map<String, dynamic> && newData['data'] != null && newData['data'] is List) {
          final List<dynamic> jobList = newData['data'];
          if (jobList.isEmpty) {
            hasMore.value = false;
          } else {
            data.addAll(List<Map<String, dynamic>>.from(jobList));
            page.value++;
          }
        } else {
          hasMore.value = false;
        }
      } else {
        ToastificationError.Error('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      ToastificationError.Error('Error: $e');
      print('Error: $e');
    } finally {
      isloding.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
