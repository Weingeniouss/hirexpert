// ignore_for_file: deprecated_member_use, non_constant_identifier_names, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app_color.dart';
import '../../app_icon.dart';

class Threedot extends StatelessWidget {
  const Threedot({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppIcons.threedots,height: 22,width: 22,color: AppColor.subcolor);
  }
}

class icons extends StatelessWidget {
  final String iconss; final Color? iconcolor;
  const icons({super.key, required this.iconss,this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Row(children: [SvgPicture.asset(iconss,width: 20,height: 20 ,color: iconcolor), SizedBox(width: Get.width / 20)]);
  }
}

