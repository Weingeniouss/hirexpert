// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class SetmagController extends GetxController {
  var isLoding = false.obs;
  var SetMassge_data;

  Future<void> SetMassage_Fuction({String? RoomId, String? IsCandidate, String? EmpCanId, String? JobId, String? MsgType, String? Message, String? SenderId, String? ReceiverId, File? FileImage, String? Tokan,}) async {
    var uri = Uri.parse(AppUrl.setmsg);
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({'API-KEY': API_KEY.key, 'Clientip': Clientip.ip, 'Logintoken': Tokan ?? '',});

    request.fields['IsCandidate'] = IsCandidate ?? '';
    request.fields['EmpCanId'] = EmpCanId ?? '';
    request.fields['JobId'] = JobId ?? '';
    request.fields['MsgType'] = MsgType ?? '';
    request.fields['Message'] = Message ?? '';
    request.fields['SenderId'] = SenderId ?? '';
    request.fields['ReceiverId'] = ReceiverId ?? '';

    print('IsCandidate :-  ${request.fields['IsCandidate']}');
    print('EmpCanId :-  ${request.fields['EmpCanId']}');
    print('JobId :-  ${request.fields['JobId']}');
    print('MsgType :-  ${request.fields['MsgType']}');
    print('Message :-  ${request.fields['Message']}');
    print('SenderId :-  ${request.fields['SenderId']}');
    print('ReceiverId :-  ${request.fields['ReceiverId']}');

    if (FileImage != null) {
      var mimeType = lookupMimeType(FileImage.path);
      var fileBytes = await FileImage.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('FileImage', fileBytes, filename: FileImage.path.split('/').last, contentType: MediaType.parse(mimeType ?? 'application/octet-stream')));
    }

    try {
      isLoding.value = true;
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = await response.stream.bytesToString();
        SetMassge_data = jsonDecode(resBody);
        print('Setmag_data: $SetMassge_data');
        print('RoomId :-  ${request.fields['RoomId']}');
        print('IsCandidate :-  ${request.fields['IsCandidate']}');
        print('EmpCanId :-  ${request.fields['EmpCanId']}');
        print('JobId :-  ${request.fields['JobId']}');
        print('MsgType :-  ${request.fields['MsgType']}');
        print('Message :-  ${request.fields['Message']}');
        print('SenderId :-  ${request.fields['SenderId']}');
        print('ReceiverId :-  ${request.fields['ReceiverId']}');
      } else {
        print('Error: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoding.value = false;
    }
  }

  Future<void> SetMassage_Fuction_image({String? RoomId, String? IsCandidate, String? EmpCanId, String? JobId, String? MsgType, String? Message, String? SenderId, String? ReceiverId, File? FileImage, String? Tokan, String? chatroomid,}) async {
    var uri = Uri.parse('https://cidevelop.weingenious.in/hirexpert/api/v1/chat/SendMsg'); // Ensure this is correct
    var request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll({'API-KEY': API_KEY.key, 'Clientip': Clientip.ip, 'Logintoken': Tokan ?? '', 'Cookie': 'ci_session=rnpt19t6lbk7rdgohk0kdsamnuv3q0og'});

    request.fields['IsCandidate'] = IsCandidate ?? '';
    request.fields['EmpCanId'] = EmpCanId ?? '';
    request.fields['JobId'] = JobId ?? '';
    request.fields['MsgType'] = MsgType ?? '';
    request.fields['Message'] = Message ?? '';
    request.fields['SenderId'] = SenderId ?? '';
    request.fields['ReceiverId'] = ReceiverId ?? '';

    print('IsCandidate :-  ${request.fields['IsCandidate']}');
    print('EmpCanId :-  ${request.fields['EmpCanId']}');
    print('JobId :-  ${request.fields['JobId']}');
    print('MsgType :-  ${request.fields['MsgType']}');
    print('Message :-  ${request.fields['Message']}');
    print('SenderId :-  ${request.fields['SenderId']}');
    print('ReceiverId :-  ${request.fields['ReceiverId']}');

    if (FileImage != null) {
      var mimeType = lookupMimeType(FileImage.path) ?? 'application/octet-stream'; // Detect MIME type
      var fileBytes = await FileImage.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('FileImage[]', fileBytes, filename: FileImage.path.split('/').last, contentType: MediaType.parse(mimeType)));
    }

    try {
      isLoding.value = true;
      var response = await request.send();
      var resBody = await response.stream.bytesToString();
      print('Response body: $resBody');

      var contentType = response.headers['content-type'];
      if (contentType != null && contentType.contains('application/json')) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          SetMassge_data = jsonDecode(resBody);
          print('Setmag_data: $SetMassge_data');
          print('IsCandidate :-  ${request.fields['IsCandidate']}');
          print('EmpCanId :-  ${request.fields['EmpCanId']}');
          print('JobId :-  ${request.fields['JobId']}');
          print('MsgType :-  ${request.fields['MsgType']}');
          print('Message :-  ${request.fields['Message']}');
          print('SenderId :-  ${request.fields['SenderId']}');
          print('ReceiverId :-  ${request.fields['ReceiverId']}');
        } else {
          print('Error: ${response.statusCode}');
          print('Response: $resBody');
        }
      } else {
        print('Unexpected response content: $contentType');
        print('Response body: $resBody');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoding.value = false;
    }
  }
}