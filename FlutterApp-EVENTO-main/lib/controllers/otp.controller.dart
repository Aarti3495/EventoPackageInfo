import 'dart:async';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPController extends GetxController {
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController otp = TextEditingController();

  var isForgotPassowrd;

  checkOtpEvent() async {
    var exitingOtp = await CommonHelper().getStorage("resetOTP");
    if (otp.text.length == 4) {
      if (otp.text == exitingOtp.toString()) {
        otp.text = "";
        if (isForgotPassowrd) {
          Get.back();
        } else {
          Get.toNamed(RouteNames().resetPassword);
          //Get.offNamed(RouteNames().signIn);
        }
        await CommonHelper().successMessage("Otp Verified!");
      } else {
        await CommonHelper().errorMessage("Invalid Otp!");
      }
    } else {
      await CommonHelper().errorMessage("Incomplete Otp!");
    }
  }

  void onLoad() {
    isForgotPassowrd = Get.arguments;
  }
}
