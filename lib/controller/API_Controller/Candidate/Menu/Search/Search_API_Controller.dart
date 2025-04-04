// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/screen/Candidate/Menu/Search/Search_location.dart';
import '../../../../../view/utils/app_constance.dart';
import '../../../../User_Controller/Candidate_Controller/SerachfindingController/SerachfindingController.dart';
import '../Home/isAppling_API_Controller.dart';

class SearchApiControllerPagination extends GetxController {
  final ScrollController scrollController = ScrollController();
  final IsapplingApiController isApply = Get.put(IsapplingApiController());

  var isLoading = false.obs;
  var searchData = <dynamic>[].obs;
  var page = 1.obs;
  var hasMoreData = true.obs;

  @override
  void onInit() {
    fetchSearchResults(token: Tokans,candidateId: Candidate,isWeb: '0',timezone: 'asia/kolkata');
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 && !isLoading.value) {
        fetchSearchResults(token: Tokans, candidateId: Candidate, isWeb: '0', timezone: 'asia/kolkata');
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchSearchResults({required String token, String? timezone, String? candidateId, String? isWeb, String? techId, String? jobId,}) async {
    if (isLoading.value || !hasMoreData.value) return;

    try {
      isLoading.value = true;

      Map<String, String> body = {
        if (timezone != null) 'Timezone': timezone,
        if (candidateId != null) 'CandidateId': candidateId,
        if (isWeb != null) 'IsWeb': isWeb,
        if (techId != null) 'TechId': techId,
        if (jobId != null) 'JobId': jobId,
        'Page': page.value.toString(),
      };

      log('Fetching Page: ${page.value} with Body: $body');

      final response = await http.post(Uri.parse(AppUrl.SearchJob.trim()), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: token}, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> newData = responseData['data'] ?? [];

        if (newData.isNotEmpty) {searchData.addAll(newData);page.value++;}
        else {hasMoreData.value = false;}}
        else {log("Error: ${response.statusCode} - ${response.body}");}
    } catch (e) {
      log('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPagination() async {
    searchData.clear(); page.value = 1; hasMoreData.value = true;
    await fetchSearchResults(token: Tokans, candidateId: Candidate, isWeb: '0', timezone: 'asia/kolkata');
  }
}
class SearchApiController extends GetxController {
  var isLoding = false.obs; var Search_data = {}.obs;

  Future SearchApiController_fuction({String? Timezone, String? CandidateId, String? Tokan, String? IsWeb, String? TechId, String? JobId, String? Page,}) async {
    try {
      isLoding.value = true;

      Map body = {
        if (Timezone != null) 'Timezone': Timezone,
        if (CandidateId != null) 'CandidateId': CandidateId,
        if (IsWeb != null) 'IsWeb': IsWeb,
        if (TechId != null) 'TechId': TechId,
        if (JobId != null) 'JobId': JobId,
        if (Page != null) 'Page' : Page,
      };

      if (kDebugMode) {log('body :- $body');}

      final Response = await http.post(Uri.parse(AppUrl.SearchJob), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''}, body: body);

      if (Response.statusCode == 200 || Response.statusCode == 201) {
        Search_data.value = await jsonDecode(Response.body);
        print({
          'Timezone': Timezone, 'CandidateId': CandidateId, 'IsWeb' : IsWeb, 'TechId' : TechId, 'JobId' : JobId, 'Page' : Page
        });
        log("Search Job :-  $Search_data");
      } else {
        throw {
          " Search Job Error this :- ${Response.statusCode} , ${Response.body} "
        };
      }
    } catch (e) {print('Search job this Error :- $e');}
    finally {isLoding.value = false;}
  }
}
class FindAPIController extends GetxController {
  final ScrollController scrollController = ScrollController();

  var isLoding = false.obs;
  var Fidingdata = <String, dynamic>{}.obs;
  var page = 1.obs;
  var hasMoreData = true.obs;
  var previousParams = ''.obs;

  @override
  void onInit() {
    super.onInit();
    FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: 0, Timezone: 'Asia/Kolkata', Page: page.value.toString());

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 && !isLoding.value) {
        if (!isLoding.value && hasMoreData.value) {
          Map<String, dynamic> params = {};
          params = jsonDecode(previousParams.value);
           FindAPIController_Fuction(
            Tokan: Tokans,
            CandidateId: Candidate,
            IsWeb: 0,
            Timezone: 'Asia/Kolkata',
            Page: page.value.toString(),
            WorkSetup: params.containsKey('WorkSetup') ? params['WorkSetup'] : null,
            formSalary: params.containsKey('formSalary') ? params['formSalary'] : null,
            JobType: params.containsKey('JobType') ? params['JobType'] : null,
            toSalary: params.containsKey('toSalary') ? params['toSalary'] : null,
            Education: params.containsKey('Education') ? params['Education'] : null,
            Experience: params.containsKey('Experience') ? params['Experience'] : null,
            TechId: params.containsKey('TechId') ? params['TechId'] : null,
            JobId: params.containsKey('JobId') ? params['JobId'] : null,
            ProvinceIds: params.containsKey('ProvinceIds') ? params['ProvinceIds'] ?? [] : null,
            CityIds: params.containsKey('CityIds') ? params['CityIds'] ?? [] : null,
          );
        }
      }
      update();
    });
    update();
  }

  Future<void> FindAPIController_Fuction({Function(List<dynamic> data)? onDataReceived, String? Timezone, String? CandidateId, String? Tokan, int? IsWeb, String? WorkSetup, String? formSalary, String? JobType, String? toSalary, String? Education, String? Experience, String? TechId, String? JobId, List? ProvinceIds, List? CityIds, String? Page}) async {
    if (isLoding.value || !hasMoreData.value) return;

    try {
      isLoding.value = true;

      Map<String, dynamic> currentFilterParams = {
        if (Timezone != null) 'Timezone': Timezone,
        if (CandidateId != null) 'CandidateId': CandidateId,
        if (Tokan != null) 'Tokan': Tokan,
        if (IsWeb != null) 'IsWeb': IsWeb,
        if (WorkSetup != null) 'WorkSetup': WorkSetup,
        if (formSalary != null) 'formSalary': formSalary,
        if (JobType != null) 'JobType': JobType,
        if (toSalary != null) 'toSalary': toSalary,
        if (Education != null) 'Education': Education,
        if (Experience != null) 'Experience': Experience,
        if (TechId != null) 'TechId': TechId,
        if (JobId != null) 'JobId': JobId,
        if (ProvinceIds != null) 'ProvinceIds': ProvinceIds,
        if (CityIds != null) 'CityIds': CityIds,
      };

      String currentParamsStr = jsonEncode(currentFilterParams);

      if (currentParamsStr != previousParams.value) {Fidingdata['data'] = []; Fidingdata.clear(); page.value = 1;hasMoreData.value = true;previousParams.value = currentParamsStr;}

      Map<String, String> body = {
        if (Timezone != null) 'Timezone': Timezone,
        if (CandidateId != null) 'CandidateId': CandidateId,
        if (IsWeb != null) 'IsWeb': IsWeb.toString(),
        if (TechId != null) 'TechId': TechId,
        if (JobId != null) 'JobId': JobId,
        if (WorkSetup != null) 'WorkSetup': WorkSetup,
        if (formSalary != null) 'formSalary': formSalary,
        if (JobType != null) 'JobType': JobType,
        if (toSalary != null) 'toSalary': toSalary,
        if (Education != null) 'Education': Education,
        if (Experience != null) 'Experience': Experience,
        if (ProvinceIds != null) 'ProvinceId[]': ProvinceIds.join(','),
        if (CityIds != null) 'CityId[]': CityIds.join(','),
        if (Page != null) 'Page': page.value.toString(),
      };

      final response = await http.post(Uri.parse(AppUrl.SearchJob), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? '',}, body: body,);
      print(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        update();
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data') && responseData['data'] != null) {
          List<dynamic> newJobs = responseData['data'];
          if (page.value == 1) {Fidingdata.assignAll(responseData);}
          else {
            List<dynamic> existingJobs = List.from(Fidingdata['data'] ?? []);
            existingJobs.addAll(newJobs);
            responseData['data'] = existingJobs;
            Fidingdata.assignAll(responseData);
            print(body);
          }
          if (newJobs.isNotEmpty) {page.value++;}
          else {hasMoreData.value = false;}
        } else {
          hasMoreData.value = false;
        }
      }
    } catch (e) {
      print("Error fetching jobs: $e");
    } finally {
      isLoding.value = false;
    }
    update();
  }

  Future<void> resetPagination() async {
    Fidingdata.clear(); page.value = 1; hasMoreData.value = true; previousParams.value = '';
    await Future.delayed(Duration.zero);
    await FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: 0, Timezone: 'asia/kolkata', Page: page.value.toString());
  }

  Future<void> refrsingpage(context)async{
  Serachfindingcontroller Serachfinding = Get.put(Serachfindingcontroller());
    Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalController>().selectedWork.value = '');
    Future.delayed(Duration(milliseconds: 100), () => Get.find<GlobalofselectedExperienceController>().selectedExperience.value = '');
    Jobtypes = null;  Selectvalue = null;  startValue = 1;  endValue = 2;
    Serachfinding.resetAllFilters(context);

    Fidingdata.clear(); page.value = 1; hasMoreData.value = true; previousParams.value = '';

    await Future.delayed(Duration.zero);
    await FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: 0, Timezone: 'asia/kolkata', Page: page.value.toString());
}
}

// class FindAPIController extends GetxController {
//   final ScrollController scrollController = ScrollController();
//
//   var isLoding = false.obs; var Fidingdata = <String, dynamic>{}.obs; var page = 1.obs; var hasMoreData = true.obs; var previousParams = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//      scrollController.addListener(() {
//       if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 && !isLoding.value) {
//         // Check if any filters are applied beyond default parameters
//         if (previousParams.value.isNotEmpty) {
//           try {
//             Map<String, dynamic> params = jsonDecode(previousParams.value);
//             Set<String> defaultKeys = {'Timezone', 'CandidateId', 'Tokan', 'IsWeb'};
//             bool hasFilters = params.keys.any((key) => !defaultKeys.contains(key));
//             if (hasFilters) {
//               return; // Disable pagination if filters are present
//             }
//           } catch (e) {
//             print('Error decoding previousParams: $e');
//           }
//         }
//         FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: '0', Timezone: 'asia/kolkata', Page: page.value.toString());
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> FindAPIController_Fuction({Function(List<dynamic> data)? onDataReceived, String? Timezone, String? CandidateId, String? Tokan, String? IsWeb, String? WorkSetup, String? formSalary, String? JobType, String? toSalary, String? Education, String? Experience, String? TechId, String? JobId, List? ProvinceIds, List? CityIds, String? Page})
//   async {
//     if (isLoding.value || !hasMoreData.value) return;
//
//     try {
//       isLoding.value = true;
//       Map<String, dynamic> currentFilterParams = {
//         'Timezone': Timezone,
//         'CandidateId': CandidateId,
//         'Tokan': Tokan,
//         if (IsWeb != null) 'IsWeb': IsWeb,
//         if (WorkSetup != null) 'WorkSetup': WorkSetup,
//         if (formSalary != null) 'formSalary': formSalary,
//         if (JobType != null) 'JobType': JobType,
//         if (toSalary != null) 'toSalary': toSalary,
//         if (Education != null) 'Education': Education,
//         if (Experience != null)'Experience': Experience,
//         if (TechId != null) 'TechId': TechId,
//         if (JobId != null) 'JobId': JobId,
//         if (ProvinceIds != null) 'ProvinceIds': ProvinceIds,
//         if (CityIds != null)  'CityIds': CityIds,
//       };
//       String currentParamsStr = jsonEncode(currentFilterParams);
//       if (currentParamsStr != previousParams.value) {Fidingdata.clear(); page.value = 1; hasMoreData.value = true; previousParams.value = currentParamsStr;}
//       print(currentParamsStr);
//       Map<String, String> body = {
//         if (Timezone != null) 'Timezone': Timezone,
//         if (CandidateId != null) 'CandidateId': CandidateId,
//         if (IsWeb != null) 'IsWeb': IsWeb,
//         if (TechId != null) 'TechId': TechId,
//         if (JobId != null) 'JobId': JobId,
//         if (WorkSetup != null) 'WorkSetup' : WorkSetup,
//         if (formSalary != null) 'formSalary' : formSalary,
//         if (JobType != null) 'JobType' : JobType,
//         if (toSalary != null) 'toSalary' : toSalary,
//         if (Education != null) 'Education' : Education,
//         if (Experience != null) 'Experience' : Experience,
//         if (ProvinceIds != null) 'ProvinceId[]': ProvinceIds.join(','),
//         if (CityIds != null) 'CityId[]': CityIds.join(','),
//         if (Page != null) 'Page' : page.value.toString(),
//       };
//       final response = await http.post(Uri.parse(AppUrl.SearchJob), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? '',}, body: body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Map<String, dynamic> responseData = jsonDecode(response.body);
//         if (responseData.containsKey('data') && responseData['data'] != null) {
//           List<dynamic> newJobs = responseData['data'];
//           List<dynamic> existingJobs = List.from(Fidingdata['data'] ?? []);
//           existingJobs.addAll(newJobs);
//           responseData['data'] = existingJobs;
//           Fidingdata.assignAll(responseData);
//           print({body});
//           if (newJobs.isNotEmpty) {page.value++;}
//           else {hasMoreData.value = false;}}
//         else {hasMoreData.value = false;}
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       isLoding.value = false;
//     }
//   }
//
//   Future<void> resetPagination() async {
//     Fidingdata.clear(); page.value = 1; hasMoreData.value = true; previousParams.value = ''; //1 Reset stored parameters
//     await FindAPIController_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: '0', Timezone: 'asia/kolkata', Page: page.value.toString());
//   }
// }

// class FindAPIController extends GetxController {
//   final ScrollController scrollController = ScrollController();
//
//   var isLoding = false.obs;
//   var Fidingdata = <String, dynamic>{}.obs;
//   var page = 1.obs;
//   var hasMoreData = true.obs;
//   var previousParams = ''.obs; // Tracks current filter parameters
//
//   @override
//   void onInit() {
//     super.onInit();
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 &&
//           !isLoding.value &&
//           hasMoreData.value && previousParams.isNotEmpty) {
//         FindAPIController_Fuction(
//           Tokan: Tokans,
//           CandidateId: Candidate,
//           IsWeb: '0',
//           Timezone: 'asia/kolkata',
//           Page: page.value.toString(),
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> FindAPIController_Fuction({
//     String? Timezone,
//     String? CandidateId,
//     String? Tokan,
//     String? IsWeb,
//     String? WorkSetup,
//     String? formSalary,
//     String? JobType,
//     String? toSalary,
//     String? Education,
//     String? Experience,
//     String? TechId,
//     String? JobId,
//     List? ProvinceIds,
//     List? CityIds,
//     String? Page,
//     bool isFilterSearch = false,
//   }) async {
//     if (isLoding.value || !hasMoreData.value) return;
//
//     try {
//       isLoding.value = true;
//
//       // Construct current parameters
//       Map<String, dynamic> currentFilterParams = {
//         'Timezone': Timezone,
//         'CandidateId': CandidateId,
//         'Tokan': Tokan,
//         'IsWeb': IsWeb,
//         'WorkSetup': WorkSetup,
//         'formSalary': formSalary,
//         'JobType': JobType,
//         'toSalary': toSalary,
//         'Education': Education,
//         'Experience': Experience,
//         'TechId': TechId,
//         'JobId': JobId,
//         'ProvinceIds': ProvinceIds,
//         'CityIds': CityIds,
//         'Page' : Page
//       };
//       String currentParamsStr = jsonEncode(currentFilterParams);
//
//       // Reset pagination if parameters change or it's a filter search
//       if (isFilterSearch || currentParamsStr != previousParams.value) {
//         Fidingdata.clear();
//         page.value = 1;
//         hasMoreData.value = true;
//         previousParams.value = currentParamsStr;
//       }
//
//       // Build the request body with correct array encoding
//       var body = {
//         if (Timezone != null) 'Timezone': Timezone,
//         if (CandidateId != null) 'CandidateId': CandidateId,
//         if (IsWeb != null) 'IsWeb': IsWeb,
//         if (TechId != null) 'TechId': TechId,
//         if (JobId != null) 'JobId': JobId,
//         if (WorkSetup != null) 'WorkSetup': WorkSetup,
//         if (formSalary != null) 'formSalary': formSalary,
//         if (JobType != null) 'JobType': JobType,
//         if (toSalary != null) 'toSalary': toSalary,
//         if (Education != null) 'Education': Education,
//         if (Experience != null) 'Experience': Experience,
//         if (Page != null) 'Page': page.value.toString(),
//       };
//
//       // Add ProvinceIds as multiple entries
//       if (ProvinceIds != null) {
//         for (var id in ProvinceIds) {
//           body['ProvinceId[]'] = id.toString();
//         }
//       }
//
//       // Add CityIds as multiple entries
//       if (CityIds != null) {
//         for (var id in CityIds) {
//           body['CityId[]'] = id.toString();
//         }
//       }
//
//       final response = await http.post(
//         Uri.parse(AppUrl.SearchJob),
//         headers: {
//           API_KEY.api_key: API_KEY.key,
//           Clientip.clientip: Clientip.ip,
//           Logintoken.logintoken: Tokan ?? '',
//         },
//         body: body,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Map<String, dynamic> responseData = jsonDecode(response.body);
//
//         if (responseData.containsKey('data') && responseData['data'] != null) {
//           List<dynamic> newJobs = responseData['data'];
//           List<dynamic> existingJobs = List.from(Fidingdata['data'] ?? []);
//           existingJobs.addAll(newJobs);
//           responseData['data'] = existingJobs;
//
//           Fidingdata.assignAll(responseData);
//
//           hasMoreData.value = newJobs.isNotEmpty;
//           if (hasMoreData.value) page.value++;
//         } else {
//           hasMoreData.value = false;
//         }
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoding.value = false;
//     }
//   }
//
//   /// Apply filters and reset pagination
//   Future<void> ApplyFilters({
//     String? WorkSetup,
//     String? formSalary,
//     String? JobType,
//     String? toSalary,
//     String? Education,
//     String? Experience,
//     String? TechId,
//     String? JobId,
//     List? ProvinceIds,
//     List? CityIds,
//   }) async {
//     await FindAPIController_Fuction(
//       WorkSetup: WorkSetup,
//       formSalary: formSalary,
//       JobType: JobType,
//       toSalary: toSalary,
//       Education: Education,
//       Experience: Experience,
//       TechId: TechId,
//       JobId: JobId,
//       ProvinceIds: ProvinceIds,
//       CityIds: CityIds,
//       isFilterSearch: true,
//     );
//   }
//
//   Future<void> resetPagination() async {
//     Fidingdata.clear();
//     page.value = 1;
//     hasMoreData.value = true;
//     previousParams.value = '';
//     await FindAPIController_Fuction(
//       Tokan: Tokans,
//       CandidateId: Candidate,
//       IsWeb: '0',
//       Timezone: 'asia/kolkata',
//       Page: page.value.toString(),
//     );
//   }
// }

// class FilterControllrs extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     FilterControllrs_Fuction(Tokan: Tokans, CandidateId: Candidate, IsWeb: '0', Timezone: 'asia/kolkata');
//   }
//
//   var isLoding = false.obs; var Fidingdata = {}.obs;
//
//   Future<void> FilterControllrs_Fuction({String? Timezone, String? CandidateId, String? Tokan, String? IsWeb, String? WorkSetup, String? formSalary, String? JobType, String? toSalary, String? Education, String? Experience, String? TechId, String? JobId, List? ProvinceIds, List? CityIds})
//   async {
//     try {
//       isLoding.value = true;
//
//       // Convert list data to comma-separated strings
//       Map<String, String> body = {
//         if (Timezone != null) 'Timezone': Timezone,
//         if (CandidateId != null) 'CandidateId': CandidateId,
//         if (IsWeb != null) 'IsWeb': IsWeb,
//         if (TechId != null) 'TechId': TechId,
//         if (JobId != null) 'JobId': JobId,
//         if (WorkSetup != null) 'WorkSetup' : WorkSetup,
//         if (formSalary != null) 'formSalary' : formSalary,
//         if (JobType != null) 'JobType' : JobType,
//         if (toSalary != null) 'toSalary' : toSalary,
//         if (Education != null) 'Education' : Education,
//         if (Experience != null) 'Experience' : Experience,
//         if (ProvinceIds != null) 'ProvinceId[]': ProvinceIds.join(','),
//         if (CityIds != null) 'CityId[]': CityIds.join(','),
//       };
//
//       final response = await http.post(Uri.parse(AppUrl.SearchJob), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? '',}, body: body);
//       print({body});
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Fidingdata.value = jsonDecode(response.body);
//         log('Fidingdata :- $Fidingdata');
//       } else {
//         throw "Search Job Error FilterJobes: ${response.statusCode}, ${response.body}";
//       }
//     } catch (e) {
//       log('$e');
//     } finally {
//       isLoding.value = false;
//     }
//   }
// }
