// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../view/utils/app_constance.dart';
import '../../../../../view/utils/common/Tostification/Toastification_error.dart';
import '../../../../../view/utils/common/Tostification/Toastification_success.dart';
import '../../../../API_Controller/Candidate/Profile/Profile/Profile_CertificateList.dart';
import '../../../../API_Controller/Candidate/Profile/Profile/Remove_Profile_CerticateList.dart';
import '../../../../API_Controller/Candidate/Profile/Profile/add_Profile_CertificateList.dart';

class CertificationAddController extends GetxController{
  ProfileCertificateListController profileController = Get.put(ProfileCertificateListController());
  RemoveProfileCerticatelist Remove = Get.put(RemoveProfileCerticatelist());
  AddProfileCertificatelist Add = Get.put(AddProfileCertificatelist());

  //Eidt
  TextEditingController Edit_Certificate_Controller = TextEditingController();

  //New
  TextEditingController Certificate_Controller = TextEditingController();

  //Edit Date issued
  TextEditingController Edit_Year_Controller = TextEditingController();
  TextEditingController Edit_Month_Controller = TextEditingController();

  //Date issued
  TextEditingController Year_Controller = TextEditingController();
  TextEditingController Month_Controller = TextEditingController();

  //Expire issued
  TextEditingController Expire_Year_Controller = TextEditingController();
  TextEditingController Expire_Month_Controller = TextEditingController();

  TextEditingController Description_Controller = TextEditingController();

  File? selectedImage;

  Future<void> pickimage() async {
    final pickedFild = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFild != null) {
        selectedImage = File(pickedFild.path);
    }
  }

  @override
  void onInit() {
    Future.microtask(() {
      profileController.fetchProfileCertificateList(candidateId: Candidate, token: Tokans);
    });
    super.onInit();
  }

  TextEditingController Certificate = TextEditingController();

  void Add_new_Certification(){
    Add.AddProfileCertificatelist_fuction(
      Tokan: Tokans,
      CandidateId: Candidate,
      ExpireDate: Expire_Year_Controller.text,
      IssueDate: Year_Controller.text,
      Title: Certificate.text,
      CertNum: Certificate.text,
    );
    if (Add.AddProfileCertificatelist_data != null && Add.AddProfileCertificatelist_data['status'] == true) {
      ToastificationSuccess.Success(Add.AddProfileCertificatelist_data['message']);
    } else {
      ToastificationError.Error(Add.AddProfileCertificatelist_data?['message'] ?? 'An error occurred');
    }
    Get.back();
    update();
  }

  void Edit_Certification(index){
    Add.AddProfileCertificatelist_fuction(
      Tokan: Tokans,
      CandidateId: Candidate,
      CertNum: profileController.profileCertificateListData['data'][index]['CertId'],
      ExpireDate: Edit_Year_Controller.text,
      IssueDate: Edit_Year_Controller.text,
      Title: Edit_Certificate_Controller.text,
    );

    Get.back();
  }

  void Remove_Certification(index) async{
    await Remove.RemoveProfileCerticatelist_fuction(
      CertId: profileController.profileCertificateListData['data'][index]['CertId'],
      Tokan: Tokans,
    );
    if (Remove.RemoveProfileCertication_data != null && Remove.RemoveProfileCertication_data['status'] == true) {
      ToastificationSuccess.Success(Remove.RemoveProfileCertication_data['message']);
    } else {
      ToastificationError.Error(Remove.RemoveProfileCertication_data?['message'] ?? 'An error occurred');
    }
    update();
    Get.back();
  }
}