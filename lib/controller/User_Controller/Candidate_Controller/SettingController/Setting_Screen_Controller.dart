// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/AddFeedback_Controllers.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/SetPrivateAccount_Controller.dart';
import '../../../API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../API_Controller/Candidate/Profile/Profile/RemoveAccount_Controllres.dart';


class SettingScreenController extends ChangeNotifier {
  bool _issues = false;
  bool _Suggestions = false;
  bool _manageAccount = false;

  get issues => _issues;
  get Suggestions => _Suggestions;
  get manageAccount => _manageAccount;

  void Issues_Fuction(val) {_issues = val!; notifyListeners();}
  void Suggestions_Fuction(val) {_Suggestions = val!; notifyListeners();}
  void manageAccount_Fuction(val) {_manageAccount = val!;notifyListeners();}
}

class SettingScreensControllres extends GetxController{
  final CandidatedetailsControllers_Controllrs Candidatedetails = Get.put(CandidatedetailsControllers_Controllrs());
  final RemoveaccountControllres Removeaccount = Get.put(RemoveaccountControllres());
  final SetprivateaccountController Setprivat = Get.put(SetprivateaccountController());
  final AddfeedbackControllers AddFeedBack = Get.put(AddfeedbackControllers());
  // final Seettings sett = Get.put(Seettings());
  // final PasswordChange chagepassword = Get.put(PasswordChange());

  TextEditingController Commint_Controllers = TextEditingController();

  @override
  void onInit() {
    // Tokans = pref!.getString('Tokan')!;
    // Candidate = pref!.getString('Candidate')!;
    // Future.microtask(()async{
    //   Candidatedetails.CandidatedetailsControllers_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', IsLabel: '1', CompanyId: '1', Tokan: Tokans);
    //   AddFeedBack.Addfeedback_fuction(Tokans: Tokans);
    // });
    super.onInit();
  }
}
