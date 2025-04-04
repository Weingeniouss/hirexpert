// ignore_for_file: annotate_overrides, file_names, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/JobInterviwe_API_Controller.dart';
import 'package:hirexpert/view/utils/app_constance.dart';

class Interviwedetails extends GetxController {
  JobinterviweApiController JobInter = Get.put(JobinterviweApiController());
  OptionApiController login = Get.put(OptionApiController());

  void onInit() {
    Future.microtask(() async {
      await JobInter.JobinterviweApiController_Fuction(Page: '1', Timezone: 'asia/kolkata', CandidateId: Candidate, Tokan: Tokans);
    });
    super.onInit();
  }
}
