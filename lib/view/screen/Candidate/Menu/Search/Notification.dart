// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, unnecessary_null_comparison, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Nofication_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/updateAllNotification_Controller.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/Notification_Hendal.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Notification_hendler.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/app_String.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../utils/common/Tostification/Toastification_error.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  @override
  void initState() {
    Future.microtask(() {
      Notification.NoficationFuction(Timezone: 'asia/kolkata', Tokan: Tokans);
    });
    super.initState();
  }

  final NoficationController Notification = Get.put(NoficationController());
  final UpdateallnotificationController updateNotification = Get.put(UpdateallnotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Full_body_color,
      appBar: AppBar(
        backgroundColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false,
        leading: Obx(() {
          if (Notification.isloding.value) {return SizedBox();}
          else {return GestureDetector(onTap: () => Get.back(), child: Icon(Icons.navigate_before_outlined));}
        }),
        title: Obx(() {
          if (Notification.isloding.value) {return SizedBox();}
          else {return Text(Notification_text.titel, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 23));}
        }),
        shape: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: OnButtons(onTap: () => updateNotification.Updateallnotification_fuction(Tokan: Tokans, candidateID: Candidate),Button_Color: AppColor.Button_color, btn_name: Details_texts.Read, Boder_Button_Color: AppColor.Button_color),
      ),
      body: Container(
        height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: Notification.Noficationdata.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Text(Notification.Noficationdata['data'][index]['Message'],style: TextStyle(fontSize: Get.width / 27),),
              );
            },
          ),
        ),
      ),
    );
  }
}
