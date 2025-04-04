// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/SettingController/Privacy_Policy_Controller.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_loder.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicyAPIController Privacy = Get.put(PrivacyPolicyAPIController());
  PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    Privacy.onInit();
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColor.Full_body_color,
        child: Obx(() {
          if (Privacy.privacyPolicy.isLoding.value) {
            return Center(child: Image.asset(AppLoder.infinityloder_without_background,width: 150,height: 150));
          } else if (Privacy.privacyPolicy.Privacypolicy_data == null || Privacy.privacyPolicy.Privacypolicy_data['data'] == null) {
            return Center(child: Text(Privacy.privacyPolicy.Privacypolicy_data?['message'] ?? 'Failed to load privacy policy.'));
          } else {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: SizedBox(
                    width: Get.width,
                    child: Html(
                      data: Privacy.privacyPolicy.Privacypolicy_data['data'],
                      style: {
                        'p': Style(fontSize: FontSize(Get.width / 27)),
                        'strong': Style(fontSize: FontSize(Get.width / 27)),
                        'li': Style(fontSize: FontSize(Get.width / 27)),
                        'h4': Style(fontSize: FontSize(Get.width / 20)),
                        'h6': Style(fontSize: FontSize(Get.width / 26)),
                      },
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}