// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/Terms_And_Conditions_Controllers.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/SettingController/Terms_Conditions_Controller.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_loder.dart';

class TermsconditionsScreen extends StatelessWidget {
  final TermsConditionsController Terms = Get.put(TermsConditionsController());
  TermsconditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
          if (Terms.TermsAndConditions.isLoding.value) {
            return Center(child: Image.asset(AppLoder.infinityloder_without_background, scale: 250));
          }else if (Terms.TermsAndConditions.TermsAndConditions_data == null || Terms.TermsAndConditions.TermsAndConditions_data['data'] == null) {
            return Center(child: Text(Terms.TermsAndConditions.TermsAndConditions_data?['message'] ?? 'Failed to load privacy policy.'));
          } else {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: Html(
                    data: Terms.TermsAndConditions.TermsAndConditions_data['data'],
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
            );
          }
        }),
      ),
    );
  }
}
