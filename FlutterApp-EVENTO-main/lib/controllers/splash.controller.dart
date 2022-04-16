import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  callOnInit() async {
    await updateLanguage();
    var token = await CommonHelper().getStorage(Constants().token);
    Future.delayed(const Duration(seconds: 2), () {
      if (token != '') {
        Get.toNamed(RouteNames().layout);
      } else {
        Get.toNamed(RouteNames().signIn);
      }
    });
  }

  updateLanguage() async {
    var countryCode = await CommonHelper().getStorage(Constants().countryCode);
    var language = await CommonHelper().getStorage(Constants().language);
    if (countryCode != "" && language != "") {
      var locale = Locale(language, countryCode);
      Get.updateLocale(locale);
    }
  }

  @override
  void onInit() {
    callOnInit();
    super.onInit();
  }
}
