// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/app_constance.dart';

// class ApplyjoblistController extends GetxController {
//   var isLoding = false.obs;
//   var ApplyJobList_data = {}.obs;
//
//   Future<void> ApplyjoblistController_Fuction({required String CandidateId, required String Timezone, required String Tokan}) async {
//     try {
//       isLoding.value = true;
//
//       final responce = await http.get(Uri.parse('${AppUrl.ApplyJobList}?CandidateId=$CandidateId&Timezone=$Timezone&Page=1'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});
//       if (responce.statusCode == 200 || responce.statusCode == 201) {
//         ApplyJobList_data.value = jsonDecode(responce.body);
//         // ToastificationSuccess.Success('Saved data Successfully');
//         print('ApplyJobList_data : - $ApplyJobList_data');
//       } else {
//         throw {
//           ToastificationError.Error('${responce.statusCode}, ${responce.body}'),
//           'ApplyJobList_data Error : - ${responce.statusCode}, ${responce.body}'
//         };
//       }
//     } catch (e) {
//       print('ApplyJobList_data Error: - $e');
//       ToastificationError.Error('$e');
//     } finally {
//       isLoding.value = false;
//     }
//   }
//
//   @override
//   void onInit() {
//     ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', Tokan: Tokans);
//     super.onInit();
//   }
// }

class ApplyjoblistController extends GetxController {
  var isLoding = false.obs;
  var ApplyJobList_data = <dynamic>[].obs;
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  ScrollController scrollController = ScrollController();

  Future<void> ApplyjoblistController_Fuction({required String CandidateId, required String Timezone, required String Tokan, bool isRefresh = false,})
  async {
    try {
      if (isLoding.value || !hasMoreData.value) return;

      isLoding.value = true;
      if (isRefresh) {
        currentPage.value = 1;
        hasMoreData.value = true;
        ApplyJobList_data.clear();
      }

      final response = await http.get(Uri.parse('${AppUrl.ApplyJobList}?CandidateId=$CandidateId&Timezone=$Timezone&Page=${currentPage.value}'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          ApplyJobList_data.addAll(data['data']); currentPage.value++;
        } else {
          hasMoreData.value = false;
        }
        print('ApplyJobList_data : - $ApplyJobList_data');
      } else {
        throw '${response.statusCode}, ${response.body}';
      }
    } catch (e) {
      print('ApplyJobList_data Error: - $e');
      ToastificationError.Error('$e');
    } finally {
      isLoding.value = false;
    }
  }

  void setupScrollController({required String Candidate, required String Tokans}) {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && hasMoreData.value && !isLoding.value) {
        loadMore(Candidate, Tokans);
      }
    });
  }

  void loadMore(String Candidate, String Tokans) {
    if (hasMoreData.value && !isLoding.value) {
      ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', Tokan: Tokans);
    }
  }

  @override
  void onInit() {
    super.onInit();
    setupScrollController(Candidate: Candidate, Tokans: Tokans);
    // if (ApplyJobList_data.isEmpty) {
    //   ApplyjoblistController_Fuction(
    //     CandidateId: Candidate,
    //     Timezone: 'Asia/Calcutta',
    //     Tokan: Tokans,
    //   );
    // }
  }
}
