// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import '../../../API_Controller/Candidate/Profile/Profile/Terms_And_Conditions_Controllers.dart';

class TermsConditionsController extends GetxController{
  TermsAndConditionsControllers TermsAndConditions = Get.put(TermsAndConditionsControllers());

  @override
  void onInit() {
    TermsAndConditions.TermsAndConditions_Fuction();
    super.onInit();
  }
}