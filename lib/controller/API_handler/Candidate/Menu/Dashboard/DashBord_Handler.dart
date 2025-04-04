// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/candidateProfileCalculate_Controller.dart';

import '../../../../../view/utils/app_constance.dart';
import '../../../../API_Controller/Candidate/Dashbord/Interviwe_Stats_Controller.dart';
import '../../../../API_Controller/Candidate/Dashbord/JobRecommendations.dart';
import '../../../../API_Controller/Candidate/Dashbord/Job_Application.dart';
import '../../../../API_Controller/Candidate/Dashbord/Profile_Analytics_Controller.dart';
import '../../../../API_Controller/Candidate/Dashbord/SaveJob_Controller.dart';
import '../../../../API_Controller/Candidate/Dashbord/Setprivateaccount.dart';
import '../../../../API_Controller/Candidate/Dashbord/upcomingInterview.dart';
import '../../../../API_Controller/Candidate/Dashbord/uploadResume.dart';
import '../../../../API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../../User_Controller/Candidate_Controller/Profile_Info_Controller/Profile_Controller/Pick_Image_Controller.dart';

class DashBord_Handler extends GetxController{
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await Candidateprofilecalculate.CandidateprofilecalculateFuction(Tokan: Tokans, CandidateId: Candidate, Timezone: 'asia/kolkata');
     await UpcomingInterviwe.UpcomingInterviwe_fuction(Timezone: 'asia/kolkata', CandidateID: Candidate, Tokan: Tokans);
     await Analytics.Profile_Analytics_Fuction(Tokan: Tokans, Timezone: 'asia/kolkata', CandidateId: Candidate);
     await SaveJob.SaveJob_Fuction(Timezone: 'asia/kolkata', CandidateId: Candidate, Tokan: Tokans);
     await Job_Application.JobApplication_Fuction(CandidateId: Candidate, Tokan: Tokans, Timezone: 'asia/kolkata');
     await Recomendation.Job_Recommendations_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', Tokan: Tokans);
     await Interviwe_Status.Interviwe_Status_Fuction(Tokan: Tokans,Page: '1',CandidateId: Candidate,Timezone: 'asia/kolkata');
    });
    super.onInit();
  }

  CandidatedetailsControllers_Controllrs Candidatedetails = Get.put(CandidatedetailsControllers_Controllrs());
  PickImageController PickImage = Get.put(PickImageController());
  Job_Recommendations_Controller Recomendation = Get.put(Job_Recommendations_Controller());
  SetPrivateAccount SetPrivatAccounts = Get.put(SetPrivateAccount());
  UploadResume_Controller UploadResume = Get.put(UploadResume_Controller());
  UpcomingInterviwe_Controller UpcomingInterviwe = Get.put(UpcomingInterviwe_Controller());
  Job_Application_Controller Job_Application = Get.put(Job_Application_Controller());
  SaveJob_Controller SaveJob = Get.put(SaveJob_Controller());
  Profile_Analytics_Controller Analytics = Get.put(Profile_Analytics_Controller());
  Interview_Status_Controllers Interviwe_Status = Get.put(Interview_Status_Controllers());
  CandidateprofilecalculateController Candidateprofilecalculate = Get.put(CandidateprofilecalculateController());
}