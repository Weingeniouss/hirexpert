// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer extends StatelessWidget {
  final String pdfs;
  Pdfviewer({super.key, required this.pdfs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width, height: Get.height,
        decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: SfPdfViewer.network(pdfs),
      ),
    );
  }
}
