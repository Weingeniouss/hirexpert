// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/common/Tostification/Toastification_success.dart';

class CandidateUpdateControllers extends GetxController{
  var isLoding = true.obs;
  var CandidateUpdate;

  Future CandidateUpdateControllers_Fuction({
    required String CandidateId,
    required String FirstName,
    required String UserId,
    required String Timezone,
    String? JobTitle,
    String? Phone,
    String? Tokan,
    String? DOB,
    String? Gender,
    String? StreetAddress,
    String? PostCode,
    String? ProvinceId,
    String? CityId,
    String? CurrentCTC,
    String? ExpectedSalary,
    String? SpecialisationProfile,
    String? DegreeIdProfile,
    String? GraduationYear,
    String? YearsExperience,
    String? MonthExperience,
    String? CompanyNameProfile,
    String? DesignationProfile,
    String? NoticePeriod,
    String? WorkType,
    String? JobType,
  })async{

    Map<String, dynamic> body = {
      'Timezone': Timezone,
      'CandidateId': CandidateId,

      //Personal Information
      'FirstName' : FirstName,
      'UserId' : UserId,
      'JobTitle' : JobTitle,
      'Phone' : Phone,
      'DOB' : DOB,
      'Gender' : Gender,

      //Educational Details
      'DegreeIdProfile' : DegreeIdProfile,
      'GraduationYear' : GraduationYear,
      'SpecialisationProfile' : SpecialisationProfile,

      //Address
      'StreetAddress' : StreetAddress,
      'PostCode' : PostCode,
      'ProvinceId' : ProvinceId,
      'CityId' : CityId,

      //Work Experience
      'YearsExperience' : YearsExperience,
      'MonthExperience' : MonthExperience,
      'CompanyNameProfile' : CompanyNameProfile,
      'DesignationProfile' : DesignationProfile,

      //Salary
      'CurrentCTC' : CurrentCTC,
      'ExpectedSalary' : ExpectedSalary,

      //Work Location
      'NoticePeriod' : NoticePeriod,
      'WorkType' : WorkType,
      'JobType' : JobType,
    };

    print(body);

    try{
      final responce = await http.post(Uri.parse(AppUrl.CandidateUpdate),
          headers: {
           API_KEY.api_key : API_KEY.key,
            Clientip.clientip : Clientip.ip,
            Logintoken.logintoken : Tokan ??''
          },
          body: body,
      );
      if(responce.statusCode == 200 || responce.statusCode == 200){
        CandidateUpdate = jsonDecode(responce.body);
        ToastificationSuccess.Success(CandidateUpdate['message'].toString());
        log("CandidateUpdate Suess :-  $CandidateUpdate");
      }else{
        ToastificationError.Error(CandidateUpdate['message'].toString());
        throw{"CandidateId Data Error :- ${responce.statusCode}, ${responce.body}"};
      }
    }catch(e){"CandidateUpdate Data Error :- $e";}
    finally{isLoding.value = false;}
  }
}