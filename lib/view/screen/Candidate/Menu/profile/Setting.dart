// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison, deprecated_member_use, prefer_const_constructors_in_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Setting/password_change.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/profile/seetting.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/SettingController/Setting_Screen_Controller.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/profile/Setting_Screen/Privacy_Policy.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/profile/Setting_Screen/Profile.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/profile/Setting_Screen/termsConditions_Screen.dart';
import 'package:hirexpert/view/screen/option/option.dart';
import 'package:hirexpert/view/screen/splash/logo.dart';
import 'package:hirexpert/view/utils/Responsive/responsive_Scrren.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/Buttons/ShortButton.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:hirexpert/view/utils/common/Container/profile_Info.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/showpop/showdialog.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/Change_PasswordController/Change_Password_Controller.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/common/Tostification/Toastification_success.dart';
import 'Setting_Screen/My_Archive.dart';
import 'Setting_Screen/Notification_Setting.dart';

class Setting extends StatelessWidget {
  final SettingScreensControllres SettingScreens = Get.put(SettingScreensControllres());
  final CandidatedetailsControllers_Controllrs Candidatedetails = Get.put(CandidatedetailsControllers_Controllrs());
  Setting({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SettingScreens.onInit();
    final Pass_change = Provider.of<ChangePasswordController>(context, listen: false);
    final feedback = Provider.of<SettingScreenController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: Get.height / 8,
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Bottam_color))),
                      child: Obx(() {
                        if (SettingScreens.Candidatedetails.isLoding.value) {
                          return Center(child: SizedBox());
                        } else if (SettingScreens.Candidatedetails.Candidatedetails_data?['data'] == null || SettingScreens.Candidatedetails.Candidatedetails_data == null) {
                          return Text(API_Error.null_data);
                        } else {
                          return Row(
                            children: [
                              CircleAvatar(radius: 40, backgroundImage: NetworkImage(SettingScreens.Candidatedetails.Candidatedetails_data?['data']['Profile']!)),
                              SizedBox(width: Get.width / 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(SettingScreens.Candidatedetails.Candidatedetails_data?['data']?['FirstName']!, style: TextStyle(fontSize: Get.width / 22, fontWeight: FontWeight.w700)),
                                  Text(SettingScreens.Candidatedetails.Candidatedetails_data?['data']?['LastName']!, style: TextStyle(fontSize: Get.width / 26, fontWeight: FontWeight.w400, color: AppColor.subcolor)),
                                ],
                              ),
                            ],
                          );
                        }
                      })),

                  Obx((){
                    if(SettingScreens.Candidatedetails.isLoding.value){
                      return Scaffold(body: Center(child: Image.asset(AppLoder.noData,scale: Get.width/250)));
                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Info_Setting(info: Profile_Text.Profile),
                            onTap: () => Get.to(() => Profiles(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 400),curve: Curves.easeIn),
                          ),

                          //My Archive
                          GestureDetector(onTap: () => Get.to(() => My_Archive(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 400),curve: Curves.easeIn), child: Info_Setting(info: Profile_Text.Archive)),

                          //Notification Setting
                          GestureDetector(onTap: () => Get.to(() => Notification_setting(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 400),curve: Curves.easeIn), child: Info_Setting(info: Profile_Text.Notification_Setting)),

                          //Send Us Your Feedback
                          Consumer<SettingScreenController>(
                            builder: (BuildContext context, SettingScreenController value, Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) inState) {
                                          return AlertDialog(
                                            backgroundColor: AppColor.Full_body_color,
                                            elevation: 0,
                                            title: Container(
                                              height: Get.height / 20,
                                              width: Get.width,
                                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Buttom_color))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(),
                                                  Text(My_Archive_text.Feedback, style: TextStyle(fontSize: Get.width / 23)),
                                                  GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset(AppIcons.cancel)),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              height: Get.height / 3.5,
                                              width: Get.width,
                                              decoration: BoxDecoration(color: AppColor.Full_body_color),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(My_Archive_text.Send_Us, style: TextStyle(fontSize: Get.width / 24)),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Checkbox(
                                                              side: BorderSide(color: AppColor.Buttom_color),
                                                              value: feedback.issues,
                                                              onChanged: (val) {
                                                                inState((){
                                                                  feedback.Issues_Fuction(val);
                                                                  feedback.Suggestions_Fuction(false);
                                                                });
                                                              }),
                                                          Text(My_Archive_text.Issues),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Checkbox(
                                                              side: BorderSide(color: AppColor.Buttom_color),
                                                              value: feedback.Suggestions,
                                                              onChanged: (val) {
                                                                inState((){
                                                                  feedback.Suggestions_Fuction(val);
                                                                  feedback.Issues_Fuction(false);
                                                                });
                                                              }),
                                                          Text(My_Archive_text.Suggestions),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height / 8,
                                                    child: TextField(
                                                      controller: SettingScreens.Commint_Controllers,
                                                      expands: true,
                                                      maxLines: null,
                                                      decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: Get.height / 80),
                                                  Container(
                                                    height: Get.height / 20,
                                                    width: Get.width / 3,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 80), color: AppColor.Button_color),
                                                    child: Center(
                                                      child: Text(
                                                        textAlign: TextAlign.center,
                                                        My_Archive_text.Add_Screenshot,
                                                        style: TextStyle(color: AppColor.Full_body_color),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              GestureDetector(
                                                onTap: () {
                                                  inState((){
                                                    SettingScreens.AddFeedBack.Addfeedback_fuction(FeedbackType: 'Issue', Comment: SettingScreens.Commint_Controllers.text,Tokans: Tokans);
                                                    if(SettingScreens.AddFeedBack.Addfeedback_data['status'] == true){
                                                      ToastificationSuccess.Success(SettingScreens.AddFeedBack.Addfeedback_data['message']);
                                                    }else{
                                                      ToastificationError.Error(SettingScreens.AddFeedBack.Addfeedback_data['message']);
                                                    }
                                                  });
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: Get.height / 20,
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 80), color: AppColor.Button_color),
                                                  child: Center(child: Text(My_Archive_text.Submit, style: TextStyle(color: AppColor.Full_body_color))),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  height: Get.height / 20,
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 80), color: AppColor.Tabbar_color),
                                                  child: Center(child: Text(My_Archive_text.Cancel, style: TextStyle(color: AppColor.subcolor))),
                                                ),
                                              ),
                                            ],
                                          );
                                        },

                                      );
                                    },
                                  );
                                },
                                child: Info_Setting(info: Profile_Text.Send_Us_Your_Feedback),
                              );
                            },
                          ),

                          //Manage_Account
                          Consumer<SettingScreenController>(
                            builder: (BuildContext context, value, Widget? child) {
                              return ResponsiveWidget(
                                  mobile: GestureDetector(
                                  onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: AppColor.Full_body_color,
                                        title: Container(
                                          height: Get.height / 20, width: Get.width,
                                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Buttom_color)),),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),
                                              Text(My_Archive_text.Manage_Account, style: TextStyle(fontSize: Get.width / 23)),
                                              GestureDetector(
                                                onTap: () => Get.back(),
                                                child: SvgPicture.asset(AppIcons.cancel),
                                              ),
                                            ],
                                          ),
                                        ),
                                        content: Container(
                                          height: Get.height / 7, width: Get.width,
                                          decoration: BoxDecoration(color: AppColor.Full_body_color),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(My_Archive_text.Hide_my, style: TextStyle(fontSize: Get.width / 25)),
                                                  StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function())inState) {
                                                      return Switch(
                                                        activeColor: AppColor.Button_color,
                                                        inactiveTrackColor: AppColor.Buttom_color,
                                                        thumbColor: MaterialStatePropertyAll(AppColor.Full_body_color),
                                                        value: feedback.manageAccount,
                                                        onChanged: (swi) {
                                                          inState((){
                                                            feedback.manageAccount_Fuction(swi);
                                                            String isPrivateValue = swi ? '0' : '1';
                                                            SettingScreens.Setprivat.Setprivateaccount_Fuction(IsPrivate: isPrivateValue, UserType: 'Candidate', UserBy: '1', Tokan: Tokans);
                                                            if (SettingScreens.Setprivat.Setprivateaccount_data['status'] == true) {
                                                              ToastificationSuccess.Success(SettingScreens.Setprivat.Setprivateaccount_data['message']);
                                                            } else {
                                                              ToastificationError.Error(SettingScreens.Setprivat.Setprivateaccount_data['message']);
                                                            }
                                                          });
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(width: Get.width / 2.5, child: Text(My_Archive_text.Remove, style: TextStyle(fontSize: Get.width / 25))),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Showdialog.showdialod(
                                                        context: context,
                                                        colamWidget: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(My_Archive_text.Sure,style: TextStyle(fontSize: Get.width/25,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                            SizedBox(height: Get.height/30),
                                                            Text(Candidatedetails.Candidatedetails_data!['data']['Email'].toString(),style: TextStyle(fontSize: Get.width/27,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                            Text(Candidatedetails.Candidatedetails_data!['data']['CustName'].toString(),style: TextStyle(fontSize: Get.width/27,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                          ],
                                                        ),
                                                        actions: [
                                                          OnButtons_short(
                                                            btn_name: My_Archive_text.Remove_buttons,
                                                            Border_color: AppColor.Button_color,
                                                            btn_color: AppColor.Button_color,
                                                            text_color: AppColor.Full_body_color,
                                                            onTap: (){
                                                              SettingScreens.Removeaccount.Removeaccount_fuction(UserType: 'Candidate', UserBy: '1', OwnRemove: '1', Tokan: Tokans);
                                                              if(SettingScreens.Removeaccount.Removeaccount_data['status'] == true){
                                                                ToastificationSuccess.Success(SettingScreens.Removeaccount.Removeaccount_data['message']);
                                                              }else{
                                                                ToastificationError.Error(SettingScreens.Removeaccount.Removeaccount_data['message']);
                                                              }
                                                              Get.back();
                                                            },
                                                          ),
                                                        ],
                                                        hedingtext: My_Archive_text.Remove_buttons,
                                                        onTabs: () => Get.back(),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: Get.height / 20,
                                                      width: Get.width / 4,
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 60), color: AppColor.Error_color),
                                                      child: Center(
                                                        child: Text(textAlign: TextAlign.center, My_Archive_text.Remove_buttons, style: TextStyle(color: AppColor.Full_body_color)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                  child: Info_Setting(info: Profile_Text.Manage_Account),
                              ),
                                  mcroMobile: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0,
                                            backgroundColor: AppColor.Full_body_color,
                                            title: Container(
                                              height: Get.height / 20, width: Get.width,
                                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Buttom_color)),),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(),
                                                  Text(My_Archive_text.Manage_Account, style: TextStyle(fontSize: Get.width / 23)),
                                                  GestureDetector(
                                                    onTap: () => Get.back(),
                                                    child: SvgPicture.asset(AppIcons.cancel),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              height: Get.height / 5, width: Get.width,
                                              decoration: BoxDecoration(color: AppColor.Full_body_color),
                                              child: Column(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(My_Archive_text.Hide_my, style: TextStyle(fontSize: Get.width / 25)),
                                                      StatefulBuilder(
                                                        builder: (BuildContext context, void Function(void Function())inState) {
                                                          return Switch(
                                                            activeColor: AppColor.Button_color,
                                                            inactiveTrackColor: AppColor.Buttom_color,
                                                            thumbColor: MaterialStatePropertyAll(AppColor.Full_body_color),
                                                            value: feedback.manageAccount,
                                                            onChanged: (swi) {
                                                              inState((){
                                                                feedback.manageAccount_Fuction(swi);
                                                                String isPrivateValue = swi ? '0' : '1';
                                                                SettingScreens.Setprivat.Setprivateaccount_Fuction(IsPrivate: isPrivateValue, UserType: 'Candidate', UserBy: '1', Tokan: Tokans);
                                                                if (SettingScreens.Setprivat.Setprivateaccount_data['status'] == true) {
                                                                  ToastificationSuccess.Success(SettingScreens.Setprivat.Setprivateaccount_data['message']);
                                                                } else {
                                                                  ToastificationError.Error(SettingScreens.Setprivat.Setprivateaccount_data['message']);
                                                                }
                                                              });
                                                              Get.back();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(width: Get.width / 2.5, child: Text(My_Archive_text.Remove, style: TextStyle(fontSize: Get.width / 25))),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Showdialog.showdialod(
                                                            context: context,
                                                            colamWidget: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(My_Archive_text.Sure,style: TextStyle(fontSize: Get.width/25,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                                SizedBox(height: Get.height/30),
                                                                Text(Candidatedetails.Candidatedetails_data!['data']['Email'].toString(),style: TextStyle(fontSize: Get.width/27,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                                Text(Candidatedetails.Candidatedetails_data!['data']['CustName'].toString(),style: TextStyle(fontSize: Get.width/27,color: AppColor.black_all,fontWeight: FontWeight.w600)),
                                                              ],
                                                            ),
                                                            actions: [
                                                              OnButtons_short(
                                                                btn_name: My_Archive_text.Remove_buttons,
                                                                Border_color: AppColor.Button_color,
                                                                btn_color: AppColor.Button_color,
                                                                text_color: AppColor.Full_body_color,
                                                                onTap: (){
                                                                  SettingScreens.Removeaccount.Removeaccount_fuction(UserType: 'Candidate', UserBy: '1', OwnRemove: '1', Tokan: Tokans);
                                                                  if(SettingScreens.Removeaccount.Removeaccount_data['status'] == true){
                                                                    ToastificationSuccess.Success(SettingScreens.Removeaccount.Removeaccount_data['message']);
                                                                  }else{
                                                                    ToastificationError.Error(SettingScreens.Removeaccount.Removeaccount_data['message']);
                                                                  }
                                                                  Get.back();
                                                                },
                                                              ),
                                                            ],
                                                            hedingtext: My_Archive_text.Remove_buttons,
                                                            onTabs: () => Get.back(),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: Get.height / 20, width: Get.width / 4,
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 60), color: AppColor.Error_color),
                                                          child: Center(
                                                            child: Text(textAlign: TextAlign.center, My_Archive_text.Remove_buttons, style: TextStyle(color: AppColor.Full_body_color)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Info_Setting(info: Profile_Text.Manage_Account),
                                  ),
                              );
                            },
                          ),

                          //Terms_And_Conditions
                          GestureDetector(child: Info_Setting(info: Profile_Text.Terms_And_Conditions),onTap: () => Get.to(() => TermsconditionsScreen(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 400),curve: Curves.easeIn)),

                          //Privacy_Policy
                          GestureDetector(child: Info_Setting(info: Profile_Text.Privacy_Policy),onTap: () => Get.to(() => PrivacyPolicy(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 400),curve: Curves.easeIn)),

                          //Password Change
                          Consumer<ChangePasswordController>(
                            builder: (BuildContext context, value, Widget? child) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) inState) {
                                          return AlertDialog(
                                            backgroundColor: AppColor.Full_body_color,
                                            elevation: 0,
                                            title: Container(
                                              height: Get.height / 15,
                                              width: Get.width,
                                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Buttom_color))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(),
                                                  Text(My_Archive_text.Old_Password, style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 23)),
                                                  InkWell(
                                                    onTap: () => Get.back(),
                                                    child: SvgPicture.asset(AppIcons.cancel),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              width: Get.width,
                                              height: Get.height / 2.8,
                                              decoration: BoxDecoration(color: AppColor.Full_body_color),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(My_Archive_text.Old_Password, style: TextStyle(fontSize: Get.width / 23, fontWeight: FontWeight.w400, color: AppColor.subcolor)),
                                                    TextField(
                                                      onTap: () {},
                                                      onChanged: (String val) {
                                                      inState((){
                                                        Pass_change.Old_Password_fuction(val);
                                                      });},
                                                      obscureText: Pass_change.o_pass,
                                                      controller: Pass_change.old_pass,
                                                      decoration: InputDecoration(
                                                        suffixIcon: GestureDetector(
                                                          onTap: () => Pass_change.OldPassword_Fuction_obx(),
                                                          child: (Pass_change.o_pass) ?  Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                                        ),
                                                        hintText: My_Archive_text.Enter_Old_Password,
                                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color),
                                                        ),
                                                      ),
                                                    ),
                                                    (Pass_change.Old_passing) ? Text(Pass_change.Olding, style: TextStyle(color: AppColor.Error_color)) : Text(""),
                                                    SizedBox(height: Get.height / 50),
                                                    Text(My_Archive_text.New_Password, style: TextStyle(fontSize: Get.width / 23, fontWeight: FontWeight.w400, color: AppColor.subcolor)),
                                                    TextField(
                                                      onChanged: (String val) {
                                                        inState((){
                                                          Pass_change.Old_Password_fuction(val);
                                                        });
                                                        Pass_change.new_password_fuction(val);},
                                                      obscureText: Pass_change.n_pass,
                                                      controller: Pass_change.new_pass,
                                                      decoration: InputDecoration(
                                                        suffixIcon: GestureDetector(
                                                          onTap: () => Pass_change.Confirm_Password_obx(),
                                                          child: (Pass_change.o_pass) ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                                        ),
                                                        hintText: My_Archive_text.Enter_New_Password,
                                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                      ),
                                                    ),
                                                    (Pass_change.Old_passing) ? Text(Pass_change.Newing, style: TextStyle(color: AppColor.Error_color)) : Text(Pass_change.Newing),
                                                    SizedBox(height: Get.height / 50),
                                                    Text(My_Archive_text.Confirm_Password, style: TextStyle(fontSize: Get.width / 23, fontWeight: FontWeight.w400, color: AppColor.subcolor)),
                                                    TextField(
                                                      onChanged:(String val) {
                                                        inState((){
                                                          Pass_change.Confirm_Password(val);
                                                        });
                                                        },
                                                      obscureText: Pass_change.c_pass,
                                                      controller: Pass_change.conf_pass,
                                                      decoration: InputDecoration(
                                                        suffixIcon: InkWell(
                                                          onTap: () => Pass_change.Confirm_Password_obx(),
                                                          child: (Pass_change.c_pass) ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                                        ),
                                                        hintText: My_Archive_text.Enter_Confirm_Password,
                                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Buttom_color)),
                                                      ),
                                                    ),
                                                    (Pass_change.Old_passing) ? Text(Pass_change.Confarm_Newing, style: TextStyle(color: AppColor.Error_color)) : Text(""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              GestureDetector(
                                                onTap: () {
                                                  inState((){
                                                    Pass_change.Button_Fuction();
                                                    // SettingScreens.chagepassword.PasswordChange_fuction(Password: Pass_change.new_pass.text, OldPassword: Pass_change.old_pass.text, Tokan: Tokans);
                                                  });
                                                },
                                                child: OnButtons(Button_Color: AppColor.Button_color, btn_name: Profile_Text.Change),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Info_Setting(info: Profile_Text.Change_Password),
                              );
                            },
                          ),
                          SizedBox(height: Get.height / 40),
                          GestureDetector(
                            onTap: () async {
                                ToastificationSuccess.Success("Successfully logged out.");
                                await auth.signOut();
                                await pref!.remove('Login');
                                await pref!.remove("Tokan");
                                await pref!.remove("Candidate");
                                Restart.restartApp();
                                Get.offAll(() => Logo());
                              },
                            child: Padding(
                              padding: EdgeInsets.only(left: Get.width / 32),
                              child: Text(Profile_Text.Logout, style: TextStyle(color: AppColor.Button_color, fontSize: Get.width / 25)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
