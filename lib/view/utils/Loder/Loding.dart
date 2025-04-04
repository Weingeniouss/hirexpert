import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../app_loder.dart';

class AppLodings {
  static void showLoadingDialog() {
    if (Get.isDialogOpen != true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(Center(child: Image.asset(AppLoder.lodding, scale: Get.width / 250)), barrierDismissible: false);
      });
    }
  }
}