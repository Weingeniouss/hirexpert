// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import '../../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../utils/app_String.dart';
import '../../../../../utils/common/List/Saved.dart';
import '../../Search/Notification.dart';

class Saved extends StatelessWidget {
  final IsfavrationControllers isfavication = Get.put(IsfavrationControllers());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height / 10, backgroundColor: AppColor.Full_body_color, shadowColor: AppColor.Full_body_color, surfaceTintColor: AppColor.Full_body_color, elevation: 0, automaticallyImplyLeading: false,
        title: Text(My_Jobs_Screen.Saved, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
             Stack(
                children: [
                  GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
                  if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                    Positioned(
                      left: 13, bottom: 13,
                      child: CircleAvatar(
                        radius: 8, backgroundColor: AppColor.Notification_Color,
                        child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40,color: AppColor.Full_body_color)),
                      ),
                    ),
                ],
              ),
          SizedBox(width: Get.width / 25),
        ],
      ),
      body: Container(
        width: size.width, height: size.height,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: (isfavication.isFavration.value.status) ? Center(child: Text("File is Empty !")) : Seved_List(),
      ),
    );
  }
}
