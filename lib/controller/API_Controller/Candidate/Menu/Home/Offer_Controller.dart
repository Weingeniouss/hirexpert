// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unnecessary_this

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class OfferController extends GetxController {
  var isLoding = false.obs;
  var OfferData = {}.obs;
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  Future<void> OfferControllers_fuction({String? Page, String? Timezone, String? CandidateId, String? JobStatus, String? Tokan}) async {
    if (!hasMoreData.value) return;
    try {
      isLoding.value = true;
      final responce = await http.get(Uri.parse('${AppUrl.Offes}?Page=${currentPage.value}&Timezone=$Timezone&CandidateId=$CandidateId&JobStatus=$JobStatus'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map<String, dynamic> responceData = jsonDecode(responce.body);
        if (responceData.isNotEmpty) {
          print({'${AppUrl.Offes}?Page=${currentPage.value}&Timezone=$Timezone&CandidateId=$CandidateId&JobStatus=$JobStatus'});
          print('Page :- $Page');
          print('Timezone :- $Timezone');
          print('CandidateId :- $CandidateId');
          print('JobStatus :- $JobStatus');
          print('Tokan :- $Tokan');
          OfferData.assignAll(responceData); currentPage.value++;
        } else {
          hasMoreData.value = false;
        }
      } else {
        throw 'Offerdata Error :- ${responce.statusCode}, ${responce.body}';
      }
    } catch (e) {
      print("Offer data Error :- $e");
    } finally {
      isLoding.value = false;
    }
  }
}

// class OfferController extends GetxController {
//   var isLoding = false.obs;
//   var data = {}.obs;
//
//   // Future OfferController_fuction({required String CompanyId, required String Page, required String Timezone, required String JobStatus, required String Tokan}) async {
//   //   try {
//   //     isLoding.value = true;
//   //
//   //     final responce = await http.get(Uri.parse('${AppUrl.Offer}?CompanyId=$CompanyId&Page=$Page&Timezone=$Timezone&JobStatus=$JobStatus'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan});
//   //     if (responce.statusCode == 200 || responce.statusCode == 201) {
//   //       data.value = jsonDecode(responce.body);
//   //       print('Offer data :- $data');
//   //     } else {
//   //       throw {
//   //         'Offer data Error this :-  ${responce.statusCode}, ${responce.body}'
//   //       };
//   //     }
//   //   } catch (e) {
//   //     "Offer data Error $e";
//   //   } finally {
//   //     isLoding.value = false;
//   //   }
//   // }
//
//   var OfferData = {}.obs;
//
//   Future<void> OfferControllers_fuction({String? Page, String? Timezone, String? CandidateId, String? JobStatus, String? Tokan})
//   async {
//     try {
//       isLoding.value = true;
//       final responce = await http.get(Uri.parse('${AppUrl.Offes}?Page=$Page&Timezone=$Timezone&CandidateId=$CandidateId&JobStatus=$JobStatus'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});
//       if (responce.statusCode == 200 || responce.statusCode == 201) {
//         print({'Page' : Page, 'Timezone' : Timezone, 'CandidateId' : CandidateId, 'JobStatus' : JobStatus});
//         OfferData.value = jsonDecode(responce.body); print('Offerdata :- $OfferData');
//       } else {
//         throw {'Offerdata Error :- ${responce.statusCode},${responce.body}'};
//       }
//     } catch (e) {
//       print("Offer data Error :- $e");
//     } finally {
//       isLoding.value = false;
//     }
//   }
// }
//
// // class OfferController extends GetxController {
// //   var isLoding = false.obs;
// //   var OfferData = <String, dynamic>{}.obs;
// //   var page = 1.obs;
// //   var hasMoreData = true.obs;
// //
// //   // @override
// //   // void onInit() {
// //   //   OfferControllers_fuction(CandidateId: Candidate, Page: '1', Timezone: 'asia/kolkata', JobStatus: '', Tokan: Tokans);
// //   //
// //   //   scrollController.addListener(() {
// //   //     if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 && !isLoding.value) {
// //   //       OfferControllers_fuction(CandidateId: Candidate, Page: page.value.toString(), Timezone: 'asia/kolkata', JobStatus: '', Tokan: Tokans);
// //   //     }
// //   //   });
// //   //
// //   //   super.onInit();
// //   // }
// //   //
// //   // @override
// //   // void dispose() {
// //   //   scrollController.dispose();
// //   //   super.dispose();
// //   // }
// //
// //   Future<void> OfferControllers_fuction({required String CandidateId, required String Page, required String Timezone, required String JobStatus, required String Tokan})
// //   async {
// //     if (isLoding.value || !hasMoreData.value) return;
// //
// //     try {
// //       isLoding.value = true;
// //       String url = '${AppUrl.Offes}?Page=$Page&Timezone=$Timezone&CandidateId=$CandidateId&JobStatus=$JobStatus';
// //
// //       log('Fetching Offers Page: $page with URL: $url');
// //
// //       final response = await http.get(
// //         Uri.parse(url),
// //         headers: {
// //           API_KEY.api_key: API_KEY.key,
// //           Clientip.clientip: Clientip.ip,
// //           Logintoken.logintoken: Tokan,
// //         },
// //       );
// //
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         Map<String, dynamic> responseData = jsonDecode(response.body);
// //         List<dynamic> newData = responseData['data'] ?? [];
// //
// //         if (newData.isNotEmpty) {
// //           List<dynamic> filteredData = newData.map((offer) {
// //             var modifiedOffer = Map<String, dynamic>.from(offer);
// //             modifiedOffer.remove('JobId');
// //             return modifiedOffer;
// //           }).toList();
// //
// //           OfferData.addAll(filteredData as Map<String, dynamic>);
// //           this.page.value++;
// //         } else {
// //           hasMoreData.value = false;
// //         }
// //       } else {
// //         log("Offer Data Error: ${response.statusCode} - ${response.body}");
// //       }
// //     } catch (e) {
// //       log('Error fetching offers: $e');
// //     } finally {
// //       isLoding.value = false;
// //     }
// //   }
// //
// //   Future<void> resetPagination() async {
// //     OfferData.clear();
// //     page.value = 1;
// //     hasMoreData.value = true;
// //     await OfferControllers_fuction(CandidateId: Candidate, Page: '1', Timezone: 'asia/kolkata', JobStatus: '', Tokan: Tokans);
// // }
// // }
