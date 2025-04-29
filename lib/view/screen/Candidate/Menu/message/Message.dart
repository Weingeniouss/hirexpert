// ignore_for_file: file_names, prefer_const_constructors, annotate_overrides, non_constant_identifier_names, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/MessageController/Message_Controller.dart';
import 'package:hirexpert/view/utils/Loder/Loding.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:lottie/lottie.dart';
import '../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../utils/app_loder.dart';
import '../Search/Notification.dart';


// ignore: must_be_immutable
class Message extends StatelessWidget {
  Message({super.key});

 final MessageControllers Messages = Get.put(MessageControllers());
 final NotificationHendler Notification = Get.put(NotificationHendler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, elevation: 0, surfaceTintColor: Colors.transparent, automaticallyImplyLeading: false,
        title: Obx(() {
          if (Messages.Setmag.isLoding.value) {return SizedBox();}
          else {return Text("Messages", style: TextStyle(fontWeight: FontWeight.w700));}
        }),
        actions: [
          Obx(() {
            if (Messages.Setmag.isLoding.value) {return SizedBox();}
            else {return
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
              );
            }
          }),
          SizedBox(width: Get.width / 50),
        ],
      ),
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
          child: Obx(() {
            if (Messages.Setmag.isLoding.value) {AppLodings.showLoadingDialog();}
            else {if (Get.isDialogOpen == true) {Get.back();}}
            if (Messages.Setmag.Setmaglist_data['data'] == null || Messages.Setmag.Setmaglist_data == null) {return Center(child: Lottie.asset(AppLoder.noData));}
            else {
              return Column(
                children: [
                  Container(
                    height: Get.height / 15,
                    decoration: BoxDecoration(
                      color: AppColor.Full_body_color, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: DropdownButton<String>(
                        underline: SizedBox(), elevation: 0,
                        value: Messages.selectedValue.value.isEmpty ? Messages.listing[0] : Messages.selectedValue.value,
                        autofocus: true, isExpanded: true,
                        dropdownColor: AppColor.Full_body_color,
                        icon: SvgPicture.asset(AppIcons.down),
                        items: Messages.listing.map((String value) {
                          return DropdownMenuItem<String>(value: value, child: SizedBox(width: Get.width / 1.2, child: Text(value, style: TextStyle(color: AppColor.black_all))));
                        }).toList(),
                        onChanged: (newValue) => Messages.Dropdown(newValue),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: Messages.Setmag.Setmaglist_data['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Messages.ChatList(index),
                          child: Container(
                            height: Get.height / 10, width: Get.width,
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.select_check_color))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(radius: 30, backgroundImage: NetworkImage(Messages.Setmag.Setmaglist_data['data'][index]['ComLogo'])),
                                    SizedBox(width: Get.width / 30),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: Get.width/1.5, child: Text(Messages.Setmag.Setmaglist_data['data'][index]['JobTitle'].toString(), style: TextStyle(fontSize: Get.width / 25)),),
                                        SizedBox(width: Get.width/1.5, child: Text(Messages.Setmag.Setmaglist_data['data'][index]['TechName'], style: TextStyle(color: AppColor.subcolor))),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(Messages.Setmag.Setmaglist_data['data'][index]['IsMessageAvailable'].toString(), style: TextStyle(fontSize: Get.width / 26)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}