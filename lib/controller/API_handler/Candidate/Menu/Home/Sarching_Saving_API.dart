// ignore_for_file: file_names, annotate_overrides, non_constant_identifier_names, unused_import

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Favouritejob.dart';
import 'package:hirexpert/view/utils/app_constance.dart';

class SarchingSavingApi extends GetxController {
  final Favouritejob favourlist = Get.put(Favouritejob());
  final OptionApiController login = Get.put(OptionApiController());

  @override
  void onInit() {
    Future.microtask(() async {
      await favourlist.Favouritejob_fuction();
    });
    super.onInit();
  }
}
