// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_const_constructors, invalid_use_of_protected_member, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Home/InterviweDetails.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/SarchHndaler_Conteroller.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_constance.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../../utils/app_loder.dart';
import '../../../../../utils/common/Icon/threedot.dart';
import '../../../../../utils/common/List/jobSearch.dart';
import '../../Search/Applied_NotApplied/Details_Search.dart';
import '../../Search/Notification.dart';

class Show_Interviwe extends StatefulWidget {
  const Show_Interviwe({super.key});

  @override
  State<Show_Interviwe> createState() => _Show_InterviweState();
}

class _Show_InterviweState extends State<Show_Interviwe> {
  final Interviwedetails Interview = Get.put(Interviwedetails());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final SarchhndalerConteroller Sarching = Get.put(SarchhndalerConteroller());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());


  @override
  Widget build(BuildContext context) {
    Interview.onInit();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height / 10, surfaceTintColor: AppColor.Full_body_color, backgroundColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false, title: Text(My_Jobs_Screen.Interview, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          Stack(
            children: [
              GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
              if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                Positioned(
                  left: 13, bottom: 13,
                  child: CircleAvatar(
                    radius: 8, backgroundColor: AppColor.Notification_Color,
                    child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40, color: AppColor.Full_body_color)),
                  ),
                ),
            ],
          ),
          SizedBox(width: Get.width / 25),
        ],
      ),
      body: Container(
        height: size.height, width: size.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
            if (Interview.JobInter.isloding.value) {return Center(child: Lottie.asset(AppLoder.noData));}
            else if (Interview.JobInter.JobInterviwe_data.value['data'] == null) {return Center(child: Lottie.asset(AppLoder.noData));}
            else {
              return ListView.builder(
                itemCount: Interview.JobInter.JobInterviwe_data['data'].length, padding: EdgeInsets.zero, shrinkWrap: true, itemBuilder: (BuildContext context, int index) {
                 var Jobbing  = Interview.JobInter.JobInterviwe_data.value['data'][index]['JobId'];
                  return JobSearch(
                    onTap: () {
                       isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate, IsInterview: '1').
                       then((_){
                        Get.to(() => Details(
                          interviwedata: true, bottomNavigationBar: SizedBox(),
                          Icon: Interview.JobInter.JobInterviwe_data.value['data'][index]['ComLogo'], JobID: Jobbing,
                          Job_Tital: Interview.JobInter.JobInterviwe_data.value['data'][index]['JobTitle'],
                          Language: Interview.JobInter.JobInterviwe_data.value['data'][index]['TechName'],
                          Commpany: Interview.JobInter.JobInterviwe_data.value['data'][index]['ComName'],
                          Working: Interview.JobInter.JobInterviwe_data.value['data'][index]['WorkWeek'],
                          Location: Interview.JobInter.JobInterviwe_data.value['data'][index]['Location'],
                          Job_time: Interview.JobInter.JobInterviwe_data.value['data'][index]['JobType'],
                          Exp: Interview.JobInter.JobInterviwe_data.value['data'][index]['Experience'],
                          lake: Interview.JobInter.JobInterviwe_data.value['data'][index]['Salary'],
                          Hybrid: Interview.JobInter.JobInterviwe_data.value['data'][index]['WorkSet'],
                          stats: Interview.JobInter.JobInterviwe_data.value['data'][index]['FormatDt'],
                          saving: PopupMenuButton<String>(
                              color: AppColor.Full_body_color,
                              onSelected: (String value) async{
                                if (value == PopMenuItem.OfferReceived) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 1, Tokan: Tokans, CandidateId: Candidate);
                                  try {
                                    if (ApplyStatus.ApplyStatusData['status'] == true) {
                                      ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- ${PopMenuItem.OfferReceived}');
                                      Get.back();
                                    } else {
                                      ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? PopMenuItem.OfferReceived);
                                    }
                                  } catch (e) {
                                    ToastificationError.Error('An error occurred: $e');
                                  } finally {
                                    ApplyStatus.isLoding.value = false;
                                  }
                                }
                                if (value == PopMenuItem.Hired) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 2, Tokan: Tokans, CandidateId: Candidate);
                                  try {
                                    if (ApplyStatus.ApplyStatusData['status'] == true) {
                                      ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- ${PopMenuItem.Hired}');
                                      Get.back();
                                    } else {
                                      ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? PopMenuItem.Hired);
                                    }
                                  } catch (e) {
                                    ToastificationError.Error('An error occurred: $e');
                                  } finally {
                                    ApplyStatus.isLoding.value = false;
                                  }
                                }
                                if (value == PopMenuItem.Not_Interested) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 3, Tokan: Tokans, CandidateId: Candidate);
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
                                }
                                 setState(() {});
                                },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<String>(value: PopMenuItem.OfferReceived, child: Text(PopMenuItem.OfferReceived)),
                                PopupMenuItem<String>(value: PopMenuItem.Hired, child: Text(PopMenuItem.Hired)),
                                PopupMenuItem<String>(value: PopMenuItem.Not_Interested, child: Text(PopMenuItem.Not_Interested)),
                              ],
                              child: Threedot(),
                            ),
                          save: true,
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
                        ),
                      );
                      });
                      setState(() {});
                    },
                    JobID: Jobbing,
                    Icon: Interview.JobInter.JobInterviwe_data.value['data'][index]['ComLogo'],
                    Job_Tital: Interview.JobInter.JobInterviwe_data.value['data'][index]['JobTitle'],
                    Language: Interview.JobInter.JobInterviwe_data.value['data'][index]['TechName'],
                    Commpany: Interview.JobInter.JobInterviwe_data.value['data'][index]['ComName'],
                    Working: Interview.JobInter.JobInterviwe_data.value['data'][index]["WorkWeek"],
                    Location: Interview.JobInter.JobInterviwe_data.value['data'][index]["Location"],
                    Job_time: Interview.JobInter.JobInterviwe_data.value['data'][index]['JobType'],
                    Exp: Interview.JobInter.JobInterviwe_data.value['data'][index]["Experience"],
                    lake: Interview.JobInter.JobInterviwe_data.value['data'][index]["Salary"],
                    Hybrid: Interview.JobInter.JobInterviwe_data.value['data'][index]["WorkSet"],
                    stats: Interview.JobInter.JobInterviwe_data.value['data'][index]["InterviewDate"],
                    top: BorderSide(color: AppColor.Bottam_color),
                    savechild: SizedBox(),
                    Sharebool: true, Sharebool2: true,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
