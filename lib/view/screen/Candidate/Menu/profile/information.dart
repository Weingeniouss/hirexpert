// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_const_constructors_in_immutables, unused_import, must_be_immutable, override_on_non_overriding_member, avoid_print

import 'dart:io';

import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/CanProfile_Update_API.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/profile/information_handler.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/Profile_Info_Controller/Profile_Controller/Pick_Image_Controller.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../../../controller/API_Controller/Candidate/Profile/Details_profile/Details_Profile.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/TabbarController/Tabcontroller.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/common/Tabbar/Profile/Tab_Conatiner/Profile_Conatiner.dart';
import '../../../../utils/common/Tabbar/Profile/Tabbarviwe/Document_profile.dart';
import '../../../../utils/common/Tabbar/Profile/Tabbarviwe/Extra_Info.dart';
import '../../../../utils/common/Tabbar/Profile/Tabbarviwe/My_Profile/My_Profile.dart';
import 'Setting.dart';

class Profile_info extends StatelessWidget {
  PickImageController PickImage = Get.put(PickImageController());
  InformationHandler Infoem = Get.put(InformationHandler());
  Profile_info({super.key});

  @override
  Widget build(BuildContext context) {
    Infoem.onInit();
    final Tabb = Provider.of<TabbarController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
            child: SingleChildScrollView(
              child: Consumer<TabbarController>(
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    children: [
                      Container(
                        height: Get.height / 8,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Bottam_color))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              if (Infoem.Candidatedetails.isLoding.value) {return Center(child: SizedBox());}
                              else if (Infoem.Candidatedetails.Candidatedetails_data?['data'] == null || Infoem.Candidatedetails.Candidatedetails_data == null) {return Center(child: Lottie.asset(AppLoder.noData));}
                              else if (Infoem.Candidatedetails.Candidatedetails_data?['data']['QuestionList'] == null || Infoem.Candidatedetails.Candidatedetails_data?['data']['QuestionList'].isEmpty) {return Center(child: Text("No questions available"));}
                              else {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => PickImage.pickImage(),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: (PickImage.image != null)
                                              ? FileImage(PickImage.image!) : (Infoem.Candidatedetails.Candidatedetails_data?['data']['Profile'] != null
                                              ? NetworkImage(Infoem.Candidatedetails.Candidatedetails_data?['data']['Profile']!) : AssetImage('assets/default_profile.png')) as ImageProvider,
                                        ),
                                    ),
                                    SizedBox(width: Get.width / 30),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(Infoem.Candidatedetails.Candidatedetails_data?['data']?['FirstName']!, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w700)),
                                            Text(Infoem.Candidatedetails.Candidatedetails_data?['data']?['LastName']!, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w700)),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width / 2,
                                          child: Text(Infoem.Candidatedetails.Candidatedetails_data?['data']?['Email'], style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400, color: AppColor.subcolor)),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }),
                            Obx((){
                              if(Infoem.Candidatedetails.isLoding.value){return SizedBox();}
                              else{return GestureDetector(onTap: () => Get.to(() => Setting(),duration: Duration(seconds: 1),curve: Curves.fastOutSlowIn,transition: Transition.upToDown), child: Icon(Icons.settings, color: AppColor.Button_color, size: 32));}
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      Obx((){
                        if(Infoem.Candidatedetails.isLoding.value){return SizedBox();}
                        else{
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tab(onTap: () => Tabb.Tabbarcontroler_1(), textcolor: Tabb.selectedIndex == 0, tabcolor: Tabb.selectedIndex == 0, name: Profile_Text.Extra_Info),
                              tab(onTap: () => Tabb.Tabbarcontroler_2(), textcolor: Tabb.selectedIndex == 1, tabcolor: Tabb.selectedIndex == 1, name: Profile_Text.My_Profile),
                              tab(onTap: () => Tabb.Tabbarcontroler_3(), textcolor: Tabb.selectedIndex == 2, tabcolor: Tabb.selectedIndex == 2, name: Profile_Text.Document),
                            ],
                          );
                        }
                      }),
                      SizedBox(height: Get.height / 50),
                      SizedBox(height: Get.height / 1.52, child: IndexedStack(index: Tabb.selectedIndex, children: [Extra_info(), MY_Profile(), Documant_Profile()])),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}