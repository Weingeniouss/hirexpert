// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;

class AddfeedbackControllers extends GetxController {
  var isLoding = false.obs;
  var Addfeedback_data;

  @override
  void onInit() {
    Addfeedback_fuction();
    super.onInit();
  }

  Future Addfeedback_fuction({String? Comment, String? FeedbackType, String? Tokans}) async {
    print('Comment : $Comment');
    print('FeedbackType : $FeedbackType');
    print('Tokans : $Tokans');

    final body = {
      'Comment': Comment,
      'FeedbackType': FeedbackType,
    };

    print("Body :- $body");

    try {
      isLoding.value = true;

      final responce = await http.post(Uri.parse(AppUrl.AddFeedback), headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokans ?? ''}, body: body);

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Addfeedback_data = jsonDecode(responce.body);
        print('Addfeedback_data :- $Addfeedback_data');
      } else {
        ToastificationError.Error('${responce.statusCode}, ${responce.body}');
        throw {'${responce.statusCode}, ${responce.body}'};
      }
    } catch (e) {
      'AddFeedBack Error: - $e';
    } finally {
      isLoding.value = false;
    }
  }
}
