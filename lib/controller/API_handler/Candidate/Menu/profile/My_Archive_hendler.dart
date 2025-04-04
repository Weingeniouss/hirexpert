// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../../../../../view/utils/app_constance.dart';
import '../../../../API_Controller/Candidate/Menu/Home/ArchiveJobList_Controller.dart';

class MyArchiveHendler extends GetxController{
  ArchivejoblistController Archivejoblist = Get.put(ArchivejoblistController());

  @override
  void onInit() {
    Future.microtask(() async {
      await Archivejoblist.Archivejoblist_Fuction(CandidateId: Candidate, Tokan: Tokans, Timezone: 'Asia/Calcutta');
    });
    super.onInit();
  }
}