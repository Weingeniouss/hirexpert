// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Details_Controllers.dart';

import '../../../../../view/utils/app_constance.dart';
import '../../../../../view/utils/common/Tostification/Toastification_error.dart';
import '../../../../../view/utils/common/Tostification/Toastification_success.dart';
import '../../../../API_Controller/Candidate/Menu/Home/ApplyJobList_Controller.dart';
import '../../../../API_Controller/Candidate/Menu/Home/Withdrow_Application_Controller.dart';
import '../../../../API_Controller/Candidate/Menu/Home/applyStatusChange_Controllre.dart';
import '../../../../API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';

class ApplingApiHandler extends GetxController {
  OptionApiController login = Get.put(OptionApiController());
  DetailsControllers Detailing = Get.put(DetailsControllers());

  @override
  void onInit() {
    Future.microtask(() async {
      // await Detailing.DetailsControllers_fuction(JobID: JobID, Timezone: 'asia/kolkata', Tokan: Tokans);
      // await pref!.setString("Tokan", login.option_data['data']['LoginToken']);
      // await pref!.setString('Candidate', login.option_data['data']['UserDetails']['CandidateId']);
    });
    Tokans = pref!.getString('Tokan')!;
    Candidate = pref!.getString('Candidate')!;
    super.onInit();
  }
  @override
  void onClose() {
    // Detailing.DetailsControllers_fuction(JobID: JobID, Timezone: 'asia/kolkata', Tokan: Tokans);
    super.onClose();
  }
}

class Appling_Handaling extends GetxController {
  ApplyjoblistController Applay = Get.put(ApplyjoblistController());
  WithdrowApplicationController Withdrow = Get.put(WithdrowApplicationController());
  ApplyStatusChange ApplyStatus = Get.put(ApplyStatusChange());
  IsapplingApiController isappling = Get.put(IsapplingApiController());

  @override
  void onInit() {
    Applay.ApplyjoblistController_Fuction(CandidateId: Candidate, Timezone: 'Asia/Calcutta', Tokan: Tokans);
    super.onInit();
  }

  void ApplyPopButton(String value,int index) async{
    if(Withdrow.isLoding.value) {Center(child: CircularProgressIndicator());} else {
      if (value == 'Withdraw application') {
        Withdrow.isLoding.value = true;
        try {
          await Withdrow.WithdrowApplication_Fuction(CandidateId: Candidate, JobApplyId: isappling.isApplingdata['data']['JobApplyId'], IsDeleted: index, Tokan: Tokans);
          if (Withdrow.WithdrowApplicationdata != null && Withdrow.WithdrowApplicationdata['status'] == true) {
            ToastificationSuccess.Success(Withdrow.WithdrowApplicationdata['message']);
            Get.back();
          } else {
            ToastificationError.Error(Withdrow.WithdrowApplicationdata['message'] ?? "Failed to withdraw application.");
          }
        } catch (e) {
          ToastificationError.Error("An error occurred: $e");
        } finally {
          Withdrow.isLoding.value = false;
        }
      }
    }
    if(ApplyStatus.isLoding.value){Center(child: CircularProgressIndicator());} else{
      if(value == 'Interviewing'){
        ApplyStatus.isLoding.value = true;
        try{
          await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate, JobApplyId: isappling.isApplingdata['data']['JobApplyId'], CandStatus: 1); // Interviewing
          if(ApplyStatus.ApplyStatusData != null && ApplyStatus.ApplyStatusData['status'] == true){
            ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- interviewing');
            Get.back();
          }else{
            ToastificationError.Error('${ApplyStatus.ApplyStatusData['message']} ?? "Failed to Interviewing."');
          }
        } catch(e){
          ToastificationError.Error('An error occurred: $e');
        } finally{
          Withdrow.isLoding.value = false;
        }
      }
    }
    if(ApplyStatus.isLoding.value){Center(child: CircularProgressIndicator());} else{
      if(value == 'Offer Received'){
        ApplyStatus.isLoding.value = true;
        try{
          await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate, JobApplyId: isappling.isApplingdata['data']['JobApplyId'], CandStatus: 2); // Offer Receiverd
          if(ApplyStatus.ApplyStatusData != null && ApplyStatus.ApplyStatusData['status'] == true){
            ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- Offer Receiverd');
            Get.back();
          }else{
            ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? "Failed to Offer Receiverd.");
          }
        } catch(e){
          ToastificationError.Error('An error occurred: $e');
        } finally{
          Withdrow.isLoding.value = false;
        }
      }
    }
    if(ApplyStatus.isLoding.value){Center(child: CircularProgressIndicator());} else{
      if(value == 'Hired'){
        ApplyStatus.isLoding.value = true;
        try{
          await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate, JobApplyId: isappling.isApplingdata['data']['JobApplyId'], CandStatus: 3); //Hired
          if(ApplyStatus.ApplyStatusData != null && ApplyStatus.ApplyStatusData['status'] == true){
            ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- Hired');
            Get.back();
          }else{
            ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? "Failed to Hired.");
          }
        } catch(e){
          ToastificationError.Error('An error occurred: $e');
        } finally{
          Withdrow.isLoding.value = false;
        }
      }
    }
    if(ApplyStatus.isLoding.value){Center(child: CircularProgressIndicator());} else{
      if(value == 'Not Interested'){
        ApplyStatus.isLoding.value = true;
        try{
          await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate, JobApplyId: isappling.isApplingdata['data']['JobApplyId'], CandStatus: 4); //Not Interested
          if(ApplyStatus.ApplyStatusData != null && ApplyStatus.ApplyStatusData['status'] == true){
            ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- Not Interested');
            Get.back();
          }else{
            ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? "Failed to Not Interested.");
          }
        } catch(e){
          ToastificationError.Error('An error occurred: $e');
        } finally{
          Withdrow.isLoding.value = false;
        }
      }
    }
    if(ApplyStatus.isLoding.value){Center(child: CircularProgressIndicator());} else{
      if(value == 'Not Selected by Employer'){
        ApplyStatus.isLoding.value = true;
        try{
          await ApplyStatus.ApplyStatusChange_Fuction(Tokan: Tokans, CandidateId: Candidate, JobApplyId: '2', CandStatus: 5); //Not Selected by Employer
          if(ApplyStatus.ApplyStatusData != null && ApplyStatus.ApplyStatusData['status'] == true){
            ToastificationSuccess.Success('${ApplyStatus.ApplyStatusData['message']} :- Not Selected by Employer');
            Get.back();
          }else{
            ToastificationError.Error(ApplyStatus.ApplyStatusData['message'] ?? "Failed to Not Selected by Employer.");
          }
        } catch(e){
          ToastificationError.Error('An error occurred: $e');
        } finally{
          Withdrow.isLoding.value = false;
        }
      }
    }
    print("Value :- $value");
  }
}
