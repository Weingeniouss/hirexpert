// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import '../../../../../view/utils/app_constance.dart';
import '../../../../API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import '../../../../API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import '../../../../Save_Controller/Candidate_state/Menu/Search/State_Search.dart';
import '../Home/Sarching_Saving_API.dart';

class SarchhndalerConteroller extends GetxController{
  final StateSearch_Controller stateSearchController = Get.put(StateSearch_Controller());
  final IsfavrationControllers isFavrationController = Get.put(IsfavrationControllers());
  final OptionApiController loginController = Get.put(OptionApiController());
  final SarchingSavingApi Saving_Apis = Get.put(SarchingSavingApi());

  @override
  void onInit() {
    Tokans = pref!.getString('Tokan')!;
    Candidate = pref!.getString('Candidate')!;
    TechId = pref!.getString('TechId')!;
    super.onInit();
  }
}