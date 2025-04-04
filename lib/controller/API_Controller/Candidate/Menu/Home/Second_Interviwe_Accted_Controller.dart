// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/utils/API_Key.dart';
import '../../../../../view/utils/appUrl.dart';
import '../../../../../view/utils/common/Tostification/Toastification_success.dart';

class SecondInterviweAcctedController extends GetxController{
  var isloding =  false.obs; Map<String,dynamic> SecondInterviweAcctedata = {};

  Future<void> SecondInterviewController_Fuction({required String Tokan, required String ScheduleStatus, required String JobApplyId, required String InterviewId,})
  async {

    Map<String, String> body = {'ScheduleStatus' : ScheduleStatus, 'JobApplyId' : JobApplyId, 'InterviewId' : InterviewId};

    try {
      isloding.value = true;
      update();

      final responce = await http.post(Uri.parse(AppUrl.CanIntReply), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan}, body: body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        var decodedResponse = jsonDecode(responce.body);
        if (decodedResponse is Map<String, dynamic>) {
          SecondInterviweAcctedata = decodedResponse;
          ToastificationSuccess.Success(decodedResponse['data']['Message']);
          log('SecondInterviweAcctedata :- ${jsonEncode(SecondInterviweAcctedata)}');
        } else {
           ToastificationError.Error(decodedResponse['data']['Message']);
          print('Unexpected response format: $decodedResponse');
        }
      } else {
        print('SecondInterviweAcctedata Error :- ${responce.statusCode}, ${responce.body}');
      }
      update();
    } catch (e) {
      print('SecondInterviweAcctedata Error :- $e');
    } finally {
      isloding.value = false;
      update();
    }
  }
}