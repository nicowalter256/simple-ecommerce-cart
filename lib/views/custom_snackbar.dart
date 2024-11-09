import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecommerce/constants.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.snackbar(
      'Success',
      message,
      icon: Icon(Icons.check_circle, color: Constants.greenBG, size: 20),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      margin: EdgeInsets.all(10 * 0.5),
    );
  }

  static error(String message) {
    return Get.snackbar(
      'Alert',
      message,
      icon: Icon(
        Icons.error,
        color: Constants.redBG,
        size: 5 * 2.6,
      ),
      margin: EdgeInsets.all(10 * 0.5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
