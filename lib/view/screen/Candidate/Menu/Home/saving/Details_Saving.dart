// ignore_for_file: must_be_immutable, non_constant_identifier_names, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../../../../controller/Save_Controller/Candidate_state/Menu/Search/Searech_location_Save.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_loder.dart';

// ignore: unused_import
import '../../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../../utils/common/List/jobSearch.dart';

class DetailsSaving extends StatelessWidget {
  final String Icon; final Color? Color_container; final String Job_Tital; final String Language; final String Commpany; final String Working; final String Location; final String Job_time; final Widget? Share; final String Exp; final String lake; final String Hybrid; final String stats; final Widget? saving; final String? jobid; final void Function()? saveonTap; final bool? save;
  DetailsSaving({super.key, required this.Icon, this.Color_container, required this.Job_Tital, required this.Language, required this.Commpany, required this.Working, required this.Location, required this.Job_time, required this.Exp, required this.lake, required this.Hybrid, required this.stats, this.saving, this.saveonTap, this.save, this.jobid, this.Share});

  final SearechLocationSave SavingDetails = Get.put(SearechLocationSave());
  final SearchApiController Search_Vacancies = Get.put(SearchApiController());

  @override
  Widget build(BuildContext context) {
    SavingDetails.sumit.onInit(); SavingDetails.onInit();
    return Scaffold(
      backgroundColor: AppColor.Full_body_color,
      body: Obx(() {
        if (SavingDetails.sumit.isApply.isLoding.value) {
          return Scaffold(
              body: Container(
                  height: Get.height, width: Get.width,
                  decoration: BoxDecoration(color: AppColor.Full_body_color),
                  child: Center(child: Image.asset(AppLoder.infinityloder_without_background, scale: Get.width / 250))
              )
          );
        } else if (SavingDetails.sumit.isApply.isApplingdata['data'] == null ||
            SavingDetails.sumit.isApply.isApplingdata == null) {
          return Scaffold(
              backgroundColor: AppColor.Full_body_color,
              body: Container(
                  height: Get.height, width: Get.width,
                  decoration: BoxDecoration(color: AppColor.Full_body_color),
                  child: Center(child: Image.asset(AppLoder.infinityloder_without_background))
              )
          );
        } else {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.Full_body_color,
              body: Container(
                height: Get.height, width: Get.width,
                decoration: BoxDecoration(color: AppColor.Full_body_color),
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        elevation: 0, backgroundColor: AppColor.Full_body_color, forceMaterialTransparency: true, pinned: false, collapsedHeight: Get.height / 3, automaticallyImplyLeading: false,
                        flexibleSpace: SizedBox(
                          height: Get.height / 3,
                          child: JobSearch(Share: Share, Sharebool2: true, JobID: jobid, Icon: Icon, Color_container: Color_container, Job_Tital: Job_Tital, Language: Language, Commpany: Commpany, Working: Working, Location: Location, Job_time: Job_time, Exp: Exp, lake: lake, Hybrid: Hybrid, stats: stats, saveonTap: saveonTap, savechild: saving, top: BorderSide(color: AppColor.Full_body_color), bottam: BorderSide(color: AppColor.Bottam_color)),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 60),

                                //Description
                                Text(Details_texts.Job_Description, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                Html(
                                  data: SavingDetails.sumit.isApply.isApplingdata['data']['JobAbout'],
                                  style: {
                                    'p': Style(fontSize: FontSize(Get.width / 27)),
                                    'strong': Style(fontSize: FontSize(Get.width / 27)),
                                    'li': Style(fontSize: FontSize(Get.width / 27))
                                  },
                                ),
                                SizedBox(height: Get.height / 60),
                                Text('Emplyoer Information', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                SizedBox(height: Get.height / 80),
                                Row(
                                  children: [
                                    SvgPicture.network(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ComLogo'], height: 50, width: 50), SizedBox(width: Get.width / 50),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ComName']),
                                  ],
                                ),
                                SizedBox(height: Get.height / 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Location', style: TextStyle(fontSize: Get.width / 27)),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ComCityName'], style: TextStyle(fontSize: Get.width / 27))
                                  ],
                                ),
                                SizedBox(height: Get.height / 100),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Mobile Number', style: TextStyle(fontSize: Get.width / 27)),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ComPhone'], style: TextStyle(fontSize: Get.width / 27))
                                  ],
                                ),
                                SizedBox(height: Get.height / 100),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Email', style: TextStyle(fontSize: Get.width / 27)),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['Email'], style: TextStyle(fontSize: Get.width / 27))
                                  ],
                                ),

                                //About Company
                                SizedBox(height: Get.height / 30),
                                Text('About Company', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ComAbout'], style: TextStyle(fontSize: Get.width / 27)),
                                SizedBox(height: Get.height / 50),

                                //About Recruiter
                                SizedBox(height: Get.height / 30),
                                Text('About Recruiter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                SizedBox(height: Get.height / 50),
                                Row(
                                  children: [
                                    Image.network(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['ProfileImage'], height: 60, width: 60), SizedBox(width: Get.width / 60),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['FirstName']), SizedBox(width: Get.width / 60),
                                    Text(SavingDetails.sumit.isApply.isApplingdata['data']['EmployerDel']['LastName']),
                                  ],
                                ),

                                //Related Vacancies
                                SizedBox(height: Get.height / 30),
                                Text('Related Vacancies', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                SizedBox(height: Get.height / 50),

                                //Related Vacancies
                                CarouselSlider.builder(
                                    itemCount: Search_Vacancies.Search_data['data'].length,
                                    itemBuilder: (context, index, realIndex) {
                                      return Container(
                                        width: Get.width,
                                        margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                        decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(Get.width / 25), border: Border.all(color: AppColor.subcolor)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Row(
                                                children: [
                                                  Image.network(Search_Vacancies.Search_data['data'][index]['ComLogo'], height: 70, width: 70),
                                                  SizedBox(width: Get.width / 30),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(width: Get.width / 2, child: Text(Search_Vacancies.Search_data['data'][index]['JobTitle'], style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 28))),
                                                      SizedBox(width: Get.width / 2, child: Text(Search_Vacancies.Search_data['data'][index]['TechName'], style: TextStyle(fontSize: Get.width / 28))),
                                                      SizedBox(width: Get.width / 2, child: Text(Search_Vacancies.Search_data['data'][index]['ComName'], style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 28))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Wrap(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(color: AppColor.offButton_color, borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          child: Padding(padding: EdgeInsets.all(5), child: Text(Search_Vacancies.Search_data['data'][index]['WorkSet'])),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          decoration: BoxDecoration(color: AppColor.offButton_color, borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          child: Padding(padding: EdgeInsets.all(5), child: Text(Search_Vacancies.Search_data['data'][index]['JobType'])),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          decoration: BoxDecoration(color: AppColor.offButton_color, borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          child: Padding(padding: EdgeInsets.all(5), child: Text(Search_Vacancies.Search_data['data'][index]['JobType'])),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }, options: CarouselOptions(viewportFraction: 1, autoPlay: true, autoPlayCurve: Curves.linear, autoPlayAnimationDuration: Duration(seconds: 2), height: Get.height / 4.5)),
                                SizedBox(height: Get.height / 60),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
