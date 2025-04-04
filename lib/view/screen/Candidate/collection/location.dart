// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/app_String.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_icon.dart';
import 'package:hirexpert/view/utils/common/showpop/showbottam.dart';
import 'package:hirexpert/view/utils/common/showpop/showdialog.dart';
import 'package:provider/provider.dart';
import '../../../../controller/User_Controller/Candidate_Controller/DropdownController/PreferenceController.dart';
import '../../../utils/aap_image.dart';
import '../../../utils/logic/next_thow.dart';
import 'choose_file.dart';

class Location extends StatelessWidget {
  final String? first_name;
  final String? last_name;

  Location({super.key, this.first_name, this.last_name});

  final PreferenceControllers next = Get.put(PreferenceControllers());

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<PreferenceController>(context, listen: false);
    context.read<PreferenceController>().onInit(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: Get.height / 20, width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Consumer<PreferenceController>(
          builder: (BuildContext context, value, Widget? child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      children: [
                        // ignore: deprecated_member_use
                        SvgPicture.asset(AppIcons.Backarrow,color: AppColor.Button_color),
                        SizedBox(width: Get.width / 70),
                        Text(Navigator_text.Back, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 23, color: AppColor.Button_color))
                      ],
                    ),
                  ),
                  Obx(() => GestureDetector(
                    onTap: () {
                      if(next.preferences.value && next.working_location.value && next.work_setup.value && next.work_location.value){
                        Get.to(()=> Choose(),transition: Transition.rightToLeft,duration: Duration(seconds: 1),curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Row(
                      children: [
                        NextThow(
                          text: Navigator_text.Next,
                          fontweight: next.preferences.value && next.working_location.value && next.work_setup.value && next.work_location.value,
                          fontcolor: next.preferences.value && next.working_location.value && next.work_setup.value && next.work_location.value,
                        ),
                        SizedBox(width: Get.width / 80),
                        NextArrow(arrowcolor: next.preferences.value && next.working_location.value && next.work_setup.value && next.work_location.value),
                      ],
                    ),
                  ),)
                ],
              ),
            );
          },
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
          child: Consumer<PreferenceController>(
            builder: (BuildContext context, PreferenceController value, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset(AppImage.profile, scale: 5)],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(first_name ?? '', style: TextStyle(fontSize: Get.width / 25)),
                      SizedBox(width: Get.width / 50),
                      Text(last_name ?? '', style: TextStyle(fontSize: Get.width / 25)),
                    ],
                  ),
                  SizedBox(height: Get.height / 20),

                  //Preference
                  Text(Location_text.preference, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                  GestureDetector(
                    onTap: () {
                      next.preferences_fuction();
                      Showdialog.showdialod(
                        context: context,
                        height: Get.height / 3,
                        colamWidget: SizedBox(
                          height: Get.height / 3,
                          child: ListView.builder(
                            itemCount: locations.Jobtype.jobtype_data['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () =>locations.Preference_fuction(text: locations.Jobtype.jobtype_data['data'][index]),
                                    child: Text(
                                      locations.Jobtype.jobtype_data['data'][index],
                                      style: TextStyle(fontSize: Get.width / 28),
                                    ),
                                  ),
                                  SizedBox(height: Get.height / 50),
                                ],
                              );
                            },
                          ),
                        ),
                        hedingtext: Location_text.preference,
                        onTabs: () => Get.back(),
                      );
                    },
                    child: Pop_Container(text: Location_text.Select, condition: locations.preference, text2: locations.preference_string),
                  ),

                  // const Preference(),
                  SizedBox(height: Get.height / 50),

                  //Current Location
                  Text(Location_text.Location, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                  GestureDetector(
                    onTap: () {
                      next.work_location_fuction();
                      showLocationSelector(
                        context: context,
                        countryList: locations.country.countrylist,
                        initialCountryId: locations.country.countrylist['data'][0]['CountryId'],
                        onLocationSelected: (String countryId, String stateName) {
                            locations.showLocationSelector_fuction(stateName);
                          print('Selected Country: $countryId, Selected State: $stateName');
                        },
                        isStateNotifier: locations.isState,
                      );
                    },
                    child: ValueListenableBuilder(
                      valueListenable: locations.isState,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Pop_Container(text: Location_text.Select, condition: locations.cuntrycode1, text2: locations.selectedState1);
                      },
                    ),
                  ),

                  SizedBox(height: Get.height / 50),

                  //Preferred Location
                  Text(Location_text.Preffered, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                  GestureDetector(
                    onTap: () {
                      next.working_location_fuction();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, inCgange) {
                              return Container(
                                height: Get.height / 1.1,
                                width: Get.width,
                                decoration: BoxDecoration(color: AppColor.Full_body_color),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height / 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(),
                                          Text(Location_text.Location, style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width / 23)),
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: SvgPicture.asset(AppIcons.cancel),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height / 50),
                                      Divider(thickness: 1, color: AppColor.subcolor),
                                      SizedBox(height: Get.height / 50),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width / 2.5,
                                              child: ListView.builder(
                                                itemCount: locations.country.countrylist['data'].length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  bool isSelected = locations.cuntrycodevalue2 == locations.country.countrylist['data'][index]['CountryId'];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      inCgange(() {
                                                        locations.showLocationselector_location(
                                                            cuntrycodevalue2: locations.country.countrylist['data'][index]['CountryId'],
                                                            states2: locations.country.countrylist['data'][index]['ProvinceList'],
                                                        );
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(vertical: Get.width / 60),
                                                      width: Get.width / 4,
                                                      height: Get.height / 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Get.width / 50),
                                                        color: isSelected ? AppColor.Button_color : AppColor.Full_body_color,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          textAlign: TextAlign.center,
                                                          locations.country.countrylist['data'][index]['Country'],
                                                          style: TextStyle(
                                                            fontSize: Get.width / 28,
                                                            color: isSelected ? AppColor.Full_body_color : AppColor.black_all,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: Get.width / 30),
                                            locations.cuntrycode2 ? Expanded(
                                              child: ListView.builder(
                                                itemCount: locations.states2.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  bool isStateSelected = locations.selectedStates.contains(locations.states2[index]['Name']);
                                                  return GestureDetector(
                                                    onTap: () {
                                                      inCgange((){
                                                         locations.showLocation_state(context, isStateSelected, locations.states2[index]['Name']);
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(vertical: Get.width / 60),
                                                      width: Get.width / 4,
                                                      height: Get.height / 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Get.width / 50),
                                                        color: isStateSelected ? AppColor.Button_color : AppColor.Full_body_color,
                                                      ),
                                                      child: Center(
                                                        child: Text(textAlign: TextAlign.center,
                                                          locations.states2[index]['Name'],
                                                          style: TextStyle(fontSize: Get.width / 28, color: isStateSelected ? AppColor.Full_body_color : AppColor.black_all,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
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
                      valueListenable: locations.isState2,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Pop_Container(text: Location_text.Select, condition: locations.cuntrycode2, text2: locations.selectedStates.join(','));
                      },
                    ),
                  ),
                  SizedBox(height: Get.height / 50),

                  //Setup
                  Text(Location_text.Work, style: TextStyle(fontSize: Get.width / 25, color: AppColor.subcolor)),
                  GestureDetector(
                    onTap: () {
                      next.work_setup_fuction();
                      Showdialog.showdialod(
                        height: Get.height / 3,
                        context: context,
                        colamWidget: SizedBox(
                          height: Get.height / 3,
                          child: ListView.builder(
                            itemCount: locations.Preferencetype.Preferencetype_data['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () =>locations.WorkSetup_fuction(locations.Preferencetype.Preferencetype_data['data'][index]),
                                    child: Text(locations.Preferencetype.Preferencetype_data['data'][index]),
                                  ),
                                  SizedBox(height: Get.height / 50),
                                ],
                              );
                            },
                          ),
                        ),
                        hedingtext: Location_text.Work,
                        onTabs: () => Get.back(),
                      );
                    },
                    child: Pop_Container(text: Location_text.Select, condition: locations.worksetup, text2: locations.worksetup_string),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
