// ignore_for_file: avoid_print, non_constant_identifier_names, camel_case_types, deprecated_member_use, prefer_const_constructors_in_immutables, must_be_immutable, prefer_typing_uninitialized_variables, invalid_use_of_protected_member

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/Profile_Info_Controller/MyProfile_Controller/Address_Controller/Address_Controller.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/common/Buttons/wideButtons.dart';
import 'package:hirexpert/view/utils/common/Tabbar/Profile/Tabbarviwe/My_Profile/pdfviewer.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/CircleAvatar_Color/(My_Profile)Circle_color.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/Navi_Icons/(My_Profile)_Navi_Icons.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/Pass_Error/(My_Profile)_Pass_Error.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/MY_ProfileController/My_ProfileController.dart';
import '../../../../../Loder/Loding.dart';
import '../../../../../app_icon.dart';
import '../../../../../app_loder.dart';
import '../../../../Container/profile_Info.dart';
import '../../../../Selection/Information_Date.dart';
import '../../../../Textfild/Inputfild.dart';
import '../../../../showpop/showdialog.dart';

class MY_Profile extends StatelessWidget {
  final AddressProvider Address_hendals = Get.put(AddressProvider());

  MY_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final myProfile = Provider.of<My_ProfileController>(context, listen: false);
    return Container(
      height: Get.height, width: Get.width,
      decoration: BoxDecoration(color: AppColor.Full_body_color),
      child: Obx(() {
        if (Address_hendals.Candidatedetails.isLoding.value) {AppLodings.showLoadingDialog();}
        else {
          if (Get.isDialogOpen == true) {Get.back();}
        }
        if (Address_hendals.Candidatedetails.Candidatedetails_data == null || Address_hendals.Candidatedetails.Candidatedetails_data?['data'] == null) {return Center(child: Lottie.asset(AppLoder.noData));}
        else {
          var candidateData = Address_hendals.Candidatedetails.Candidatedetails_data?['data'];
          if (candidateData == null) {return Center(child: Text(API_Error.null_data));}
          else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Consumer<My_ProfileController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Column(
                        children: [

                          //Upload Your CV
                          GestureDetector(
                            onTap: () => myProfile.Upload_lock_fun(),
                            child: Info(info: Profile_Text.Upload_Your_CV, CircleAvatar_color: Change_Circle(Condition: myProfile.file != null || candidateData['ResumeDetails']['UploadName'] != null), dropicons: DropIcons(conditional_name: myProfile.Upload_lock)),
                          ),
                          Visibility(
                            visible: myProfile.Upload_lock,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 60), Text(Profile_Text.Upload, style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 23)), SizedBox(height: Get.height / 60),
                                InkWell(
                                  onTap: () => myProfile.picksinglefile(),
                                  child: DottedBorder(
                                    color: AppColor.Bottam_color, dashPattern: [15, 12],
                                    child: SizedBox(
                                      height: Get.height / 6, width: Get.width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppIcons.PDF_Icon), SizedBox(height: Get.height / 50),
                                          Text(maxLines: 3, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, candidateData['ResumeDetails']['ResumeName'].toString(), style: TextStyle(fontSize: Get.width / 27, color: AppColor.subcolor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height / 60),
                                Row(
                                  children: [
                                    Text(Profile_Text.Resume_Link, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                    Row(
                                      children: [
                                        SizedBox(width: Get.width / 25),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => Pdfviewer(pdfs: candidateData['ResumeDetails']['UploadName']));
                                          }, child: SizedBox(width: Get.width / 2, child: Text(candidateData['ResumeDetails']['UploadName'].toString(), style: TextStyle(color: AppColor.Button_color, decoration: TextDecoration.underline, fontSize: Get.width / 26, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //Personal_Information_fun
                          GestureDetector(
                            onTap: () => myProfile.Personal_Information_fun(),
                            child: Info(
                              info: Profile_Text.Personal_Information,
                              CircleAvatar_color: Change_Circle(Condition: Address_hendals.JobTitle_Controllers!.text.isNotEmpty && Address_hendals.FirstName_Controllers!.text.isNotEmpty && Address_hendals.LastName_Controllers!.text.isNotEmpty && Address_hendals.Email_Controllers!.text.isNotEmpty && Address_hendals.Phone_Controllers!.text.isNotEmpty && Address_hendals.DOB_Controllers!.text.isNotEmpty && myProfile.selectedCheckboxIndex.toString().isNotEmpty),
                              dropicons: DropIcons(conditional_name: myProfile.Personal_Information),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Personal_Information,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 60),

                                //Job Title
                                Inputfild(
                                  onTap: () => myProfile.P_Job_Title_fun(),
                                  onChanged: (val) {myProfile.JobTitle_validation(val);},
                                  labal: Profile_Text.Job_Title,
                                  hint: Address_hendals.Candidatedetails.Candidatedetails_data?['data']['JobTitle'],
                                  controller: Address_hendals.JobTitle_Controllers!,
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.JobTitle),
                                SizedBox(height: Get.height / 60),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    //First Name
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: Inputfild(
                                            onTap: () => myProfile.P_Frist_Name_fun(),
                                            onChanged: (val) {myProfile.FristName_validation(val);},
                                            labal: Profile_Text.First_Name,
                                            hint: candidateData['FirstName'] ?? '',
                                            controller: Address_hendals.FirstName_Controllers!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.FristName),
                                        ),
                                      ],
                                    ),

                                    //Last Name
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: Inputfild(
                                            onTap: () => myProfile.P_Last_Name_fun(),
                                            onChanged: (val) => myProfile.LastName_validation(val),
                                            labal: Profile_Text.Last_Name,
                                            hint: candidateData['LastName'] ?? '',
                                            controller: Address_hendals.LastName_Controllers!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.LastName),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height / 60),

                                //Email ID
                                Inputfild(
                                  readOnly: true,
                                  labal: Profile_Text.Email_Id,
                                  hint: candidateData['Email'] ?? '',
                                  controller: Address_hendals.Email_Controllers!,
                                  onTap: () => myProfile.P_Email_ID_fun(),
                                  onChanged: (val) => myProfile.Email_ID_validation(val),
                                ),
                                //Error
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Email_Id,),
                                SizedBox(height: Get.height / 60),

                                //Mobile Numbres
                                Inputfild(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  labal: Profile_Text.Mobile_Number,
                                  hint: candidateData['Phone'] ?? '',
                                  controller: Address_hendals.Phone_Controllers!,
                                  onTap: () => myProfile.P_Mobile_Numbres_fun(),
                                  onChanged: (val) => myProfile.Mobile_Numbress_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Mobile_Numbress),
                                SizedBox(height: Get.height / 60),

                                //Gender
                                Text(Profile_Text.Gender, style: TextStyle(fontSize: Get.width / 24, color: AppColor.select_check_color)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<int>(value: 0, groupValue: savedIndex, onChanged: (int? value) => Address_hendals.Male_Value(value), activeColor: AppColor.Button_color),
                                        Text(Profile_Text.Male, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<int>(value: 1, groupValue: savedIndex, onChanged: (int? value) => Address_hendals.Female_value(value), activeColor: AppColor.Button_color),
                                        Text(Profile_Text.Female, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<int>(value: 2, groupValue: savedIndex, onChanged: (int? value) => Address_hendals.Other_value(value), activeColor: AppColor.Button_color),
                                        Text(Profile_Text.PreferNot_tosay, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height / 60),

                                //Date Of Birthday
                                Inputfild(
                                  readOnly: true,
                                  labal: Profile_Text.Date_Of_Birthday,
                                  hint: candidateData['DOB'].toString(),
                                  controller: Address_hendals.DOB_Controllers!,
                                  onTap: () => myProfile.P_Birthday_fun(),
                                  onChanged: (val) => myProfile.Date_OF_Bithday_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Date_Of_Birth),
                              ],
                            ),
                          ),

                          //Address
                          GestureDetector(
                            onTap: () => myProfile.Address_fun(),
                            child: Obx(() => Info(
                                CircleAvatar_color: Change_Circle(Condition: Address_hendals.Street_Controllers!.text.isNotEmpty && Address_hendals.Post_Controllers!.text.isNotEmpty && Address_hendals.selectedProvince.value.isNotEmpty && Address_hendals.selectedCityId.value.isNotEmpty || candidateData['ProvinceName'].toString().isNotEmpty || candidateData['CityName'].toString().isNotEmpty),
                                info: Profile_Text.Address,
                                dropicons: DropIcons(conditional_name: myProfile.Address)
                              ),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Address,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 50),

                                //Street Address
                                Inputfild(
                                  readOnly: true,
                                  labal: Profile_Text.Street_Address,
                                  hint: candidateData['StreetAddress'] ?? '',
                                  controller: Address_hendals.Street_Controllers!,
                                  onTap: () => myProfile.P_Street_Adress_Fun(),
                                  onChanged: (val) => myProfile.Street_Adress_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Street_Adress),

                                //Post Code
                                Inputfild(
                                  labal: Profile_Text.Post_Code,
                                  hint: candidateData['PostCode'] ?? '',
                                  controller: Address_hendals.Post_Controllers!,
                                  onTap: () => myProfile.P_Post_Code_Fun(),
                                  onChanged: (val) => myProfile.Post_Codes_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Post_Codes),

                                // //Country
                                // RichText(
                                //   text: TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: Profile_Text.Select_Country,
                                //         style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor),
                                //       ),
                                //       TextSpan(
                                //         text: ' *',
                                //         style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Obx(() => Container(
                                //   width: Get.width,
                                //   height: Get.height / 15,
                                //   decoration: BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: AppColor.Textfild_color)),
                                //     color: AppColor.Full_body_color,
                                //   ),
                                //   child: DropdownButton<String>(
                                //     items: Address_hendals.Countrylist.countrylist['data'].map<DropdownMenuItem<String>>((value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value['Country'],
                                //         child: Text(value['Country']),
                                //       );
                                //     }).toList(),
                                //     onChanged: (val) {
                                //       if (val != null) {
                                //         Address_hendals.setSelectedCountry(val); // Set the selected country
                                //         print("Selected value: $val");
                                //       }
                                //     },
                                //     icon: SizedBox(),
                                //     autofocus: false,
                                //     isExpanded: true,
                                //     underline: SizedBox(),
                                //     hint: Text("Select Country"),
                                //     value: Address_hendals.selectedCountry.value.isNotEmpty ? Address_hendals.selectedCountry.value : null, // Bind to the selected country value
                                //   ),
                                // )),
                                // SizedBox(height: Get.height / 50),

                                //Province
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: Profile_Text.Select_Province, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                // Obx(() => GestureDetector(
                                //   onTap: Address_hendals.toggleProvinceSelection,
                                //   child: Container(
                                //     width: Get.width, height: Get.height / 15,
                                //     decoration: BoxDecoration(color: AppColor.Full_body_color, border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
                                //     child: (Address_hendals.selectedProvinceBool.value) ? DropdownButton<String>(
                                //       items: Address_hendals.Countrylist.countrylist['data'][0]['ProvinceList'].map<DropdownMenuItem<String>>((province) {
                                //         String value = "${province['ProvinceId']} : ${province['Name']}";
                                //         return DropdownMenuItem<String>(value: value, child: Text(province['Name']));
                                //       }).toList(),
                                //       onChanged: (val) {
                                //         Address_hendals.setSelectedProvince(val!);
                                //         print("Selected Province: $val");
                                //       },
                                //       icon: SizedBox(), autofocus: false, isExpanded: true,
                                //       hint: Text("Select Province"),
                                //       value: (Address_hendals.selectedProvince.value.isNotEmpty) ? Address_hendals.selectedProvince.value : null) : Column(crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         SizedBox(height: Get.height / 70),
                                //         Text(candidateData['ProvinceName'], style: TextStyle(fontSize: Get.width / 23)),
                                //       ],
                                //     ),
                                //   ),
                                // )),
                                StatefulBuilder(
                                  builder: (BuildContext context, void Function(void Function()) intState) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            List<dynamic> allProvinces = [];
                                            var countries = Address_hendals.Countrylist.countrylist['data'];
                                            for (var country in countries) {
                                              allProvinces.addAll(country['ProvinceList']);
                                            }
                                            return AlertDialog(
                                              backgroundColor: AppColor.Full_body_color,
                                              surfaceTintColor: AppColor.Full_body_color,
                                              shadowColor: AppColor.Full_body_color,
                                              elevation: 0,
                                              content: SizedBox(
                                                height: Get.height / 2, width: Get.width,
                                                child: ListView.builder(
                                                  itemCount: allProvinces.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: Get.height / 50),
                                                        GestureDetector(
                                                          child: Text(allProvinces[index]['Name'], style: TextStyle(fontSize: Get.width / 26)),
                                                          onTap: () {
                                                            intState(() {
                                                              Address_hendals.Statetrue.value = true;
                                                              Address_hendals.SelectedState.value = allProvinces[index]['Name'];
                                                              Address_hendals.SelectedStateID.value = allProvinces[index]['ProvinceId'];
                                                              Address_hendals.selectedProvince.value = allProvinces[index];
                                                            });
                                                            Get.back();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: Get.width, height: Get.height / 20,
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: Get.height / 80),
                                            (Address_hendals.Statetrue.value)
                                                ? Text(Address_hendals.SelectedState.value, style: TextStyle(fontSize: Get.width / 26))
                                                : Text(candidateData['ProvinceName'], style: TextStyle(fontSize: Get.width / 26)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: Get.height / 60),

                                //City
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: Profile_Text.Select_City, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                // Obx(() => GestureDetector(
                                //       onTap: Address_hendals.toggleCitySelection,
                                //       child: Container(
                                //         width: Get.width, height: Get.height / 15,
                                //         decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color)), color: AppColor.Full_body_color),
                                //         child: (Address_hendals.selectedProvinceBool.value)
                                //             ? DropdownButton<String>(
                                //                 items: Address_hendals.cityList.map<DropdownMenuItem<String>>((city) {
                                //                   return DropdownMenuItem<String>(value: city, child: Text(city.split(':')[1].trim()));
                                //                 }).toList(),
                                //                 onChanged: (val) {
                                //                   if (val != null) {
                                //                     Address_hendals.setSelectedCity(val);
                                //                     print("Selected City: $val");
                                //                   }
                                //                 },
                                //                 icon: SizedBox(), autofocus: false, isExpanded: true, hint: Text("Select City"),
                                //                 value: (Address_hendals.selectedCityId.value.isNotEmpty) ? Address_hendals.selectedCityId.value : null)
                                //             : Column(
                                //                 crossAxisAlignment: CrossAxisAlignment.start,
                                //                 children: [
                                //                   SizedBox(height: Get.height / 70),
                                //                   Text(candidateData['CityName'], style: TextStyle(fontSize: Get.width / 23)),
                                //                 ],
                                //               ),
                                //             ),
                                //           )),
                                StatefulBuilder(
                                  builder: (BuildContext context, void Function(void Function()) intState) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            List<dynamic> allProvinces = [];
                                            var countries = Address_hendals.Countrylist.countrylist['data'];
                                            for (var country in countries) {
                                              allProvinces.addAll(country['ProvinceList']);
                                            }
                                            return AlertDialog(
                                              backgroundColor: AppColor.Full_body_color,
                                              surfaceTintColor: AppColor.Full_body_color,
                                              shadowColor: AppColor.Full_body_color,
                                              elevation: 0,
                                              content: SizedBox(
                                                height: Get.height / 2, width: Get.width,
                                                child: (Address_hendals.selectedProvince.values.isNotEmpty)
                                                    ? ListView.builder(
                                                        itemCount: Address_hendals.selectedProvince['CityList'].length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          var city = Address_hendals.selectedProvince['CityList'][index];
                                                          return Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(height: Get.height / 50),
                                                              GestureDetector(
                                                                child: Text(city['CityName'], style: TextStyle(fontSize: Get.width / 26)),
                                                                onTap: () {
                                                                  intState(() {
                                                                    Address_hendals.Citytrue.value = true;
                                                                    Address_hendals.SelectCityID.value = city['CityId'];
                                                                    Address_hendals.SelectCity.value = city['CityName'];
                                                                  });
                                                                  Get.back();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    : Center(child: Text('No province data available')),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: Get.width, height: Get.height / 20,
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: Get.height / 80),
                                            (Address_hendals.Citytrue.value)
                                                ? Text(Address_hendals.SelectCity.value, style: TextStyle(fontSize: Get.width / 26))
                                                : Text(candidateData['CityName'], style: TextStyle(fontSize: Get.width / 26)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: Get.height / 50),
                              ],
                            ),
                          ),

                          // Education Details
                          GestureDetector(
                            onTap: () => myProfile.Education_Details_fun(),
                            child: Info(
                              CircleAvatar_color: Change_Circle(Condition: Address_hendals.Degree_pop_name.isNotEmpty && Address_hendals.Specialization_pop_name.isNotEmpty && Address_hendals.Institute_Controllers!.text.isNotEmpty && Address_hendals.passYearNotifier.value.toString() == value.toString() || Address_hendals.Candidatedetails.Candidatedetails_data!['data']['DegreeName'].toString().isNotEmpty || candidateData['QuestionList'][0]['Answer'].toString().isNotEmpty || candidateData['DegreeName'].toString().isNotEmpty && Address_hendals.setectpasing.value),
                              info: Profile_Text.Educational_Detailss,
                              dropicons: DropIcons(conditional_name: myProfile.Education_Details),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Education_Details,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 50),

                                //Degree
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: EditProfile_text.Degree, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor),),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Showdialog.showdialod(
                                      height: Get.height/2, context: context,
                                      colamWidget: SizedBox(
                                        height: Get.height/1.5,
                                        child: ListView.builder(
                                            itemCount: Address_hendals.Degree.Degree_data['data'].length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return GestureDetector(
                                                onTap: () => Address_hendals.Degree_fuc(index),
                                                child: SizedBox(
                                                  height: Get.height/20,
                                                  child: Text(Address_hendals.Degree.Degree_data['data'][index]['Name'], style: TextStyle(fontSize: Get.width/25)
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      hedingtext: EditProfile_text.Degree,
                                      onTabs: () => Get.back(),
                                    );
                                  },
                                  child: Container(
                                    width: Get.width, height: Get.height/15,
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Textfild_color)), color: AppColor.Full_body_color),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Get.height/50),
                                        Obx(() => (Address_hendals.Degree_pop_bool.value)
                                            ? Text(Address_hendals.Degree_pop_name.value,style: TextStyle(fontSize: Get.width/25))
                                            : Text(Address_hendals.Candidatedetails.Candidatedetails_data!['data']['DegreeName'].toString(),style: TextStyle(fontSize: Get.width/25)),)
                                      ],
                                    ),
                                  ),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Degrees),
                                SizedBox(height: Get.height / 50),

                                //Specialisation
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: EditProfile_text.Specialisation, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Showdialog.showdialod(
                                      height: Get.height/2, context: context,
                                      colamWidget: SizedBox(
                                        height: Get.height/1.5,
                                        child: ListView.builder(
                                            itemCount: Address_hendals.candidate.Candidatetech_data['data']['OptionList'].length,
                                            itemBuilder: (BuildContext context, int index) {
                                              if (index < Address_hendals.candidate.Candidatetech_data['data']['OptionList'].length) {
                                                return GestureDetector(
                                                  onTap: () => Address_hendals.Specialisation(index),
                                                  child: SizedBox(
                                                    height: Get.height / 20,
                                                    child: Text(Address_hendals.candidate.Candidatetech_data['data']['OptionList'][index]['QueAnswer'], style: TextStyle(fontSize: Get.width / 25)),
                                                  ),
                                                );
                                              } else {
                                                return Container(); // Or some placeholder widget
                                              }
                                            }
                                        ),
                                      ),
                                      hedingtext: EditProfile_text.Specialisation,
                                      onTabs: () => Get.back(),
                                    );
                                  },
                                  child: Container(
                                      width: Get.width, height: Get.height/15,
                                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.Textfild_color)), color: AppColor.Full_body_color),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Get.height/50),
                                          Obx(() => (Address_hendals.Specialization_pop_bool.value)
                                              ? Text(Address_hendals.Specialization_pop_name.value,style: TextStyle(fontSize: Get.width/25))
                                              : Text(candidateData['QuestionList'][0]['Answer'].toString() ,style: TextStyle(fontSize: Get.width/25)))
                                        ],
                                      )
                                  ),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Specialisations),
                                SizedBox(height: Get.height / 50),

                                //Institute Name
                                Inputfild(
                                  labal: EditProfile_text.Institute_Name,
                                  hint: candidateData['DegreeName'] ?? '',
                                  controller: Address_hendals.Institute_Controllers!,
                                  onTap: () => myProfile.P_Instiute_name_fun(),
                                  onChanged: (val) => myProfile.Institute_name_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Institute_names),
                                SizedBox(height: Get.height / 70),

                                //Passing Year
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: EditProfile_text.Passing_Yea, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context, builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: AppColor.Full_body_color,
                                          content: ValueListenableBuilder(
                                            valueListenable: Address_hendals.passYearNotifier,
                                            builder: (context, int value, child) {
                                              return Container(
                                                height: Get.height / 4, width: Get.width,
                                                decoration: BoxDecoration(color: AppColor.Full_body_color),
                                                child: GetBuilder<AddressProvider>(builder: (GetxController controller) {
                                                  return NumberPicker(
                                                    step: 1,
                                                    minValue: 1900,
                                                    maxValue: 2025,
                                                    itemHeight: Get.height / 12,
                                                    selectedTextStyle: TextStyle(color: AppColor.black_all, fontSize: Get.width / 20),
                                                    decoration: BoxDecoration(
                                                      border: Border(top: BorderSide(color: AppColor.subcolor), bottom: BorderSide(color: AppColor.subcolor)),
                                                    ),
                                                    value: value,
                                                    onChanged: (newValue) {
                                                        Address_hendals.passYearNotifier.value = newValue;
                                                        Address_hendals.Passyer(newValue);
                                                      },
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                          actions: [
                                            OnButtons(onTap: () {
                                                Address_hendals.setectpasing.value = true;
                                                Address_hendals.Gradution_ID();
                                              },
                                                Button_Color: AppColor.Button_color, btn_name: 'Save'
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: Address_hendals.passYearNotifier,
                                    builder: (BuildContext context, value, Widget? child) {
                                      return Container(
                                        height: Get.height / 20, width: Get.width,
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.select_check_color))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text((Address_hendals.setectpasing.value) ? value.toString() : Address_hendals.Candidatedetails.Candidatedetails_data!['data']['GraduationYears'].toString(),style: TextStyle(fontSize: Get.width/23)),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: Get.height / 30),

                                //Add Education Details
                                Text(Profile_Text.Add_Educational_Details, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600, color: AppColor.Button_color)),
                                SizedBox(height: Get.height / 30),
                              ],
                            ),
                          ),

                          //Work Experience
                          GestureDetector(
                            onTap: () => myProfile.Work_Experience_fun(),
                            child: Info(
                              CircleAvatar_color: Change_Circle(Condition: Address_hendals.selectExperience_month.value && Address_hendals.CompanyName_Controllers!.text.isNotEmpty && Address_hendals.Designation_Controllers!.text.isNotEmpty),
                              info: Profile_Text.Work_Experience,
                              dropicons: DropIcons(conditional_name: myProfile.Work_Experience),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Work_Experience,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 50),

                                //I'm Not a Fresher
                                Container(
                                  height: Get.height / 20, width: Get.width,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.select_check_color))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Profile_Text.fresher, style: TextStyle(fontSize: Get.width / 24)),
                                      GestureDetector(
                                        onTap: () => myProfile.Freshers_fun(),
                                        child: SwitchTheme(
                                          data: SwitchThemeData(
                                            thumbColor: MaterialStateProperty.resolveWith((states) {
                                              if (states.contains(MaterialState.selected)) {return AppColor.Button_color;}
                                              return AppColor.Button_color;
                                            }),
                                            trackColor: MaterialStateProperty.resolveWith((states) {
                                              if (states.contains(MaterialState.selected)) {return AppColor.Full_body_color;}
                                              return AppColor.Full_body_color;
                                            }),
                                            trackOutlineColor: MaterialStateProperty.all(AppColor.Button_color),
                                          ),
                                          child: Switch(
                                            materialTapTargetSize: MaterialTapTargetSize.padded,
                                            value: myProfile.fresher,
                                            onChanged: (val) => myProfile.Fresher_fun(val),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height / 50),
                                Visibility(
                                  visible: myProfile.fresher,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Profile_Text.Total_Experience, style: TextStyle(fontSize: Get.width / 24, color: AppColor.select_check_color)),
                                      //Company Name
                                      GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context, StateSetter inchange) {
                                                return AlertDialog(
                                                  backgroundColor: AppColor.Full_body_color,
                                                  content: Container(
                                                    height: Get.height / 3,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(color: AppColor.Full_body_color),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        // First NumberPicker (Start Year)
                                                        Column(
                                                          children: [
                                                            SizedBox(height: Get.height / 50),
                                                            Text(My_Profile_text.Year, style: TextStyle(fontSize: Get.width / 22)),
                                                            SizedBox(
                                                              width: Get.width / 3.04,
                                                              child: NumberPicker(
                                                                step: 1,
                                                                minValue: 1,
                                                                maxValue: 25,
                                                                itemHeight: Get.height / 12,
                                                                selectedTextStyle: TextStyle(color: AppColor.black_all, fontSize: Get.width / 20),
                                                                decoration: BoxDecoration(
                                                                  border: Border(top: BorderSide(color: AppColor.subcolor), bottom: BorderSide(color: AppColor.subcolor)),
                                                                ),
                                                                value: Address_hendals.experienceYearNotifier_start.value,
                                                                onChanged: (value) {
                                                                  inchange(() {
                                                                    Address_hendals.experienceYearNotifier_start.value = value;
                                                                    Address_hendals.Year(value);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Second NumberPicker (End Year)
                                                        Column(
                                                          children: [
                                                            SizedBox(height: Get.height / 50),
                                                            Text(My_Profile_text.month, style: TextStyle(fontSize: Get.width / 22)),
                                                            SizedBox(
                                                              width: Get.width / 3.04,
                                                              child: NumberPicker(
                                                                step: 1,
                                                                minValue: Address_hendals.experienceYearNotifier_start.value,
                                                                maxValue: 25,
                                                                itemHeight: Get.height / 12,
                                                                selectedTextStyle: TextStyle(color: AppColor.black_all, fontSize: Get.width / 20),
                                                                decoration: BoxDecoration(
                                                                  border: Border(
                                                                    top: BorderSide(color: AppColor.subcolor),
                                                                    bottom: BorderSide(color: AppColor.subcolor),
                                                                  ),
                                                                ),
                                                                value: Address_hendals.experienceYearNotifier_end.value,
                                                                onChanged: (value) {
                                                                  inchange(() {
                                                                    Address_hendals.experienceYearNotifier_end.value = value;
                                                                    Address_hendals.Month(value);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    OnButtons(
                                                      onTap: () => Get.back(),
                                                      Button_Color: AppColor.Button_color,
                                                      btn_name: 'Save',
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: Get.height / 20,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: AppColor.select_check_color)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                ValueListenableBuilder<int>(
                                                  valueListenable: Address_hendals.experienceYearNotifier_start,
                                                  builder: (BuildContext context, int startYear, Widget? child) {
                                                    return Text(Address_hendals.selectExperience_year.value ? '${startYear.toString()} Year' : EditProfile_text.Work_Experience,style: TextStyle(fontSize: Get.width/26));
                                                  },
                                                ),
                                                SizedBox(width: Get.width/50),
                                                ValueListenableBuilder<int>(
                                                  valueListenable: Address_hendals.experienceYearNotifier_end,
                                                  builder: (BuildContext context, int endYear, Widget? child) {
                                                    return Text(Address_hendals.selectExperience_month.value ? '${endYear.toString()} Month' : '',style: TextStyle(fontSize: Get.width/26));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                      SizedBox(height: Get.height / 30),

                                      Inputfild(
                                        labal: Profile_Text.Company_Name,
                                        hint: candidateData['CompanyName'],
                                        controller: Address_hendals.CompanyName_Controllers!,
                                        onTap: () => myProfile.P_Company_Name_fun(),
                                        onChanged: (val) => myProfile.Companys_names_validation(val),
                                      ),
                                      MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Companys_names),
                                      SizedBox(height: Get.height / 50),

                                      //Designation
                                      Inputfild(
                                        labal: Profile_Text.Designation,
                                        hint: candidateData['Designation'] ?? '',
                                        controller: Address_hendals.Designation_Controllers!,
                                        onTap: () => myProfile.P_Designation_fun(),
                                        onChanged: (val) {myProfile.Designations_validation(val);
                                        },
                                      ),
                                      MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Designations),
                                      SizedBox(height: Get.height / 50),

                                      //Duration
                                      Text(Profile_Text.Duration, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      SizedBox(height: Get.height / 50),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: Get.width / 2.5, child: DatePickerWidget(initialDate: DateTime.now(), onDateSelected: (DateTime selectedDate) {})),
                                          SizedBox(width: Get.width / 2.5, child: DatePickerWidget(initialDate: DateTime.now(), onDateSelected: (DateTime selectedDate) {}))
                                        ],
                                      ),
                                      SizedBox(height: Get.height / 50),

                                      //Chaek Boks
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: myProfile.I_currently_workhere,
                                                onChanged: (val) {myProfile.Work_Check(val);},
                                              ),
                                              Text(Profile_Text.I_currently_work_here, style: TextStyle(fontSize: Get.width / 24, color: AppColor.subcolor)),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: Get.height / 50),
                                      Text(Profile_Text.Add_Work_Experience, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600, color: AppColor.Button_color)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          //Salary
                          GestureDetector(
                            onTap: () => myProfile.Salary_fun(),
                            child: Info(
                              CircleAvatar_color: Change_Circle(Condition: Address_hendals.CurrentSalary_Controllers!.text.isNotEmpty && Address_hendals.CurrentExpented_Controllers!.text.isNotEmpty),
                              info: Profile_Text.Salarys,
                              dropicons: DropIcons(conditional_name: myProfile.Salary),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Salary,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 50),

                                //CTC
                                Inputfild(
                                  labal: Profile_Text.CTC,
                                  hint: candidateData['CurrentCTC'] ?? '',
                                  controller: Address_hendals.CurrentSalary_Controllers!,
                                  onTap: () {myProfile.CTC_Fun();},
                                  onChanged: (val) {myProfile.CTCs_Validation(val);},
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.CTCS),
                                SizedBox(height: Get.height / 50),

                                //Expected
                                Inputfild(
                                  labal: Profile_Text.Expected_Salary,
                                  hint: candidateData['ExpectedSalaryTo'] ?? '',
                                  controller: Address_hendals.CurrentExpented_Controllers!,
                                  onTap: () {myProfile.Expected_Fun();},
                                  onChanged: (val) {myProfile.Expected_Validation(val);},
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Expecteds),
                                SizedBox(height: Get.height / 50),
                              ],
                            ),
                          ),

                          //Work Location
                          GestureDetector(
                            onTap: () =>  myProfile.Work_Location_fun(),
                            child: Info(
                              CircleAvatar_color: Change_Circle(Condition: Address_hendals.NoticePeriod_Controllers!.text.isNotEmpty),
                              info: Profile_Text.Work_Location,
                              dropicons: DropIcons(conditional_name: myProfile.Work_Location),
                            ),
                          ),
                          Visibility(
                            visible: myProfile.Work_Location,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 50),

                                //CTC
                                Inputfild(
                                  labal: Profile_Text.Current_CTC_per_annum,
                                  hint: candidateData['CurrentCTC'],
                                  controller: Address_hendals.CurrentSalarywork_Controllers!,
                                  onTap: () => myProfile.P_CTC_Current_fun(),
                                  onChanged: (val) {myProfile.P_CTC_Currents_validation(val);},
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.P_CTC_Currents),
                                SizedBox(height: Get.height / 50),

                                //Preffered Working Location
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: Profile_Text.Preffered_Working_Location, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                Obx(() => GestureDetector(
                                  onTap: null,
                                  child: Container(
                                    width: Get.width, height: Get.height / 15,
                                    decoration: BoxDecoration(color: AppColor.Full_body_color, border: Border(bottom: BorderSide(color: AppColor.Textfild_color))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Get.height / 70),
                                        Text(Address_hendals.selectedProvince.value.isNotEmpty ? Address_hendals.selectedProvince.value['name'] : candidateData['ProvinceName'], style: TextStyle(fontSize: Get.width / 23)),
                                      ],
                                    ),
                                  ),
                                )),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Preffered_Workings),
                                SizedBox(height: Get.height / 50),

                                //Preffered Working Setup
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: Profile_Text.Preffered_Work_Setup, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Showdialog.showdialod(
                                      height: Get.height/2,
                                        context: context,
                                        colamWidget: SizedBox(
                                          height: Get.height/2,
                                            child: ListView.builder(
                                            itemCount: Address_hendals.JobType.jobtype_data['data'].length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return SizedBox(
                                                height: Get.height/20,
                                                child: GestureDetector(
                                                  onTap: () => Address_hendals.Work_Setups(index),
                                                  child: Text(textAlign: TextAlign.center, Address_hendals.JobType.jobtype_data['data'][index],style: TextStyle(fontSize: Get.width/25)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        hedingtext: Profile_Text.Preffered_Work_Setup,
                                        onTabs: () => Get.back(),
                                    );
                                  },
                                  child: Container(
                                    height: Get.height/15, width: Get.width,
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
                                    child: Obx(() => Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text((Address_hendals.WorkSetup_bool.value) ? Address_hendals.WorkSetup_pop_name.value : candidateData['CurrentlyWork'],style: TextStyle(fontSize: Get.width/25)),
                                      ],
                                    )),
                                  ),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.PPreffered_Work_Workings),
                                SizedBox(height: Get.height / 50),

                                //Job Type Preferrence
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: Profile_Text.Job_Type_Preferrence, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Get.width / 25, color: AppColor.subcolor)),
                                      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width / 22, color: AppColor.Error_color)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Showdialog.showdialod(
                                        context: context,
                                        colamWidget: SizedBox(
                                          height: Get.height/4,
                                          child: ListView.builder(
                                            itemCount: Address_hendals.Preferencet.Preferencetype_data['data'].length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return SizedBox(
                                                height: Get.height/20,
                                                child: GestureDetector(
                                                  onTap: () => Address_hendals.Job_Types(index),
                                                  child: Text(textAlign: TextAlign.center, Address_hendals.Preferencet.Preferencetype_data['data'][index],style: TextStyle(fontSize: Get.width/25)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        hedingtext: Profile_Text.Job_Type_Preferrence,
                                        onTabs: () => Get.back(),
                                    );
                                  },
                                  child: Container(
                                    height: Get.height/15, width: Get.width,
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.offButton_color))),
                                    child: Obx(() => Column(
                                      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text((Address_hendals.JobType_bool.value) ? Address_hendals.JobType_pop_name.value : candidateData['CurrentlyWork'],style: TextStyle(fontSize: Get.width/25)),
                                      ],
                                    )),
                                  )
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Job_Type_Preferrences),
                                SizedBox(height: Get.height / 50),

                                //Notice Period (days)(Optional)
                                Inputfild(
                                  labal: Profile_Text.Notice_Period_days_Optional,
                                  hint: candidateData['NoticePeriod'],
                                  controller: Address_hendals.NoticePeriod_Controllers!,
                                  onTap: () => myProfile.Notice_Period_fun(),
                                  onChanged: (val) => myProfile.Notice_Periods_validation(val),
                                ),
                                MyProfile_Error(throww: myProfile.onthrowError, Error: myProfile.Notice_Periods),
                                SizedBox(height: Get.height / 50),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: Get.height / 10),

                  //Buttons
                  OnButtons(onTap: () => Address_hendals.Sentdata(), Button_Color: AppColor.Button_color, btn_name: Profile_Text.Buttion_name),

                  SizedBox(height: Get.height / 30),
                ],
              ),
            );
          }
        }
      }),
    );
  }
}
