// ignore_for_file: non_constant_identifier_names, override_on_non_overriding_member, avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:hirexpert/view/utils/appUrl.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_error.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../../view/utils/app_constance.dart';
import '../../../../API_Controller/Candidate/Menu/Home/CanProfile_Update_API.dart';
import '../../../../API_handler/Candidate/Menu/profile/information_handler.dart';

class PickImageController extends GetxController {
  CanProfile_Update_API canProfile = Get.put(CanProfile_Update_API());
  InformationHandler Infoem = Get.put(InformationHandler());

  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        await uploadImage();
        update();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (image == null) {
      print('No image selected');
      return;
    }

    String uploadUrl = AppUrl.update_profile;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.headers.addAll({'API-KEY': API_KEY.key, 'Clientip': Clientip.ip, 'Logintoken': Tokans, 'Cookie': 'ci_session=p55910l1f76eglrr9c0lhp8ng9uf1am1'});
      request.fields['CandidateId'] = Candidate;
      var file = await http.MultipartFile.fromPath('Profile', image!.path);
      request.files.add(file);

      var response = await request.send();
      final res = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        ToastificationSuccess.Success('Image uploaded successfully');
        print('Response: ${res.body}');
      } else {
        print('Failed to upload image: ${response.statusCode}, ${res.body}');
        print('Error Response: ${res.body}');
      }
    } catch (e) {
      print('Upload error: $e');
      ToastificationError.Error('$e');
    }
  }
}
