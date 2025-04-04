// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationSuccess{
  static void Success(String description){
    toastification.show(
      dragToClose: true,
      description: Text(description),
      dismissDirection: DismissDirection.startToEnd,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      autoCloseDuration: Duration(seconds: 2),
      boxShadow: kElevationToShadow[2],
    );
  }
}