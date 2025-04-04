// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_color.dart';

//With Leble
class Inputfild extends StatelessWidget {
  final String labal;
  final String hint;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextStyle? style;
  final double? fontSize_r;

   Inputfild({super.key, required this.labal, required this.hint, this.suffixIcon, required this.controller, this.obscureText, this.keyboardType, this.onChanged, this.onTap, this.style, this.readOnly, this.fontSize_r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labal,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: fontSize_r ?? Get.width / 25, color: AppColor.subcolor),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: fontSize_r ?? Get.width / 22, color: AppColor.Error_color),
              ),
            ],
          ),
        ),
        TextField(
          readOnly: readOnly ?? false,
          onTap: onTap,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          controller: controller,
          style: style,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: TextStyle(color: AppColor.black_all),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.offButton_color)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.offButton_color)),
          ),
        ),
      ],
    );
  }
}

