// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, invalid_use_of_protected_member, prefer_const_constructors_in_immutables, must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/jobcountsaccording.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Home/saving/saved.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Search/Notification.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/common/Row/homerow.dart';
import 'package:lottie/lottie.dart';
import '../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../controller/Save_Controller/Candidate_state/Menu/home/My_jobs/State_home.dart';
import '../../../../utils/Loder/Loding.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/app_loder.dart';
import 'Applied/Show_Applied.dart';
import 'Declined/Show_Declined.dart';
import 'Hired/Show_Hired.dart';
import 'Interviwe/Show_Interview.dart';
import 'Offer/Show_Offer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeState_Controller home_state = Get.put(HomeState_Controller());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final Jobcountsaccording jobcount = Get.put(Jobcountsaccording());

  @override
  void initState() {
    setState(() {
       home_state.jobincount.jobcount.onInit();
       home_state.jobincount.onInit();
       home_state.onInit();

       jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 8),
        child: Container(
          height: Get.height /8,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
          child: AppBar(
            toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, automaticallyImplyLeading: false,
            title: Obx((){
              if(home_state.jobincount.jobcount.isLoding.value) {return SizedBox();}
              else{return Text(My_Jobs_Screen.My_Jobs, style: TextStyle(fontWeight: FontWeight.w700));}
            }),
            actions: [
              Obx((){
                if(home_state.jobincount.jobcount.isLoding.value){return SizedBox();}
                else{
                  return Stack(
                    children: [
                      GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
                      if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                        Positioned(
                          left: 13, bottom: 13,
                          child: CircleAvatar(
                            child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40,color: AppColor.Full_body_color)),
                            radius: 8, backgroundColor: AppColor.Notification_Color,
                          ),
                        ),
                    ],
                  );
                }
              }),
              SizedBox(width: Get.width / 25),
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
          if (home_state.jobincount.jobcount.isLoding.value) {AppLodings.showLoadingDialog();}
          else {if (Get.isDialogOpen == true) {Get.back();}}
          if (home_state.jobincount.jobcount.data.value['data'] == null) {return Center(child: Lottie.asset(AppLoder.noData));}
          else {
              return Column(
                children: [
                  SizedBox(height: Get.height / 40),
                  Wrap(
                  spacing: 20, runSpacing: 20,
                    alignment: WrapAlignment.center, children: [

                      //Saved
                      GestureDetector(
                        onTap: ()  => Get.to(() => Saved(),duration: Duration(milliseconds: 300), transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.Seeved, name: My_Jobs_Screen.Saved,
                          child: (home_state.jobincount.jobcount.data.value['data']['savedJobCnt'] > 0) ? CircleAvatar(minRadius: 12 ,backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['savedJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),

                      //Applied
                      GestureDetector(
                        onTap: () => Get.to(() => Show_Applied(),duration: Duration(milliseconds: 300), transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.Applid, name: My_Jobs_Screen.Applied,
                          child: (home_state.jobincount.jobcount.data.value['data']['appliedJobCnt'] > 0) ? CircleAvatar(minRadius: 12, backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['appliedJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),

                      //Interviwe
                      GestureDetector(
                        onTap: () => Get.to(() => Show_Interviwe(),duration: Duration(milliseconds: 300), transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.seved, name: My_Jobs_Screen.Interview,
                          child: (home_state.jobincount.jobcount.data.value['data']['interviewJobCnt'] > 0) ? CircleAvatar(minRadius: 12, backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['interviewJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),

                      //Offer
                      GestureDetector(
                        onTap: () => Get.to(() => Show_Offer(),duration: Duration(milliseconds: 300),transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.rupess, name: My_Jobs_Screen.Offer,
                          child: (home_state.jobincount.jobcount.data.value['data']['offersJobCnt'] > 0) ? CircleAvatar(minRadius: 12, backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['offersJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),

                      //Hired
                      GestureDetector(
                        onTap: () => Get.to(() => Show_Hired(),duration: Duration(milliseconds: 300),transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.Hired, name: My_Jobs_Screen.Hired,
                          child: (home_state.jobincount.jobcount.data.value['data']['hiredJobCnt'] > 0) ? CircleAvatar(minRadius: 12, backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['hiredJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),

                      //Declined
                      GestureDetector(
                        onTap: () => Get.to(() => Show_Declined(),duration: Duration(milliseconds: 300),transition: Transition.leftToRight,curve: Curves.easeInExpo),
                        child: Jobrow(
                          icon: AppIcons.Declind,name: My_Jobs_Screen.Declined,
                          child: (home_state.jobincount.jobcount.data.value['data']['declinedJobCnt'] > 0) ? CircleAvatar(minRadius: 12, backgroundColor: AppColor.Notification_Color, child: Text(home_state.jobincount.jobcount.data.value['data']['declinedJobCnt'].toString(),style: TextStyle(color: AppColor.Full_body_color))) : SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
