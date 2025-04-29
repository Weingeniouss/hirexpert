
// ignore_for_file: file_names, camel_case_types, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/Offer_Controller.dart';
import '../../../../../../controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../utils/Loder/Loding.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_constance.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../../utils/common/Icon/threedot.dart';
import '../../Search/Applied_NotApplied/Details_Search.dart';
import '../../Search/Notification.dart';

class Show_Declined extends StatefulWidget {

  Show_Declined({super.key});

  @override
  State<Show_Declined> createState() => _Show_DeclinedState();
}

class _Show_DeclinedState extends State<Show_Declined> {
  final OfferController Decline = Get.put(OfferController());
  final ScrollController scrollController = ScrollController();

   @override
  void initState() {
    Decline.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Declined', Tokan: Tokans, Page: Decline.currentPage.value.toString());
    if (Decline.hasMoreData.value && !Decline.isLoding.value) {
      scrollController.addListener(() {
        if (Decline.hasMoreData.value && !Decline.isLoding.value) {
          if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9) {
            Decline.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Declined', Tokan: Tokans, Page: Decline.currentPage.value.toString());
          }
        }
      });
    }
    super.initState();
  }


  // final DeclinedApiHendler Declined_offer = Get.put(DeclinedApiHendler());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: AppColor.Full_body_color,
          toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false, title: Text(My_Jobs_Screen.Declined, style: TextStyle(fontWeight: FontWeight.w700)),
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
          ]
      ),
      body: Obx(() {
        if (Decline.isLoding.value) {AppLodings.showLoadingDialog();}
        else {if (Get.isDialogOpen == true) {Get.back();}}
        if (Decline.OfferData['data']  == null) {return Scaffold(body: Container(height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color), child: Center(child: Lottie.asset(AppLoder.noData))));}
        else {
        return Container(
          height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
          child: RefreshIndicator(
              onRefresh: () {
                Decline.OfferData.clear();
                Decline.currentPage.value = 1;
                Decline.hasMoreData.value = true;
                return Decline.OfferControllers_fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', JobStatus: 'Declined', Tokan: Tokans, Page: Decline.currentPage.value.toString());
              },
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero, shrinkWrap: true, itemCount: Decline.OfferData['data']?.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == Decline.OfferData['data'].length) {
                if (Decline.OfferData['data'].length > 12 && Decline.hasMoreData.value) {
                  return Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)));
                } else {
                  return Center(child: Text('', style: TextStyle(color: Colors.grey)));
                }
              }

              var Jobbing = Decline.OfferData['data'][index]['JobId'];
              return JobSearch(
                onTap: () async{
                await isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate);
                  Get.to(
                    () => Details(
                      bottomNavigationBar: (isApply.isApplingdata['data']['CurrentStatus'] == 'Declined') ? Padding(padding: EdgeInsets.all(20), child: OnButtons(Button_Color: AppColor.SuessColor_Color, btn_name: Details_texts.Hired, Boder_Button_Color: AppColor.SuessColor_Color)) : SizedBox(),
                      Icon: Decline.OfferData['data'] [index]['ComLogo'], JobID: Jobbing,
                      Job_Tital: Decline.OfferData['data'] [index]['JobTitle'],
                      Language: Decline.OfferData['data'] [index]['TechName'],
                      Commpany: Decline.OfferData['data'] [index]['ComName'],
                      Working: Decline.OfferData['data'] [index]['WorkWeek'],
                      Location: Decline.OfferData['data'] [index]['Location'],
                      Job_time: Decline.OfferData['data'] [index]['JobType'],
                      Exp: Decline.OfferData['data'] [index]['Experience'],
                      lake: Decline.OfferData['data'] [index]['Salary'],
                      Hybrid: Decline.OfferData['data'] [index]['WorkSet'],
                      stats: Decline.OfferData['data'] [index]['WorkSet'],
                      saveonTap: () => SizedBox(),
                      save: true,
                      Share: Column(
                        children: [
                          SizedBox(height: Get.height / 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)),
                              SizedBox(width: Get.width / 20), icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                            ],
                          ),
                        ],
                      ),
                      saving: SizedBox(),
                    ),
                  );
                },
                JobID: Jobbing, Icon: Decline.OfferData['data'][index]['ComLogo'],
                Job_Tital: Decline.OfferData['data'] [index]['JobTitle'],
                Language: Decline.OfferData['data'][index]['TechName'],
                Commpany: Decline.OfferData['data'][index]['ComName'],
                Working: Decline.OfferData['data'][index]['WorkWeek'],
                Location: Decline.OfferData['data'][index]['Location'],
                Job_time: Decline.OfferData['data'] [index]['JobType'],
                Exp: Decline.OfferData['data'][index]['Experience'],
                lake: Decline.OfferData['data'][index]['Salary'],
                Hybrid: Decline.OfferData['data'][index]['WorkSet'],
                stats: Decline.OfferData['data'][index]['WorkSet'],
                savechild: SizedBox(), top: BorderSide(color: AppColor.Bottam_color), bottam: BorderSide(color: AppColor.Bottam_color),
                Sharebool: true, Sharebool2: true,
              );
            },
          ))
        );
      }
    })
    );
  }
}
