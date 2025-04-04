
// ignore_for_file: non_constant_identifier_names, unnecessary_import, avoid_print, unused_import, deprecated_member_use, must_be_immutable, unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/Interviwe_Stats_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/JobRecommendations.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/Job_Application.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/Profile_Analytics_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/SaveJob_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/Setprivateaccount.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/upcomingInterview.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Dashbord/uploadResume.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Dashboard/DashBord_Handler.dart';
import 'package:hirexpert/controller/User_Controller/Candidate_Controller/DashbordController/DashBoardController.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Home/Interviwe/Show_Interview.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Home/saving/saved.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../../../../controller/API_Controller/Candidate/Dashbord/candidateProfileCalculate_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/BottamController/MenuNavigationController.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/Profile_Info_Controller/Profile_Controller/Pick_Image_Controller.dart';
import '../../../../utils/Loder/Loding.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../utils/common/List/Saved.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0.0);

  CandidateprofilecalculateController Candidateprofilecalculate = Get.put(CandidateprofilecalculateController());
  DashBoardController Dash = Get.put(DashBoardController());
  DashBord_Handler Dash_handler = Get.put(DashBord_Handler());

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateProgress();
  }

  Future<void> fetchDataAndUpdateProgress() async {
    try {
      log('Fetching Candidateprofilecalculate data...');
      await Candidateprofilecalculate.CandidateprofilecalculateFuction(Tokan: Tokans, CandidateId: Candidate, Timezone: 'asia/kolkata');
      var data = Candidateprofilecalculate.Candidateprofilecalculatedata['data'];
      log('Candidateprofilecalculate data received: $data');
      int progressValue = (data is int) ? data : int.tryParse(data.toString()) ?? 0;
      setState(() {progressNotifier.value = progressValue.toDouble();});
    } catch (e) {
      log('Error fetching progress: $e');
      setState(() {progressNotifier.value = 0.0;});
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<MenuNavigationController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
            child: Obx(() {
              if (Dash_handler.Interviwe_Status.isLoding.value) {
                AppLodings.showLoadingDialog();
              } else {
                if (Get.isDialogOpen == true) {
                  Get.back();
                }
              }
              if (Dash_handler.Analytics.ProfileAnalyicsData == null || Dash_handler.Analytics.ProfileAnalyicsData['data'] == null) {
                return Center(child: Lottie.asset(AppLoder.noData));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height / 40), Text(Dashboard_text.Candidate_flow, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w800)), SizedBox(height: Get.height / 40),

                      //Candidate Dashboard Container Start
                      Container(
                        height: Get.height / 3, width: Get.width,
                        decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 55)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: Get.width / 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Dashboard_text.Profile_Overview, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                              Divider(color: AppColor.offButton_color),
                              SizedBox(height: Get.height / 90),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      //Profile Photo Start
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(width: 110, height: 130, child: SimpleCircularProgressBar(startAngle: -180, progressStrokeWidth: 7, backStrokeWidth: 7, progressColors: [Colors.green], backColor: Colors.grey[200]!, valueNotifier: progressNotifier)),
                                            CircleAvatar(
                                              backgroundColor: AppColor.Full_body_color,
                                              radius: 40,
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage: (Dash_handler.PickImage.image != null)
                                                    ? FileImage(Dash_handler.PickImage.image!)
                                                    : (Dash_handler.Candidatedetails.Candidatedetails_data?['data'] != null && Dash_handler.Candidatedetails.Candidatedetails_data['data']!['Profile'] != null)
                                                        ? NetworkImage(Dash_handler.Candidatedetails.Candidatedetails_data['data']!['Profile'])
                                                        : AssetImage('assets/default_profile.png') as ImageProvider,
                                                child: (Dash_handler.Candidatedetails.Candidatedetails_data?['data'] == null || Dash_handler.Candidatedetails.Candidatedetails_data?['data']!['Profile'] == null)
                                                    ? Icon(Icons.person, size: 30) : null,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -3, child: ValueListenableBuilder<double>(
                                                valueListenable: progressNotifier,
                                                builder: (context, value, _) {
                                                  return Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                                                    decoration: BoxDecoration(color: AppColor.Full_body_color, borderRadius: BorderRadius.circular(10)),
                                                    child: Text("${value.toInt()}%", style: TextStyle(color: AppColor.success_color, fontWeight: FontWeight.bold, fontSize: Get.width / 28,)),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // //Profile Photo Over

                                      SizedBox(width: Get.width / 30),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(Dash_handler.Candidatedetails.Candidatedetails_data?['data']?['FirstName']! ?? 'FirstName', style: TextStyle(fontSize: Get.width / 25)),
                                              Text(Dash_handler.Candidatedetails.Candidatedetails_data?['data']?['LastName']! ?? 'LastName', style: TextStyle(fontSize: Get.width / 25)),
                                            ],
                                          ),
                                          Text(Dash_handler.Candidatedetails.Candidatedetails_data?['data']?['TechName'] ?? 'TechName', style: TextStyle(color: AppColor.subcolor)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //Profile Photos Button
                                  // GestureDetector(onTap: () => Dash_handler.PickImage.pickImage(), child: CircleAvatar(radius: 20, backgroundColor: AppColor.Notification_Color, child: SvgPicture.asset(AppIcons.Edit))),
                                  Consumer<MenuNavigationController>(builder: (BuildContext context, value, Widget? child) {
                                    return GestureDetector(onTap: () => nav.SelectIndex_four(), child: CircleAvatar(radius: 20, backgroundColor: AppColor.Notification_Color, child: SvgPicture.asset(AppIcons.Edit)));
                                  }),
                                ],
                              ),
                              SizedBox(height: Get.height / 90),
                              Divider(color: AppColor.offButton_color),
                              SizedBox(height: Get.height / 90),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Dashboard_text.profile_visibility, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                  Transform.scale(
                                    scaleX: 0.7,
                                    scaleY: 0.6,
                                    child: Switch(
                                      inactiveTrackColor: AppColor.offButton_color,
                                      value: Dash.profile_Visibility.value,
                                      onChanged: (value) => Dash.SwichButton(value),
                                      activeColor: AppColor.Button_color,
                                      activeTrackColor: AppColor.Button_color,
                                      thumbColor: MaterialStatePropertyAll(AppColor.Full_body_color),
                                      trackOutlineColor: WidgetStatePropertyAll(Dash.profile_Visibility.value ? AppColor.Button_color : AppColor.offButton_color),
                                      trackOutlineWidth: WidgetStatePropertyAll(Get.width / 60),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Candidate Dashboard Container Ovar

                      //Upload Resume Start
                      SizedBox(height: Get.height / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Dashboard_text.Upload_Resume, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => Dash.selectAndUploadResume(),
                            child: Container(
                              height: Get.height / 20, width: Get.width / 3.1,
                              decoration: BoxDecoration(color: AppColor.Button_color, borderRadius: BorderRadius.circular(Get.width / 33)),
                              child: Center(child: Text(Dashboard_text.Browse, style: TextStyle(color: AppColor.Full_body_color))),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Get.height / 50),
                      Divider(color: AppColor.offButton_color),
                      SizedBox(height: Get.height / 100),
                      //Upload Resume Ovaer

                      //Job Recommendations Start
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Dashboard_text.Job_Recommendations, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                          // Text(Dashboard_text.Viwe_All, style: TextStyle(fontSize: Get.width / 25, color: AppColor.Error_color, decoration: TextDecoration.underline)),
                        ],
                      ),
                      SizedBox(height: Get.height / 50),
                      (Dash_handler.Recomendation.JobRecommendationsData?['data'] == null || Dash_handler.Recomendation.JobRecommendationsData == null) ? SizedBox() : CarouselSlider.builder(
                        itemCount: Dash_handler.Recomendation.JobRecommendationsData?['data'].length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return Container(
                            height: Get.height / 5, width: Get.width / 1.4,
                            padding: EdgeInsets.symmetric(vertical: Get.height / 80, horizontal: Get.width / 20),
                            margin: EdgeInsets.only(right: Get.width / 50),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 45), border: Border.all(color: AppColor.offButton_color)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.JobApp), SizedBox(height: Get.height / 50),
                                Text(Dash_handler.Recomendation.JobRecommendationsData?['data']['TechName'], style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w600)), SizedBox(height: Get.height / 130),
                                Text(Dash_handler.Recomendation.JobRecommendationsData?['data']['ComName'], style: TextStyle(fontSize: Get.width / 28)),
                                Text('Salary Range : ${Dash_handler.Recomendation.JobRecommendationsData?['data']['Salary']}', style: TextStyle(fontSize: Get.width / 28, color: AppColor.subcolor)),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(autoPlay: false, viewportFraction: 0.8, initialPage: 0, enableInfiniteScroll: false, padEnds: false),
                      ),
                      SizedBox(height: Get.height / 150),
                      //Job Recommendations Over

                      //Upcoming Interviews Start
                      SizedBox(height: Get.height / 60),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 55), border: Border.all(color: AppColor.offButton_color)),
                        child: Padding(
                          padding: EdgeInsets.all(Get.width / 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height / 80),
                              Row(
                                children: [
                                  SizedBox(width: Get.width / 28),
                                  Text(Dashboard_text.Upcoming_Interviews, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: Get.height / 80),
                              Divider(color: AppColor.offButton_color),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data']?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['JobTitle'], style: TextStyle(fontWeight: FontWeight.w600)),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Company : ${Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['ComName']}'),
                                            Row(
                                              children: [
                                                Text('${Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['OptionList'][5]['LabelName']} : ${Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['OptionList'][5]['Answer']}'),
                                                SizedBox(width: Get.width / 50),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Time : ${Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['InterviewDate']}'),
                                                SizedBox(width: Get.width / 50),
                                                Text('|'),
                                                SizedBox(width: Get.width / 50),
                                                Text(Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['InterviewTime']),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: AppColor.offButton_color),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: Get.height / 50),
                              GestureDetector(
                                onTap: () => Get.to(() => Show_Interviwe(), duration: Duration(milliseconds: 300), transition: Transition.leftToRight, curve: Curves.easeInExpo),
                                child: OnButtons(height_R: Get.height / 25, btn_name: Dashboard_text.Manage_Interview, Button_Color: AppColor.Button_color),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Upcoming Interviews Over
                      SizedBox(height: Get.height / 50),

                      //Job Applications Start
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Dashboard_text.Job_Applications, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                          // Text(Dashboard_text.Viwe_All, style: TextStyle(fontSize: Get.width / 25, color: AppColor.Error_color, decoration: TextDecoration.underline)),
                        ],
                      ),
                      SizedBox(height: Get.height / 50),
                      CarouselSlider.builder(
                        itemCount: Dash_handler.Job_Application.JobApplicationData?['data']?.length ?? 0,
                        itemBuilder: (BuildContext context, int index, int realIndex) {

                          if (Dash_handler.Job_Application.JobApplicationData?['data'] == null || Dash_handler.Job_Application.JobApplicationData['data'].length <= index) {return Center(child: Lottie.asset(AppLoder.noData));}
                          final jobData = Dash_handler.Job_Application.JobApplicationData['data'][index];

                          return Container(
                            height: Get.height / 5, width: Get.width / 1.4,
                            padding: EdgeInsets.symmetric(vertical: Get.height / 80, horizontal: Get.width / 20),
                            margin: EdgeInsets.only(right: Get.width / 50),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 45), border: Border.all(color: AppColor.offButton_color)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(AppIcons.JobApp),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                              (jobData['CurrentStatus'] == 'Second Interview') ? AppColor.Activebutton_Color :
                                              (jobData['CurrentStatus'] == 'Hired') ?  AppColor.Blue_Color:
                                              (jobData['CurrentStatus'] == 'Offers') ? AppColor.SuessColor_Color :
                                              (jobData['CurrentStatus'] == 'Not Action Perform') ? AppColor.Yellaow_Color :
                                              (jobData['CurrentStatus'] == 'First Interview') ? AppColor.Yellaow_Color_2 :
                                              (jobData['CurrentStatus'] == 'Declined') ? AppColor.orangeLight : AppColor.subcolor,
                                              borderRadius: BorderRadiusDirectional.circular(Get.width / 60),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: Get.height / 50, vertical: Get.width / 100),
                                          child: Text(jobData['CurrentStatus'], style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w600,color: AppColor.Full_body_color)),
                                        ),
                                        SizedBox(height: Get.height / 20),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height / 50),
                                Text(jobData['TechName'] ?? 'Tech Name Not Available', style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w600)),
                                SizedBox(height: Get.height / 130),
                                Text(jobData['ComName'] ?? 'Company Name Not Available', style: TextStyle(fontSize: Get.width / 28)),
                                Text('Date Applied : ${jobData['ApplyDate']}', style: TextStyle(fontSize: Get.width / 28, color: AppColor.subcolor)),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(autoPlay: false, viewportFraction: 0.8, initialPage: 0, enableInfiniteScroll: false, padEnds: false),
                      ),
                      SizedBox(height: Get.height / 150),
                      //Job Applications Over

                      //Saved Job Start
                      SizedBox(height: Get.height / 60),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 55), border: Border.all(color: AppColor.offButton_color)),
                        child: Padding(
                          padding: EdgeInsets.all(Get.width / 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height / 80),
                              Row(
                                children: [
                                  SizedBox(width: Get.width / 28),
                                  Text(Dashboard_text.SaveJob, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: Get.height / 80),
                              Divider(color: AppColor.offButton_color),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Dash_handler.SaveJob.SaveJobData?['data']?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  final upcomingDataAvailable = index < Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'].length;
                                  final optionListAvailable = upcomingDataAvailable && Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['OptionList'] != null && Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['OptionList'].length > 3;
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(Dash_handler.SaveJob.SaveJobData?['data'][index]['JobTitle'], style: TextStyle(fontWeight: FontWeight.w600)),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Company : ${Dash_handler.SaveJob.SaveJobData?['data'][index]['ComName']}'), SizedBox(width: Get.width / 50),
                                              ],
                                            ),
                                            Text('Location : ${Dash_handler.SaveJob.SaveJobData?['data'][index]['Location']}'), SizedBox(width: Get.width / 50),
                                            Row(
                                              children: [
                                                Text(optionListAvailable ? 'Salary Range : ${Dash_handler.UpcomingInterviwe.UpcomingInterviwedata?['data'][index]['Salary']}' : 'Data not available'),
                                                SizedBox(width: Get.width / 50),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: AppColor.offButton_color),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: Get.height / 50),
                              GestureDetector(
                                onTap: () => Get.to(() => Saved(), duration: Duration(milliseconds: 300), transition: Transition.leftToRight, curve: Curves.easeInExpo),
                                child: OnButtons(height_R: Get.height / 25, btn_name: Dashboard_text.View_All_Saved_Jobs, Button_Color: AppColor.Button_color),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      //Saved Job Over

                      //Chart Start
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Get.width / 50,vertical: Get.width /50),
                        decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 55)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height / 80), Padding(padding: EdgeInsets.symmetric(horizontal: Get.width / 15), child: Text(Dashboard_text.Analytics, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600))), SizedBox(height: Get.height / 80),
                            Divider(color: AppColor.offButton_color),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width / 90,vertical: Get.height / 80),
                              child: SizedBox(
                                height: Get.height / 2.3, width: Get.width,
                                child: AspectRatio(
                                  aspectRatio: 1.5,
                                  child: BarChart(
                                    BarChartData(
                                      maxY: 250, gridData: FlGridData(show: true,horizontalInterval: 50,verticalInterval: 1),
                                      borderData: FlBorderData(border: Border(left: BorderSide(color: Colors.grey, width: 1), bottom: BorderSide(color: Colors.grey, width: 1))),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          drawBelowEverything: true,
                                          sideTitles: SideTitles(
                                            interval: 50, showTitles: true, reservedSize: 40,
                                            getTitlesWidget: (double value, TitleMeta meta) {
                                              if (value % 50 == 0 && value >= 0 && value <= 300) {return Text(value.toInt().toString(), style: TextStyle(fontSize: Get.width / 28));}
                                              else {return const SizedBox();}
                                            },
                                          ),
                                        ),
                                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (double value, TitleMeta meta) {
                                              final index = value.toInt() - 1;
                                              if (index >= 0 && index < Dash_handler.Analytics.ProfileAnalyicsData['data'].length) {
                                                var monthData = Dash_handler.Analytics.ProfileAnalyicsData['data'][index];
                                                String? dateString = monthData['date'];
                                                if (dateString != null) {
                                                  DateTime? date = DateTime.tryParse(dateString);
                                                  if (date != null) {
                                                    String formattedDate = DateFormat("dd \n MMM").format(date);
                                                    return Text(textAlign: TextAlign.center, formattedDate, style: TextStyle(fontSize: Get.width / 30));
                                                  }
                                                }
                                              }
                                              return Text('', style: TextStyle(fontSize: Get.width / 30));
                                            },
                                            reservedSize: 45, interval: 1,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: AppColor.Full_body_color,
                                      barGroups: List.generate(Dash_handler.Analytics.ProfileAnalyicsData['data'].length, (index) {
                                        var monthData = Dash_handler.Analytics.ProfileAnalyicsData['data'][index];
                                        var value = double.tryParse(monthData['date']?.toString() ?? '0') ?? 0.0;
                                        return BarChartGroupData(x: index + 1,
                                          barRods: [
                                            BarChartRodData(toY: value, color: AppColor.Button_color, width: Get.width / 15, borderRadius: BorderRadius.circular(Get.width / 80)),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Chart Over

                      SizedBox(height: Get.height / 50),

                      //InterviweStatus Start
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 55)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height / 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
                                  child: Text(Dashboard_text.Interview_Status, style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
                                  child: Container(
                                    width: Get.width / 3.3, height: Get.height / 20, padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 50)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
                                      child: DropdownButton<String>(
                                        isExpanded: true, dropdownColor: AppColor.Full_body_color, elevation: 2, value: Dash.selectedValue.string,
                                        hint: Text('Pending', style: TextStyle(color: AppColor.subcolor)),
                                        underline: SizedBox(),
                                        icon: SvgPicture.asset(AppIcons.down, color: AppColor.subcolor),
                                        borderRadius: BorderRadius.circular(Get.width / 50),
                                        items: Dash.items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item, child: Text(item, style: TextStyle(color: AppColor.subcolor)),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) => Dash.DropDownButton(newValue),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height / 80),
                            Divider(color: AppColor.offButton_color),

                            // ✅ Show only "Pending" status data
                            (Dash.selectedValue.string == 'Pending')
                                ? Padding(
                                    padding: EdgeInsets.all(10),
                                    child: (Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'] == null)
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Pending').length,
                                            itemBuilder: (BuildContext context, int index) {
                                              var pendingData = Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Pending').toList()[index];

                                              return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(pendingData['TechName'], style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600),),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Company : ${pendingData['ComName']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Location : ${pendingData['Location']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Apply Date : ${pendingData['InterviewDate']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Current Status : ${pendingData['CurrentStatus']}', style: TextStyle(color: AppColor.subcolor)),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(color: AppColor.offButton_color),
                                                ],
                                              );
                                            },
                                          ),
                                  )
                                : SizedBox(),

                            (Dash.selectedValue.string == 'Accepted')
                                ? Padding(
                                    padding: EdgeInsets.all(10),
                                    child: (Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'] == null)
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Accepted').length,
                                            itemBuilder: (BuildContext context, int index) {
                                              var pendingData = Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Accepted').toList()[index];

                                              return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(pendingData['TechName'], style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600)),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Company : ${pendingData['ComName']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Location : ${pendingData['Location']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Apply Date : ${pendingData['InterviewDate']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Current Status : ${pendingData['CurrentStatus']}', style: TextStyle(color: AppColor.subcolor)),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(color: AppColor.offButton_color),
                                                ],
                                              );
                                            },
                                          ),
                                  )
                                : SizedBox(),

                            (Dash.selectedValue.string == 'Viewed')
                                ? Padding(
                                    padding: EdgeInsets.all(10),
                                    child: (Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'] == null)
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Viewed').length,
                                            itemBuilder: (BuildContext context, int index) {
                                              var pendingData = Dash_handler.Interviwe_Status.Interviwe_Statusdata?['data'].where((item) => item['CurrentStatus'] == 'Viewed').toList()[index];

                                              return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(pendingData['TechName'], style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w600)),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Company : ${pendingData['ComName']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Location : ${pendingData['Location']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Apply Date : ${pendingData['InterviewDate']}', style: TextStyle(color: AppColor.subcolor)),
                                                        Text('Current Status : ${pendingData['CurrentStatus']}', style: TextStyle(color: AppColor.subcolor)),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(color: AppColor.offButton_color),
                                                ],
                                              );
                                            },
                                          ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      //InterviweStarts Over

                      SizedBox(height: Get.height / 60),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
