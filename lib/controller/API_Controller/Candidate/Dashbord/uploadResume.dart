// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:http/http.dart' as http;
import '../../../../view/utils/API_Key.dart';
import '../../../../view/utils/appUrl.dart';

class UploadResume_Controller extends GetxController {
  var isLoading = false.obs;
  var uploadResumeData;

  Future<void> uploadResumeFunction({required String candidateId, required File? resume, required String timezone, required String token,}) async {
    try {
      isLoading.value = true;

      // URL for the API endpoint
      final uploadUrl = Uri.parse(AppUrl.CandidateResume);

      // Create a multipart request
      var request = http.MultipartRequest('POST', uploadUrl);

      // Add headers
      request.headers.addAll({'API-KEY': API_KEY.key, 'Clientip': Clientip.ip, 'Logintoken': token});

      // Add fields
      request.fields['CandidateId'] = candidateId;
      request.fields['Timezone'] = timezone;

      // Add the file if it exists
      if (resume != null) {
        var resumeFile = await http.MultipartFile.fromPath('Resume', resume.path);
        request.files.add(resumeFile);
      }

      // Send the request
      var response = await request.send();

      // Get the response
      final res = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        uploadResumeData = jsonDecode(res.body);
        print('UploadResumeData: $uploadResumeData');
      } else {
        print('Failed to upload resume: ${response.statusCode}, ${res.body}');
        ToastificationError.Error('${response.statusCode}, ${res.body}');
      }
    } catch (e) {
      print('Upload error: $e');
      ToastificationError.Error('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'], // Allow resume file formats
      );

      if (result != null) {
        return File(result.files.single.path!);
      } else {
        print('No file selected');
        return null;
      }
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }
}