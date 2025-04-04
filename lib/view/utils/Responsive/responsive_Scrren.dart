// ignore_for_file: use_super_parameters, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? mcroMobile;

  const ResponsiveWidget({Key? key, required this.mobile, this.tablet, this.desktop, this.mcroMobile}) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool ismcroMobile(BuildContext context) => MediaQuery.of(context).size.width > 300 && MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 1200 && MediaQuery.of(context).size.width < 2556;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (isTablet(context) && tablet != null) {
      return tablet!;
    } else if(ismcroMobile(context) && mcroMobile != null){
      return mcroMobile!;
    }else {
      return mobile;
    }
  }
}