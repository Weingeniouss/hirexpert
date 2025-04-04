// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:provider/provider.dart';
import '../../../controller/Internet_Controller/Internet_Controller.dart';
import '../../../controller/User_Controller/Option_Controller/SelectButton.dart';
import '../../utils/Responsive/responsive_Scrren.dart';
import '../../utils/aap_image.dart';
import '../../utils/app_constance.dart';

class Option extends StatelessWidget {
  final OptionApiController option_api = Get.put(OptionApiController());
  Option({super.key});

  @override
  Widget build(BuildContext context) {
    final select = Provider.of<SelectButtonsController>(context, listen: false);
    final internetController = Provider.of<InternetController>(context, listen: false);
    return ResponsiveWidget(

      //Mobile Viwe
      mobile: Consumer<InternetController>(
        builder: (BuildContext context, value, Widget? child) {
          return (internetController.isConnected)
              ? Scaffold(
            body: Container(
              height: Get.height, width: Get.width,
              decoration: BoxDecoration(color: AppColor.Full_body_color),
              child: SafeArea(child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: Consumer<SelectButtonsController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Column(
                        children: [
                          SizedBox(height: Get.height / 10), Image.asset(AppIcons.logo, scale: 5), SizedBox(height: Get.height / 10),
                          SizedBox(width: Get.width / 1.2, child: Text(textAlign: TextAlign.center, Option_text.hed, style: TextStyle(fontSize: Get.width / 17, fontWeight: FontWeight.w600))), SizedBox(height: Get.height / 50),
                          SizedBox(width: Get.width / 1.19, child: Text(textAlign: TextAlign.center, Option_text.subhed, style: TextStyle(fontSize: Get.width / 27, fontWeight: FontWeight.w400, color: AppColor.subcolor))), SizedBox(height: Get.height / 20),

                          //Employer
                          GestureDetector(
                            onTap: () async {
                              option_api.OptionApiController_fuction(UserType: 'Company', Tokan: Tokans, CandidateId: Candidate);
                              await pref!.setString('usertype', 'Company');
                              username = pref!.getString('usertype')!;
                              select.Select();
                            },
                            child: WideButton(text: Option_text.Employer, Icon: AppIcons.Employee, B_Colors: AppColor.Notification_Color),
                          ),
                          SizedBox(height: Get.height / 50),

                          //Candidate
                          GestureDetector(
                            onTap: () async {
                              option_api.OptionApiController_fuction(UserType: 'Candidate', Tokan: Tokans, CandidateId: Candidate);
                              await pref!.setString('usertype', 'Candidate');
                              username = pref!.getString('usertype')!;
                              select.SelectSecond();
                            },
                            child: WideButton(text: Option_text.Candidate, Icon: AppIcons.briefcase),
                          ),
                          SizedBox(height: Get.height / 20),
                          Text(textAlign: TextAlign.center, Option_text.ThenkYOU, style: TextStyle(fontSize: Get.width / 27, color: AppColor.subcolor)),
                          SizedBox(height: Get.height / 15),
                        ],
                      );
                    },
                  ),
                ),
              ) // Ensure this path is correct
              ),
            ),
          )
              : Scaffold(
            body: Container(
              height: Get.height, width: Get.width,
              decoration: BoxDecoration(color: AppColor.Full_body_color),
              child: Center(child: Image.asset(AppLoder.noInternet)),
            ),
          );
        },
      ),

      //Tablet Horizatal Viwe
      tablet: Consumer<InternetController>(
        builder: (BuildContext context, value, Widget? child) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(flex: 1, child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height, width: Get.width,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImage.Side), fit: BoxFit.fitHeight, alignment: Alignment.topLeft)),
                      ),
                      Container(
                          height: Get.height, width: Get.width,
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: Get.width/20),
                                child: Text(textAlign: TextAlign.center, Login_text.Steve_Jobs,style: TextStyle(color: AppColor.Full_body_color,fontSize: Get.width/40)),
                              ),
                            ],
                          )),
                    ],
                  ),
                )),
            
                Expanded(child: (internetController.isConnected)
                    ? Scaffold(
                    body: Container(
                  height: Get.height, width: Get.width,
                  decoration: BoxDecoration(color: AppColor.Full_body_color),
                  child: SafeArea(child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                      child: Consumer<SelectButtonsController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            children: [
                              SizedBox(height: Get.height / 10), Image.asset(AppIcons.logo, scale: 5),
                              SizedBox(height: Get.height / 10), SizedBox(width: Get.width / 1.2, child: Text(textAlign: TextAlign.center, Option_text.hed, style: TextStyle(fontSize: Get.width / 45, fontWeight: FontWeight.w600))),
                              SizedBox(height: Get.height / 50), SizedBox(width: Get.width / 1.19, child: Text(textAlign: TextAlign.center, Option_text.subhed, style: TextStyle(fontSize: Get.width / 70, fontWeight: FontWeight.w400, color: AppColor.subcolor))),
                              SizedBox(height: Get.height / 20),
            
                              //Employer
                              GestureDetector(
                                onTap: () async {
                                  option_api.OptionApiController_fuction(UserType: 'Company', Tokan: Tokans, CandidateId: Candidate);
                                  await pref!.setString('usertype', 'Company');
                                  username = pref!.getString('usertype')!;
                                  select.Select();
                                },
                                child: WideButton(B_Colors: AppColor.Notification_Color, text: Option_text.Employer, Icon: AppIcons.Employee, height_R: Get.height/15, fontSize_r: Get.width/75),
                              ),
                              SizedBox(height: Get.height / 50),
            
                              //Candidate
                              GestureDetector(
                                  onTap: () async {
                                    option_api.OptionApiController_fuction(UserType: 'Candidate', Tokan: Tokans, CandidateId: Candidate);
                                    await pref!.setString('usertype', 'Candidate');
                                    username = pref!.getString('usertype')!;
                                    select.SelectSecond();
                                  },
                                  child: WideButton(text: Option_text.Candidate, Icon: AppIcons.briefcase, height_R: Get.height/15, fontSize_r: Get.width/75)
                              ),
                              SizedBox(height: Get.height / 20),
                              Text(textAlign: TextAlign.center, Option_text.ThenkYOU, style: TextStyle(fontSize: Get.width / 70, color: AppColor.subcolor)),
                              SizedBox(height: Get.height / 15),
                            ],
                          );
                        },
                      ),
                    ),
                  ) // Ensure this path is correct
                  ),
                ))
                    : Scaffold(body: Container(
                  height: Get.height, width: Get.width,
                  decoration: BoxDecoration(color: AppColor.Full_body_color),
                  child: Center(child: Image.asset(AppLoder.noInternet)),
                ))),
              ],
            ),
          );
        },
      ),
    );
  }
}
