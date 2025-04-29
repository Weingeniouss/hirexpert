// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, must_be_immutable, prefer_const_constructors_in_immutables, unused_import, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/Profile_CertificateList.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/Remove_Profile_CerticateList.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Profile/Profile/add_Profile_CertificateList.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/Profile_Info_Controller/Document_Info_Controller.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/Profile_Info_Controller/Profile_Controller/certification_Add_Controller.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/profile/information.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/Buttons/ShortButton.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../../controller/User_Controller/Candidate_Controller/BottamController/MenuNavigationController.dart';
import '../../../../app_icon.dart';
import '../../../showpop/showdialog.dart';

class Documant_Profile extends StatelessWidget {
  Documant_Profile({super.key});

  final CertificationAddController Certificat = Get.put(CertificationAddController());

  @override
  Widget build(BuildContext context) {
    final Documents_pro = Provider.of<DocumentInfoController>(context, listen: false);
    return Consumer<DocumentInfoController>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(

          //Buttons
          floatingActionButton: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) intState) {
                      return AlertDialog(
                        backgroundColor: AppColor.Full_body_color,
                        elevation: 0,
                        title: Container(
                          height: Get.height / 20, width: Get.width,
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Bottam_color))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(Profile_Text.Hedding_Critifaction, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                              InkWell(onTap: () => Get.back(), child: SvgPicture.asset(AppIcons.cancel)),
                            ],
                          ),
                        ),
                        content: Container(
                          height: Get.height / 1.5, width: Get.width,
                          decoration: BoxDecoration(color: AppColor.Full_body_color),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) inState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Profile_Text.Certificate, style: TextStyle(fontSize: Get.width / 25, color: AppColor.select_check_color)),
                                    TextField(
                                      controller: Certificat.Certificate,
                                      decoration: InputDecoration(
                                        hintText: Profile_Text.Certificate_Name,
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                      ),
                                    ),
                                    SizedBox(height: Get.height / 50),

                                    //Date
                                    Text(Profile_Text.Date_issued, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Get.width / 3,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: Certificat.Month_Controller,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                              hintText: 'Month',
                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width / 3,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: Certificat.Year_Controller,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                              hintText: 'Year',
                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    //Expire Date
                                    SizedBox(height: Get.height / 50),
                                    Visibility(
                                      visible: Documents_pro.certificate_cheak,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(Profile_Text.Expire_issued, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Get.width / 3,
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: Certificat.Expire_Month_Controller,
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                    hintText: 'Month',
                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width / 3,
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: Certificat.Expire_Year_Controller,
                                                  decoration: InputDecoration(
                                                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                    hintText: 'Year',
                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Get.height / 50),
                                    Row(
                                      children: [
                                        Checkbox(
                                            side: BorderSide(color: AppColor.select_check_color),
                                            value: Documents_pro.certificate_cheak,
                                            onChanged: (val) {
                                              inState(() {
                                                Documents_pro.certificate_cheak_fuction(val);
                                              });
                                            }),
                                        SizedBox(
                                          width: Get.width / 2,
                                          child: Text(Profile_Text.This_certificate, style: TextStyle(fontSize: Get.width / 27, color: AppColor.select_check_color)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height / 50),
                                    Text(Profile_Text.Description, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                    SizedBox(height: Get.height / 70),
                                    SizedBox(
                                      height: Get.height / 8,
                                      width: Get.width,
                                      child: TextField(
                                        controller: Certificat.Description_Controller,
                                        expands: true,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.select_check_color)),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.select_check_color)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height / 50),
                                    Text(Profile_Text.Image_Type, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                    Row(
                                      children: [
                                        Checkbox(
                                          side: BorderSide(color: AppColor.select_check_color),
                                          value: Documents_pro.Image_url,
                                          onChanged: (val) {
                                            inState(() {
                                              Documents_pro.Image_url_fuction(val);
                                            });
                                          },
                                        ),
                                        Text(Profile_Text.Image_URL, style: TextStyle(fontSize: Get.width / 26, color: AppColor.subcolor)),
                                        SizedBox(width: Get.width / 70),
                                        Checkbox(
                                          side: BorderSide(color: AppColor.select_check_color),
                                          value: Documents_pro.Image,
                                          onChanged: (val) {
                                            inState(() {
                                              Documents_pro.Image_fuction(val);
                                            });
                                          },
                                        ),
                                        Text(Profile_Text.Image, style: TextStyle(fontSize: Get.width / 26, color: AppColor.subcolor)),
                                      ],
                                    ),
                                    SizedBox(height: Get.height / 50),
                                    Visibility(
                                      visible: Documents_pro.Image_url,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(Profile_Text.Image_URL, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 23)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Get.width / 2.5,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: AppColor.Textfild_color,
                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: Get.height / 15,
                                                width: Get.width / 3.9,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 60), color: AppColor.Button_color),
                                                child: Center(child: Text(textAlign: TextAlign.center, Profile_Text.Choose_File, style: TextStyle(color: AppColor.Full_body_color, fontWeight: FontWeight.w600))),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: Documents_pro.Image,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(Profile_Text.Image, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 23)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: SizedBox(
                                                  width: Get.width / 2.5,
                                                  child: TextField(
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      hintText: (Certificat.selectedImage == null) ? 'Please insert your image' : Certificat.selectedImage?.path.toString(),
                                                      filled: true,
                                                      fillColor: AppColor.Textfild_color,
                                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context).size.height / 15,
                                                width: MediaQuery.of(context).size.width / 3.9,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 60),
                                                  color: AppColor.Button_color,
                                                ),
                                                child: (Certificat.selectedImage == null)
                                                    ? Center(
                                                        child: TextButton(
                                                          onPressed: Certificat.pickimage,
                                                          child: Text(Profile_Text.Choose_File, textAlign: TextAlign.center, style: TextStyle(color: AppColor.Full_body_color, fontWeight: FontWeight.w600)),
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 60),
                                                        child: Image.file(
                                                          Certificat.selectedImage!,
                                                          fit: BoxFit.cover,
                                                          height: MediaQuery.of(context).size.height / 15,
                                                          width: MediaQuery.of(context).size.width / 3.9,
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        actions: [
                          OnButtons(
                            onTap: () {
                              intState(() {
                                Certificat.Add_new_Certification();
                              });
                            },
                            Button_Color: AppColor.Button_color,
                            btn_name: Profile_Text.Submit,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              height: Get.height / 20, width: Get.width / 3,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.height / 80), color: AppColor.Button_color2),
              child: Center(
                child: Text(Profile_Text.Add_New, style: TextStyle(color: AppColor.Full_body_color, fontSize: Get.width / 26)),
              ),
            ),
          ),

          //Body
          body: Container(
              height: Get.height, width: Get.width,
              decoration: BoxDecoration(color: AppColor.Full_body_color),
              child: Obx(() {
                if (Certificat.profileController.isLoading.value) {return Center(child: Image.asset(AppLoder.infinityloder_without_background));}
                else if (Certificat.profileController.profileCertificateListData['data'] == null || Certificat.profileController.profileCertificateListData['data'].isEmpty) {return Center(child: Lottie.asset(AppLoder.noData));}
                else {
                  return ListView.builder(
                    itemCount: Certificat.profileController.profileCertificateListData['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: Get.width, height: Get.height / 9,
                        color: AppColor.Full_body_color,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(height: Get.height / 15, width: Get.width / 5, child: SvgPicture.asset(AppIcons.PDF_Icon)),
                                Expanded(
                                  child: ListTile(
                                    title: Text(Certificat.profileController.profileCertificateListData['data'][index]['Title'] ?? 'No title'),
                                    subtitle: Text('Issue Date ${Certificat.profileController.profileCertificateListData['data'][index]['IssueDate']}'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context, void Function(void Function()) intState) {
                                            return AlertDialog(
                                              backgroundColor: AppColor.Full_body_color,
                                              elevation: 0,
                                              title: Container(
                                                height: Get.height / 20, width: Get.width,
                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Bottam_color))),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(),
                                                    Text(Profile_Text.Hedding_Critifaction, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                                    InkWell(onTap: () => Get.back(), child: SvgPicture.asset(AppIcons.cancel)),
                                                  ],
                                                ),
                                              ),
                                              content: Container(
                                                height: Get.height / 1.5, width: Get.width,
                                                decoration: BoxDecoration(color: AppColor.Full_body_color),
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) inState) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(Profile_Text.Certificate, style: TextStyle(fontSize: Get.width / 25, color: AppColor.select_check_color)),
                                                          TextField(
                                                            controller: Certificat.Edit_Certificate_Controller = TextEditingController(text: Certificat.profileController.profileCertificateListData['data'][index]['Title']),
                                                            decoration: InputDecoration(
                                                              hintText: Profile_Text.Certificate_Name,
                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height / 50),

                                                          //Date
                                                          Text(Profile_Text.Date_issued, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: Get.width / 3,
                                                                child: TextField(
                                                                  keyboardType: TextInputType.number,
                                                                  controller: Certificat.Month_Controller,
                                                                  decoration: InputDecoration(
                                                                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                                    hintText: 'Month',
                                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Get.width / 3,
                                                                child: TextField(
                                                                  keyboardType: TextInputType.number,
                                                                  controller: Certificat.Edit_Year_Controller = TextEditingController(text: Certificat.profileController.profileCertificateListData['data'][index]['IssueDate']),
                                                                  decoration: InputDecoration(
                                                                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                                    hintText: 'Year',
                                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          //Expire Date
                                                          SizedBox(height: Get.height / 50),
                                                          Visibility(
                                                            visible: Documents_pro.certificate_cheak,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(Profile_Text.Expire_issued, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: Get.width / 3,
                                                                      child: TextField(
                                                                        keyboardType: TextInputType.number,
                                                                        controller: Certificat.Expire_Month_Controller,
                                                                        decoration: InputDecoration(
                                                                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                                          hintText: 'Month',
                                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get.width / 3,
                                                                      child: TextField(
                                                                        keyboardType: TextInputType.number,
                                                                        controller: Certificat.Edit_Month_Controller = TextEditingController(text: Certificat.profileController.profileCertificateListData['data'][index]['ExpireDate']),
                                                                        decoration: InputDecoration(
                                                                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColor.select_check_color),
                                                                          hintText: 'Year',
                                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height / 50),
                                                          Row(
                                                            children: [
                                                              Checkbox(
                                                                  side: BorderSide(color: AppColor.select_check_color),
                                                                  value: Documents_pro.certificate_cheak,
                                                                  onChanged: (val) {
                                                                    inState(() {
                                                                      Documents_pro.certificate_cheak_fuction(val);
                                                                    });
                                                                  }),
                                                              SizedBox(
                                                                width: Get.width / 2,
                                                                child: Text(Profile_Text.This_certificate, style: TextStyle(fontSize: Get.width / 27, color: AppColor.select_check_color)),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height / 50),
                                                          Text(Profile_Text.Description, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                                          SizedBox(height: Get.height / 70),
                                                          SizedBox(
                                                            height: Get.height / 8,
                                                            width: Get.width,
                                                            child: TextField(
                                                              controller: Certificat.Description_Controller,
                                                              expands: true,
                                                              maxLines: null,
                                                              decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.select_check_color)),
                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.select_check_color)),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height / 50),
                                                          Text(Profile_Text.Image_Type, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 25)),
                                                          Row(
                                                            children: [
                                                              Checkbox(
                                                                side: BorderSide(color: AppColor.select_check_color),
                                                                value: Documents_pro.Image_url,
                                                                onChanged: (val) {
                                                                  inState(() {
                                                                    Documents_pro.Image_url_fuction(val);
                                                                  });
                                                                },
                                                              ),
                                                              Text(Profile_Text.Image_URL, style: TextStyle(fontSize: Get.width / 26, color: AppColor.subcolor)),
                                                              SizedBox(width: Get.width / 70),
                                                              Checkbox(
                                                                side: BorderSide(color: AppColor.select_check_color),
                                                                value: Documents_pro.Image,
                                                                onChanged: (val) {
                                                                  inState(() {
                                                                    Documents_pro.Image_fuction(val);
                                                                  });
                                                                },
                                                              ),
                                                              Text(Profile_Text.Image, style: TextStyle(fontSize: Get.width / 26, color: AppColor.subcolor)),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height / 50),
                                                          Visibility(
                                                            visible: Documents_pro.Image_url,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(Profile_Text.Image_URL, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 23)),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: Get.width / 2.5,
                                                                      child: TextField(
                                                                        decoration: InputDecoration(
                                                                          filled: true,
                                                                          fillColor: AppColor.Textfild_color,
                                                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height: Get.height / 15,
                                                                      width: Get.width / 3.9,
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 60), color: AppColor.Button_color),
                                                                      child: Center(child: Text(textAlign: TextAlign.center, Profile_Text.Choose_File, style: TextStyle(color: AppColor.Full_body_color, fontWeight: FontWeight.w600))),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: Documents_pro.Image,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(Profile_Text.Image, style: TextStyle(color: AppColor.select_check_color, fontSize: Get.width / 23)),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: SizedBox(
                                                                        width: Get.width / 2.5,
                                                                        child: TextField(
                                                                          readOnly: true,
                                                                          decoration: InputDecoration(
                                                                            hintText: (Certificat.selectedImage == null) ? 'Please insert your image' : Certificat.selectedImage?.path.toString(),
                                                                            filled: true,
                                                                            fillColor: AppColor.Textfild_color,
                                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height: MediaQuery.of(context).size.height / 15,
                                                                      width: MediaQuery.of(context).size.width / 3.9,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 60),
                                                                        color: AppColor.Button_color,
                                                                      ),
                                                                      child: (Certificat.selectedImage == null) ? Center(
                                                                        child: TextButton(
                                                                          onPressed: Certificat.pickimage,
                                                                          child: Text(Profile_Text.Choose_File, textAlign: TextAlign.center, style: TextStyle(color: AppColor.Full_body_color, fontWeight: FontWeight.w600)),
                                                                        ),
                                                                      )
                                                                          : ClipRRect(
                                                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 60),
                                                                        child: Image.file(
                                                                          Certificat.selectedImage!,
                                                                          fit: BoxFit.cover,
                                                                          height: MediaQuery.of(context).size.height / 15,
                                                                          width: MediaQuery.of(context).size.width / 3.9,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                OnButtons(
                                                  onTap: () {
                                                    Certificat.Edit_Certification(index);
                                                    intState(() {});
                                                  },
                                                  Button_Color: AppColor.Button_color,
                                                  btn_name: Profile_Text.Submit,
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(AppIcons.Edit, color: AppColor.offButton_color),
                                ),
                                SizedBox(width: Get.width / 80),
                                Text('|', style: TextStyle(color: AppColor.offButton_color)),
                                SizedBox(width: Get.width / 50),
                                GestureDetector(
                                  onTap: () {
                                    Showdialog.showdialod(
                                        context: context,
                                        colamWidget: RichText(text: TextSpan(children: [
                                          TextSpan(text: '${Profile_Text.sure} :- ', style: TextStyle(color: AppColor.black_all, fontSize: Get.width / 23)),
                                          TextSpan(text: Certificat.profileController.profileCertificateListData['data'][index]['Title'], style: TextStyle(color: AppColor.Button_color, fontSize: Get.width / 23)),
                                        ])),
                                        hedingtext: '',
                                        onTabs: () => Get.back(),
                                        actions: [
                                          Row(
                                            children: [
                                              OnButtons_short(onTap: () => Get.back(), width: Get.width / 3, btn_name: 'Cancel', Border_color: AppColor.offButton_color, btn_color: AppColor.offButton_color, text_color: AppColor.subcolor,),
                                              SizedBox(width: Get.width / 50),
                                              OnButtons_short(onTap: () => Certificat.Remove_Certification(index), width: Get.width / 3, btn_name: 'Delete', Border_color: AppColor.Error_color, btn_color: AppColor.Error_color, text_color: AppColor.Full_body_color),
                                            ],
                                          )
                                        ]);
                                  },
                                  child: SvgPicture.asset(AppIcons.cancel, color: AppColor.offButton_color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              })
          ),
        );
      },
    );
  }
}
