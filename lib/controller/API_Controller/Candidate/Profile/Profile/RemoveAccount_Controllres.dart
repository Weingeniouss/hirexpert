// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;

class RemoveaccountControllres extends GetxController{
  var isLoding = false.obs;
  var Removeaccount_data;

  @override
  void onInit() {
    Removeaccount_fuction();
    super.onInit();
  }

  Future Removeaccount_fuction({String? OwnRemove, String? UserBy, String? UserType, String? Tokan})async{
    print('OwnRemove : $OwnRemove');
    print('UserBy : $UserBy');
    print('UserType : $UserType');

    final body = {
      'OwnRemove' : OwnRemove,
      'UserBy' : UserBy,
      'UserType' : UserType,
    };

    print(body);

    try{
      isLoding.value = true;

      final responce = await http.post(Uri.parse(AppUrl.RemoveAccount),headers: {
        API_KEY.api_key : API_KEY.key,
        Clientip.clientip : Clientip.ip,
        Logintoken.logintoken : Tokan ?? ''
      },
        body: body,
      );

      if(responce.statusCode == 200 || responce.statusCode == 201){
        Removeaccount_data = jsonDecode(responce.body);
        print('Removeaccount_data :- $Removeaccount_data');
      }else{
        throw{
          '${responce.statusCode}, ${responce.body}',
        };
      }
    }catch(e){'RemoveAccount Error :- $e';}finally{
      isLoding.value = false;
    }
  }
}