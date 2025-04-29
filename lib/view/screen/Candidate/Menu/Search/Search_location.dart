// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, unnecessary_import, invalid_use_of_protected_member, deprecated_member_use, use_key_in_widget_constructors, unused_import, prefer_iterable_wheretype, duplicate_import, must_be_immutable, unrelated_type_equality_checks, override_on_non_overriding_member, annotate_overrides

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Location/jobtype_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Location/preferencetype_API_controller.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Pop_Collection/DegreeList_pop_Controller.dart';
import 'package:hirexpert/controller/API_Controller/countrylist_API.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Search/Search.dart';
import 'package:hirexpert/view/utils/common/Buttons/ShortButton.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/isAppling_API_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Search/SearchFilter_API_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../../../controller/API_handler/Candidate/Menu/Home/Button_Apping_handler.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/SearchScreenController/SavingData_Controller.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/SerachfindingController/SerachfindingController.dart';
import '../../../../../controller/User_Controller/Candidate_Controller/UserJob_Search_listing_Controller/User_Search_Controller.dart';
import '../../../../utils/app_String.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/app_icon.dart';
import '../../../../utils/app_loder.dart';
import '../../../../utils/common/Icon/threedot.dart';
import '../../../../utils/common/List/jobSearch.dart';
import '../../../../utils/common/Tostification/Toastification_error.dart';
import '../../../../utils/common/Tostification/Toastification_success.dart';
import 'Applied_NotApplied/Details_Search.dart';

  class Search_location extends StatefulWidget {
  @override
  State<Search_location> createState() => _Search_locationState();
}

class _Search_locationState extends State<Search_location> {
    @override
    final Serachfindingcontroller Serachfinding = Get.put(Serachfindingcontroller());
    final IsapplingApiController isApply = Get.put(IsapplingApiController());
    final GlobalController globalController = Get.find<GlobalController>();
    final GlobalofselectedExperienceController SectedExperience =Get.put(GlobalofselectedExperienceController());
    final SearchApiControllerPagination Paggnation  = Get.put(SearchApiControllerPagination());

    ValueNotifier<Map<String, bool>> isFavouriteNotifier = ValueNotifier({});

    Future SavePoint({required String JoID, required String Tecahname}) async{
      try {
        final currentStatus = isFavouriteNotifier.value[JoID] ?? false;
        final newState = Map<String, bool>.from(isFavouriteNotifier.value);
        newState[JoID] = !currentStatus;
        isFavouriteNotifier.value = newState;
        setState(() {
           Serachfinding.isfavication.IsfavrationControllers_fuction(CandidateId: Candidate, JobId: JoID, IsLike: newState[JoID]! ? "1" : "0", Tokan: Tokans);
        });
        ToastificationSuccess.Success(newState[JoID]! ? '$Tecahname is Saved Successfully' : '$Tecahname is Removed Successfully');
       } catch (error) {
        final currentStatus = isFavouriteNotifier.value[JoID] ?? false;
        final revertState = Map<String, bool>.from(isFavouriteNotifier.value);
        revertState[JoID] = currentStatus;
        isFavouriteNotifier.value = revertState;
        ToastificationError.Error("Failed to update favorite status. Please try again.");
     }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height / 10, backgroundColor: AppColor.Full_body_color, automaticallyImplyLeading: false, elevation: 0,
        surfaceTintColor: AppColor.Full_body_color,
        title: Text(Search_text.Search_Jobss, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          Row(
            children: [
              GestureDetector(onTap: () => Get.back(), child: Text(Search_text.cancel, style: TextStyle(color: AppColor.Error_color, fontWeight: FontWeight.w600, fontSize: Get.width / 23))),
              SizedBox(width: Get.width / 40),
            ],
          )
        ],
      ),
      body: Container(
        width: Get.width, height: Get.height,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => Serachfinding.onSearchTextChanged(), controller: Serachfinding.searchController,
              decoration: InputDecoration(
                hintText: Search_text.Keyword,
                hintStyle: TextStyle(color: AppColor.subcolor),
                prefixIcon: Icon(Icons.search, color: AppColor.subcolor),
                suffixIcon: Obx(() => (Serachfinding.isshowlist.value)
                    ? GestureDetector(onTap: () {
                      Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalController>().selectedWork.value = '');
                                      Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalofselectedExperienceController>().selectedExperience.value = '');
                                      Jobtypes = null;  Selectvalue = null;  startValue = 1;  endValue = 2;
                      Serachfinding.resetAllFilters(context);
                      }, child: Text(Search_text.Clear, style: TextStyle(color: AppColor.Error_color, fontWeight: FontWeight.w600, fontSize: Get.width / 28)))
                    : SizedBox()),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.Bottam_color)),
              ),
            ),
            Obx(() => (Serachfinding.isShow.value)
                  ? GestureDetector(
                      onTap: () {
                        Serachfinding.onSearchTextChanged(); log('Filter data $Serachfinding.filteredData');
                      },
                      child: (Serachfinding.isshowlist.value == true)
                          ? SizedBox()
                          : ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: Get.height / 5),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                                child: ListView.builder(
                                  shrinkWrap: true, physics: ClampingScrollPhysics(),
                                  itemCount: Serachfinding.filteredData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final job = Serachfinding.filteredData[index];
                                    return SizedBox(
                                      height: Get.height / 25,
                                      child: GestureDetector(
                                        onTap: () async {
                                          Serachfinding.isfinding.resetPagination();
                                          Serachfinding.searchController.text = job['value']; Serachfinding.Filteringdata = job['valueId']; Serachfinding.isshowlist.value = true;
                                          if (Serachfinding.selectedProvinceId.value.isNotEmpty && Serachfinding.selectedCityId.value.isNotEmpty) {
                                            try {
                                              Serachfinding.isfinding.FindAPIController_Fuction(
                                                Page: Serachfinding.isfinding.page.value.toString(),
                                                TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                                JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                                CandidateId: Candidate,
                                                Tokan: Tokans,
                                                Timezone: 'asia/kolkata',
                                                IsWeb: 0,
                                                Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                                Experience: (SectedExperience.selectedExperience.isNotEmpty) ? SectedExperience.selectedExperience.value : null,
                                                formSalary: (startValue > 2) ? startValue.round().toString() : null,
                                                toSalary: (endValue > 3) ? endValue.round().toString() : null,
                                                WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null,
                                                ProvinceIds: [(Serachfinding.selectedProvinceId.value.isNotEmpty) ? Serachfinding.selectedProvinceId.value : null],
                                                CityIds: [(Serachfinding.selectedCityId.value.isNotEmpty) ? Serachfinding.selectedCityId.value : null ],
                                              );
                                            } catch (e) {
                                              log('Error during search: $e');
                                            }
                                          } else if (Serachfinding.selectedProvinceId.value.isEmpty && Serachfinding.selectedCityId.value.isEmpty) {
                                            try {
                                              Serachfinding.isfinding.FindAPIController_Fuction(
                                                Page: Serachfinding.isfinding.page.value.toString(),
                                                TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                                JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                                CandidateId: Candidate,
                                                Tokan: Tokans,
                                                Timezone: 'asia/kolkata',
                                                IsWeb: 0,
                                                Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                                Experience: (SectedExperience.selectedExperience.isNotEmpty) ? SectedExperience.selectedExperience.value : null,
                                                formSalary: (startValue > 2) ? startValue.round().toString() : null,
                                                toSalary: (endValue > 3) ? endValue.round().toString() : null,
                                                WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null,
                                              );
                                            } catch (e) {
                                              log('Error during search: $e');
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(color: AppColor.Full_body_color),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: Get.height / 48, child: Text(job['value'], style: TextStyle(color: AppColor.subcolor))),
                                              Divider(color: AppColor.Bottam_color),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    )
                  : SizedBox(),
            ),
            CountryList(context,Serachfinding.Filteringdata),
            SizedBox(height: Get.height / 50),
            Obx(() => (Serachfinding.isshowlist.value)
                  ? Expanded(
                      child: Obx(() {
                        if (Serachfinding.isfinding.Fidingdata.value.isEmpty && Serachfinding.isfinding.isLoding.value) {return Center(child: CircularProgressIndicator());}
                        else if (Serachfinding.isfinding.Fidingdata.value.isEmpty) {return Center(child: Text("No Jobs Found"));}

                         return RefreshIndicator(
                           color: AppColor.Button_color,
                           backgroundColor: AppColor.Full_body_color,
                           onRefresh: () async => await Serachfinding.isfinding.refrsingpage(context),
                           child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: Serachfinding.isfinding.scrollController,
                              itemCount: (Serachfinding.isfinding.Fidingdata.value['data']?.length ?? 0) + (Serachfinding.isfinding.hasMoreData.value ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {

                                if (isFavouriteNotifier.value.isEmpty) {
                                    final initialFavorites = <String, bool>{};
                                    final List<dynamic> previousJobs = Serachfinding.isfinding.previousParams.value is List ? List.from(Serachfinding.isfinding.previousParams.value as Iterable) : [];
                                   final List<dynamic> allJobs = [...Paggnation.searchData, ...previousJobs];
                                    for (var job in allJobs) {
                                     final jobId = job['JobId'].toString();
                                      initialFavorites[jobId] = job['IsFavourite'] == "1";
                                    }
                                  isFavouriteNotifier.value = initialFavorites;
                                }

                                if (index == Serachfinding.isfinding.Fidingdata.value['data']?.length) {
                                    return Serachfinding.isfinding.hasMoreData.value
                                      ? (Serachfinding.isfinding.isLoding.value
                                        ? Padding(padding: const EdgeInsets.all(16.0),
                                          child: ((Serachfinding.isfinding.previousParams.value.isNotEmpty)
                                              ? Center(child: CircularProgressIndicator(color: AppColor.Button_color))
                                              : SizedBox()),
                                        )
                                        : SizedBox()) // If not loading, return empty space
                                        : Center(child: Text('No More Data'));
                                }

                                if (index >= Serachfinding.isfinding.Fidingdata.value['data'].length) {return Container();}

                                var jobData = Serachfinding.isfinding.Fidingdata.value['data'][index];
                                var Jobbing = jobData['JobId'];

                                return JobSearch(
                                  onTap: () {
                                    isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate).then((_) {
                                      Get.to(() => Details(
                                        JobID: Jobbing, Icon: jobData['ComLogo'], Job_Tital: jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'], Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'],
                                            saveonTap: () {
                                              setState(() {
                                                SavePoint(JoID: Jobbing, Tecahname: jobData['TechName']);
                                              });
                                            },
                                            saving: ValueListenableBuilder<Map<String, bool>>(
                                              valueListenable: isFavouriteNotifier, builder: (context, favMap, child) {
                                              final  isFav = favMap[Jobbing] ?? false;
                                               return SvgPicture.asset(isFav ? AppIcons.bookmark : AppIcons.save, color: AppColor.Button_color);
                                            },
                                          ),
                                        Share: Column(
                                          children: [
                                            SizedBox(height: Get.height / 80),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)), SizedBox(width: Get.width / 20),
                                                icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                    });
                                  },
                                  Icon: jobData['ComLogo'], Job_Tital: jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'], Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'], JobID: Jobbing,
                                   saveonTap: () {
                                    setState(() {
                                      SavePoint(JoID: Jobbing, Tecahname: jobData['TechName']);
                                     });
                                    },
                                  savechild: ValueListenableBuilder<Map<String, bool>>(
                                    valueListenable: isFavouriteNotifier, builder: (context, favMap, child) {
                                      final  isFav = favMap[Jobbing] ?? false;
                                      return SvgPicture.asset(isFav ? AppIcons.bookmark : AppIcons.save, color: AppColor.Button_color);
                                      },
                                    ),
                                  top: BorderSide(color: AppColor.Bottam_color),
                                  Sharebool: true, Sharebool2: true,
                                );
                              },
                            ),
                         );
                      }),
                    )
                  : Expanded(
                      child: Obx(() {
                        if (Serachfinding.isfinding.Fidingdata.value.isEmpty && Serachfinding.isfinding.isLoding.value) {return Center(child: CircularProgressIndicator());}
                        else if (Serachfinding.isfinding.Fidingdata.value.isEmpty) {return Center(child: Text("No Jobs Found"));}

                        return RefreshIndicator(
                          color: AppColor.Button_color,
                          backgroundColor: AppColor.Full_body_color,
                          onRefresh: () async => await Serachfinding.isfinding.refrsingpage(context),
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: Serachfinding.isfinding.scrollController,
                              itemCount: (Serachfinding.isfinding.Fidingdata.value['data']?.length ?? 0) + (Serachfinding.isfinding.hasMoreData.value ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {

                                  if (isFavouriteNotifier.value.isEmpty) {
                                    final initialFavorites = <String, bool>{};
                                    final List<dynamic> previousJobs = Serachfinding.isfinding.previousParams.value is List ? List.from(Serachfinding.isfinding.previousParams.value as Iterable) : [];
                                   final List<dynamic> allJobs = [...Paggnation.searchData, ...previousJobs];
                                    for (var job in allJobs) {
                                     final jobId = job['JobId'].toString();
                                      initialFavorites[jobId] = job['IsFavourite'] == "1";
                                    }
                                  isFavouriteNotifier.value = initialFavorites;
                                }

                                 if (index == Serachfinding.isfinding.Fidingdata.value['data']?.length) {
                                    return Serachfinding.isfinding.hasMoreData.value
                                      ? (Serachfinding.isfinding.isLoding.value
                                        ? Padding(padding: const EdgeInsets.all(16.0),
                                          child: ((Serachfinding.isfinding.previousParams.value.isNotEmpty)
                                              ? Center(child: CircularProgressIndicator())
                                              : SizedBox()),
                                        )
                                        : SizedBox()) // If not loading, return empty space
                                        : Center(child: Text('No More Data'));
                                }

                                if (index >= Serachfinding.isfinding.Fidingdata.value['data'].length) {return Container();}

                                var jobData = Serachfinding.isfinding.Fidingdata.value['data'][index];
                                var Jobbing = jobData['JobId'];
                                return JobSearch(
                                  onTap: () {
                                    isApply.IsApplingAPIController_fuction(JobId: Jobbing, Tokan: Tokans, Timezone: 'asia/kolkata', Candidate: Candidate).
                                    then((_) {
                                      Get.to(() => Details(
                                        JobID: Jobbing, Icon: jobData['ComLogo'], Job_Tital: jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'], Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'],
                                        saveonTap: () {
                                          setState(() {
                                             SavePoint(JoID: Jobbing, Tecahname: jobData['TechName']);
                                            });
                                          },
                                        saving: ValueListenableBuilder<Map<String, bool>>(
                                          valueListenable: isFavouriteNotifier, builder: (context, favMap, child) {
                                            final  isFav = favMap[Jobbing] ?? false;
                                            return SvgPicture.asset(isFav ? AppIcons.bookmark : AppIcons.save, color: AppColor.Button_color);
                                            },
                                          ),
                                            Share: Column(
                                              children: [
                                                SizedBox(height: Get.height / 80),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(Search_text.Share, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 27)), SizedBox(width: Get.width / 20),
                                                    icons(iconss: AppIcons.whatsapp), icons(iconss: AppIcons.Telegram), icons(iconss: AppIcons.facebook), icons(iconss: AppIcons.message1, iconcolor: Colors.blue), icons(iconss: AppIcons.link), icons(iconss: AppIcons.twitter), icons(iconss: AppIcons.email)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ));
                                    });
                                  },
                                  Icon: jobData['ComLogo'], Job_Tital: jobData['JobTitle'], Language: jobData['TechName'], Commpany: jobData['ComName'], Working: jobData['WorkWeek'], Location: jobData['Location'], Job_time: jobData['JobType'], Exp: jobData['Experience'], lake: jobData['Salary'], Hybrid: jobData['WorkSet'], stats: jobData['FormatDt'], JobID: Jobbing,
                                  saveonTap: () {
                                    setState(() {
                                      SavePoint(JoID: Jobbing, Tecahname: jobData['TechName']);
                                     });
                                    },
                                  savechild: ValueListenableBuilder<Map<String, bool>>(
                                    valueListenable: isFavouriteNotifier, builder: (context, favMap, child) {
                                      final  isFav = favMap[Jobbing] ?? false;
                                      return SvgPicture.asset(isFav ? AppIcons.bookmark : AppIcons.save, color: AppColor.Button_color);
                                      },
                                  ),
                                  top: BorderSide(color: AppColor.Bottam_color),
                                  Sharebool: true, Sharebool2: true,
                                );
                              },
                            ),
                        );
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

String? Jobtypes;
String? Selectvalue;
double startValue = 1;
double endValue = 2;

Widget CountryList(BuildContext context, String Filteringdata) {
  Serachfindingcontroller Serachfinding = Get.put(Serachfindingcontroller());
  final CountrylistApi countrylistApi = Get.put(CountrylistApi());
  final ValueNotifier<String> selectCitys = ValueNotifier<String>('');
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  GlobalController globalController = Get.find<GlobalController>();
  GlobalofselectedExperienceController SectedExperience =Get.put(GlobalofselectedExperienceController());

  List<dynamic> cityList = [];

  String? selectedProvinceId;
  String? selectedCityId;

  List<dynamic> getFilteredStates(List<dynamic> states, String query) {
    return states.where((state) {
      return state['Name'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<dynamic> getFilteredCities(List<dynamic> cities, String query) {
    return cities.where((city) {
      return city['CityName'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        sheetAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 600), curve: Curves.bounceIn),
        showDragHandle: true, elevation: 0, context: context, backgroundColor: AppColor.Full_body_color, isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) inState) {
              return Container(
                height: Get.height / 1.2, width: Get.width,
                decoration: BoxDecoration(color: AppColor.Full_body_color, boxShadow: kElevationToShadow[1]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 13),
                  child: Column(
                    children: [
                      Obx(() {
                        if (countrylistApi.isLoding.value) {return SizedBox();}
                        else {
                          return Column(children: [
                            SizedBox(height: Get.height / 50), Text('Select City', style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w600)), SizedBox(height: Get.height / 80), Divider(color: AppColor.offButton_color), SizedBox(height: Get.height / 50)
                          ]);
                        }
                      }),
                      Expanded(
                        child: Obx(() {
                          if (countrylistApi.isLoding.value) {return Center(child: Image.asset(AppLoder.infinityloder_without_background));}
                          else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / 2.5,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: stateController, onChanged: (value) {inState(() {});},
                                        decoration: InputDecoration(
                                          hintText: 'Search State',
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.subcolor), borderRadius: BorderRadius.circular(Get.width / 30)),
                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.subcolor), borderRadius: BorderRadius.circular(Get.width / 30)),
                                        ),
                                      ),
                                      Expanded(
                                        child: RawScrollbar(
                                          thickness: 3, thumbColor: AppColor.Button_color,
                                          radius: Radius.circular(10),
                                          child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: ListView.builder(
                                              itemCount: countrylistApi.CountrylistApi_data['data']?.length ?? 0,
                                              itemBuilder: (BuildContext context, int stateIndex) {
                                                final states = countrylistApi.CountrylistApi_data['data'][stateIndex]['ProvinceList'];
                                                final filteredStates = getFilteredStates(states, stateController.text);
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: filteredStates.length,
                                                  itemBuilder: (BuildContext context, int provinceIndex) {
                                                    final province = filteredStates[provinceIndex]; // Correct province selection
                                                    final bool isSelected = selectedProvinceId == province['ProvinceId'];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        inState(() {
                                                          selectedProvinceId = province['ProvinceId'];
                                                          cityList = province['CityList'] ?? [];
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.symmetric(vertical: Get.height / 200),
                                                        height: Get.height / 15,
                                                        decoration: BoxDecoration(
                                                          boxShadow: (isSelected) ? [BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 5)] : null,
                                                          color: (isSelected) ? AppColor.Button_color : AppColor.Full_body_color,
                                                          borderRadius: BorderRadius.circular(Get.width / 50),
                                                        ),
                                                        child: Center(
                                                          child: Text(textAlign: TextAlign.center, province['Name'] ?? 'No Name', style: TextStyle(color: (isSelected) ? AppColor.Full_body_color : AppColor.black_all)),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                (cityList.isNotEmpty)
                                    ? SizedBox(
                                        width: Get.width / 2.5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: cityController, onChanged: (value) {inState(() {});},
                                              decoration: InputDecoration(
                                                hintText: 'Search City',
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.subcolor), borderRadius: BorderRadius.circular(Get.width / 30)),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.subcolor), borderRadius: BorderRadius.circular(Get.width / 30)),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: RawScrollbar(
                                                  thickness: 3, thumbColor: AppColor.Button_color,
                                                  radius: Radius.circular(10),
                                                  child: ListView.builder(
                                                    itemCount: getFilteredCities(cityList, cityController.text).length,
                                                    itemBuilder: (BuildContext context, int cityListIndex) {
                                                      final filteredCities = getFilteredCities(cityList, cityController.text);
                                                      final province = filteredCities[cityListIndex];
                                                      final bool isSelected = selectedCityId == province['CityId'];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          inState(() {
                                                            selectedCityId = filteredCities[cityListIndex]['CityId'];
                                                          });
                                                          selectCitys.value = filteredCities[cityListIndex]['CityName'];
                                                          print(selectCitys.value);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.symmetric(vertical: Get.height / 200),
                                                          height: Get.height / 15,
                                                          decoration: BoxDecoration(
                                                            boxShadow: (isSelected) ? [BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 5)] : null,
                                                            color: (isSelected) ? AppColor.Button_color : AppColor.Full_body_color,
                                                            borderRadius: BorderRadius.circular(Get.width / 50),
                                                          ),
                                                          child: Center(child: Text(textAlign: TextAlign.center, filteredCities[cityListIndex]['CityName'], style: TextStyle(color: (isSelected) ? AppColor.Full_body_color : AppColor.black_all))),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            );
                          }
                        }),
                      ),
                      Obx(() {
                        if (countrylistApi.isLoding.value) {return SizedBox();}
                        else {
                          return GestureDetector(
                            onTap: () {
                              final SearchfilterApiController Searchfilter = Get.put(SearchfilterApiController());
                              Searchfilter.fetchSearchFilterApiData(token: Tokans);
                              final isfinding = Get.put(FindAPIController());
                              isfinding.resetPagination();
                              if (selectedProvinceId != null && selectedCityId != null) {
                                Serachfinding.selectedProvinceId.value = selectedProvinceId!;
                                Serachfinding.selectedCityId.value = selectedCityId!;
                                isfinding.FindAPIController_Fuction(
                                   Page: isfinding.page.value.toString(),
                                  TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                  JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                  CandidateId: Candidate,
                                  Tokan: Tokans,
                                  Timezone: 'asia/kolkata',
                                  IsWeb: 0,
                                  Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                  Experience: (SectedExperience.selectedExperience.isNotEmpty) ? SectedExperience.selectedExperience.value : null,
                                  formSalary: (startValue > 2) ? startValue.round().toString() : null,
                                  toSalary: (endValue > 3) ? endValue.round().toString() : null,
                                  WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null,
                                  ProvinceIds: [selectedProvinceId!],
                                  CityIds: [selectedCityId!],
                                ).then((_) {
                                  print('FindAPI operation completed.');
                                }).catchError((error) {
                                  print('Error: $error');
                                });
                              } else {
                                print("Please select both Province and City.");
                              }
                              Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: Get.width / 50),
                              width: Get.width, height: Get.height / 15,
                              decoration: BoxDecoration(color: AppColor.Button_color, borderRadius: BorderRadius.circular(Get.width / 25)),
                              child: Center(child: Text('Save', style: TextStyle(color: AppColor.Full_body_color))),
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
    child: ValueListenableBuilder(
      valueListenable: selectCitys,
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          height: Get.height / 15, width: Get.width,
          decoration: BoxDecoration(color: AppColor.Full_body_color, border: Border(bottom: BorderSide(color: AppColor.Bottam_color))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((selectCitys.value.isNotEmpty) ? selectCitys.value : 'Select City', style: TextStyle(color: AppColor.subcolor, fontSize: Get.width / 24)),
                    SearchTypes(context),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget SearchTypes(BuildContext context) {
  FindAPIController isfinding = Get.put(FindAPIController());
  DegreelistPopController Degreelist = Get.put(DegreelistPopController());
  JobtypeApiController Jobtype = Get.put(JobtypeApiController());
  Serachfindingcontroller Serachfinding = Get.put(Serachfindingcontroller());

  GlobalController globalController = Get.put(GlobalController());
  GlobalofselectedExperienceController SectedExperience =Get.put(GlobalofselectedExperienceController());

  Degreelist.DegreelistPopController_Fuction();
  Jobtype.JobtypeApiController_Fuction();

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        sheetAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 600), curve: Curves.bounceIn),
        elevation: 0, context: context,
        backgroundColor: AppColor.Full_body_color, isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) insState) {
              return SizedBox(
                height: Get.height / 1.08, width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                        child: Column(
                          children: [
                            SizedBox(height: Get.height / 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(Search_text.Filters, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)),
                                GestureDetector(child: SvgPicture.asset(AppIcons.cancel), onTap: () => Get.back()),
                              ],
                            ),
                            Divider(color: AppColor.offButton_color),
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height / 50), Text(Search_text.Experience, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)), SizedBox(height: Get.height / 60),
                                  SelecteContainer(),
                                  SizedBox(height: Get.height / 60), Text(Search_text.Education, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)), SizedBox(height: Get.height / 60),
                                  Container(
                                    width: Get.width, height: Get.height / 19,
                                    decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 50)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: DropdownButton(
                                          icon: SvgPicture.asset(AppIcons.down, color: AppColor.subcolor), elevation: 0,
                                          dropdownColor: AppColor.Full_body_color,
                                          underline: SizedBox(), autofocus: true, isExpanded: true,
                                          menuMaxHeight: 200,
                                          value: Selectvalue,
                                          hint: Text('Select Education', style: TextStyle(fontWeight: FontWeight.w600)),
                                          items: (Degreelist.Degree_data['data'] ?? []).map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                             value: item['DegreeId'],
                                             child: Text(item['Name'], style: TextStyle(backgroundColor: Selectvalue == item['Name'] ? Colors.black.withOpacity(0.1) : AppColor.Full_body_color, fontWeight: Selectvalue == item['Name'] ? FontWeight.bold : FontWeight.normal, color: AppColor.black_all,)));}).toList(),
                                          onChanged: (value) => insState(() => Selectvalue = value!),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  Text(Search_text.Salary_Rang, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)),
                                  RangeSlider(
                                    values: RangeValues(startValue, endValue),
                                    min: 1, max: 10, divisions: 100,
                                    activeColor: AppColor.Button_color,
                                    inactiveColor: AppColor.offButton_color,
                                    onChanged: (RangeValues values) {
                                      insState(() {startValue = values.start;endValue = values.end;});
                                      print('Start: ${values.start}, End: ${values.end}');
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(5)),
                                        child: Text("${startValue.round().toString()} Lakh's", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.Container_higthcolot)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(5)),
                                        child: Text("${endValue.round().toString()} Lakh's", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.Container_higthcolot)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  Text(Search_text.Job_Tayp, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)),
                                  SizedBox(height: Get.height / 60),
                                  Container(
                                    width: Get.width, height: Get.height / 19,
                                    decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(Get.width / 50)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          icon: SvgPicture.asset(AppIcons.down, color: AppColor.subcolor),
                                          elevation: 0, dropdownColor: AppColor.Full_body_color, underline: SizedBox(), isExpanded: true, menuMaxHeight: 200,
                                          value: Jobtype.jobtype_data['data'].contains(Jobtypes) ? Jobtypes : null,
                                          hint: Text("Select Job Type"),
                                          items: (Jobtype.jobtype_data['data'] ?? []).toSet().toList().map<DropdownMenuItem<String>>((jobType) => DropdownMenuItem<String>(value: jobType, child: Text(jobType))).toList(),
                                          onChanged: (newValue) => insState(() => Jobtypes = newValue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height / 60), Text(Search_text.Work_Setup, style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w800)), SizedBox(height: Get.height / 60), WorkSetups(), SizedBox(height: Get.height / 15),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                      child: Column(
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OnButtons_short(
                                    onTap: () {
                                      Get.back();
                                      Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalController>().selectedWork.value = '');
                                      Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalofselectedExperienceController>().selectedExperience.value = '');
                                      Jobtypes = null;  Selectvalue = null;  startValue = 1;  endValue = 2;
                                      Serachfinding.resetAllFilters(context);
                                }, width: Get.width / 2.3, btn_name: 'Clear', Border_color: AppColor.Notification_Color, btn_color: AppColor.Notification_Color, text_color: AppColor.Full_body_color),
                              OnButtons_short(
                                  onTap: () {
                                    isfinding.resetPagination();
                                if(Serachfinding.selectedProvinceId.value.isNotEmpty && Serachfinding.selectedCityId.value.isNotEmpty){
                                  isfinding.FindAPIController_Fuction(
                                      Page: isfinding.page.value.toString(),
                                      TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                      JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                      CandidateId: Candidate,
                                      Tokan: Tokans,
                                      Timezone: 'asia/kolkata',
                                      IsWeb: 0,
                                      Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                      Experience: (SectedExperience.selectedExperience.isNotEmpty) ? SectedExperience.selectedExperience.value  : null,
                                      ProvinceIds: [(Serachfinding.selectedProvinceId.value.isNotEmpty) ? Serachfinding.selectedProvinceId.value : null],
                                      CityIds: [(Serachfinding.selectedCityId.value.isNotEmpty) ? Serachfinding.selectedCityId.value : null ],
                                      WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null
                                   );
                                }
                                if(Serachfinding.selectedProvinceId.value.isEmpty && Serachfinding.selectedCityId.value.isEmpty){
                                  isfinding.FindAPIController_Fuction(
                                    Page: isfinding.page.value.toString(),
                                      TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                      JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                      CandidateId: Candidate,
                                      Tokan: Tokans,
                                      Timezone: 'asia/kolkata',
                                      IsWeb: 0,
                                      Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                      Experience: (SectedExperience.selectedExperience.isNotEmpty) ? SectedExperience.selectedExperience.value : null,
                                      WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null
                                  );
                                  if(startValue.round().toString().isNotEmpty && endValue.round().toString().isNotEmpty){
                                    isfinding.FindAPIController_Fuction(
                                      Page: isfinding.page.value.toString(),
                                        TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                      JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                      CandidateId: Candidate,
                                      Tokan: Tokans,
                                      Timezone: 'asia/kolkata',
                                      IsWeb: 0,
                                      Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                      Experience: (SectedExperience.selectedExperience.value .toString().isNotEmpty) ? SectedExperience.selectedExperience.value  : null,
                                      formSalary: (startValue > 2) ? startValue.round().toString() : null,
                                      toSalary: (endValue > 3) ? endValue.round().toString() : null,
                                      WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null
                                  );
                                  }
                                  if(startValue.round().toString().isEmpty && endValue.round().toString().isEmpty){
                                    isfinding.FindAPIController_Fuction(
                                      Page: isfinding.page.value.toString(),
                                      TechId: (Serachfinding.Filteringdata.isNotEmpty) ? Serachfinding.Filteringdata : null,
                                      JobType: (Jobtypes.toString().isNotEmpty) ?Jobtypes : null,
                                      CandidateId: Candidate,
                                      Tokan: Tokans,
                                      Timezone: 'asia/kolkata',
                                      IsWeb: 0,
                                      Education: (Selectvalue.toString().isNotEmpty) ? Selectvalue : null,
                                      Experience: (SectedExperience.selectedExperience.value .toString().isNotEmpty) ? SectedExperience.selectedExperience.value  : null,
                                      WorkSetup: (globalController.selectedWork.value.isNotEmpty) ? globalController.selectedWork.value : null
                                  );
                                  }
                                  Get.back();
                                }
                              },
                                  width: Get.width / 2.3, btn_name: 'Save', Border_color: AppColor.Button_color, btn_color: AppColor.Button_color, text_color: AppColor.Full_body_color),
                            ],
                          ),
                          SizedBox(height: Get.height / 50),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    child: Icon(Icons.accessibility_new_outlined, color: AppColor.subcolor),
  );
}

class GlobalofselectedExperienceController extends GetxController {
  var selectedExperience = ''.obs;
  void onInit() {selectedExperience.value = '';super.onInit();}
  void onClose() {selectedExperience.value = '';super.onClose();}
  void dispose() {selectedExperience.value = '';super.dispose();}

}

// Commen Widget's
Widget SelecteContainer(){
  GlobalofselectedExperienceController selected = Get.put(GlobalofselectedExperienceController());

  List<Map<String, String>> experienceList = [
  {"TechName": "Fresher"},
  {"TechName": "0-1 Year"},
  {"TechName": "1-3 Year"},
  {"TechName": "3-5 Year"},
  {"TechName": "5-7 Year"},
  {"TechName": "7-9 Year"},
  {"TechName": "10+ Year"},
];

  return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
     return Obx(() => Wrap(
      spacing: 8, runSpacing: 8,
      children: experienceList.map((exp) {
        bool isSelected = selected.selectedExperience == exp['TechName'];
        return InkWell(
          onTap: (){
            setState(() {
              selected.selectedExperience.value = isSelected ? '' : exp['TechName']!;
            });
          },
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(5), color: isSelected ? AppColor.Button_color : AppColor.Full_body_color),
            child: Text(exp['TechName']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isSelected ? AppColor.Full_body_color : AppColor.black_all)),
          ),
        );
      }).toList(),
    ));
  });
}

class GlobalController extends GetxController {
  var selectedWork = ''.obs;
  void onInit() {selectedWork.value = '';super.onInit();}
  void onClose() {selectedWork.value = '';super.onClose();}
  void dispose() {selectedWork.value = '';super.dispose();}

}

Widget WorkSetups() {
  PreferencetypeApiController WorkSetup = Get.put(PreferencetypeApiController());
  WorkSetup.PreferencetypeApiController_fuction();

  GlobalController globalController = Get.find<GlobalController>();

  return Obx(() {
    if (WorkSetup.islodind.value) {return Center(child: CircularProgressIndicator());}
    if (WorkSetup.Preferencetype_data.isEmpty || WorkSetup.Preferencetype_data['data'] == null) {return Center(child: Text("No data available"));}

    List<String> workList = List<String>.from(WorkSetup.Preferencetype_data['data']);
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: workList.map((workType) {
        bool isSelected = globalController.selectedWork.value == workType;
        return InkWell(
          onTap: () => globalController.selectedWork.value = workType,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: AppColor.offButton_color), borderRadius: BorderRadius.circular(5), color: isSelected ? AppColor.Button_color : AppColor.Full_body_color),
            child: Text(workType, style: TextStyle(fontSize: 14, color: isSelected ? AppColor.Full_body_color : AppColor.black_all, fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  });
}