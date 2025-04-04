// ignore_for_file: file_names, annotate_overrides

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Offer_Controller.dart';
import 'package:hirexpert/view/utils/app_constance.dart';

class HiredApiHandler extends GetxController {
  OfferController hired = Get.put(OfferController());

  @override
  void onInit() {
    super.onInit();
    hired.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', JobStatus: 'Hired', Tokan: Tokans, Page: '1');
  }
}
