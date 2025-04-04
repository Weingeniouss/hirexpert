// ignore_for_file: camel_case_types, file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_null_comparison, unused_local_variable, must_be_immutable, deprecated_member_use, avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Withdrow_Application_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/SarchHndaler_Conteroller.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/ApplyJobList_Controller.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/jobcountsaccording.dart';
import '../../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../utils/Loder/Loding.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_constance.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../../utils/common/Icon/threedot.dart';
import '../../Search/Applied_NotApplied/Details_Search.dart';
import '../../Search/Notification.dart';

class Show_Applied extends StatefulWidget {

  Show_Applied({super.key});

  @override
  State<Show_Applied> createState() => _Show_AppliedState();
}

class _Show_AppliedState extends State<Show_Applied> {
  ApplyjoblistController Applay = Get.put(ApplyjoblistController());

  @override
  void initState() {
    Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
    super.initState();
  }

  final WithdrowApplicationController Withdrow = Get.put(WithdrowApplicationController());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());
  final SarchhndalerConteroller Sarching = Get.put(SarchhndalerConteroller());
  final Jobcountsaccording jobcount = Get.put(Jobcountsaccording());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false, surfaceTintColor: AppColor.Full_body_color,
        title: Text(My_Jobs_Screen.Applied, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          Stack(
            children: [
              GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
              if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata == null))
                Positioned(left: 13, bottom: 13, child: CircleAvatar(radius: 8, backgroundColor: AppColor.Notification_Color, child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40, color: AppColor.Full_body_color)))),
            ],
          ),
          SizedBox(width: Get.width / 25),
        ],
      ),
      body: Obx(() {
          if (Applay.isLoding.value) {AppLodings.showLoadingDialog();}
          else {if (Get.isDialogOpen == true) {Get.back();}}
          if (Applay.ApplyJobList_data == null) {return Center(child: Lottie.asset(AppLoder.noData));}
          else {
            return Container(
              height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
              child: ListView.builder(
                controller: Applay.scrollController,
                padding: EdgeInsets.zero, shrinkWrap: true, itemCount: Applay.ApplyJobList_data.value.length + (Applay.hasMoreData.value ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {

                  if (index == Applay.ApplyJobList_data.value.length) {
                    if (Applay.ApplyJobList_data.value.length > 10) {
                      return Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)));
                    } else {
                      return Center(child: Text('', style: TextStyle(color: Colors.grey)));
                    }
                  }

                  if (Applay.ApplyJobList_data.value != null && index < Applay.ApplyJobList_data.value.length) {
                    var jobData = Applay.ApplyJobList_data.value[index];
                    var Jobbing = Applay.ApplyJobList_data.value[index]['JobId'];
                    return JobSearch(
                      onTap: () async{
                        await isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate);
                        Get.to(() => Details(
                          Icon: Applay.ApplyJobList_data.value[index]['ComLogo'],
                          JobID: Jobbing,
                          Job_Tital: Applay.ApplyJobList_data.value[index]['JobTitle'],
                          Language: Applay.ApplyJobList_data.value[index]['TechName'],
                          Commpany: Applay.ApplyJobList_data.value[index]['ComName'],
                          Working: Applay.ApplyJobList_data.value[index]['WorkWeek'],
                          Location: Applay.ApplyJobList_data.value[index]['Location'],
                          Job_time: Applay.ApplyJobList_data.value[index]['JobType'],
                          Exp: Applay.ApplyJobList_data.value[index]['Experience'],
                          lake: Applay.ApplyJobList_data.value[index]['Salary'],
                          Hybrid: Applay.ApplyJobList_data.value[index]['W orkSet'],
                          stats: Applay.ApplyJobList_data.value[index]['FormatDt'],
                          saving: PopupMenuButton<String>(
                            color: AppColor.Full_body_color,
                              onSelected: (String value) async{
                                if (value == PopMenuItem.WithdrowApplication) {
                                  Withdrow.isLoding.value = true;
                                  await Withdrow.WithdrowApplication_Fuction(Tokan: Tokans,CandidateId: Candidate,JobApplyId: isApply.isApplingdata['data']['JobApplyId'],IsDeleted: 1);
                                  try {
                                    if (Withdrow.WithdrowApplicationdata['status'] == true) {
                                      ToastificationSuccess.Success('${Withdrow.WithdrowApplicationdata['message']} :- WithdrowApplicationdata');
                                      Applay.ApplyJobList_data.value.removeWhere((item) => item['JobApplyId'] == isApply.isApplingdata['data']['JobApplyId']);
                                      Applay.ApplyJobList_data.refresh();
                                      jobcount.update();
                                      jobcount.data.refresh();
                                      await jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                                      Applay.ApplyJobList_data.refresh();
                                      await Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
                                      Get.back();
                                    } else {
                                      ToastificationError.Error(Withdrow.WithdrowApplicationdata['message'] ?? "WithdrowApplicationdata.");
                                    }
                                  } catch (e) {
                                    ToastificationError.Error('An error occurred: $e');
                                  } finally {
                                    Withdrow.isLoding.value = false;
                                  }
                                }
                                if (value == PopMenuItem.InteractiveViewing) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate,JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 0);
                                  try {
                                    if (ApplyStatus.ApplyStatusData['status'] == true) {
                                      ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- ${PopMenuItem.InteractiveViewing}');
                                      jobcount.update();
                                      jobcount.data.refresh();
                                      await jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                                      ApplyStatus.ApplyStatusData.refresh();
                                      await Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
                                      Get.back();
                                    } else {
                                      ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? PopMenuItem.InteractiveViewing);
                                    }
                                  } catch (e) {
                                    ToastificationError.Error('An error occurred: $e');
                                  } finally {
                                    ApplyStatus.isLoding.value = false;
                                  }
                                }
                                if (value == PopMenuItem.OfferReceived) {
                                  ApplyStatus.isLoding.value = true;
                                  await ApplyStatus.ApplyStatusChange_Fuction(JobApplyId: isApply.isApplingdata['data']['JobApplyId'], CandStatus: 1, Tokan: Tokans, CandidateId: Candidate);
                                  try {
                                    if (ApplyStatus.ApplyStatusData['status'] == true) {
                                      ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- ${PopMenuItem.OfferReceived}');
                                      jobcount.update();
                                      jobcount.data.refresh();
                                      await jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                                      ApplyStatus.ApplyStatusData.refresh();
                                      await Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
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
                                      jobcount.update();
                                      jobcount.data.refresh();
                                      await jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                                      ApplyStatus.ApplyStatusData.refresh();
                                      await Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
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
                                      jobcount.update();
                                      jobcount.data.refresh();
                                      await jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                                      ApplyStatus.ApplyStatusData.refresh();
                                      await Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
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
                                PopupMenuItem<String>(value: PopMenuItem.WithdrowApplication, child: GestureDetector(child: Text(PopMenuItem.WithdrowApplication))),
                                PopupMenuItem<String>(value: PopMenuItem.InteractiveViewing, child: Text(PopMenuItem.InteractiveViewing)),
                                PopupMenuItem<String>(value: PopMenuItem.OfferReceived, child: Text(PopMenuItem.OfferReceived)),
                                PopupMenuItem<String>(value: PopMenuItem.Hired, child: Text(PopMenuItem.Hired)),
                                PopupMenuItem<String>(value: PopMenuItem.Not_Interested, child: Text(PopMenuItem.Not_Interested)),
                              ],
                              child: Threedot(),
                            ),
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
                            bottomNavigationBar: Padding(padding: EdgeInsets.all(20), child: OnButtons(Button_Color: AppColor.SuessColor_Color, btn_name: Details_texts.Applied, Boder_Button_Color: AppColor.SuessColor_Color)),
                          ),
                        );
                      },
                      Icon: Applay.ApplyJobList_data.value[index]['ComLogo'],
                      JobID: Jobbing,
                      Job_Tital: Applay.ApplyJobList_data.value[index]['JobTitle'],
                      Language: Applay.ApplyJobList_data.value[index]['TechName'],
                      Commpany: Applay.ApplyJobList_data.value[index]['ComName'],
                      Working: Applay.ApplyJobList_data.value[index]['WorkWeek'],
                      Location: Applay.ApplyJobList_data.value[index]['Location'],
                      Job_time: Applay.ApplyJobList_data.value[index]['JobType'],
                      Exp: Applay.ApplyJobList_data.value[index]['Experience'],
                      lake: Applay.ApplyJobList_data.value[index]['Salary'],
                      Hybrid: Applay.ApplyJobList_data.value[index]['WorkSet'],
                      stats: Applay.ApplyJobList_data.value[index]['FormatDt'],
                      savechild: SizedBox(),
                      top: BorderSide(color: AppColor.Bottam_color),
                      Sharebool: true,
                      Sharebool2: true,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}