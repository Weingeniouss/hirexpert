import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/privacyPolicy_Controller.dart';

class PrivacyPolicyAPIController extends GetxController{
  final PrivacypolicyController privacyPolicy = Get.put(PrivacypolicyController());

  @override
  void onInit() {
    privacyPolicy.Privacypolicy_Fuction();
    super.onInit();
  }
}