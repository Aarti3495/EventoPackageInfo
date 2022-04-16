import 'package:evento_package/controllers/notification.controller.dart';
import 'package:evento_package/models/user.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' as io;

class SignInController extends GetxController {
  TextEditingController emailIdORNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  void signInEvent() async {
    try {
      CommonHelper().showLoading();
      var params = {
        "username": emailIdORNumber.text,
        "password": password.text,
      };

      OutputHandler resData = await ApiMethods().postRequest('login', params);
      debugPrint(resData.data.toString());

      if (resData.isSuccess == true && resData.status == 200) {
        CommonHelper().hideLoading();
        if (resData.data != null && resData.data != 0) {
          CommonHelper().writeStorage(Constants().token, resData.data['token']);
          CommonHelper()
              .writeStorage(Constants().userId, resData.data['userId']);
          OutputHandler userData = await ApiMethods().getRequest("user", []);
          final fcmToken = await NotificationController().getFCMToken();
          final outputHandler = await ApiMethods()
              .postRequest(Constants.appToken, {"apptoken": fcmToken,"platform_type":io.Platform.operatingSystem});
          if (userData.isSuccess == true && userData.status == 200) {
            if (userData.data != null && userData.data != "") {
              User user = User.fromJson(userData.data[0]);
              CommonHelper().writeStorage(Constants().userData, user);
              Get.toNamed(RouteNames().layout);
            } else {
              CommonHelper().alertMessage(userData.message.toString());
            }
          } else {
            CommonHelper().hideLoading();
            CommonHelper().errorMessage(userData.message.toString());
          }
        } else {
          CommonHelper().alertMessage(resData.message.toString());
        }
      } else {
        CommonHelper().hideLoading();
        CommonHelper().errorMessage(Constants.someThingWentWrong);
      }
      update();
    } catch (e) {
      CommonHelper().hideLoading();
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }
}
