// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_color.dart';

class JobSearch extends StatelessWidget {

  String Icon; Widget? Threedot; bool? Sharebool; bool? Sharebool2; Color? Color_container; String Job_Tital; String Language; String Commpany; String Working; String Location; String Job_time; String Exp; String lake; String Hybrid; String? jobid; String stats; BorderSide top; BorderSide? bottam; void Function()? onTap; void Function()? saveonTap; void Function()? ThreedotTap;Widget? savechild; Widget? Share;

  JobSearch({super.key, required this.Icon, this.Color_container, required this.Job_Tital, required this.Language, required this.Commpany, required this.Working, required this.Location, required this.Job_time, required this.Exp, required this.lake, required this.Hybrid, required this.stats, this.onTap, required this.top, this.saveonTap,this.Threedot, this.bottam, this.savechild, this.ThreedotTap, this.Share, this.Sharebool = false, this.Sharebool2 = false, String? JobID});
  bool isSeved = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width/20), height: Get.height / 3.5, width: Get.width,
        decoration: BoxDecoration(border: Border(top: top), color: AppColor.Full_body_color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width / 40),
                  child: Container(width: Get.width / 5.5, height: Get.height / 12, decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 30), color: Color_container, image: DecorationImage(image: NetworkImage(Icon), fit: BoxFit.fill))),
                ),
                Column(
                  children: [
                    SizedBox(width:Get.width/2, child: Text(Job_Tital, style: TextStyle(color: AppColor.subcolor,fontSize: size.width / 30))),
                    SizedBox(width: Get.width / 2, child: Text(Language, style: TextStyle(fontSize: size.width / 30, fontWeight: FontWeight.w600))),
                    SizedBox(width: Get.width/2, child: Text(Commpany, style: TextStyle(fontSize: size.width / 30, fontWeight: FontWeight.w400, color: AppColor.Button_color))),
                  ],
                ),
                GestureDetector(onTap: saveonTap, child: savechild),
                (Sharebool2 == true) ? SizedBox() : GestureDetector(onTap: ThreedotTap, child: Threedot),
              ],
            ),

            SizedBox(height: size.height / 70),
             Expanded(child: showCategory(Working: Working, Location: Location, Job_time: Job_time, Exp: Exp, lake: lake, Hybrid: Hybrid)),
            // Wrap(
            //   spacing: Get.height / 180, runSpacing: Get.width / 130,  alignment: WrapAlignment.start, direction: Axis.horizontal,
            //   children: [
            //     Container(width:Get.width/6, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(Working, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 30),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //     Container(width:Get.width/5, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(Location, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 30),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //     Container(width:Get.width/6, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(Job_time, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 30),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //     Container(width:Get.width/6, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(Exp, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 35),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //     Container(width:Get.width/3, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(lake, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 30),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //     Container(width:Get.width/3.5, padding: EdgeInsets.all(5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width / 60), color: AppColor.ditalis_conatiner), child: Center(child: Text(Hybrid, style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.width / 30),maxLines: 1,overflow: TextOverflow.ellipsis))),
            //   ],
            // ),
            SizedBox(height: size.height / 70),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text(stats, style: TextStyle(color: AppColor.subcolor))]),
            (Sharebool == true)
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(height: Get.height / 50),
                        Container(
                          height: Get.height / 20, width: Get.width,
                          decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColor.offButton_color))),
                          child: Share,
                        ),
                      ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget showCategory({required String Working, required String Hybrid, required String Location, required String Job_time, required String Exp, required String lake,}) {
  List<Map<String, String>> categories = [
    {'Categories': Working},
    {'Categories': Location},
    {'Categories': Job_time},
    {'Categories': Exp},
    {'Categories': lake},
    {'Categories': Hybrid},
  ];

  return Wrap(
    spacing: 5, runSpacing: -2,
    children: categories.map((category) {
      return Chip(
        elevation: 0,
        label: Text(category['Categories']!, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Get.width / 32)),
        backgroundColor: AppColor.ditalis_conatiner,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.transparent)),
      );
    }).toList(),
  );
}
