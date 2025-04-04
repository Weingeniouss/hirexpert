// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, unused_import, deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:provider/provider.dart';
import '../../../../controller/Internet_Controller/Internet_Controller.dart';
import '../../../../controller/User_Controller/Candidate_Controller/BottamController/MenuNavigationController.dart';

class Candidate_Bottam extends StatelessWidget {
  Candidate_Bottam({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<MenuNavigationController>(context, listen: false);
    final internetController = Provider.of<InternetController>(context, listen: false);
    return Consumer<InternetController>(builder: (BuildContext context, value, Widget? child) {
      return (internetController.isConnected)
          ? Scaffold(backgroundColor: AppColor.Full_body_color,
              bottomNavigationBar: Container(
                width: Get.width, height: Get.height / 15,
                decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[2],
                  border: Border(top: BorderSide(color: AppColor.offButton_color)),
                  color: AppColor.Buttom_color,
                ),
                child: Consumer<MenuNavigationController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => nav.SelectIndex_two(),
                          child: (nav.Selectindex == 2)
                              ? SvgPicture.asset(AppIcons.open_job, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color2)
                              : SvgPicture.asset(AppIcons.open_job, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color),
                        ),
                        GestureDetector(
                          onTap: () => nav.SelectIndex_one(),
                          child: (nav.Selectindex == 1)
                              ? SvgPicture.asset(AppIcons.Search_job, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color2)
                              : SvgPicture.asset(AppIcons.Search, height: Get.height / 32, width: Get.width / 32,color: AppColor.Button_color),
                        ),
                        GestureDetector(
                          onTap: () => nav.SelectIndex_three(),
                          child: (nav.Selectindex == 0)
                              ? SvgPicture.asset(AppIcons.Dashbord, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color2)
                              : SvgPicture.asset(AppIcons.Dashbord, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color),
                        ),
                        GestureDetector(
                          onTap: () => nav.SelectIndex_four(),
                          child: (nav.Selectindex == 3)
                              ? SvgPicture.asset(AppIcons.profile_open, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color2)
                              : SvgPicture.asset(AppIcons.profile_open, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color),
                        ),
                        GestureDetector(
                          onTap: () => nav.SelectIndex_five(),
                          child: (nav.Selectindex == 4)
                              ? SvgPicture.asset(AppIcons.Messages_Open, height: Get.height / 32, width: Get.width / 32, color: AppColor.Button_color2)
                              : SvgPicture.asset(AppIcons.Messages_Open, height: Get.height / 32, width: Get.width / 32,color: AppColor.Button_color),
                        ),
                      ],
                    );
                  },
                ),
              ),
              body: Consumer<MenuNavigationController>(builder: (BuildContext context, value, Widget? child) {return nav.Selectitem(nav.Selectindex);}),
            )
          : Scaffold(body: Container(height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color), child: Center(child: Image.asset(AppLoder.noInternet))));
    });
  }
}
