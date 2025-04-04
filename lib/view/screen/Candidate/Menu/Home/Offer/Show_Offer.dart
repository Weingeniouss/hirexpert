// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_const_constructors, invalid_use_of_protected_member, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Search/Applied_NotApplied/Details_Search.dart';
import 'package:hirexpert/view/utils/Loder/Loding.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
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
import '../../../../../utils/common/Icon/threedot.dart';
import '../../../../../utils/common/List/jobSearch.dart';
import '../../Search/Notification.dart';

class Show_Offer extends StatefulWidget {
  const Show_Offer({super.key});

  @override
  State<Show_Offer> createState() => _Show_OfferState();
}

class _Show_OfferState extends State<Show_Offer> {
  final OfferController offer = Get.put(OfferController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    offer.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Offered', Tokan: Tokans, Page: offer.currentPage.value.toString());
    if (offer.hasMoreData.value && !offer.isLoding.value) {
      scrollController.addListener(() {
        if (offer.hasMoreData.value && !offer.isLoding.value) {
          if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9) {
            offer.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Offered', Tokan: Tokans, Page: offer.currentPage.value.toString());
          }
        }
      });
    }
    super.initState();
  }

  // final OfferApiHandler offing = Get.put(OfferApiHandler());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height / 10, surfaceTintColor: AppColor.Full_body_color, backgroundColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false,
        title: Text(My_Jobs_Screen.Offer, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          Stack(
            children: [
              GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
              if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                Positioned(
                  left: 13, bottom: 13,
                  child: CircleAvatar(radius: 8, backgroundColor: AppColor.Notification_Color, child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40, color: AppColor.Full_body_color))),
                ),
            ],
          ),
          SizedBox(width: Get.width / 25),
        ],
      ),
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
            if (offer.isLoding.value) {AppLodings.showLoadingDialog();}
            else {if (Get.isDialogOpen == true) {Get.back();}}
            if (offer.OfferData['data'] == null) {return Center(child: Lottie.asset(AppLoder.noData));}
            else {
              return RefreshIndicator(
                backgroundColor: AppColor.Full_body_color, color: AppColor.Button_color,
                onRefresh: () {
                  offer.OfferData.clear();
                  offer.currentPage.value = 1;
                  offer.hasMoreData.value = true;
                  return offer.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Offered', Tokan: Tokans, Page: offer.currentPage.value.toString());
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: offer.OfferData['data'].length + 1, padding: EdgeInsets.zero, shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // if (index == offer.OfferData['data'].length) {
                    //   return offer.hasMoreData.value
                    //       ? (offer.isLoding.value
                    //       ? Padding(padding: const EdgeInsets.all(16.0),
                    //     child: ((offer.OfferData['data'].length.isNotEmpty)
                    //         ? Center(child: CircularProgressIndicator(color: AppColor.Button_color))
                    //         : SizedBox()),
                    //   )
                    //       : SizedBox())
                    //       : Center(child: Text('No More Data'));
                    // }

                    if (index == offer.OfferData['data'].length) {
                      if (offer.OfferData['data'].length > 10 && offer.hasMoreData.value) {
                        return Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)));
                      } else {
                        return Center(child: Text('', style: TextStyle(color: Colors.grey)));
                      }
                    }

                    var Jobbing = offer.OfferData['data'][index]['JobId'];
                    return JobSearch(
                      onTap: () {
                        isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate).then((_) {
                          Get.to(() => Details(
                              bottomNavigationBar: SizedBox(),
                              Icon: offer.OfferData['data'][index]['ComLogo'], JobID: Jobbing,
                              Job_Tital: offer.OfferData['data'][index]['JobTitle'],
                              Language: offer.OfferData['data'][index]['TechName'],
                              Commpany: offer.OfferData['data'][index]['ComName'],
                              Working: offer.OfferData['data'][index]['WorkWeek'],
                              Location: offer.OfferData['data'][index]['Location'],
                              Job_time: offer.OfferData['data'][index]['JobType'],
                              Exp: offer.OfferData['data'][index]['Experience'],
                              lake: offer.OfferData['data'][index]['Salary'],
                              Hybrid: offer.OfferData['data'][index]['WorkSet'],
                              stats: offer.OfferData['data'][index]['FormatDt'], offerletters: true,
                              saveonTap: () => SvgPicture.asset(AppIcons.bookmark, color: AppColor.Button_color), save: true,
                              Share: Column(
                                children: [
                                  SizedBox(height: Get.height / 80),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)),
                                      SizedBox(width: Get.width / 20),
                                      icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook),icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                                    ],
                                  ),
                                ],
                              ),
                              saving: PopupMenuButton<String>(
                                color: AppColor.Full_body_color,
                                onSelected: (String value) async {
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
                                  PopupMenuItem<String>(value: PopMenuItem.Hired, child: Text(PopMenuItem.Hired)),
                                  PopupMenuItem<String>(value: PopMenuItem.Not_Interested, child: Text(PopMenuItem.Not_Interested)),
                                ],
                                child: Threedot(),
                              ),
                            ),
                          );
                        });
                        setState(() {});
                      },
                      JobID: Jobbing,
                      Icon: offer.OfferData['data'][index]["ComLogo"],
                      Job_Tital: offer.OfferData['data'][index]["JobTitle"],
                      Language: offer.OfferData['data'][index]["TechName"],
                      Commpany: offer.OfferData['data'][index]["ComName"],
                      Working: offer.OfferData['data'][index]['WorkWeek'],
                      Location: offer.OfferData['data'][index]["Location"],
                      Job_time: offer.OfferData['data'][index]["JobType"],
                      Exp: offer.OfferData['data'][index]["Experience"],
                      lake: offer.OfferData['data'][index]["Salary"],
                      Hybrid: offer.OfferData['data'][index]["WorkSet"],
                      stats: offer.OfferData['data'][index]['InterviewDate'],
                      top: BorderSide(color: AppColor.offButton_color),
                      savechild: SizedBox(), Sharebool: true, Sharebool2: true,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
