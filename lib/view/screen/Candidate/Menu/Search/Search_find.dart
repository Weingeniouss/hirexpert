// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_const_constructors, avoid_print, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/Search_Hendal.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/common/Icon/threedot.dart';
import '../../../../utils/common/List/jobSearch.dart';
import 'Applied_NotApplied/Details_Search.dart';

class Search_find extends StatelessWidget {
  final String onString;
  final SearchHendal searchHandler = Get.put(SearchHendal());
  final IsfavrationControllers isfavication = Get.put(IsfavrationControllers());
  final OptionApiController login = Get.put(OptionApiController());

  Search_find({super.key, required this.onString});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: Get.width, height: Get.height,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: Get.height / 50), Searching(OnString: onString),
            Expanded(
              child: Obx(() {
                if (searchHandler.Search.isLoding.value) {return Center(child: Image.asset(AppLoder.infinityloder_without_background));}
                else if (searchHandler.Search.Search_data['data'] == null) {return Center(child: Text(API_Error.null_data));}
                else {
                  return ListView.builder(
                    itemCount: searchHandler.Search.Search_data['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () {Details(
                                // JobID: ButtonAppingHandler().initializeWithIndex(index),
                                Icon: searchHandler.Search.Search_data['data'][index]['ComLogo'],
                                Job_Tital: searchHandler.Search.Search_data['data'][index]['JobTitle'],
                                Language: searchHandler.Search.Search_data['data'][index]['TechName'],
                                Commpany: searchHandler.Search.Search_data['data'][index]['ComName'],
                                Working: searchHandler.Search.Search_data['data'][index]["WorkWeek"],
                                Location: searchHandler.Search.Search_data['data'][index]["Location"],
                                Job_time: searchHandler.Search.Search_data['data'][index]['JobType'],
                                Exp: searchHandler.Search.Search_data['data'][index]["Experience"],
                                lake: searchHandler.Search.Search_data['data'][index]["Salary"],
                                Hybrid: searchHandler.Search.Search_data['data'][index]["WorkSet"],
                                stats: searchHandler.Search.Search_data['data'][index]["FormatDt"],
                                saveonTap: () => isfavication.IsfavrationControllers_fuction(CandidateId: Candidate, JobId: '10', IsLike: isfavication.isFavration.value.isFavourite == 1 ? '1' : '0', Tokan: Tokans),
                                saving: isfavication.isFavration.value.isFavourite == 1 ? SvgPicture.asset(AppIcons.bookmark) : SvgPicture.asset(AppIcons.save),
                                Share: Column(
                                  children: [
                                    SizedBox(height: Get.height / 80),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)), SizedBox(width: Get.width / 20),
                                        icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: JobSearch(
                          saveonTap: () => searchHandler,
                          savechild: (isfavication.isFavration.value.isFavourite == 1) ? SvgPicture.asset(AppIcons.bookmark) : SvgPicture.asset(AppIcons.save),
                          top: BorderSide(color: AppColor.Bottam_color),
                          Icon: searchHandler.Search.Search_data['data'][index]['ComLogo'],
                          Job_Tital: searchHandler.Search.Search_data['data'][index]['JobTitle'],
                          Language: searchHandler.Search.Search_data['data'][index]['TechName'],
                          Commpany: searchHandler.Search.Search_data['data'][index]['ComName'],
                          Working: searchHandler.Search.Search_data['data'][index]["WorkWeek"],
                          Location: searchHandler.Search.Search_data['data'][index]["Location"],
                          Job_time: searchHandler.Search.Search_data['data'][index]['JobType'],
                          Exp: searchHandler.Search.Search_data['data'][index]["Experience"],
                          lake: searchHandler.Search.Search_data['data'][index]["Salary"],
                          Hybrid: searchHandler.Search.Search_data['data'][index]["WorkSet"],
                          stats: searchHandler.Search.Search_data['data'][index]["FormatDt"],
                          Sharebool: true, Sharebool2: true,
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
