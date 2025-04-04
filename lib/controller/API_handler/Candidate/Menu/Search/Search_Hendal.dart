// ignore_for_file: file_names, annotate_overrides, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';

import '../../../../../view/utils/app_constance.dart';

class SearchHendal extends GetxController {
  OptionApiController Login = Get.put(OptionApiController());
  SearchApiController Search = Get.put(SearchApiController());

  void onInit() {
    Future.microtask(() async {
      Search.onInit();
      if (Login.option_data['status'] == true) {
        await Search.SearchApiController_fuction(IsWeb: 'false', Timezone: 'asia/kolkata', CandidateId: Login.option_data['data']['UserDetails']['CandidateId'], Tokan: Login.option_data['data']['LoginToken'], TechId: TechId, JobId: Search.Search_data[0]['data']['JobId']);
        await pref!.setString("Tokan", Login.option_data['data']['LoginToken']);
        await pref!.setString('Candidate', Login.option_data['data']['UserDetails']['CandidateId']);
      }
      Tokans = pref!.getString('Tokan')!;
      Candidate = pref!.getString('Candidate')!;
    });
    super.onInit();
  }
}
