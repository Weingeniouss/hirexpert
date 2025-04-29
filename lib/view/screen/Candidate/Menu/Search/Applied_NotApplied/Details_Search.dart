// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, override_on_non_overriding_member, avoid_print, prefer_const_constructors_in_immutables, annotate_overrides, unnecessary_null_comparison, must_be_immutable, unused_import, use_build_context_synchronously, deprecated_member_use

// //Benefits Offered
// Text(Details_texts.Benefits_Offered, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
// SizedBox(height: Get.height / 50),
// SizedBox(
//   height: Get.height / 45,
//   child: ListView.builder(
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: Benefits_Offered.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 8, height: 8, child: CircleAvatar(backgroundColor: AppColor.subcolor)),
//           SizedBox(width: Get.width / 23),
//           Expanded(child: Text(Benefits_Offered[index], style: TextStyle(fontSize: 16, color: AppColor.subcolor))),
//         ],
//       );
//     },
//   ),
// ),
// SizedBox(height: Get.height / 50),
//
// //Suppiement Pay
// Text(Details_texts.Supplement_Pay, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
// SizedBox(height: Get.height / 50),
// SizedBox(
//   height: Get.width / 10,
//   child: ListView.builder(
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: Supplement_pay.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Row(crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 8, height: 8, child: CircleAvatar(backgroundColor: AppColor.subcolor)),
//           SizedBox(width: Get.width / 23),
//           Expanded(child: Text(Supplement_pay[index], style: TextStyle(fontSize: 16, color: AppColor.subcolor))),
//         ],
//       );
//     },
//   ),
// ),
// SizedBox(height: Get.height / 50),
//
// //Education Level Requird
// Text(Details_texts.Educational_Level_Required, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
// SizedBox(height: Get.height / 50),
// SizedBox(
//   height: Get.width / 15,
//   child: ListView.builder(
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: Education_level_Required.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 8, height: 8, child: CircleAvatar(backgroundColor: AppColor.subcolor)),
//           SizedBox(width: Get.width / 23),
//           Expanded(child: Text(Education_level_Required[index], style: TextStyle(fontSize: 16, color: AppColor.subcolor))),
//         ],
//       );
//     },
//   ),
// ),
// SizedBox(height: Get.height / 50),
//
// //Added Advantage Skills
// Text(Details_texts.Added_Advantage_Skills, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
// SizedBox(height: Get.height / 50),
// SizedBox(
//   height: Get.width / 10,
//   child: ListView.builder(
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: Added_Advantage_Skills.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 8, height: 8, child: CircleAvatar(backgroundColor: AppColor.subcolor)),
//           SizedBox(width: Get.width / 23),
//           Expanded(child: Text(Added_Advantage_Skills[index], style: TextStyle(fontSize: 16, color: AppColor.subcolor))),
//         ],
//       );
//     },
//   ),
// ),
// SizedBox(height: Get.height / 50),

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/OfferedjobConfim_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Second_Interview_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Second_Interviwe_Accted_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../../../../controller/User_Controller/Candidate_Controller/DatailsController/Details_Interviwe.dart';
import '../../../../../../modal/Dropdowns/drops.dart';
import '../../../../../utils/Loder/Loding.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../../utils/common/Buttons/ShortButton.dart';
import '../../../../../utils/common/Container/Option.dart';

class Details extends StatefulWidget {
  bool? interviwedata = false;
  bool? offerletters = false;
  final Widget? bottomNavigationBar; final String? Icon;  final Widget? Share; final Color? Color_container; final String? Job_Tital; final String? Language; final String? Commpany; final String? Working; final String? Location; final String? Job_time; final String? Exp; final String? lake; final String? Hybrid; final String? stats; final Widget? saving; final String? JobID; final void Function()? saveonTap; final bool? save;

  Details({
    super.key, this.interviwedata, this.offerletters, this.bottomNavigationBar, this.Icon, this.Color_container, this.Job_Tital,  this.Language,  this.Commpany,  this.Working,  this.Location,  this.Job_time,  this.Exp,  this.lake,  this.Hybrid,  this.stats, this.saveonTap, this.save, this.saving, this.JobID, this.Share
  });

  @override
  State<Details> createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  final SearchApiController Search = Get.put(SearchApiController());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
    final SearchApiControllerPagination Paggnation  = Get.put(SearchApiControllerPagination());

  @override
  void initState() {
    Future.microtask((){
      setState(() {
        Paggnation.fetchSearchResults(token: Tokans,candidateId: Candidate,isWeb: '0',timezone: 'asia/kolkata');
        isApply.IsApplingAPIController_fuction(JobId: isApply.isApplingdata['data']['JobId'], Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate);
        isApply.isApplingdata['data']['CurrentStatus'];
        print("pppp :- ${isApply.isApplingdata['data']['CurrentStatus']}");
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    var InterviweDetails = isApply.isApplingdata['data']['InterviewDel']['InterviewId'] ?? '';
    var OffersLatter = isApply.isApplingdata['data']['OfferDetail'] ?? '';
    return Scaffold(
      body: Obx(() {
          if (Paggnation.searchData.isEmpty && Paggnation.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (Paggnation.searchData.isEmpty) {
            return Center(child: Text("No Jobs Found"));
          }

         if (isApply.isLoding.value) {AppLodings.showLoadingDialog();}
         else {if (Get.isDialogOpen == true) {Get.back();}}
         if (isApply.isApplingdata['data'] == null) {return Scaffold(body: Center(child: Lottie.asset(AppLoder.noData)));}
         else {
            return Scaffold(
              backgroundColor: AppColor.Full_body_color, bottomNavigationBar: widget.bottomNavigationBar,
              body: Container(
                height: Get.height, width: Get.width,
                decoration: BoxDecoration(color: AppColor.Full_body_color),
                child: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          elevation: 0, backgroundColor: AppColor.Full_body_color, forceMaterialTransparency: true, pinned: false,
                          collapsedHeight: Get.height / 3.2, automaticallyImplyLeading: false,
                          flexibleSpace: SizedBox(
                            height: Get.height / 3.2,
                            child: JobSearch(
                              Sharebool2: true, JobID: widget.JobID, Icon: widget.Icon ?? '', Color_container: widget.Color_container, Job_Tital: widget.Job_Tital ?? '', Language: widget.Language ?? '', Commpany: widget.Commpany ?? '', Working: widget.Working ?? '', Location: widget.Location ?? '', Job_time: widget.Job_time ?? '', Exp: widget.Exp ?? '', lake: widget.lake ?? '', Hybrid: widget.Hybrid ?? '', stats: widget.stats ?? '', saveonTap: widget.saveonTap, savechild: widget.saving,
                              top: BorderSide(color: AppColor.Full_body_color),
                              bottam: BorderSide(color: AppColor.Bottam_color),
                              Share: widget.Share,
                            ),
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

                                   //Show ID
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: Get.width /2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Job Id :', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                                Text(widget.JobID ?? '', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                              ],
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('EmployerId :', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                                Text(isApply.isApplingdata['data']['EmployerId'] ?? '', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('JobApply ID :', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                                Text(isApply.isApplingdata['data']['JobApplyId'] ?? '', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('UniqueNo :', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                                SizedBox(width: Get.width / 20),
                                                Text(isApply.isApplingdata['data']['UniqueNo'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('CompanyId :', style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                                SizedBox(width: Get.width / 20),
                                                Text(isApply.isApplingdata['data']['CompanyId'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25,color: AppColor.subcolor)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),


                                  (InterviweDetails.toString().isNotEmpty)
                                      ? (widget.interviwedata == true)
                                      ?  InterviweStatas(context)
                                      : SizedBox()
                                      : SizedBox(),

                                 (widget.offerletters == true)
                                     ? (OffersLatter.toString().isNotEmpty) ? OfferLetter(context) : SizedBox()
                                     : SizedBox() ,

                                  SizedBox(height: Get.height / 60),

                                  // Description
                                  Text(Details_texts.Job_Description, style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  SizedBox(height: Get.height / 60),

                                  Html(
                                    data: isApply.isApplingdata['data']['JobAbout'],
                                    style: {
                                      'p': Style(fontSize: FontSize(Get.width / 27)),
                                      'strong': Style(fontSize: FontSize(Get.width / 27)),
                                      'li': Style(fontSize: FontSize(Get.width / 27)),
                                    },
                                  ),

                                  SizedBox(height: Get.height / 50),

                                  //Education level required
                                  Text('Education level required', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  Text(isApply.isApplingdata['data']['DegreeList'] != null && isApply.isApplingdata['data']['DegreeList'].isNotEmpty ? isApply.isApplingdata['data']['DegreeList'][0]['DegreeName'] : 'No Degree Available',),

                                  SizedBox(height: Get.height / 50),

                                  //Job Information
                                  Text('Job Information',style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  SizedBox(
                                    height: Get.height / 6,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: isApply.isApplingdata['data']['QuestionList'].length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('.', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 15)), SizedBox(width: Get.width / 50),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: Get.height / 80),
                                                Text(isApply.isApplingdata['data']['QuestionList'][index]['LabelName'],style: TextStyle(fontSize: Get.width / 25)),
                                                Text(isApply.isApplingdata['data']['QuestionList'][index]['Answer'][0],style: TextStyle(color: AppColor.subcolor,fontSize: Get.width / 27)),
                                                SizedBox(height: Get.height / 80),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(height: Get.height / 80), Divider(color: AppColor.offButton_color), SizedBox(height: Get.height / 80),

                                  //Emplyoer Information
                                  Text('Emplyoer Information',style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  SizedBox(height: Get.height / 80),
                                  Row(
                                    children: [
                                      SvgPicture.network(isApply.isApplingdata['data']['EmployerDel']['ComLogo'],height: 50,width: 50), SizedBox(width: Get.width / 50),
                                      Text(isApply.isApplingdata['data']['EmployerDel']['ComName']),
                                    ],
                                  ),
                                  SizedBox(height: Get.height / 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Location',style: TextStyle(fontSize: Get.width / 27)), Text(isApply.isApplingdata['data']['EmployerDel']['ComCityName'],style: TextStyle(fontSize: Get.width / 27))],
                                  ),
                                  SizedBox(height: Get.height / 100),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Mobile Number',style: TextStyle(fontSize: Get.width / 27)), Text(isApply.isApplingdata['data']['EmployerDel']['ComPhone'],style: TextStyle(fontSize: Get.width / 27))],
                                  ),
                                  SizedBox(height: Get.height / 100),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Email',style: TextStyle(fontSize: Get.width / 27)), Text(isApply.isApplingdata['data']['EmployerDel']['Email'],style: TextStyle(fontSize: Get.width / 27))],
                                  ),

                                  //About Company
                                  SizedBox(height: Get.height / 30),
                                  Text('About Company',style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  Text(isApply.isApplingdata['data']['EmployerDel']['ComAbout'],style: TextStyle(fontSize: Get.width / 27)),
                                  SizedBox(height: Get.height / 50),

                                  //About Recruiter
                                  SizedBox(height: Get.height / 30),
                                  Text('About Recruiter',style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  SizedBox(height: Get.height / 50),
                                  Row(
                                    children: [
                                      Image.network(isApply.isApplingdata['data']['EmployerDel']['ProfileImage'],height: 60, width: 60),
                                      SizedBox(width: Get.width / 60), Text(isApply.isApplingdata['data']['EmployerDel']['FirstName']),
                                      SizedBox(width: Get.width / 60), Text(isApply.isApplingdata['data']['EmployerDel']['LastName']),
                                    ],
                                  ),

                                  //Related Vacancies
                                  SizedBox(height: Get.height / 30),
                                  Text('Related Vacancies',style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)),
                                  SizedBox(height: Get.height / 50),

                                  //Related Vacancies
                                  CarouselSlider.builder(
                                      itemCount: Paggnation.searchData.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return Container(
                                          width: Get.width,
                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                          decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(Get.width / 25), border: Border.all(color: AppColor.subcolor)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(Paggnation.searchData[index]['ComLogo'],height: 70, width: 70),
                                                    SizedBox(width: Get.width / 30),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(width: Get.width / 2, child: Text(Paggnation.searchData[index]['JobTitle'],style: TextStyle(color: AppColor.subcolor,fontSize: Get.width / 28))),
                                                        SizedBox(width: Get.width / 2,child: Text(Paggnation.searchData[index]['TechName'],style: TextStyle(fontSize: Get.width / 28,))),
                                                        SizedBox(width: Get.width / 2, child: Text(Paggnation.searchData[index]['ComName'],style: TextStyle(color: AppColor.subcolor,fontSize: Get.width / 28))),
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
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(color: AppColor.offButton_color,borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          child: Padding(padding: EdgeInsets.all(5), child: Text(Paggnation.searchData[index]['WorkSet'])),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          decoration: BoxDecoration(color: AppColor.offButton_color,borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          child: Padding(padding: EdgeInsets.all(5), child: Text(Paggnation.searchData[index]['JobType'])),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          decoration: BoxDecoration(color: AppColor.offButton_color,borderRadius: BorderRadiusDirectional.circular(Get.width / 50)),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(5),
                                                            child: Text(Paggnation.searchData[index]['JobType']),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(viewportFraction: 1, autoPlay: true, autoPlayCurve: Curves.linear, autoPlayAnimationDuration: Duration(seconds: 2), height: Get.height / 4.5)),
                                  SizedBox(height: Get.height / 50),
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
        }
      ),
    );
  }
}

Widget InterviweStatas(context) {
  final Interviwe = Provider.of<DetailsInterviwe>(context, listen: false);
  final SecondInterviewController SecondInterview = Get.put(SecondInterviewController());
  final SecondInterviweAcctedController SecondInterviweAccted = Get.put(SecondInterviweAcctedController());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final TextEditingController dateTimeController = TextEditingController();

  Future<void> selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: now, lastDate: DateTime(2101));

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);

        if (combinedDateTime.isAfter(now)) {
          String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(combinedDateTime);
          dateTimeController.text = formattedDateTime;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select a future date and time.")),
          );
        }
      }
    }
  }

  String currentStatus = isApply.isApplingdata['data']['CurrentStatus'] ?? '';
  bool checkInterviewStatus(String status) {
    RegExp regex = RegExp(r"interview|interviwe", caseSensitive: false);
    return regex.hasMatch(status);
  }

  bool isInterview = checkInterviewStatus(currentStatus);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: Get.height / 60),
      Text(isApply.isApplingdata['data']['InterviewDel']['InterViewStep'], style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22)), SizedBox(height: Get.height / 60),
      SvgPicture.asset(AppIcons.interviwe_png), SizedBox(height: Get.height / 80),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isApply.isApplingdata['data']['InterviewDel']['InterviewType'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 22)),
          Text(isApply.isApplingdata['data']['InterviewDel']['InterviewDate'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 22)),
          Text(isApply.isApplingdata['data']['InterviewDel']['Descriptions'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 22)),
        ],
      ),
      SizedBox(height: Get.height / 60),
      // Text(Details_texts.Message, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 22)),
      // Text(Details_texts.Second_link, style: TextStyle(fontWeight: FontWeight.w300, fontSize: Get.width / 26, color: AppColor.Button_color, decoration: TextDecoration.underline)),


      (isApply.isApplingdata['data']['InterviewDel']['ScheduleStatus'] == 'Current' && isApply.isApplingdata['data']['CurrentStatus'] == isInterview)
          ? Row(
              mainAxisAlignment: (isApply.isApplingdata['data']['InterviewDel']['ScheduleStatus'] == 'Current' && isApply.isApplingdata['data']['CurrentStatus'] == isInterview) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                (isApply.isApplingdata['data']['InterviewDel']['CandidateRearrage'] == '0')
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColor.Full_body_color, elevation: 0,
                                    content: Container(
                                      height: Get.height / 5, width: Get.width,
                                      decoration: BoxDecoration(color: AppColor.Full_body_color),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppIcons.AlertDialog), SizedBox(height: Get.height / 50),
                                          Text(Details_texts.Decline_Interview, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w600)), SizedBox(height: Get.height / 80),
                                          Text(Details_texts.Are_you, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          OnButtons_short(onTap: () => Get.back(), width: Get.width / 3, btn_name: Details_texts.Cancle, Border_color: AppColor.Error_color, btn_color: AppColor.Error_color, text_color: AppColor.Full_body_color),
                                          OnButtons_short(
                                              onTap: () {
                                                Get.back();
                                                SecondInterviweAccted.SecondInterviewController_Fuction(Tokan: Tokans, ScheduleStatus: 'Declined', JobApplyId: '20', InterviewId: '30');
                                                print({
                                                  SecondInterviweAccted.SecondInterviewController_Fuction(Tokan: Tokans, ScheduleStatus: 'Declined', JobApplyId: '20', InterviewId: '30')
                                                });
                                              },
                                              width: Get.width / 3, btn_name: Details_texts.Decline, Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Collec(text: Details_texts.Decline, color: AppColor.Error_color, textcolor: AppColor.Full_body_color),
                          ),
                          (isApply.isApplingdata['data']['InterviewDel']['ScheduleStatus'] == 'Current' && isApply.isApplingdata['data']['CurrentStatus'] == isInterview)
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: AppColor.Full_body_color, elevation: 0,
                                            title: Container(
                                              height: Get.height / 20, width: Get.width,
                                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.select_check_color))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(),
                                                  Text(Details_texts.Re_arranges, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600)),
                                                  GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset(AppIcons.cancel)),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              height: Get.height / 4, width: Get.width,
                                              decoration: BoxDecoration(color: AppColor.Full_body_color),
                                              child: StatefulBuilder(
                                                builder: (BuildContext context, void Function(void Function())setState) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(text: Details_texts.HI, style: TextStyle(color: AppColor.subcolor, fontWeight: FontWeight.w600, fontSize: Get.width / 27, fontFamily: GoogleFonts.poppins().fontFamily)),
                                                            TextSpan(text: FristName, style: TextStyle(color: AppColor.subcolor, fontWeight: FontWeight.w600, fontSize: Get.width / 27, fontFamily: GoogleFonts.poppins().fontFamily)),
                                                            TextSpan(text: Details_texts.when_would, style: TextStyle(color: AppColor.subcolor, fontWeight: FontWeight.w600, fontSize: Get.width / 27, fontFamily: GoogleFonts.poppins().fontFamily)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: Get.height / 50),
                                                      Container(
                                                          height: Get.height / 20, width: Get.width,
                                                          decoration: BoxDecoration(border: Border.all(color: AppColor.select_check_color), borderRadius: BorderRadius.circular(Get.width / 60)),
                                                          child: Consumer<DetailsInterviwe>(
                                                            builder: (BuildContextcontext, value, Widget?child) {
                                                              return Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: Get.width / 1.5,
                                                                    child: DropdownButton<String>(
                                                                      underline: SizedBox(),
                                                                      borderRadius: BorderRadius.circular(Get.width / 20),
                                                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 30, color: AppColor.black_all),
                                                                      value: Interviwe.face,
                                                                      items: Mettings.map((String value) {
                                                                        return DropdownMenuItem<String>(value: value, child: Text(value));
                                                                      }).toList(),
                                                                      onChanged: (String? newValue) {
                                                                        if (newValue != null) {
                                                                          Interviwe.face_Select(newValue);
                                                                          print({
                                                                            Interviwe.face_Select(newValue)
                                                                          });
                                                                        }
                                                                      },
                                                                      isExpanded:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          )),
                                                      SizedBox(height: Get.height / 50),
                                                      Text(Details_texts.Date_Time, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                                      Container(
                                                        height: Get.height / 20, width: Get.width,
                                                        decoration: BoxDecoration(border: Border.all(color: AppColor.select_check_color), borderRadius: BorderRadius.circular(Get.width / 60)),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                                          child: TextField(
                                                            decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
                                                            keyboardType: TextInputType.number,
                                                            controller: dateTimeController,
                                                            readOnly: true,
                                                            onTap: () => selectDateTime(context),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  OnButtons_short(onTap: () => Get.back(), width: Get.width / 3, btn_name: Details_texts.Cancle, Border_color: AppColor.Error_color, btn_color: AppColor.Error_color, text_color: AppColor.Full_body_color),
                                                  OnButtons_short(
                                                      onTap: () {
                                                        Get.back();
                                                        SecondInterview.SecondInterviewController_Fuction(
                                                          Tokan: Tokans,
                                                          InterviewQueId: isApply.isApplingdata['data']['InterviewDel']['InterviewQueId'],
                                                          InterviewId: isApply.isApplingdata['data']['InterviewDel']['InterviewId'],
                                                          JobApplyId: isApply.isApplingdata['data']['InterviewDel']['JobApplyId'],
                                                          CandidateId: Candidate,
                                                          InterviewStatus: Interviwe.face.toString(),
                                                          InterviewDate: '2024-12-06 11:47',
                                                          Timezone: 'Asia/Calcutta',
                                                          InterviewType: isApply.isApplingdata['data']['InterviewDel']['InterviewType'],
                                                        );
                                                        print({
                                                          SecondInterview.SecondInterviewController_Fuction(
                                                          Tokan: Tokans,
                                                          InterviewQueId: isApply.isApplingdata['data']['InterviewDel']['InterviewQueId'],
                                                          InterviewId: isApply.isApplingdata['data']['InterviewDel']['InterviewId'],
                                                          JobApplyId: isApply.isApplingdata['data']['InterviewDel']['JobApplyId'],
                                                          CandidateId: Candidate,
                                                          InterviewStatus: Interviwe.face.toString(),
                                                          InterviewDate: '2024-12-06 11:47',
                                                          Timezone: 'Asia/Calcutta',
                                                          InterviewType: isApply.isApplingdata['data']['InterviewDel']['InterviewType'],
                                                        ),
                                                        });
                                                      },
                                                      width: Get.width / 3, btn_name: Details_texts.Yes_re_arrange, Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Collec(text: Details_texts.Re_arranges, color: AppColor.success_color, textcolor: AppColor.Full_body_color))
                              : SizedBox(),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColor.Full_body_color, elevation: 0,
                                    content: Container(
                                      height: Get.height / 5, width: Get.width,
                                      decoration: BoxDecoration(color: AppColor.Full_body_color),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppIcons.AlertDialog), SizedBox(height: Get.height / 50),
                                          Text(Details_texts.Accept_Interview, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w600)), SizedBox(height: Get.height / 80),
                                          Text(Details_texts.Are_you_sure, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          OnButtons_short(onTap: () => Get.back(), width: Get.width / 3, btn_name: Details_texts.Cancle, Border_color: AppColor.Error_color, btn_color: AppColor.Error_color, text_color: AppColor.Full_body_color),
                                          OnButtons_short(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    elevation: 0, backgroundColor: AppColor.Full_body_color,
                                                    content: Container(
                                                      width: Get.width, height: Get.height / 5, decoration: BoxDecoration(color: AppColor.Full_body_color),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(AppIcons.select, height: 60, width: 60), SizedBox(height: Get.height / 50),
                                                          Text(Details_texts.Success, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w600)), SizedBox(height: Get.height / 50),
                                                          Text(Details_texts.Job_Interview, style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 25, fontWeight: FontWeight.w400)),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      OnButtons_short(onTap: () => Get.back(), btn_name: Details_texts.Ok, Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            width: Get.width / 3, btn_name: Details_texts.Accept, Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color,
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: GestureDetector(
                                onTap: () {
                                  SecondInterviweAccted.SecondInterviewController_Fuction(Tokan: Tokans, ScheduleStatus: 'Accepted', JobApplyId: isApply.isApplingdata['data']['JobApplyId'], InterviewId: isApply.isApplingdata['data']['InterviewDel']['InterviewId']);
                                  print({
                                    SecondInterviweAccted.SecondInterviewController_Fuction(Tokan: Tokans, ScheduleStatus: 'Accepted', JobApplyId: isApply.isApplingdata['data']['JobApplyId'], InterviewId: isApply.isApplingdata['data']['InterviewDel']['InterviewId'])
                                  });
                                },
                                child: Collec(text: Details_texts.Accept, color: AppColor.Button_color, textcolor: AppColor.Full_body_color)),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            )
          : SizedBox(),
    ],
  );
}

Widget OfferLetter(context) {
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final OfferedjobconfimController OfferedConform = Get.put(OfferedjobconfimController());
  final ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());

  String Offersring = isApply.isApplingdata['data']['CurrentStatus'];

  Future<void> downloadOfferLetter(String offerLetterUrl) async {
    try {
      if (offerLetterUrl.isEmpty) {throw Exception("No file path provided");}
      const String baseUrl = '${AppUrl.CanJobDetails}?JobId=76&Timezone=asia/kolkata&CandidateId=6&IsInterview=1';
      if (!offerLetterUrl.startsWith("http")) {offerLetterUrl = baseUrl + offerLetterUrl;}
      print("Downloading from: $offerLetterUrl");
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Storage permission denied')));
          return;
        }
      }
      if (offerLetterUrl.startsWith("http") || offerLetterUrl.startsWith("https")) {
        await launchUrl(Uri.parse(offerLetterUrl), mode: LaunchMode.externalApplication);
      } else {
        if (Platform.isAndroid) {
          var status = await Permission.storage.request();
          if (!status.isGranted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Storage permission denied')));
            return;
          }
        }
        var dio = Dio();
        Directory? downloadsDir = await getExternalStorageDirectory();
        String filePath = "${downloadsDir?.path}/OfferLetter.pdf";
        await dio.download(offerLetterUrl, filePath);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloaded to: $filePath')));
      }
    } catch (e) {
      print("Error downloading file: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to download offer letter')));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Offered', style: TextStyle(fontSize: Get.width / 25)),
      SizedBox(height: Get.height / 60),
      Horizontalplace('Offerer CTC', '${isApply.isApplingdata['data']['OfferDetail']['OfferSalary']} Per Monthly'),
      Horizontalplace('Offerer Letter', isApply.isApplingdata['data']['OfferDetail']['OfferLetter'], onTap: () {
        downloadOfferLetter(isApply.isApplingdata['data']['OfferDetail']['OfferLetter']);
      }),
      Horizontalplace('Notes', isApply.isApplingdata['data']['OfferDetail']['Description']),
      Horizontalplace('Status', isApply.isApplingdata['data']['OfferDetail']['OfferSalary']),
      SizedBox(height: Get.height / 50),

      (Offersring == 'Offered') ? SizedBox(
        width: Get.width / 1.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnButtons_short(
              onTap: () {
                OfferedConform.isLoding.value = true;
                try {
                  OfferedConform.Offeredjobconfim_Fuction(ApplyStatus: 'Declined', JobApplyId: isApply.isApplingdata['data']['JobApplyId'].toString(), Tokan: Tokans).
                  then((_) {
                    OfferedConform.isLoding.value = false; ToastificationSuccess.Success(OfferedConform.Offeredjobconfim_data['message']);
                  }).catchError((error) {
                    OfferedConform.isLoding.value = false; ToastificationError.Error("Failed: $error");
                    print('$error');
                  });
                } catch (e) {
                  OfferedConform.isLoding.value = false; ToastificationError.Error("Exception: $e");
                }
              },
              width: Get.width / 3, btn_name: (OfferedConform.isLoding.value) ? 'Loading...' : 'Cancel', Border_color: AppColor.SuessColor_Color, btn_color: AppColor.SuessColor_Color, text_color: AppColor.Full_body_color,
            ),
             OnButtons_short(
              onTap: () {
                OfferedConform.isLoding.value = true;
                try {
                  OfferedConform.Offeredjobconfim_Fuction(ApplyStatus: 'Accepted', JobApplyId: isApply.isApplingdata['data']['JobApplyId'].toString(), Tokan: Tokans).
                  then((_) {
                    ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 3, Tokan: Tokans, CandidateId: Candidate);
                    try {
                      if (ApplyStatus.ApplyStatusData['status'] == true) {
                        ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- ${PopMenuItem.Not_Interested}');
                        Get.back();
                      } else {
                        ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? PopMenuItem.Not_Interested);
                      }
                    } catch (e) {
                      ToastificationError.Error('An error occurred: $e');
                    } finally {
                      ApplyStatus.isLoding.value = false;
                    }
                    OfferedConform.isLoding.value = false; ToastificationSuccess.Success(OfferedConform.Offeredjobconfim_data['message']);
                  }).catchError((error) {
                    OfferedConform.isLoding.value = false; ToastificationError.Error("Failed: $error");
                    print('$error');
                  });
                } catch (e) {
                  OfferedConform.isLoding.value = false; ToastificationError.Error("Exception: $e");
                }
              },
              width: Get.width / 3, btn_name: (OfferedConform.isLoding.value) ? 'Loading...' : 'Accept', Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color,
            ),
          ],
        ),
      ) : SizedBox()
    ],
  );
}

// Commen Widget
Widget Horizontalplace(text, offertext, {void Function()? onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('$text : ', style: TextStyle(fontSize: Get.width / 27)),
      GestureDetector(
        onTap: onTap,
        child: Text(offertext, style: TextStyle(fontSize: Get.width / 27)),
      ),
    ],
  );
}
