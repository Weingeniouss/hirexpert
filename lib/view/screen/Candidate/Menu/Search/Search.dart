// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, must_be_immutable, invalid_use_of_protected_member, avoid_print, prefer_const_constructors_in_immutables, override_on_non_overriding_member, unused_import, deprecated_member_use, sort_child_properties_last, unrelated_type_equality_checks, avoid_unnecessary_containers

//Saveings.SavingData(jobData['JobId'], jobData);
//Saveings.isFavourite = jobData['IsFavourite'] == "1";

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Search/JobApplyController.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Search/Notification.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/message/Message.dart';
import 'package:hirexpert/view/screen/Employer/Menu/My_Job/Live_jobs/Job_ID.dart';
import 'package:hirexpert/view/utils/Loder/Loding.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/common/Popup/Candidate/Search_Job(Conatiner).dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Nofication_Controller.dart';
import '../../../../../controller/API_handler/Candidate/Menu/Home/Button_Apping_handler.dart';
import '../../../../../controller/API_handler/Candidate/Menu/Home/Sarching_Saving_API.dart';
import '../../../../../controller/API_handler/Candidate/Menu/Search/SarchHndaler_Conteroller.dart';
import '../../../../../controller/API_handler/Candidate/Notification_hendler.dart';
import '../../../../../controller/Save_Controller/Candidate_state/Menu/Search/State_Search.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/BottamController/MenuNavigationController.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/SearchScreenController/SavingData_Controller.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/SerachfindingController/SerachfindingController.dart';
import '../../../../utils/app_String.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/buttom/Candidate/candidate_buttom.dart';
import '../../../../utils/common/Buttons/wideButtons.dart';
import '../../../../utils/common/Icon/threedot.dart';
import '../../../../utils/common/List/jobSearch.dart';
import '../../../../utils/common/Tostification/Toastification_success.dart';
import 'Applied_NotApplied/Details_Search.dart';
import 'Search_location.dart';
import 'Searching.dart';

class Search extends StatefulWidget {

   Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    Paggnation.searchData ?? [];
    Paggnation.resetPagination();
    super.initState();
  }

  final SearchApiController Search = Get.put(SearchApiController());
  final SearchApiControllerPagination Paggnation  = Get.put(SearchApiControllerPagination());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final NotificationHendler Notification = Get.put(NotificationHendler());
  final Jobapplycontroller Jobapply = Get.put(Jobapplycontroller());
  final IsfavrationControllers isFavrationController = Get.put(IsfavrationControllers());
  final Serachfindingcontroller Serachfinding = Get.put(Serachfindingcontroller());

  ValueNotifier<Map<String, bool>> isFavouriteNotifier = ValueNotifier({});

  void toggleFavorite(String jobId, String techName) async {
   final currentStatus = isFavouriteNotifier.value[jobId] ?? false;
    final newIsLike = currentStatus ? "0" : "1";
    // Update local state immediately
    isFavouriteNotifier.value = {...isFavouriteNotifier.value, jobId: !currentStatus,};
    try {
     await isFavrationController.IsfavrationControllers_fuction(CandidateId: Candidate, JobId: jobId, IsLike: newIsLike, Tokan: Tokans);
      // Update the actual data source if needed
      final jobIndex = Paggnation.searchData.indexWhere((j) => j['JobId'].toString() == jobId);
      if (jobIndex != -1) {
        Paggnation.searchData[jobIndex]['IsFavourite'] = newIsLike;
       }
     ToastificationSuccess.Success(newIsLike == "1" ? '$techName is Saved Successfully' : '$techName is Removed Successfully');
    } catch (e) {
      // Revert on error
     isFavouriteNotifier.value = {...isFavouriteNotifier.value, jobId: currentStatus};
     ToastificationError.Error('Failed to update favorite status');
   }
  }


  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<MenuNavigationController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, surfaceTintColor: Colors.transparent, elevation: 0, automaticallyImplyLeading: false,
        title: Obx(() {
          if (Paggnation.isLoading.value) {return SizedBox();}
          else if(Paggnation.searchData.isEmpty){return SizedBox();}
          else {return Text(Search_text.Search_Jobs, style: TextStyle(fontWeight: FontWeight.w700));}
        }),
        actions: [

          // Search Button
          Obx(() {
            if (Paggnation.isLoading.value) {return SizedBox();}
            else {
              return GestureDetector(
                onTap: () {
                    setState(() => Get.to(() => Search_location()));
                    Serachfinding.isfinding.refrsingpage(context);
                  },
                child: Icon(Icons.search, color: AppColor.subcolor, size: 30)
              );
            }
          }), SizedBox(width: Get.width / 50),

          // Notification Button
          Obx(() {
            if (Paggnation.isLoading.value) {
              return SizedBox();
            } else {
              return Stack(
                children: [
                  GestureDetector(onTap: () => Get.to(() => Notification_Screen()), child: Icon(Icons.notifications_none, color: AppColor.subcolor, size: 30)),
                  if (!(Notification.Notification.isloding.value || Notification.Notification.Noficationdata['data'] == null))
                    Positioned(
                      left: 13, bottom: 13,
                      child: CircleAvatar(
                        child: Text(Notification.Notification.Noficationdata['unseen'].toString(), style: TextStyle(fontSize: Get.width / 40,color: AppColor.Full_body_color)),
                        radius: 8, backgroundColor: AppColor.Notification_Color,
                      ),
                    ),
                ],
              );
            }
          }), SizedBox(width: Get.width / 50),

          // Popup Menu
          Obx(() {
            if (Paggnation.isLoading.value) {return SizedBox();}
            else {
              return PopupMenuButton(
                color: AppColor.Full_body_color, onSelected: (value) => print(value),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(value: 1, child: Text('All')),
                  PopupMenuItem(value: 2, child: Text('Last 7 Days')),
                  PopupMenuItem(value: 3, child: Text('Last 30 Days')),
                  PopupMenuItem(value: 4, child: Text('Last 6 Months')),
                  PopupMenuItem(value: 5, child: Text('Last 1 Year')),
                ],
                child: Icon(Icons.more_vert, color: AppColor.subcolor, size: 30),
              );
            }
          }),
          SizedBox(width: Get.width / 50),
        ],
      ),
      body: Container(
        height: Get.height, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Obx(() {
          if (Paggnation.searchData.isEmpty && Paggnation.isLoading.value) {AppLodings.showLoadingDialog();}
          else {if (Get.isDialogOpen == true) {Get.back();}}
          if (Paggnation.searchData.isEmpty) {return Center(child: Lottie.asset(AppLoder.noData));}
          if (isFavouriteNotifier.value.isEmpty)
          {
            final initialFavorites = <String, bool>{};
            for (var job in Paggnation.searchData)
            {
              final jobId = job['JobId'].toString(); initialFavorites[jobId] = job['IsFavourite'] == "1";
            }
            isFavouriteNotifier.value = initialFavorites;
          }

          return RefreshIndicator(
            color: AppColor.Button_color,
            backgroundColor: AppColor.Full_body_color,
            onRefresh: () => Paggnation.resetPagination(),
            child: ListView.builder(
                  controller : Paggnation.scrollController,
                  itemCount: (Paggnation.searchData.length ?? 0) + 1,
                  itemBuilder: (BuildContext context, int index) {

                    if (index == Paggnation.searchData.length) {
                        return Paggnation.hasMoreData.value
                          ? Padding(padding: const EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)))
                          : Center(child: Text('No More Data'));
                    }

                    var jobData = Paggnation.searchData[index];
                    bool isFavourite = (jobData['IsFavourite']?.toString() ?? "0") == "1";
                    var Jobbing = Paggnation.searchData[index]['JobId'];

                    return JobSearch(
                      onTap: () async{
                       await isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate);
                        Get.to(() => Details(
                          JobID: Jobbing ?? '', Icon: jobData['ComLogo'] , Job_Tital:jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'], Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'],
                          saveonTap: () {
                            setState(() {
                                toggleFavorite(Jobbing, jobData['TechName']);
                            });
                          },
                          saving: ValueListenableBuilder<Map<String, bool>>(
                              valueListenable: isFavouriteNotifier,
                                builder: (context, favMap, child) {
                                   bool isFav = favMap[Jobbing] ?? false;
                                return SvgPicture.asset(isFav ? AppIcons.bookmark : AppIcons.save, color: AppColor.Button_color);
                            },
                          ),
                          Share: Column(
                            children: [
                              SizedBox(height: Get.height / 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Search_text.Share,style: TextStyle(fontWeight: FontWeight.w600,fontSize: Get.width / 27)), SizedBox(width: Get.width / 20),
                                  icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1,iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter),icons(iconss: AppIcons.email)
                                ],
                              ),
                            ],
                          ),
                          bottomNavigationBar: (isApply.isApplingdata['data']['IsApply'] == '1')
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.all(20), child: OnButtons(onTap: ()
                                     async{
                                    try{
                                      Jobapply.isLoding.value == true;
                                      await Jobapply.Jobapplycontroller_Fuction(Tokan: Tokans, CandidateId: Candidate, JobId: Jobbing, CompanyId: isApply.isApplingdata['data']['CompanyId']);
                                      if(Jobapply.JobapplyData['data']['status'] == true){
                                        ToastificationSuccess.Success(Jobapply.JobapplyData['message']);
                                      }
                                    }
                                    catch(e){
                                      print('$e');
                                      ToastificationError.Error('$e');
                                    }
                                    finally{
                                      Jobapply.isLoding.value == true;
                                      ToastificationSuccess.Success(Jobapply.JobapplyData['message']);
                                    }

                                  }, width_r: Get.width / 2.5, Button_Color: AppColor.SuessColor_Color, btn_name: Details_texts.Applied, Boder_Button_Color: AppColor.SuessColor_Color)),
                                   Consumer<MenuNavigationController>(builder: (BuildContext context, value, Widget? child) {
                                      return GestureDetector(
                                          onTap: () {
                                              Get.offAll(() => Candidate_Bottam());
                                              nav.SelectIndex_five();
                                            },
                                          child: Padding(padding: EdgeInsets.all(20), child: OnButtons(width_r: Get.width / 2.5, Button_Color: AppColor.Button_color, btn_name: Details_texts.Message, Boder_Button_Color: AppColor.Button_color)));
                                    }),
                                ],
                              )
                              : Padding(
                                padding: EdgeInsets.all(20),
                                child: OnButtons(
                                  onTap: () async{
                                    try{
                                      Jobapply.isLoding.value == true;
                                      await Jobapply.Jobapplycontroller_Fuction(Tokan: Tokans, CandidateId: Candidate, JobId: Jobbing, CompanyId: isApply.isApplingdata['data']['CompanyId']);
                                      if(Jobapply.JobapplyData['data']['status'] == true){
                                        ToastificationSuccess.Success(Jobapply.JobapplyData['message']);
                                      }
                                    }
                                    catch(e){
                                      print('$e');
                                      ToastificationError.Error('$e');
                                    }
                                    finally{
                                      Jobapply.isLoding.value == true;
                                      ToastificationSuccess.Success(Jobapply.JobapplyData['message']);
                                    }
                              },
                                  Button_Color: AppColor.Button_color, btn_name: Details_texts.Apply_Now,
                               ),
                             )
                           ),
                        );
                         print({
                           Details(
                             // JobID: Search.Search_data['data'][index]['JobId'],
                           )
                         });
                        },
                      Icon: jobData['ComLogo'], Job_Tital: jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'],Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'], JobID: Jobbing ?? '',
                      saveonTap: () {
                            setState(() {
                                toggleFavorite(Jobbing, jobData['TechName']);
                              });
                            },
                             savechild: ValueListenableBuilder<Map<String, bool>>(
                              valueListenable: isFavouriteNotifier,
                              builder: (context, favMap, child) {
                              bool isFav = favMap[Jobbing] ?? false;
                              return SvgPicture.asset(
                                isFav ? AppIcons.bookmark : AppIcons.save,
                                color: AppColor.Button_color,
                              );
                            },
                          ),
                      top: BorderSide(color: AppColor.Bottam_color),
                      Sharebool: true, Sharebool2: true,
                    );
                  },
                ),
          );
        }
        ),
      ),
    );
  }
}

// Save.SavingData(Sarching.stateSearchController.Searchings.Search.Search_data['data'][index]['JobId'], jobData)