// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class WithdrowApplicationController extends GetxController {
  var isLoding = false.obs;  var WithdrowApplicationdata = {}.obs;

  Future<void> WithdrowApplication_Fuction({String? Tokan, String? CandidateId, String? JobApplyId, int? IsDeleted})
  async {
    print({'Tokan' : Tokan, 'CandidateId' : CandidateId, 'JobApplyId' : JobApplyId, 'IsDeleted' : IsDeleted,});

    try {
      isLoding.value = true;

      final Response = await http.get(Uri.parse('${AppUrl.CanWithdrawJob}?CandidateId=$CandidateId&JobApplyId=$JobApplyId&IsDeleted=$IsDeleted'), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});

      print({'Tokan' : Tokan, 'CandidateId' : CandidateId, 'JobApplyId' : JobApplyId, 'IsDeleted' : IsDeleted,});

      if (Response.statusCode == 200 || Response.statusCode == 201) {
        WithdrowApplicationdata.value = jsonDecode(Response.body); print('WithdrowApplicationdata :- $WithdrowApplicationdata');
      } else {
        throw {
          'WithdrowApplicationdata Data Error :- ${Response.statusCode}, ${Response.body}'
        };
      }
      print({'Tokan' : Tokan, 'CandidateId' : CandidateId, 'JobApplyId' : JobApplyId, 'IsDeleted' : IsDeleted,});
    } catch (e) {
      print('WithdrowApplicationdata Error :- $e');
    } finally {
      isLoding.value = false;
    }
  }
}
