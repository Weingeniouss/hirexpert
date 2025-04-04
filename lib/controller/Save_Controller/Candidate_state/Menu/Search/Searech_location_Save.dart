// ignore_for_file: non_constant_identifier_names, unused_import, prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import '../../../../API_Controller/Candidate/Menu/Home/Apply_now_Controller.dart';
import '../../../../API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../../API_handler/Candidate/Menu/Home/Button_Apping_handler.dart';

class SearechLocationSave extends GetxController {
  final OptionApiController login = Get.put(OptionApiController());
  final ApplyNowController Apply_maees = Get.put(ApplyNowController());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final ButtonAppingHandler sumit = Get.put(ButtonAppingHandler());
  final SearchApiController Search = Get.put(SearchApiController());

  var valuecheck;
  int? _index;

  void setIndex(int index) {_index = index;initializeWithIndex(_index!);}

  String initializeWithIndex(int index) {
    if (index < 0 || index >= Search.Search_data['data'].length) {throw Exception("Index out of range");}

    String jobId = Search.Search_data['data'][index]['JobId'];
    Future.microtask(() async {
      // await isApply.IsApplingAPIController_fuction(Tokan: Tokans, Candidate: Candidate, JobId: jobId, Timezone: 'asia/kolkata');
      // JobID = pref!.getString('JobId')!;
    });
    return jobId;
  }

  @override
  void onInit() {
    super.onInit();
    if (_index != null) {initializeWithIndex(_index!);}
  }
}