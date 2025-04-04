// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app_color.dart';

class WideButton extends StatelessWidget {
  final Color? B_Colors; final String text; final String Icon; final double? width_r; final double? height_R; final double? fontSize_r;
  WideButton({super.key, required this.text, required this.Icon, this.width_r, this.height_R, this.fontSize_r, this.B_Colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height_R ?? Get.height / 15, width: width_r ?? Get.width,
      decoration: BoxDecoration(border: Border.all(color: B_Colors ?? AppColor.Button_color, width: 2), borderRadius: BorderRadius.circular(Get.width / 80), color: B_Colors ?? AppColor.Button_color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Icon, color: AppColor.Full_body_color), SizedBox(width: Get.width / 30),
          Text(text, style: TextStyle(fontSize: fontSize_r ?? Get.width / 26, color: AppColor.Full_body_color)),
        ],
      ),
    );
  }
}

class OnButtons extends StatelessWidget {
  final Color Button_Color; final Color? Boder_Button_Color; final String btn_name; final void Function()? onTap; final double? width_r; final double? height_R; final double? fontSize_r;
  const OnButtons({super.key, required this.Button_Color, required this.btn_name, this.onTap, this.Boder_Button_Color, this.width_r, this.height_R, this.fontSize_r,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height_R ?? Get.height / 15, width: width_r ?? Get.width,
        decoration: BoxDecoration(border: Border.all(color: Boder_Button_Color ?? AppColor.Button_color, width: 2,), borderRadius: BorderRadius.circular(Get.width / 80), color: Button_Color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(btn_name, style: TextStyle(fontSize: fontSize_r  ?? Get.width / 26, fontWeight: FontWeight.w600, color: AppColor.Full_body_color)))
          ],
        ),
      ),
    );
  }
}
