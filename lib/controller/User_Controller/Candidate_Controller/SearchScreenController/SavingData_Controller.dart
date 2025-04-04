// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../view/utils/app_constance.dart';
import '../../../../view/utils/common/Tostification/Toastification_success.dart';
import '../../../API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import '../../../API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import '../../../API_handler/Candidate/Menu/Home/Sarching_Saving_API.dart';
import '../../../Save_Controller/Candidate_state/Menu/Search/State_Search.dart';

class FavouriteProvider with ChangeNotifier {
  final StateSearch_Controller stateSearchController = Get.put(StateSearch_Controller());
  final IsfavrationControllers isFavrationController = Get.put(IsfavrationControllers());
  final OptionApiController loginController = Get.put(OptionApiController());
  final SarchingSavingApi Saving_Apis = Get.put(SarchingSavingApi());

  bool _isFavourite = false; bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {_isFavourite = value;notifyListeners();}

  Future<void> SavingData(String JobId, Map<String, dynamic> jobData) async {
    var newIsLike = _isFavourite ? "0" : "1";
    await isFavrationController.IsfavrationControllers_fuction(CandidateId: Candidate, JobId: JobId.toString(), IsLike: newIsLike, Tokan: Tokans);
    if (isFavrationController.isFavration.value.status) {_isFavourite = jobData['IsFavourite'] == "1";jobData['IsFavourite'] = newIsLike;_isFavourite = !_isFavourite; notifyListeners();}

    if (isFavourite) {ToastificationSuccess.Success('${jobData['TechName']} is Saved SuccessFully');}
    if (!isFavourite) {ToastificationSuccess.Success('${jobData['TechName']} is Removed SuccessFully');}
    else {ToastificationSuccess.Success('${jobData['TechName']} is Saved SuccessFully');}

    // Saving_Apis.favourlist.data?.addAll(jobData);
    notifyListeners();
  }
}