// ignore_for_file: camel_case_types, non_constant_identifier_names, invalid_use_of_protected_member, deprecated_member_use, unused_import, duplicate_ignore, unnecessary_null_comparison, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/Archive_Controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Home/Sarching_Saving_API.dart';
import 'package:hirexpert/controller/API_handler/Candidate/Menu/Search/SarchHndaler_Conteroller.dart';

// ignore: unused_import
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:hirexpert/view/utils/common/List/jobSearch.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:lottie/lottie.dart';
import '../../../../controller/API_Controller/Candidate/Menu/Home/Favouritejob.dart';
import '../../../../controller/API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import '../../../../controller/API_Controller/Candidate/Menu/Home/jobcountsaccording.dart';
import '../../../../controller/API_handler/Candidate/Menu/Home/Button_Apping_handler.dart';
import '../../../screen/Candidate/Menu/Home/saving/Details_Saving.dart';
import '../../../screen/Candidate/Menu/Search/Applied_NotApplied/Details_Search.dart';
import '../../Loder/Loding.dart';
import '../../app_String.dart';
import '../../app_color.dart';
import '../../app_icon.dart';
import '../Icon/threedot.dart';

class Seved_List extends StatelessWidget {
  Seved_List({super.key});

  final Favouritejob favourlist = Get.put(Favouritejob());
  final Jobcountsaccording jobcount = Get.put(Jobcountsaccording());
  final ArchiveController Archive = Get.put(ArchiveController());
  final IsapplingApiController isApply = Get.put(IsapplingApiController());
  final IsfavrationControllers isFavrationController = Get.put(IsfavrationControllers());

  RxMap<String, bool> isRemoving = <String, bool>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (favourlist.isloding.value) {AppLodings.showLoadingDialog();}
      else {if (Get.isDialogOpen == true) {Get.back();}}
      if (favourlist.data == null) {return Center(child: Lottie.asset(AppLoder.noData));}
      else {
        return Container(
          height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true, itemCount: favourlist.data.length + 1,
            controller: favourlist.scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index == favourlist.data.length) {
                if (favourlist.data.length > 10 && favourlist.hasMore.value) {
                  return Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator(color: AppColor.Button_color)));
                } else {
                  return Center(child: Text('', style: TextStyle(color: Colors.grey)));
                }
              }
              var jobbing = favourlist.data[index]['JobId'];
              return JobSearch(
                onTap: () {
                  isApply.IsApplingAPIController_fuction(JobId: jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate)
                      .then((_) {
                        Get.to(() => Details(
                          bottomNavigationBar: SizedBox(),
                          Icon: favourlist.data[index]['ComLogo'], JobID: jobbing, Job_Tital: favourlist.data[index]['JobTitle'], Language: favourlist.data[index]['TechName'], Commpany: favourlist.data[index]['ComName'], Working: favourlist.data[index]['WorkWeek'], Location: favourlist.data[index]['Location'], Job_time: favourlist.data[index]['JobType'], Exp: favourlist.data[index]['Experience'], lake: favourlist.data[index]['Salary'], Hybrid: favourlist.data[index]['WorkSet'], stats: favourlist.data[index]['FormatDt'],
                          saveonTap: () => SvgPicture.asset(AppIcons.bookmark, color: AppColor.Button_color), save: true,
                          Share: Column(
                            children: [
                              SizedBox(height: Get.height / 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)),
                                  SizedBox(width: Get.width / 20),
                                  icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                                ],
                              ),
                            ],
                          ),
                          saving: SizedBox(),
                        ));
                  });
                },
                JobID: jobbing, Icon: favourlist.data[index]['ComLogo'], Job_Tital: favourlist.data[index]['JobTitle'], Language: favourlist.data[index]['TechName'], Commpany: favourlist.data[index]['ComName'], Working: favourlist.data[index]['WorkWeek'], Location: favourlist.data[index]['Location'], Job_time: favourlist.data[index]['JobType'], Exp: favourlist.data[index]['Experience'], lake: favourlist.data[index]['Salary'], Hybrid: favourlist.data[index]['WorkSet'], stats: favourlist.data[index]['FormatDt'],
                savechild: GestureDetector(
                  onTap: () async {
                    try {
                      isRemoving[jobbing] = true;
                      AppLodings.showLoadingDialog();
                      await isFavrationController.IsfavrationControllers_fuction(Tokan: Tokans, IsLike: '0', JobId: jobbing, CandidateId: Candidate);
                      ToastificationSuccess.Success('${favourlist.data[index]['TechName']} removed from favorites');
                      favourlist.data.removeWhere((item) => item['JobId'] == jobbing);
                      favourlist.data.refresh();
                      jobcount.data.refresh();
                      jobcount.Jobcountsaccording_fuction(CandidateId: Candidate , Tokan: Tokans);
                      await favourlist.Favouritejob_fuction();
                      if (Get.isDialogOpen!) Get.back();
                    } catch (e) {
                      if (Get.isDialogOpen!) Get.back();
                      favourlist.Favouritejob_fuction();
                    } finally {
                      isRemoving[jobbing] = false;
                    }
                  },
                  child: Obx(() => isRemoving[jobbing] == true ? SvgPicture.asset(AppIcons.save, color: AppColor.Button_color) : SvgPicture.asset(AppIcons.bookmark, color: AppColor.Button_color)),
                ),
                top: BorderSide(color: AppColor.Bottam_color),
                bottam: BorderSide(color: AppColor.Bottam_color),
                Sharebool: true, Sharebool2: false,
                Threedot: PopupMenuButton(
                  elevation: 5,
                  color: AppColor.Full_body_color,
                  onSelected: (value) async {
                    if (value == 'Archive') {
                      if (Archive.isloding.value) {
                        Center(child: CircularProgressIndicator());
                      } else {
                        await Archive.ArchiveController_Fuction(CandidateId: Candidate, JobId: jobbing, IsLike: '1', Tokan: Tokans);
                        if (Archive.ArchiveControllerdata['status'] == true) {
                          ToastificationSuccess.Success(Archive.ArchiveControllerdata['message']);
                          Get.back();
                        } else {
                          ToastificationError.Error(Archive.ArchiveControllerdata['message']);
                        }
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(value: 'Archive', child: Text('Archive')),
                  ],
                  child: SvgPicture.asset(AppIcons.threedots, width: 20, height: 20),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
