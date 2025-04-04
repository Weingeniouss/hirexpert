// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app_color.dart';

class Jobrow extends StatelessWidget {
  final String icon;final String name;final Widget? child;final void Function()? onTap;
  const Jobrow({super.key, required this.icon, required this.name, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent, focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: Get.width / 2.3, height: Get.height / 5,
        decoration: BoxDecoration(color: AppColor.BoxShodwcolor.withOpacity(0.03), borderRadius: BorderRadius.circular(Get.width / 30)),
        child: Stack(children: [
          Positioned(right: 17, bottom: 130, child: SizedBox(child: child)),
          Positioned(
            right: 50, bottom: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width / 8, height: Get.height / 17,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width / 50), color: AppColor.Button_color),
                  child: Padding(padding: EdgeInsets.all(15), child: SvgPicture.asset(icon, color: AppColor.Full_body_color)),
                ),
                SizedBox(width: Get.width / 30),
              ],
            ),
          ),
          Positioned(width: Get.width /5, right: 48, bottom: 40, child: Text(textAlign: TextAlign.center, name, style: TextStyle(fontSize: Get.width / 25,fontWeight: FontWeight.w700))),
        ]),
      ),
    );
  }
}
