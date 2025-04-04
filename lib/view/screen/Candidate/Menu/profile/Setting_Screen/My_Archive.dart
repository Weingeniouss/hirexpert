// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_null_comparison, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/ArchiveJobList_Controller.dart';
import 'package:hirexpert/view/utils/Loder/Loding.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/buttom/Candidate/candidate_buttom.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../../controller/API_handler/Candidate/Menu/profile/My_Archive_hendler.dart';
import '../../../../../../controller/User_Controller/Candidate_Controller/BottamController/MenuNavigationController.dart';

class My_Archive extends StatelessWidget {
  final MyArchiveHendler MyArchiv = Get.put(MyArchiveHendler());
  My_Archive({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<MenuNavigationController>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColor.Full_body_color,
      // bottomNavigationBar: Consumer<MenuNavigationController>(
      //   builder: (BuildContext context, value, Widget? child) {
      //     return Padding(
      //       padding: EdgeInsets.all(15),
      //       child: Container(child: OnButtons(onTap: () {Get.offAll(() => Candidate_Bottam()); nav.SelectIndex_one();}, Button_Color: AppColor.Button_color, btn_name: My_Archive_text.Search_Job)),
      //     );
      //   },
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 15),
        child: AppBar(
          surfaceTintColor: AppColor.Full_body_color,
          backgroundColor: AppColor.Full_body_color, automaticallyImplyLeading: false,
          title: SizedBox(
            height: Get.height / 20, width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // GestureDetector(onTap: () => Get.back(), child: Icon(Icons.navigate_before, size: 35)),
                Text(My_Archive_text.titele, style: TextStyle(fontSize: Get.width / 20)),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
          if (MyArchiv.Archivejoblist.isloding.value) {AppLodings.showLoadingDialog();}
          else {if (Get.isDialogOpen == true) {Get.back();}}
          if (MyArchiv.Archivejoblist.Archivejoblistdata.value?['data']  == null) {return Center(child: Lottie.asset(AppLoder.noData));}
          else {
            return SafeArea(
              child: ListView.builder(
                itemCount:MyArchiv. Archivejoblist.Archivejoblistdata.value!['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return JobSearch(
                    Icon: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['ComLogo'],
                    Job_Tital: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['JobTitle'],
                    Language: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['TechName'],
                    Commpany: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['ComName'],
                    Working: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['Experience'],
                    Location: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['Location'],
                    Job_time: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['TechName'],
                    Exp: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['Experience'],
                    lake: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['Salary'],
                    Hybrid:MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['Experience'],
                    stats: MyArchiv.Archivejoblist.Archivejoblistdata.value?['data'][index]['FormatDt'],
                    savechild: SizedBox(), Sharebool2: true, Sharebool: true,
                    top: BorderSide(color: AppColor.Bottam_color),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
