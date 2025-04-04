// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_iterable_wheretype, avoid_print, unused_import

// void onSearchTextChanged() {
//   final query = searchController.text.toLowerCase();
//   if (query.length >= 3) {
//     filteredData = _filterData(query);
//     isshowlist.value = filteredData.isNotEmpty;
//   } else {
//     filteredData = [];
//     isshowlist.value = false;
//   }
//   update();
// }
//
// List<Map<String, dynamic>> _filterData(String query) {
//   final skillArr = (Searchfilter.searchFilterApiData?['data']?['skillArr'] as List?) ?? [];
//   return skillArr.where((job) => job is Map<String, dynamic>).cast<Map<String, dynamic>>().where((job) {
//     final value = job['value']?.toString().toLowerCase() ?? '';
//     final valueId = job['valueId']?.toString().toLowerCase() ?? '';
//     return value.contains(query) || valueId.contains(query);
//   }).toList();
// }

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Search/Search_location.dart';
import '../../../../view/utils/app_constance.dart';
import '../../../API_Controller/Candidate/Collction/Login/login_API_controller.dart';
import '../../../API_Controller/Candidate/Menu/Home/isFavration_Controllers.dart';
import '../../../API_Controller/Candidate/Menu/Search/SearchFilter_API_Controller.dart';
import '../../../API_Controller/Candidate/Menu/Search/Search_API_Controller.dart';
import '../../../API_Controller/countrylist_API.dart';

class Serachfindingcontroller extends GetxController {
  var isShow = false.obs; var isshowlist = false.obs;

  final FindAPIController isfinding = Get.put(FindAPIController());
  final SearchfilterApiController Searchfilter = Get.put(SearchfilterApiController());
  final IsfavrationControllers isfavication = Get.put(IsfavrationControllers());
  final OptionApiController login = Get.put(OptionApiController());

  final TextEditingController searchController = TextEditingController();

  //Contry list Object
  final CountrylistApi countrylistApi = Get.put(CountrylistApi());

  //ontry list Object over

  List<dynamic> filteredData = [];

   var selectedProvinceId = ''.obs;
   var selectedCityId = ''.obs;

  String Filteringdata = '';

  void onInit() {
    super.onInit();
    Searchfilter.fetchSearchFilterApiData(token: Tokans);

    //Contry list Call
    countrylistApi.CountrylistApi_Fuction();
    //Contry list Call over

    filteredData = Searchfilter.searchFilterApiData?['data']['skillArr'] ?? [];
    searchController.addListener(onSearchTextChanged);

    // Future.microtask(() {
    //   isfinding.FindAPIController_Fuction(Timezone: 'asia/kolkata', IsWeb: '0', CandidateId: Candidate, Tokan: Tokans, Page: isfinding.page.value.toString());
    // });

    update();
  }

  void onSearchTextChanged() {
    final query = searchController.text.toLowerCase();
    if (query.length >= 3) {
      isShow.value = true;
      filteredData = Searchfilter.searchFilterApiData?['data']['skillArr'].where((job) {
        return job['value'].toLowerCase().contains(query) || job['valueId'].toLowerCase().contains(query);
      }).toList();
    } else {
      isShow.value = false; filteredData = [];
    }
    update();
  }

  void resetSearch() {
    searchController.clear();
    isShow.value = false;
    filteredData = Searchfilter.searchFilterApiData?['data']['skillArr'] ?? [];
    update();
  }

  void resetAllFilters(context) {
    searchController.clear();
    filteredData = Searchfilter.searchFilterApiData?['data']['skillArr'] ?? [];
    isshowlist.value = false;
    isfinding.FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: 0, Timezone: 'Asia/Kolkata', Page: isfinding.page.value.toString());
    Navigator.pushReplacement(
      context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Search_location(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

Future<void> findJobs({required String timezone, required String jobId, required String techId, int? IsWeb, required String candidateId, required String token, List<String>? CityIds, List<String>? ProvinceIds})
async {
  try {
    await isfinding.FindAPIController_Fuction(Timezone: timezone, JobId: jobId, TechId: techId, IsWeb: IsWeb, CandidateId: candidateId, Tokan: token, ProvinceIds: ProvinceIds ?? [], CityIds: CityIds ?? []);
    isshowlist.value = true;
    print('Search API call successful');
  } catch (e) {
    print('Error during search: $e');
  }
  }
}
