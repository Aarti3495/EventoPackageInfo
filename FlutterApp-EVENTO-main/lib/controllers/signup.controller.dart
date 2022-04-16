import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

import '../utilities/constants.dart';

class SignUpController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController referCode = TextEditingController();

  final _commonHelper = CommonHelper();

  bool verification = false;
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;
  bool isPhone = false;

  onObscureTextChange(int val) {
    if (val == 1) {
      passwordSecure = passwordSecure ? false : true;
    } else {
      confirmPasswordSecure = confirmPasswordSecure ? false : true;
    }
    update();
  }

  signUpRequest() async {
    try {
      _commonHelper.showLoading();
      String apiName = "register";
      var params = {
        "email": emailId.text,
        "name": name.text,
        "phone_no": phoneNumber.text,
        "password": password.text,
        "password2": confirmPassword.text,
        "user_type": "5",
        "refer_code": ""
      };
      if (referCode.text.isNotEmpty) {
        params["refer_code"] = referCode.text;
      }
      dio.FormData formData = dio.FormData.fromMap(params);
      var resData = await ApiMethods().postRequest(apiName, formData);
      if (resData.isSuccess == true && resData.status == 200) {
        if (resData.data.toString() == "1") {
          _commonHelper.hideLoading();
          Get.back();
          await _commonHelper.successMessage(resData.message.toString());
        } else {
          _commonHelper.hideLoading();
          if (resData.data is Object) {
            String objString = _commonHelper.removeBraces(resData.data);
            _commonHelper.alertMessage(objString);
          } else {
            _commonHelper.alertMessage(resData.message);
          }
        }
      } else {
        _commonHelper.hideLoading();
        _commonHelper.errorMessage(resData.message);
      }
      update();
    } catch (e) {
      _commonHelper.hideLoading();
      _commonHelper.errorMessage(Constants.someThingWentWrong);
    }
  }

  Future<void> verificationPhoneNumber(dynamic number) async {
    try {
      _commonHelper.showLoading();
      String apiName = "sms";
      var params = {
        "phone": number.phoneNumber!,
      };
      dio.FormData formData = dio.FormData.fromMap(params);
      var resData = await ApiMethods().postRequest(apiName, formData);
      if (resData.isSuccess == true && resData.status == 200) {
        _commonHelper.hideLoading();
        CommonHelper().successMessage(resData.message);
        CommonHelper().writeStorage("resetOTP", resData.data['OTP'].toString());
        Get.toNamed(RouteNames().otp, arguments: true);
        isPhone = false;
        verification = true;
        update();
      } else {
        verification = false;
        update();
        _commonHelper.hideLoading();
        _commonHelper.errorMessage(resData.message);
      }
      update();
    } catch (e) {
      _commonHelper.hideLoading();
      _commonHelper.errorMessage(Constants.someThingWentWrong);
    }
  }

  Future<bool> validation(String s, String isoCode) async {
    PhoneNumberUtil plugin = PhoneNumberUtil();
    bool isValid = await plugin.validate(s, isoCode);
    return isValid;
  }
}
