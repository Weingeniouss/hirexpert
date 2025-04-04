// ignore_for_file: invalid_use_of_protected_member, camel_case_types, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/SearchScreenController/SavingData_Controller.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_icon.dart';

class Searching_finding_screen extends StatefulWidget {
  const Searching_finding_screen({super.key});

  @override
  State<Searching_finding_screen> createState() => _Searching_finding_screenState();
}

class _Searching_finding_screenState extends State<Searching_finding_screen> {
  FindAPIController isfinding = Get.put(FindAPIController());

  @override
  void initState() {
    Future.microtask(() {
      isfinding.FindAPIController_Fuction(Timezone: 'asia/kolkata', JobId: '1', TechId: '12', IsWeb: 0, CandidateId: Candidate, Tokan: Tokans);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Save = Provider.of<FavouriteProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: SafeArea(
          child: Obx((){
            if(isfinding.isLoding.value){return Center(child: Lottie.asset(AppLoder.noData));}
            else{
              return ListView.builder(
            itemCount: (isfinding.Fidingdata.value?.length ?? 0) + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index >= isfinding.Fidingdata.value.length) {return Container();}
              var jobData = isfinding.Fidingdata.value[index];
              var isFavourite = isfinding.Fidingdata.value[index]['IsFavourite'] == "1";

              return Consumer<FavouriteProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return JobSearch(
                    Icon: jobData['ComLogo'],
                    Job_Tital: jobData['JobTitle'],
                    Language: jobData['TechName'],
                    Commpany: jobData['ComName'],
                    Working: jobData['WorkWeek'],
                    Location: jobData['Location'],
                    Job_time: jobData['JobType'],
                    Exp: jobData['Experience'],
                    lake: jobData['Salary'],
                    Hybrid: jobData['WorkSet'],
                    stats: jobData['FormatDt'],
                    JobID: jobData['JobId'],
                    saveonTap: () => Save.SavingData(jobData['JobId'], jobData),
                    savechild: (isFavourite)
                        ? SvgPicture.asset(AppIcons.bookmark, color: AppColor.Button_color)
                        : SvgPicture.asset(AppIcons.save, color: AppColor.Button_color),
                    top: BorderSide(color: AppColor.Bottam_color),
                    Sharebool: true,
                    Sharebool2: true,
                  );
                },
              );
            },
          );
            }

          }),
        ),
      ),
    );
  }
}
