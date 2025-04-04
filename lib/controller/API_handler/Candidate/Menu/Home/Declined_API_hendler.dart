// ignore_for_file: file_names, annotate_overrides, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Offer_Controller.dart';

import '../../../../../view/utils/app_constance.dart';


class DeclinedApiHendler extends GetxController {
  OfferController Decline = Get.put(OfferController());

  @override
  void onInit() {
    super.onInit();
    Decline.OfferControllers_fuction(CandidateId: Candidate,Timezone: 'asia/kolkata',JobStatus: 'Declined',Tokan: Tokans,Page: '1');
  }
}

