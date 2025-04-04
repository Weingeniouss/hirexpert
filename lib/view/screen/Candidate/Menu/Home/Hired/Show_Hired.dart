
// ignore_for_file: file_names, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, invalid_use_of_protected_member, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Withdrow_Application_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Home/Appling_API_handler.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Home/Hired_API_handler.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/SarchHndaler_Conteroller.dart';
import 'package:hirexpert/view/utils/Loder/Loding.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/Offer_Controller.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_constance.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../../utils/common/Icon/threedot.dart';
import '../../Search/Applied_NotApplied/Details_Search.dart';
import '../../Search/Notification.dart';

class Show_Hired extends StatefulWidget {
  Show_Hired({super.key});

  @override
  State<Show_Hired> createState() => _Show_HiredState();
}

class _Show_HiredState extends State<Show_Hired> {
  final OfferController hired = Get.put(OfferController());
  final ScrollController scrollController = ScrollController();

   @override
  void initState() {
    hired.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Hired', Tokan: Tokans, Page: hired.currentPage.value.toString());
    if (hired.hasMoreData.value && !hired.isLoding.value) {
      scrollController.addListener(() {
        if (hired.hasMoreData.value && !hired.isLoding.value) {
          if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9) {
            hired.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Hired', Tokan: Tokans, Page: hired.currentPage.value.toString());
          }
        }
      });
    }
    super.initState();
  }

  // final HiredApiHandler Hireding = Get.put(HiredApiHandler());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, elevation: 0, surfaceTintColor: AppColor.Full_body_color, automaticallyImplyLeading: false, title: Text(My_Jobs_Screen.Hired, style: TextStyle(fontWeight: FontWeight.w700)),
          actions: [
            Stack(
                children: [
                  GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
                  if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                    Positioned(
                      left: 13, bottom: 13,
                      child: CircleAvatar(
                        radius: 8, backgroundColor: AppColor.Notification_Color,
                        child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40,color: AppColor.Full_body_color)),
                      ),
                    ),
                ],
              ),
           SizedBox(width: Get.width / 25),
          ],
      ),
      body: Obx(() {
          if (hired.isLoding.value) {AppLodings.showLoadingDialog();}
          else {if (Get.isDialogOpen == true) {Get.back();}}
          if (hired.OfferData['data'] == null) {return Scaffold(body: Container(height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color), child: Center(child: Lottie.asset(AppLoder.noData))));}
          else {
            return Container(
              height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
              child: RefreshIndicator(
                onRefresh: () {
                  hired.OfferData.clear();
                  hired.currentPage.value = 1;
                  hired.hasMoreData.value = true;
                  return hired.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Hired', Tokan: Tokans, Page: hired.currentPage.value.toString());
                },
                child: ListView.builder(
                  controller: scrollController,
                itemCount: hired.OfferData['data']!.length + 1, padding: EdgeInsets.zero, shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index == hired.OfferData['data'].length) {
                      if (hired.OfferData['data'].length > 10 && hired.hasMoreData.value) {
                        return Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)));
                      } else {
                        return Center(child: Text('', style: TextStyle(color: Colors.grey)));
                      }
                    }

                var Jobbing = hired.OfferData['data'][index]['JobId'];
                  return JobSearch(
                    onTap: () async{
                     await isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate);
                      Get.to(() => Details(
                          bottomNavigationBar: (isApply.isApplingdata['data']['CurrentStatus'] == 'Hired') ? Padding(padding: EdgeInsets.all(20), child: OnButtons(Button_Color: AppColor.SuessColor_Color, btn_name: Details_texts.Hired, Boder_Button_Color: AppColor.SuessColor_Color)) : SizedBox(),
                          JobID: Jobbing,
                          Icon: hired.OfferData['data'][index]['ComLogo'],
                          Job_Tital: hired.OfferData['data'][index]['JobTitle'],
                          Language: hired.OfferData['data'][index]['TechName'],
                          Commpany: hired.OfferData['data'][index]['ComName'],
                          Working: hired.OfferData['data'][index]['WorkWeek'],
                          Location: hired.OfferData['data'][index]['Location'],
                          Job_time: hired.OfferData['data'][index]['JobType'],
                          Exp: hired.OfferData['data'][index]['Experience'],
                          lake: hired.OfferData['data'][index]['Salary'],
                          Hybrid: hired.OfferData['data'][index]['WorkSet'],
                          stats: hired.OfferData['data'][index]['FormatDt'],save: true,
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
                                if (value == PopMenuItem.Not_Interested) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 2, Tokan: Tokans, CandidateId: Candidate);
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
                                PopupMenuItem<String>(value: PopMenuItem.Not_Interested, child: Text(PopMenuItem.Not_Interested)),
                              ],
                            child: Threedot(),
                          ),
                        ),
                      );
                    },
                    JobID: Jobbing, Icon: hired.OfferData['data'][index]["ComLogo"],
                    Job_Tital: hired.OfferData['data'][index]["JobTitle"],
                    Language: hired.OfferData['data'][index]["TechName"],
                    Commpany: hired.OfferData['data'][index]["ComName"],
                    Working: hired.OfferData['data'][index]['WorkWeek'],
                    Location: hired.OfferData['data'][index]["Location"],
                    Job_time: hired.OfferData['data'][index]["JobType"],
                    Exp: hired.OfferData['data'][index]["Experience"],
                    lake: hired.OfferData['data'][index]["Salary"],
                    Hybrid: hired.OfferData['data'][index]["WorkSet"],
                    stats: hired.OfferData['data'][index]['InterviewDate'],
                    top: BorderSide(color: AppColor.Bottam_color),
                    savechild: SizedBox(), Sharebool: true, Sharebool2: true,
                  );
                },
              ),
              ),
            );
          }
        },
      ),
    );
  }
}
