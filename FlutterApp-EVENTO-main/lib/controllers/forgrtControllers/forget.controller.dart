import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController {
  TextEditingController txtEmail = TextEditingController();

  sendOtp() async {
    CommonHelper().showLoading();
    var requestData = {"email": txtEmail.text};
    OutputHandler resData =
        await ApiMethods().postRequest('email_otp', requestData);
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      print(resData.data.toString());
      CommonHelper().writeStorage("resetOTP", resData.data['otp'].toString());
      CommonHelper().writeStorage(Constants().userId, resData.data['userId']);
      Get.toNamed(RouteNames().otp, arguments: false);
      await CommonHelper()
          .successMessage("One time password sent to your email.");
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().alertMessage("Unable to send Otp! Try again.");
    }
  }
}
