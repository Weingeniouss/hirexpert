// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/app_constance.dart';
import 'package:http/http.dart' as http;

class SendmessageController extends GetxController {
  var isloding = false.obs;
  var SendmessageController_data;

  Future<void> SendmessageController_Fuction({String? MsgType, String? JobIds, String? RoomId, String? MSenderId, String? ReceiverId, String? Message, String? Tokan})
  async {

    isloding.value = true;

    try {
      final body = {
        'MsgType': MsgType,
        'JobId': JobIds,
        'RoomId': RoomId,
        'MSenderId': MSenderId,
        'ReceiverId': ReceiverId,
        'Message': Message,
      };

      print('Sent Message After:- $body');

      final responce = await http.post(Uri.parse(AppUrl.sendMessage),
          body: body,
          headers: {API_KEY.api_key: API_KEY.key, Clientip.clientip: Clientip.ip, Logintoken.logintoken: Tokan ?? ''});
      print('Sent Message Before:- $body');

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        SendmessageController_data = jsonDecode(responce.body);
        print(SendmessageController_data);
      }
    } catch (e) {
      'Sendmessage Error : -$e';
    } finally {
      isloding.value = false;
    }
  }
}


class MessageController extends GetxController {
  Future<void> sendMessage({
  required String msgType,
  required String jobId,
  required String roomId,
  required String mSenderId,
  required String receiverId,
  String? message,
  String? fileImagePath,
}) async {
  const String url = AppUrl.sendMessage;
  const String apiKey = API_KEY.key;
  const String clientIp = Clientip.ip;
  String loginToken = Tokans;

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll({
        'API-KEY': apiKey,
        'Clientip': clientIp,
        'Logintoken': loginToken,
      })
      ..fields.addAll({
        'MsgType': msgType,
        'JobId': jobId,
        'RoomId': roomId,
        'MSenderId': mSenderId,
        'ReceiverId': receiverId,
        'Message': message ?? '',
      });

    // Ensure image is properly attached
    if (fileImagePath != null && fileImagePath.isNotEmpty) {
      var file = File(fileImagePath);
      if (await file.exists()) {
        request.files.add(await http.MultipartFile.fromPath('FileImage[]', fileImagePath));
      } else {
        print("File not found at path: $fileImagePath");
      }
    }

    // Send the request
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("✅ Message Sent Successfully: $responseData");
    } else {
      print("❌ Failed to send message. Status: ${response.statusCode}, Response: $responseData");
    }
  } catch (e) {
    print("⚠️ Error while sending message: $e");
  }
}
}