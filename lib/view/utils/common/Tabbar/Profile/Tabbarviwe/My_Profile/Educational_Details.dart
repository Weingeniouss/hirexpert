// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/modal/Dropdowns/drops.dart';
import 'package:hirexpert/view/utils/common/Textfild/Inputfild.dart';
import 'package:provider/provider.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/CircleAvatar_Color/(My_Profile)Circle_color.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/Navi_Icons/(My_Profile)_Navi_Icons.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/Logic_Conroller/Screen_Logic/Profile_Logic/My_Profile_Logic(Tabbar)/Pass_Error/(My_Profile)_Pass_Error.dart';
import '../../../../../../../controller/User_Controller/Candidate_Controller/MY_ProfileController/My_ProfileController.dart';
import '../../../../../app_String.dart';
import '../../../../../app_color.dart';
import '../../../../Container/profile_Info.dart';
import '../../../../Selection/Information_Selection.dart';

class Educational_Details extends StatelessWidget {
  const Educational_Details({super.key});

  @override
  Widget build(BuildContext context) {
    final myProfile = Provider.of<My_ProfileController>(
      context,
      listen: false,
    );
    return Consumer<My_ProfileController>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                myProfile.Education_Details_fun();
              },
              child: Info(
                CircleAvatar_color: Change_Circle(
                    Condition: myProfile.P_Degree == 0 &&
                        myProfile.P_Specialisation == 1 &&
                        myProfile.P_Instiute_name == 2 &&
                        myProfile.P_Passing_Year == 3),
                info: Profile_Text.Educational_Detailss,
                dropicons: DropIcons(
                  conditional_name: myProfile.Education_Details,
                ),
              ),
            ),
            Visibility(
              visible: myProfile.Education_Details,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 50),

                  //Degree
                  Inputfild(
                    labal: EditProfile_text.Degree,
                    hint: Profile_Text.Degree,
                    controller: myProfile.Degree,
                    onTap: () {
                      myProfile.P_Degree_fun();
                    },
                    onChanged: (val) {
                      myProfile.Degree_validation(val);
                    },
                  ),
                  MyProfile_Error(
                    throww: myProfile.onthrowError,
                    Error: myProfile.Degrees,
                  ),
                  SizedBox(height: Get.height / 50),

                  //Specialisation
                  Inputfild(
                    labal: EditProfile_text.Specialisation,
                    hint: Profile_Text.Specialisation,
                    controller: myProfile.Specialisation,
                    onTap: () {
                      myProfile.P_Specialisation_fun();
                    },
                    onChanged: (val) {
                      myProfile.Specialisation_validation(val);
                    },
                  ),
                  MyProfile_Error(
                    throww: myProfile.onthrowError,
                    Error: myProfile.Specialisations,
                  ),
                  SizedBox(height: Get.height / 50),

                  //Institute Name
                  Inputfild(
                    labal: EditProfile_text.Institute_Name,
                    hint: Profile_Text.Institute_Name,
                    controller: myProfile.Institute_Name,
                    onTap: () {
                      myProfile.P_Instiute_name_fun();
                    },
                    onChanged: (val) {
                      myProfile.Institute_name_validation(val);
                    },
                  ),
                  MyProfile_Error(
                    throww: myProfile.onthrowError,
                    Error: myProfile.Institute_names,
                  ),
                  SizedBox(height: Get.height / 50),

                  //Passing Year
                  Infromation_Selection(
                    name: EditProfile_text.Passing_Yea,
                    Hadline: Profile_Text.Select_City,
                    Selectedtext: myProfile.selectedYear,
                    children: List.generate(
                      Years.length,
                      (index) => Text(
                        Years[index],
                        style: TextStyle(
                          fontSize: Get.width / 20,
                        ),
                      ),
                    ),
                    onSelectedItemChanged: (int index) {
                      myProfile.onSelectedItemChanged(index);
                    },
                    SelectonTap_Button: () {
                      myProfile.P_Passing_Year_fun();
                      Get.back();
                    },
                  ),
                  SizedBox(height: Get.height / 50),

                  //Add Education Details
                  Text(
                    Profile_Text.Add_Educational_Details,
                    style: TextStyle(
                      fontSize: Get.width / 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.Button_color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
