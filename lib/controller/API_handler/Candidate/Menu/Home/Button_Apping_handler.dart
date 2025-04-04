// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Apply_now_Controller.dart';
import '../../../../../view/utils/app_color.dart';
import '../../../../../view/utils/app_constance.dart';
import '../../../../../view/utils/common/Buttons/wideButtons.dart';
import '../../../../API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';

class ButtonAppingHandler extends GetxController {
  final OptionApiController login = Get.put(OptionApiController());
  final ApplyNowController Apply_maees = Get.put(ApplyNowController());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final SearchApiController Search = Get.put(SearchApiController());

  var valuecheck;

  // String initializeWithIndex(int index) {
  //   String jobId = Search.Search_data['data'][index]['JobId'];
  //   Future.microtask(() async {
  //     await isApply.IsApplingAPIController_fuction(Tokan: Tokans, Candidate: Candidate, JobId: jobId, Timezone: 'asia/kolkata');
  //     JobID = pref!.getString('JobId')!;
  //   });
  //   return jobId;
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   initializeWithIndex();
  // }

  void Messes(context) async{
    await Apply_maees.ApplynowController_fuction(Candidate: Candidate, JobId: isApply.isApplingdata['data']['JobId'], Company: isApply.isApplingdata['data']['CompanyId'], Tokan: Tokans);
    String message = Apply_maees.Applynowcontroller_var['message']?.toString() ?? "No message available";

    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          OnButtons(
              onTap: () {
                Get.replace(IsApply());
                Get.back();
              },
              Button_Color: AppColor.Button_color,
              btn_name: "OK"
          )
        ],
        elevation: 0,
        backgroundColor: AppColor.Full_body_color,
        content: Container(width: Get.width, height: Get.height / 5, decoration: BoxDecoration(color: AppColor.Full_body_color), child: Center(child: Text(message, style: TextStyle(fontSize: Get.width / 27)))),
      );
    });
  }

  void IsApply() async {
    await isApply.IsApplingAPIController_fuction(Tokan: Tokans, Candidate: Candidate, JobId: isApply.isApplingdata['data']['JobId'], Timezone: 'asia/kolkata');

    valuecheck = isApply.isApplingdata['data']['IsApply'] = 1;
    print("is Your print :-  $valuecheck");
    update();
  }
}
