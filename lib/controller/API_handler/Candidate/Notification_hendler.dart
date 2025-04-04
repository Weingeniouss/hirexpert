// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../view/utils/app_constance.dart';
import '../../API_Controller/Candidate/Nofication_Controller.dart';

class NotificationHendler extends GetxController{
  final NoficationController Notification = Get.put(NoficationController());

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Notification.NoficationFuction(Timezone: 'asia/kolkata', Tokan: Tokans);
    });
    super.onInit();
  }
}