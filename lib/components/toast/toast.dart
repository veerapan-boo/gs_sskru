import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

void toast(String title, String message) {
  Get.snackbar(
    '', // title
    message, // message
    titleText: Text(title),
    snackPosition: SnackPosition.BOTTOM,
    barBlur: 20,
    isDismissible: true,
    maxWidth: kMaxWidth,
    borderRadius: 0.0,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.grey.withOpacity(.15),
  );
}
