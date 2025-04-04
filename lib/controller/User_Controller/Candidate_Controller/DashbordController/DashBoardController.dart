// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:io';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import '../../../../view/utils/app_constance.dart';
import '../../../../view/utils/common/Tostification/Toastification_success.dart';
import '../../../API_Controller/Candidate/Dashbord/Setprivateaccount.dart';
import '../../../API_Controller/Candidate/Dashbord/uploadResume.dart';

class DashBoardController extends GetxController{
  var selectedValue = 'Pending'.obs;
  var profile_Visibility = false.obs;
  List<String> items = ['Pending', "Accepted", 'Viewed'];

  UploadResume_Controller controller = Get.put(UploadResume_Controller());
  SetPrivateAccount SetPrivatAccounts = Get.put(SetPrivateAccount());


  void selectAndUploadResume() async {
    File? selectedFile = await controller.pickFile();

    if (selectedFile != null) {
      await controller.uploadResumeFunction(candidateId: '5', resume: selectedFile, timezone: 'asia/kolkata', token: Tokans);
    } else {
      print('No file selected for upload');
      if(controller.uploadResumeData['status'] == true){
        ToastificationSuccess.Success(controller.uploadResumeData['data']['message']);
      }else{
        ToastificationError.Error(controller.uploadResumeData['data']['message']);
      }
    }
  }

  void SwichButton(value) async{
    profile_Visibility.value = value;

    String isPrivateValue = value ? '0' : '1';
    await SetPrivatAccounts.SetPrivateAccount_fuction(IsPrivate: isPrivateValue, UserBy: '1', UserType: 'Candidate', Tokans: Tokans);
    if (SetPrivatAccounts.setprivateaccount['status'] == true) {
      ToastificationSuccess.Success(SetPrivatAccounts.setprivateaccount['message']);
    } else {
      ToastificationSuccess.Success(SetPrivatAccounts.setprivateaccount['message']);
    }
  }

  void DropDownButton(newValue) =>  selectedValue.value = newValue;
}