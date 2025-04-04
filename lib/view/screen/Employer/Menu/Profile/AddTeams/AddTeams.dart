// ignore_for_file: file_names, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/common/Buttons/ShortButton.dart';
import 'package:hirexpert/view/utils/common/Textfild/Inputfild.dart';
import '../../../../../utils/common/Buttons/wideButtons.dart';

class Addteams extends StatefulWidget {
  const Addteams({super.key});

  @override
  State<Addteams> createState() => _AddteamsState();
}

class _AddteamsState extends State<Addteams> {
  bool vis = false;
  TextEditingController FristName_Controller = TextEditingController();
  TextEditingController LastName_Controller = TextEditingController();
  TextEditingController Email_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.Full_body_color,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 50),
                  Text(AddTeams.Team_Members, style: TextStyle(fontSize: Get.height / 45, fontWeight: FontWeight.w600)),
                  SizedBox(height: Get.height / 50),
                  Visibility(
                    visible: vis,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AddTeams.AddNewTeamMembers, style: TextStyle(fontSize: Get.height / 45, fontWeight: FontWeight.w600)),
                        SizedBox(height: Get.height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width / 2.5,
                              child: Inputfild(labal: AddTeams.FristName, hint: AddTeams.FristName, controller: FristName_Controller),
                            ),
                            SizedBox(
                              width: Get.width / 2.5,
                              child: Inputfild(labal:AddTeams.LastName, hint: AddTeams.LastName, controller: LastName_Controller),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                        Inputfild(labal: AddTeams.Email, hint: AddTeams.Email, controller: Email_Controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  vis = true;
                });
              },
              child: (vis)
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  vis = false;
                                });
                              },
                              child: Container(
                                height: Get.height / 15,
                                width: Get.width / 2.5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.subcolor),
                                  borderRadius: BorderRadius.circular(Get.width / 40),
                                  color: AppColor.Bottam_color,
                                ),
                                child: Center(
                                  child: Text(AddTeams.Cancle, style: TextStyle(color: AppColor.black_all, fontSize: Get.width / 25)),
                                ),
                              ),
                            ),
                            Container(
                              height: Get.height / 15,
                              width: Get.width / 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Get.width / 40),
                                color: AppColor.Button_color,
                              ),
                              child: Center(
                                child: Text(AddTeams.Add_Member, style: TextStyle(color: AppColor.Full_body_color, fontSize: Get.width / 25)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                      ],
                    )
                  : Column(
                      children: [
                        OnButtons(Button_Color: AppColor.Button_color, btn_name: AddTeams.Add_Another_Member),
                        SizedBox(height: Get.height / 50),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
