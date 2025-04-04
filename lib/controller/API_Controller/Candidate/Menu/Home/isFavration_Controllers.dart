// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/app_constance.dart';

class FavouriteResponse {

  final bool status; final String message; final int isFavourite;

  FavouriteResponse({required this.status, required this.message, required this.isFavourite});

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteResponse(status: json['status'], message: json['message'], isFavourite: int.parse(json['IsFavourite'].toString()));
  }
}

class IsfavrationControllers extends GetxController {
  var isloding = false.obs;
  var isFavration = FavouriteResponse(status: false, message: '', isFavourite: 0).obs;

  @override
  void onInit() {
    IsfavrationControllers_fuction(CandidateId: Candidate, JobId: '', IsLike: '', Tokan: Tokans);
    super.onInit();
  }

  Future IsfavrationControllers_fuction({String? CandidateId, String? JobId, String? IsLike,  String? Tokan}) async {
    try {
      isloding.value = true;

      final responce = await http.get(Uri.parse('${AppUrl.IsFavourite}?CandidateId=$CandidateId&JobId=$JobId&IsLike=$IsLike',), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});

      print("CandidateId :-  $CandidateId");
      print("JobId :-  $JobId");
      print("IsLike :-  $IsLike");
      print("Tokan :-  $Tokan");

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        isFavration = jsonDecode(responce.body);
        print("isFavication data :- $isFavration");
      } else {
        throw {
          'isFavication is thir Error :-  ${responce.statusCode}, ${responce.body}',
        };
      }
    } catch (e) {
      'isfavication Error :- $e';
    } finally {
      isloding.value = false;
    }
  }
}
