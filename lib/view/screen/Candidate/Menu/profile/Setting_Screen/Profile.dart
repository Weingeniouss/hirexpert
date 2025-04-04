// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/Profile_Info_Controller/Profile_Controller/Profile_information.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';

class Profiles extends StatelessWidget {
  final ProfileInformation Profile_info = Get.put(ProfileInformation());
  final CandidatedetailsControllers_Controllrs Candidatedetails = Get.put(CandidatedetailsControllers_Controllrs());

  Profiles({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Get.height/3),
          child: Container(
            height: Get.height/3,
            width: Get.width,
            decoration: BoxDecoration(color: AppColor.Button_color,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Get.width/20), bottomRight: Radius.circular(Get.width/20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                    child: GestureDetector(
                      onTap: () => Profile_info.pickImage(),
                      child: (Profile_info.image != null)
                        ? CircleAvatar(radius: 70, child: Image.file(Profile_info.image!, height: 10))
                        : CircleAvatar(radius: 70, backgroundImage: NetworkImage(Candidatedetails.Candidatedetails_data?['data']['Profile']!)),
                    )
                ),
                SizedBox(height: Get.height/50),
                Obx((){
                  if(Candidatedetails.isLoding.value){
                    return SizedBox();
                  }else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Candidatedetails.Candidatedetails_data?['data']?['FirstName'],style: TextStyle(fontSize: Get.width/20,color: AppColor.Full_body_color)),
                        Text(Candidatedetails.Candidatedetails_data?['data']?['LastName'],style: TextStyle(fontSize: Get.width/20,color: AppColor.Full_body_color)),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/20),
          child: Column(
            children: [
              SizedBox(height: Get.height/20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.Email,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['Email'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.UserID,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['UserId'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.DOB,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['DOB'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.Description,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['Designation'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.JobTitle,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['JobTitle'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.SecondarySkillset, style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['SecondarySkillset'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
              SizedBox(height: Get.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Profile_Text.CurrentLocation,style: TextStyle(fontSize: Get.width/24,color: AppColor.Button_color)),
                  Text(Candidatedetails.Candidatedetails_data?['data']?['CurrentLocation'],style: TextStyle(fontSize: Get.width/24,color: AppColor.subcolor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
