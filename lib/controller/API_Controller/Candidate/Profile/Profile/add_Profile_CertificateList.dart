// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;
import '../../../../../view/utils/common/Tostification/Toastification_success.dart';

class AddProfileCertificatelist extends GetxController {
  var isLoding = false.obs;
  var AddProfileCertificatelist_data;

  Future AddProfileCertificatelist_fuction({String? CandidateId, String? Title, String? CertNum, String? IssueDate, String? ExpireDate, String? Tokan, String? ImageType, String? ImageUrl, String? Image})
  async {

    print('CandidateId :- $CandidateId');
    print('Title :- $Title');
    print('CertNum :- $CertNum');
    print('IssueDate :- $IssueDate');
    print('ExpireDate :- $ExpireDate');

    final body = {'CandidateId': CandidateId, 'Title': Title, 'CertNum': CertNum, 'IssueDate': IssueDate, 'ExpireDate': ExpireDate, 'ImageType': ImageType, 'ImageUrl': ImageUrl, 'Image': Image};
    print('AddProfileCertificatelist :- $body');

    try {
      final responce = await http.post(Uri.parse(AppUrl.CertificateList_list_add), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''}, body: body);
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        AddProfileCertificatelist_data = jsonDecode(responce.body);
        log('AddProfileCertificatelist_data ADD :- $AddProfileCertificatelist_data');
        ToastificationSuccess.Success(AddProfileCertificatelist_data['message']);
      } else {
        throw {
          'AddProfileCertificatelist_data :- ${responce.body},${responce.statusCode}',
          log('AddProfileCertificatelist_data :- ${responce.body},${responce.statusCode}'),
        };
      }
    } catch (e) {
      log('AddProfileCerticateList Error $e');
    } finally {
      isLoding.value = false;
    }
  }
}
