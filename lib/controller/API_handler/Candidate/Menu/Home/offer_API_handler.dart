// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Offer_Controller.dart';
import 'package:hirexpert/view/utils/app_constance.dart';

class OfferApiHandler extends GetxController{
  OptionApiController login = Get.put(OptionApiController());
  OfferController offer = Get.put(OfferController());

  @override
  void onInit() {
    super.onInit();
    offer.OfferControllers_fuction(CandidateId: Candidate,Timezone: 'asia/kolkata',JobStatus: 'Offered',Tokan: Tokans,Page: '1');
  }
}

